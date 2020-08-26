Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F4DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F6C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbgHZMvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgHZMva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:51:30 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3AC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:51:29 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id LCrR2300G4C55Sk01CrRDP; Wed, 26 Aug 2020 14:51:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAuth-00082b-IT; Wed, 26 Aug 2020 14:51:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kAuth-0006Dc-Fu; Wed, 26 Aug 2020 14:51:25 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: amiga: Clean up Amiga hardware configuration
Date:   Wed, 26 Aug 2020 14:51:24 +0200
Message-Id: <20200826125124.23863-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the generic Amiga hardware configuration section out of the
switch statement, which allows to replace all ugly jumps by break
statements.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/amiga/config.c | 118 +++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 60 deletions(-)

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index 9c1afa143d05962b..bee9f240f35deef5 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -214,7 +214,7 @@ static void __init amiga_identify(void)
 
 	switch (amiga_model) {
 	case AMI_UNKNOWN:
-		goto Generic;
+		break;
 
 	case AMI_600:
 	case AMI_1200:
@@ -227,7 +227,7 @@ static void __init amiga_identify(void)
 	case AMI_2000:
 	case AMI_2500:
 		AMIGAHW_SET(A2000_CLK);	/* Is this correct for all models? */
-		goto Generic;
+		break;
 
 	case AMI_3000:
 	case AMI_3000T:
@@ -238,7 +238,7 @@ static void __init amiga_identify(void)
 		AMIGAHW_SET(A3000_SCSI);
 		AMIGAHW_SET(A3000_CLK);
 		AMIGAHW_SET(ZORRO3);
-		goto Generic;
+		break;
 
 	case AMI_4000T:
 		AMIGAHW_SET(A4000_SCSI);
@@ -247,68 +247,12 @@ static void __init amiga_identify(void)
 		AMIGAHW_SET(A4000_IDE);
 		AMIGAHW_SET(A3000_CLK);
 		AMIGAHW_SET(ZORRO3);
-		goto Generic;
+		break;
 
 	case AMI_CDTV:
 	case AMI_CD32:
 		AMIGAHW_SET(CD_ROM);
 		AMIGAHW_SET(A2000_CLK);             /* Is this correct? */
-		goto Generic;
-
-	Generic:
-		AMIGAHW_SET(AMI_VIDEO);
-		AMIGAHW_SET(AMI_BLITTER);
-		AMIGAHW_SET(AMI_AUDIO);
-		AMIGAHW_SET(AMI_FLOPPY);
-		AMIGAHW_SET(AMI_KEYBOARD);
-		AMIGAHW_SET(AMI_MOUSE);
-		AMIGAHW_SET(AMI_SERIAL);
-		AMIGAHW_SET(AMI_PARALLEL);
-		AMIGAHW_SET(CHIP_RAM);
-		AMIGAHW_SET(PAULA);
-
-		switch (amiga_chipset) {
-		case CS_OCS:
-		case CS_ECS:
-		case CS_AGA:
-			switch (amiga_custom.deniseid & 0xf) {
-			case 0x0c:
-				AMIGAHW_SET(DENISE_HR);
-				break;
-			case 0x08:
-				AMIGAHW_SET(LISA);
-				break;
-			default:
-				AMIGAHW_SET(DENISE);
-				break;
-			}
-			break;
-		}
-		switch ((amiga_custom.vposr>>8) & 0x7f) {
-		case 0x00:
-			AMIGAHW_SET(AGNUS_PAL);
-			break;
-		case 0x10:
-			AMIGAHW_SET(AGNUS_NTSC);
-			break;
-		case 0x20:
-		case 0x21:
-			AMIGAHW_SET(AGNUS_HR_PAL);
-			break;
-		case 0x30:
-		case 0x31:
-			AMIGAHW_SET(AGNUS_HR_NTSC);
-			break;
-		case 0x22:
-		case 0x23:
-			AMIGAHW_SET(ALICE_PAL);
-			break;
-		case 0x32:
-		case 0x33:
-			AMIGAHW_SET(ALICE_NTSC);
-			break;
-		}
-		AMIGAHW_SET(ZORRO);
 		break;
 
 	case AMI_DRACO:
@@ -318,6 +262,60 @@ static void __init amiga_identify(void)
 		panic("Unknown Amiga Model");
 	}
 
+	AMIGAHW_SET(AMI_VIDEO);
+	AMIGAHW_SET(AMI_BLITTER);
+	AMIGAHW_SET(AMI_AUDIO);
+	AMIGAHW_SET(AMI_FLOPPY);
+	AMIGAHW_SET(AMI_KEYBOARD);
+	AMIGAHW_SET(AMI_MOUSE);
+	AMIGAHW_SET(AMI_SERIAL);
+	AMIGAHW_SET(AMI_PARALLEL);
+	AMIGAHW_SET(CHIP_RAM);
+	AMIGAHW_SET(PAULA);
+
+	switch (amiga_chipset) {
+	case CS_OCS:
+	case CS_ECS:
+	case CS_AGA:
+		switch (amiga_custom.deniseid & 0xf) {
+		case 0x0c:
+			AMIGAHW_SET(DENISE_HR);
+			break;
+		case 0x08:
+			AMIGAHW_SET(LISA);
+			break;
+		default:
+			AMIGAHW_SET(DENISE);
+			break;
+		}
+		break;
+	}
+	switch ((amiga_custom.vposr>>8) & 0x7f) {
+	case 0x00:
+		AMIGAHW_SET(AGNUS_PAL);
+		break;
+	case 0x10:
+		AMIGAHW_SET(AGNUS_NTSC);
+		break;
+	case 0x20:
+	case 0x21:
+		AMIGAHW_SET(AGNUS_HR_PAL);
+		break;
+	case 0x30:
+	case 0x31:
+		AMIGAHW_SET(AGNUS_HR_NTSC);
+		break;
+	case 0x22:
+	case 0x23:
+		AMIGAHW_SET(ALICE_PAL);
+		break;
+	case 0x32:
+	case 0x33:
+		AMIGAHW_SET(ALICE_NTSC);
+		break;
+	}
+	AMIGAHW_SET(ZORRO);
+
 #define AMIGAHW_ANNOUNCE(name, str)		\
 	if (AMIGAHW_PRESENT(name))		\
 		pr_cont(str)
-- 
2.17.1

