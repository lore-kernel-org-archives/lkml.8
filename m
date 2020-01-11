Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C87C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE6C2064C
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737172;
	bh=THr1tRLvVX09Ro0T6M/vUy7Oez33Pgukhzb0B/IVhsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJT2G8afyfPiwqW03ZYZOiZurskI7EvpB4mHoMFn+/QTvKZQwiXzFWtRtu6Fnrh5l
	 3hyxHpCr3re2BBFMwR+XxJg33qgr/ae+1g9rrklk/E6xfNsPvuaD6bHhcwNpA2MoKM
	 nC9Br02QpyscVtz8W4eY3menE+ZgJkoEys6TWf1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbgAKKGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:39890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbgAKKGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:06:10 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D8E20848;
        Sat, 11 Jan 2020 10:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737170;
        bh=THr1tRLvVX09Ro0T6M/vUy7Oez33Pgukhzb0B/IVhsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i0/4+8CIEucIMXUegZn8l3Ot+TuzyQ2DqjYWDNqZ2WfMTyjYt9JAsQrpqxa72OpQ6
         qQt7GQ/912vmTxvmOc+7jY7z/gex08DvmA1DjoAvFteZnb3iYGu0QE7HMCAXqsT+/x
         Jw4DF1EwcmydDvGr0Ee3/0NhrcASd+u7bHpcKFh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        RENARD Pierre-Francois <pfrenard@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 82/91] net: usb: lan78xx: fix possible skb leak
Date:   Sat, 11 Jan 2020 10:50:15 +0100
Message-Id: <20200111094912.458055213@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094844.748507863@linuxfoundation.org>
References: <20200111094844.748507863@linuxfoundation.org>
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
@@ -2407,11 +2407,6 @@ static int lan78xx_stop(struct net_devic
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
@@ -2422,8 +2417,10 @@ static struct sk_buff *lan78xx_tx_prep(s
 		return NULL;
 	}
 
-	if (lan78xx_linearize(skb) < 0)
+	if (skb_linearize(skb)) {
+		dev_kfree_skb_any(skb);
 		return NULL;
+	}
 
 	tx_cmd_a = (u32)(skb->len & TX_CMD_A_LEN_MASK_) | TX_CMD_A_FCS_;
 


