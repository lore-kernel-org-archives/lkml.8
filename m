Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B4A9C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1031920B80
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098563;
	bh=VCDnRq6KNn8pBZy4kFj3bnJQnDEccmaJeGcDMIiba5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PXvGlJNEfxgYOZRnj/081SVha1tIzQua57G+6q4+m/ePNUjFaj+HmvG6akmWY6Wrm
	 Nhq9rxtfrCD/FOptcIhDkTP5mPV4iBgYdwYLgeWCf/QkA0lRxbXC9hHH9+pqnVBFng
	 MoOwfZ0ZVNU3dPSWsHru3v2SWnvQKbvgBYAs//Os=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgD1S3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:29:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbgD1S3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:29:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED36D20B80;
        Tue, 28 Apr 2020 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098558;
        bh=VCDnRq6KNn8pBZy4kFj3bnJQnDEccmaJeGcDMIiba5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DGkelCfxd5ZXDgOnIIhOh2isyVDeyyqPwhH7VnbEonqXECrWuQCaQg3Fd2n/LGudL
         nrLRP9FRyAhkZhr9sGOvqiRctG0MlikPR0o4zOOVM8uDyvuIrR3dSMS6HXPw7J9MS5
         LrgunHFzwOwayd4dool5d4ksH2QzSOQym9kb8+FU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.6 072/167] xfrm: Always set XFRM_TRANSFORMED in xfrm{4,6}_output_finish
Date:   Tue, 28 Apr 2020 20:24:08 +0200
Message-Id: <20200428182234.043027809@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 0c922a4850eba2e668f73a3f1153196e09abb251 ]

IPSKB_XFRM_TRANSFORMED and IP6SKB_XFRM_TRANSFORMED are skb flags set by
xfrm code to tell other skb handlers that the packet has been passed
through the xfrm output functions. Simplify the code and just always
set them rather than conditionally based on netfilter enabled thus
making the flag available for other users.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/xfrm4_output.c |    2 --
 net/ipv6/xfrm6_output.c |    2 --
 2 files changed, 4 deletions(-)

--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -58,9 +58,7 @@ int xfrm4_output_finish(struct sock *sk,
 {
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
-#ifdef CONFIG_NETFILTER
 	IPCB(skb)->flags |= IPSKB_XFRM_TRANSFORMED;
-#endif
 
 	return xfrm_output(sk, skb);
 }
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -111,9 +111,7 @@ int xfrm6_output_finish(struct sock *sk,
 {
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-#ifdef CONFIG_NETFILTER
 	IP6CB(skb)->flags |= IP6SKB_XFRM_TRANSFORMED;
-#endif
 
 	return xfrm_output(sk, skb);
 }


