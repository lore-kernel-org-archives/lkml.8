Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D72C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C690721531
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592944930;
	bh=5G6QCiSLWqOGR4zy8AvkLNISOCXLbxImzAtZx8OvqCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E3lX4Z8mQwsbj76fU6mO8KdbXRmJpjSAt4DluFaplNjS59zOpN+nGWog3H0u/bdA+
	 R9VwGofflIYRp9NkVsQOvQsNhQtn6kQFLZfenApQlevqh0aesG1PpqENOWHqNk4BRj
	 PBCiApRJknO7RqA02/9hK1Qrh94oOzMbjnLa7F+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbgFWUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:38616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391490AbgFWUmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:42:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBD92053B;
        Tue, 23 Jun 2020 20:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944925;
        bh=5G6QCiSLWqOGR4zy8AvkLNISOCXLbxImzAtZx8OvqCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNr9Y6mqDyzfYP2JD6/RQRJZGIFw4n1vX4Fs9lgLOF+ns9gRT9/LLLu9PdM2/wJ01
         LdJ2+XkFTwU1zheZqF2GK7aToHKdp2hRbHj5bK3ifO3xwupK2M9Xz+35xnINI49+d6
         Q1l2JHKXJwDrWa1SVZGQzQyp5lQrGAZihcLRaPEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 161/206] xdp: Fix xsk_generic_xmit errno
Date:   Tue, 23 Jun 2020 21:58:09 +0200
Message-Id: <20200623195324.917781007@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit aa2cad0600ed2ca6a0ab39948d4db1666b6c962b ]

Propagate sock_alloc_send_skb error code, not set it to
EAGAIN unconditionally, when fail to allocate skb, which
might cause that user space unnecessary loops.

Fixes: 35fcde7f8deb ("xsk: support for Tx")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/1591852266-24017-1-git-send-email-lirongqing@baidu.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xdp/xsk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 72caa4fb13f47..9ff2ab63e6392 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -233,10 +233,8 @@ static int xsk_generic_xmit(struct sock *sk, struct msghdr *m,
 
 		len = desc.len;
 		skb = sock_alloc_send_skb(sk, len, 1, &err);
-		if (unlikely(!skb)) {
-			err = -EAGAIN;
+		if (unlikely(!skb))
 			goto out;
-		}
 
 		skb_put(skb, len);
 		addr = desc.addr;
-- 
2.25.1



