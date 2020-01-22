Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B612BC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837382468D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699453;
	bh=QKDa25hlURHn5kDz4X4uEheo2MeMZoYUHemUpyuIs7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10yMiss6TxP8BGZwT9zus4SEBi+PzkFQ+ldRehm3fBYLDkQbCSLdvBtvkNYBDaDSA
	 0FXuXjlsuWyJAdq/n+hWEJ7v77nYhmwkb+VsMT78y2O630t66KmE4xOIek6icce/Vn
	 JqSa8xa50yU7mufODxlGY87T6ANKSrUZ54f5QWvk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbgAVNX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:23:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:42422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730547AbgAVNXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:23:54 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251FA24688;
        Wed, 22 Jan 2020 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699433;
        bh=QKDa25hlURHn5kDz4X4uEheo2MeMZoYUHemUpyuIs7Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=idqSZ/PAKrGsv1BCw5a/Es1Xjf3njgb26BnG+ROPO+RL4q+pA/J9lqKgcAggJnCf1
         gq9sDdKwh/C6zonS+rKF0virzwmZoxRGkEwtPSm2Q2Kc2IzDzzSa58V21gu1ZarSVH
         yU/4QJxwGXdzsI9xlt63g2lfP8vs8di+Nj892OWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 142/222] net: phy: dp83867: Set FORCE_LINK_GOOD to default after reset
Date:   Wed, 22 Jan 2020 10:28:48 +0100
Message-Id: <20200122092843.900371168@linuxfoundation.org>
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

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

[ Upstream commit 86ffe920e669ec73035e84553e18edf17d16317c ]

According to the Datasheet this bit should be 0 (Normal operation) in
default. With the FORCE_LINK_GOOD bit set, it is not possible to get a
link. This patch sets FORCE_LINK_GOOD to the default value after
resetting the phy.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/dp83867.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -80,6 +80,7 @@
 #define DP83867_PHYCR_FIFO_DEPTH_MAX		0x03
 #define DP83867_PHYCR_FIFO_DEPTH_MASK		GENMASK(15, 14)
 #define DP83867_PHYCR_RESERVED_MASK		BIT(11)
+#define DP83867_PHYCR_FORCE_LINK_GOOD		BIT(10)
 
 /* RGMIIDCTL bits */
 #define DP83867_RGMII_TX_CLK_DELAY_MAX		0xf
@@ -454,7 +455,12 @@ static int dp83867_phy_reset(struct phy_
 
 	usleep_range(10, 20);
 
-	return 0;
+	/* After reset FORCE_LINK_GOOD bit is set. Although the
+	 * default value should be unset. Disable FORCE_LINK_GOOD
+	 * for the phy to work properly.
+	 */
+	return phy_modify(phydev, MII_DP83867_PHYCTRL,
+			 DP83867_PHYCR_FORCE_LINK_GOOD, 0);
 }
 
 static struct phy_driver dp83867_driver[] = {


