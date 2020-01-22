Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5240AC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B7624695
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699326;
	bh=eaBgZMQiR1ktJvSTogygs1ZOXePmbAz1byQHBsb4F9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wlx+JLPiGTB6BvonlKXqoRKP3gA40W+ULHDQRvt+lTq2NvdzymWi32zPueMw9cwnJ
	 ioEz7s7jxeekYELq2u13V6FDE2I/fFTAOlbwDLkSAALW/tD9DBUYIM6IkCDzxvRpdN
	 P9ZKdFVZnErqFXQ0pBWlxLGPsXJ9SNG626I9bNU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbgAVNWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:22:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729440AbgAVNWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:22:03 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D19624688;
        Wed, 22 Jan 2020 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699323;
        bh=eaBgZMQiR1ktJvSTogygs1ZOXePmbAz1byQHBsb4F9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UMnDOF0DqFjIs0+vtJ7/mm5FjrTngx6nGssIY+Rg8jE+bRnG/lxtGzkMBvI7L61+0
         HLg0oElZaGoJ2kMgyMc/ljdybMQawshpCS0bWnPT3IxL9y2hJtx2579zpLgwAjiSx5
         TUXNz8kP0EePVelI6tfVY0NT6dXiXaUJv95sPRNI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Song Liu <songliubraving@fb.com>
Subject: [PATCH 5.4 108/222] bpf: Sockmap/tls, during free we may call tcp_bpf_unhash() in loop
Date:   Wed, 22 Jan 2020 10:28:14 +0100
Message-Id: <20200122092841.469023967@linuxfoundation.org>
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

From: John Fastabend <john.fastabend@gmail.com>

commit 4da6a196f93b1af7612340e8c1ad8ce71e18f955 upstream.

When a sockmap is free'd and a socket in the map is enabled with tls
we tear down the bpf context on the socket, the psock struct and state,
and then call tcp_update_ulp(). The tcp_update_ulp() call is to inform
the tls stack it needs to update its saved sock ops so that when the tls
socket is later destroyed it doesn't try to call the now destroyed psock
hooks.

This is about keeping stacked ULPs in good shape so they always have
the right set of stacked ops.

However, recently unhash() hook was removed from TLS side. But, the
sockmap/bpf side is not doing any extra work to update the unhash op
when is torn down instead expecting TLS side to manage it. So both
TLS and sockmap believe the other side is managing the op and instead
no one updates the hook so it continues to point at tcp_bpf_unhash().
When unhash hook is called we call tcp_bpf_unhash() which detects the
psock has already been destroyed and calls sk->sk_prot_unhash() which
calls tcp_bpf_unhash() yet again and so on looping and hanging the core.

To fix have sockmap tear down logic fixup the stale pointer.

Fixes: 5d92e631b8be ("net/tls: partially revert fix transition through disconnect with close")
Reported-by: syzbot+83979935eb6304f8cd46@syzkaller.appspotmail.com
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20200111061206.8028-2-john.fastabend@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/skmsg.h |    1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -354,6 +354,7 @@ static inline void sk_psock_update_proto
 static inline void sk_psock_restore_proto(struct sock *sk,
 					  struct sk_psock *psock)
 {
+	sk->sk_prot->unhash = psock->saved_unhash;
 	sk->sk_write_space = psock->saved_write_space;
 
 	if (psock->sk_proto) {


