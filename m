Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7777220884
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825244;
	bh=JnO/HTljguYyDlXacpcME3iHeEzv1y1UnnpJKpBEuR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ih7mLhzpWWaQauDfUNfdFXhaSpow8JhnuOECjDNUpOGGCGVFjvyz7k7eU0jE1Us0O
	 mEWYFb/EmG0aC6vCtt45KubixMG2xTglCIiN/aIMJv93SnZHaVzRMyVZZnBOVNOUp3
	 rW7JJteanGVbGiNPKsPfLjrDIZx8Qc+ulsyteUWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733306AbgERSHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733292AbgERSHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:07:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3D320873;
        Mon, 18 May 2020 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825237;
        bh=JnO/HTljguYyDlXacpcME3iHeEzv1y1UnnpJKpBEuR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mnrneoC7mOaGnzhlq5yYola4HXhteJLWsT+2aK/n415sRcINgKf5t4GgkG5GjOtYJ
         EE90sYwGycPc1VQt0boFQr+oqTVqHk++pZNk1XB2GT+NzjYRq6cCF2lS16cj4vDL7M
         REAtwcyCatFLS/ysPyscA7kGGU6TqB868FsFGRwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH 5.6 184/194] bpf: Fix sk_psock refcnt leak when receiving message
Date:   Mon, 18 May 2020 19:37:54 +0200
Message-Id: <20200518173546.791738129@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit 18f02ad19e2c2a1d9e1d55a4e1c0cbf51419151c upstream.

tcp_bpf_recvmsg() invokes sk_psock_get(), which returns a reference of
the specified sk_psock object to "psock" with increased refcnt.

When tcp_bpf_recvmsg() returns, local variable "psock" becomes invalid,
so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in several exception handling paths
of tcp_bpf_recvmsg(). When those error scenarios occur such as "flags"
includes MSG_ERRQUEUE, the function forgets to decrease the refcnt
increased by sk_psock_get(), causing a refcnt leak.

Fix this issue by calling sk_psock_put() or pulling up the error queue
read handling when those error scenarios occur.

Fixes: e7a5f1f1cd000 ("bpf/sockmap: Read psock ingress_msg before sk_receive_queue")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Link: https://lore.kernel.org/bpf/1587872115-42805-1-git-send-email-xiyuyang19@fudan.edu.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/tcp_bpf.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -121,14 +121,17 @@ int tcp_bpf_recvmsg(struct sock *sk, str
 	struct sk_psock *psock;
 	int copied, ret;
 
+	if (unlikely(flags & MSG_ERRQUEUE))
+		return inet_recv_error(sk, msg, len, addr_len);
+
 	psock = sk_psock_get(sk);
 	if (unlikely(!psock))
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
-	if (unlikely(flags & MSG_ERRQUEUE))
-		return inet_recv_error(sk, msg, len, addr_len);
 	if (!skb_queue_empty(&sk->sk_receive_queue) &&
-	    sk_psock_queue_empty(psock))
+	    sk_psock_queue_empty(psock)) {
+		sk_psock_put(sk, psock);
 		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);
+	}
 	lock_sock(sk);
 msg_bytes_ready:
 	copied = __tcp_bpf_recvmsg(sk, psock, msg, len, flags);


