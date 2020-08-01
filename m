Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCFDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45B4B207BC
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgHAPvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:51:07 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:60722 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726432AbgHAPvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:51:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EA2C2837F24D;
        Sat,  1 Aug 2020 15:51:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: flag31_57050f426f8d
X-Filterd-Recvd-Size: 4502
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 15:51:04 +0000 (UTC)
Message-ID: <e45d15ad36a0c9a994b5a1136c72518215c99f7a.camel@perches.com>
Subject: [PATCH] via-velocity: Add missing KERN_<LEVEL> where needed
From:   Joe Perches <joe@perches.com>
To:     Francois Romieu <romieu@fr.zoreil.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 01 Aug 2020 08:51:03 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link status is emitted on multiple lines as it does not use
KERN_CONT.

Coalesce the multi-part logging into a single line output and
add missing KERN_<LEVEL> to a couple logging calls.

This also reduces object size.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/net/ethernet/via/via-velocity.c | 46 ++++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/via/via-velocity.c b/drivers/net/ethernet/via/via-velocity.c
index 713dbc04b25b..84d456464b88 100644
--- a/drivers/net/ethernet/via/via-velocity.c
+++ b/drivers/net/ethernet/via/via-velocity.c
@@ -927,12 +927,12 @@ static int velocity_set_media_mode(struct velocity_info *vptr, u32 mii_status)
 		if (mii_status & VELOCITY_DUPLEX_FULL) {
 			CHIPGCR |= CHIPGCR_FCFDX;
 			writeb(CHIPGCR, &regs->CHIPGCR);
-			VELOCITY_PRT(MSG_LEVEL_INFO, "set Velocity to forced full mode\n");
+			VELOCITY_PRT(MSG_LEVEL_INFO, KERN_INFO "set Velocity to forced full mode\n");
 			if (vptr->rev_id < REV_ID_VT3216_A0)
 				BYTE_REG_BITS_OFF(TCR_TB2BDIS, &regs->TCR);
 		} else {
 			CHIPGCR &= ~CHIPGCR_FCFDX;
-			VELOCITY_PRT(MSG_LEVEL_INFO, "set Velocity to forced half mode\n");
+			VELOCITY_PRT(MSG_LEVEL_INFO, KERN_INFO "set Velocity to forced half mode\n");
 			writeb(CHIPGCR, &regs->CHIPGCR);
 			if (vptr->rev_id < REV_ID_VT3216_A0)
 				BYTE_REG_BITS_ON(TCR_TB2BDIS, &regs->TCR);
@@ -985,45 +985,61 @@ static int velocity_set_media_mode(struct velocity_info *vptr, u32 mii_status)
  */
 static void velocity_print_link_status(struct velocity_info *vptr)
 {
+	const char *link;
+	const char *speed;
+	const char *duplex;
 
 	if (vptr->mii_status & VELOCITY_LINK_FAIL) {
 		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: failed to detect cable link\n", vptr->netdev->name);
-	} else if (vptr->options.spd_dpx == SPD_DPX_AUTO) {
-		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link auto-negotiation", vptr->netdev->name);
+		return;
+	}
+
+	if (vptr->options.spd_dpx == SPD_DPX_AUTO) {
+		link = "auto-negotiation";
 
 		if (vptr->mii_status & VELOCITY_SPEED_1000)
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 1000M bps");
+			speed = "1000";
 		else if (vptr->mii_status & VELOCITY_SPEED_100)
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps");
+			speed = "100";
 		else
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 10M bps");
+			speed = "10";
 
 		if (vptr->mii_status & VELOCITY_DUPLEX_FULL)
-			VELOCITY_PRT(MSG_LEVEL_INFO, " full duplex\n");
+			duplex = "full";
 		else
-			VELOCITY_PRT(MSG_LEVEL_INFO, " half duplex\n");
+			duplex = "half";
 	} else {
-		VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link forced", vptr->netdev->name);
+		link = "forced";
+
 		switch (vptr->options.spd_dpx) {
 		case SPD_DPX_1000_FULL:
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 1000M bps full duplex\n");
+			speed = "1000";
+			duplex = "full";
 			break;
 		case SPD_DPX_100_HALF:
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps half duplex\n");
+			speed = "100";
+			duplex = "half";
 			break;
 		case SPD_DPX_100_FULL:
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 100M bps full duplex\n");
+			speed = "100";
+			duplex = "full";
 			break;
 		case SPD_DPX_10_HALF:
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 10M bps half duplex\n");
+			speed = "10";
+			duplex = "half";
 			break;
 		case SPD_DPX_10_FULL:
-			VELOCITY_PRT(MSG_LEVEL_INFO, " speed 10M bps full duplex\n");
+			speed = "10";
+			duplex = "full";
 			break;
 		default:
+			speed = "unknown";
+			duplex = "unknown";
 			break;
 		}
 	}
+	VELOCITY_PRT(MSG_LEVEL_INFO, KERN_NOTICE "%s: Link %s speed %sM bps %s duplex\n",
+		     vptr->netdev->name, link, speed, duplex);
 }
 
 /**


