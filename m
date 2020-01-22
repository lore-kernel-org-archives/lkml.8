Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66254C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A91D205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699407;
	bh=TMn3jYVlQc/Uk2+dQ9IlqD8wZaLCV/tfllBc2wf93Oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iE6GgTZY9ISKx6RRn0vDY4BWy4ml/uoE91ymypDwcGs/LJ+YmOA0QdviwNwK5MRum
	 lgq4w6PrN7LBo0GekKed8iRO9QECKx3jgbds2T5pj7wkecTpuiEutPl9dzIz2JmQ4i
	 l9diTDvN88Fv6WPXWofUcazxJ4kIoSHID7OzRWFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgAVNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730728AbgAVNXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:22 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2105B205F4;
        Wed, 22 Jan 2020 13:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699401;
        bh=TMn3jYVlQc/Uk2+dQ9IlqD8wZaLCV/tfllBc2wf93Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lIdv+fskmKw9JOk0WeJHB9rXmSoV1+gWeT7E9umKgfOumZnQ0RZl/Lrua47COOFeo
         t0bV6Dh3kw1Cgf8XOPGUhunHHTPcuhMPOB5h3aeD9k6zZIDoNKkxaQ/U9ZlFI1CCyY
         2fhiXgWlz7rXhK9/RHtmXXxHpFo7baPf0WA8iFbI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH 5.4 133/222] net: bpf: Dont leak time wait and request sockets
Date:   Wed, 22 Jan 2020 10:28:39 +0100
Message-Id: <20200122092843.267838496@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenz Bauer <lmb@cloudflare.com>

commit 2e012c74823629d9db27963c79caa3f5b2010746 upstream.

It's possible to leak time wait and request sockets via the following
BPF pseudo code:
 
  sk = bpf_skc_lookup_tcp(...)
  if (sk)
    bpf_sk_release(sk)

If sk->sk_state is TCP_NEW_SYN_RECV or TCP_TIME_WAIT the refcount taken
by bpf_skc_lookup_tcp is not undone by bpf_sk_release. This is because
sk_flags is re-used for other data in both kinds of sockets. The check

  !sock_flag(sk, SOCK_RCU_FREE)

therefore returns a bogus result. Check that sk_flags is valid by calling
sk_fullsock. Skip checking SOCK_RCU_FREE if we already know that sk is
not a full socket.

Fixes: edbf8c01de5a ("bpf: add skc_lookup_tcp helper")
Fixes: f7355a6c0497 ("bpf: Check sk_fullsock() before returning from bpf_sk_lookup()")
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20200110132336.26099-1-lmb@cloudflare.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/filter.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5306,8 +5306,7 @@ __bpf_sk_lookup(struct sk_buff *skb, str
 	if (sk) {
 		sk = sk_to_full_sk(sk);
 		if (!sk_fullsock(sk)) {
-			if (!sock_flag(sk, SOCK_RCU_FREE))
-				sock_gen_put(sk);
+			sock_gen_put(sk);
 			return NULL;
 		}
 	}
@@ -5344,8 +5343,7 @@ bpf_sk_lookup(struct sk_buff *skb, struc
 	if (sk) {
 		sk = sk_to_full_sk(sk);
 		if (!sk_fullsock(sk)) {
-			if (!sock_flag(sk, SOCK_RCU_FREE))
-				sock_gen_put(sk);
+			sock_gen_put(sk);
 			return NULL;
 		}
 	}
@@ -5412,7 +5410,8 @@ static const struct bpf_func_proto bpf_s
 
 BPF_CALL_1(bpf_sk_release, struct sock *, sk)
 {
-	if (!sock_flag(sk, SOCK_RCU_FREE))
+	/* Only full sockets have sk->sk_flags. */
+	if (!sk_fullsock(sk) || !sock_flag(sk, SOCK_RCU_FREE))
 		sock_gen_put(sk);
 	return 0;
 }


