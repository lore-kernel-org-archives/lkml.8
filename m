Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2255CC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA72C208D6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588339757;
	bh=Qs78r1hJQ7eIwNzO01q2Oa9PHG7c6wH58tUjB1MxkYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJHsk5b9xTKmm34Cifhtk/wFjHY0yUYFnFXb28GYPjZgvu5ncVfIAdF6ezcNzmC0L
	 tnsjY93Yf/UTaQbjG0uyRLNA6CsNATTCzBoCiaLBKp9gx4uDtrC+EfGwwY6xOCYlK+
	 DR4YI6htuxx7XdVdjyMi1WUDSblBkbZqIo+Zu11o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgEAN3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:29:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgEAN3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:29:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4225B2166E;
        Fri,  1 May 2020 13:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339743;
        bh=Qs78r1hJQ7eIwNzO01q2Oa9PHG7c6wH58tUjB1MxkYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wUQz6Tx4ml+aaTiWsKxazYhoPWuSsRQWxK3kfVijUzmSEtJVPVL74/RYgbD9ycEor
         M/OruPCVilPpCzenhoBHWJgvokakzMKdiC66KBfpqb717tMJYkWxpViUTD9PB6ScF4
         eZw+vYbS9C3c8V4J32VWc7NhU9npXAcGv60B0QWI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 28/80] xfrm: Always set XFRM_TRANSFORMED in xfrm{4,6}_output_finish
Date:   Fri,  1 May 2020 15:21:22 +0200
Message-Id: <20200501131523.355882658@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131513.810761598@linuxfoundation.org>
References: <20200501131513.810761598@linuxfoundation.org>
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
@@ -75,9 +75,7 @@ int xfrm4_output_finish(struct sock *sk,
 {
 	memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 
-#ifdef CONFIG_NETFILTER
 	IPCB(skb)->flags |= IPSKB_XFRM_TRANSFORMED;
-#endif
 
 	return xfrm_output(sk, skb);
 }
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -125,9 +125,7 @@ int xfrm6_output_finish(struct sock *sk,
 {
 	memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
 
-#ifdef CONFIG_NETFILTER
 	IP6CB(skb)->flags |= IP6SKB_XFRM_TRANSFORMED;
-#endif
 
 	return xfrm_output(sk, skb);
 }


