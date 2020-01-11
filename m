Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAB2C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2814E20882
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738788;
	bh=ekY1pzXc//oztwUxTxyZSqXmrG1IKiusznaJnwOuNhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2Z4n4VHwPmOXbeShIegUQ+iQt6v2ywynByIdPm6pRBtL6/iU13yguWi+Jl2C0beI
	 OqBhBvgxjVOk61UZMa/q12Dgc2sDy2bkqqwLAMsX9sy7v6sPQmxDOjgB3ywSxj8xOs
	 2YMbY9S3rWgQFtnz21GBPiWF34ob+QBtQw6TxOxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgAKKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:33:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgAKKdF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:33:05 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8002620842;
        Sat, 11 Jan 2020 10:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738784;
        bh=ekY1pzXc//oztwUxTxyZSqXmrG1IKiusznaJnwOuNhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1sedDB3cPqh98WvguPn8S0w/XYHo7ydWW31oBGG/QsFLsTDks/Ss/cg2maYRQxn3R
         enG8cUwMQzrHlYO/aBWe+D6vepSEe/G9jO5MQpDFU4xATV0WpGUuVowzNCRZyvHiO7
         bMYmB/jy0y0m902Fzrx23+J+gussZckRzALsr4Fs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        RENARD Pierre-Francois <pfrenard@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 145/165] net: usb: lan78xx: fix possible skb leak
Date:   Sat, 11 Jan 2020 10:51:04 +0100
Message-Id: <20200111094939.290795974@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
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
@@ -2724,11 +2724,6 @@ static int lan78xx_stop(struct net_devic
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
@@ -2740,8 +2735,10 @@ static struct sk_buff *lan78xx_tx_prep(s
 		return NULL;
 	}
 
-	if (lan78xx_linearize(skb) < 0)
+	if (skb_linearize(skb)) {
+		dev_kfree_skb_any(skb);
 		return NULL;
+	}
 
 	tx_cmd_a = (u32)(skb->len & TX_CMD_A_LEN_MASK_) | TX_CMD_A_FCS_;
 


