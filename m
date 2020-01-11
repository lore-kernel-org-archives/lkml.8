Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31728C33CA3
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F2E2077C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 09:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578736583;
	bh=Q1o8h/zPHzFtnLMEx2DXNfR7tGOva6KqlcozL3/R9Ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ay4SH3xXy8movIB7j2L9nHqCBK++guRpUIr28VxdtSSqlm5i8rrJ6v0NSnw89X1QW
	 Gv6RoV0X1PxZ0UrnJghfGGT701EdzYRnCoIsFoZEKH6fomKV3g79do5BhRZLDbnSBG
	 DQHvegyk8WgQfUIPBTDPRfUm3mw9V8Ltue9lxfs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgAKJ4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 04:56:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:47296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728768AbgAKJ4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 04:56:21 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EE7E2064C;
        Sat, 11 Jan 2020 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578736580;
        bh=Q1o8h/zPHzFtnLMEx2DXNfR7tGOva6KqlcozL3/R9Ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vCrlgFNXTQBliUKS0rx8T5qdKUoqE1CyoN888kyORucgAoWBK3vTHUdqcpqRmWxer
         swB7GTKdIbE2buBgjx48LSK7slhmxJ8r4t39djeQVgmjyIvO2h7SgLTd758AXzaJDV
         j9Git7JQg9Xh4qoTfI9b0270t6PEPfBHnF9Cv9uM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        RENARD Pierre-Francois <pfrenard@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 50/59] net: usb: lan78xx: fix possible skb leak
Date:   Sat, 11 Jan 2020 10:49:59 +0100
Message-Id: <20200111094850.091642079@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094835.417654274@linuxfoundation.org>
References: <20200111094835.417654274@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 47240ba0cd09bb6fe6db9889582048324999dfa4 ]

If skb_linearize() fails, we need to free the skb.

TSO makes skb bigger, and this bug might be the reason
Raspberry Pi 3B+ users had to disable TSO.

Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: RENARD Pierre-Francois <pfrenard@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/lan78xx.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2036,11 +2036,6 @@ int lan78xx_stop(struct net_device *net)
 	return 0;
 }
 
-static int lan78xx_linearize(struct sk_buff *skb)
-{
-	return skb_linearize(skb);
-}
-
 static struct sk_buff *lan78xx_tx_prep(struct lan78xx_net *dev,
 				       struct sk_buff *skb, gfp_t flags)
 {
@@ -2051,8 +2046,10 @@ static struct sk_buff *lan78xx_tx_prep(s
 		return NULL;
 	}
 
-	if (lan78xx_linearize(skb) < 0)
+	if (skb_linearize(skb)) {
+		dev_kfree_skb_any(skb);
 		return NULL;
+	}
 
 	tx_cmd_a = (u32)(skb->len & TX_CMD_A_LEN_MASK_) | TX_CMD_A_FCS_;
 


