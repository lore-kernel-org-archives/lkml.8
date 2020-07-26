Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B4D20658
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEMXr2oh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGZKxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZKxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:53:22 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80C9C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:53:22 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so7570665pfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 03:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mT3x0356kVRWVeFjxu7KR4BK4J66kBgEfHawKmKvOdY=;
        b=UEMXr2oh28zetGxqfszujUEJM/QhQBAVaJqXfzd+OY6V5gwlCms7u+8d/LoeUQEeFy
         GjnQGqhkF1G2S/MMOzMfUI6h/1XalxhlevR70yIlTaNBgZrcVn2b7NDeNFLZ9r27qxIf
         mlQoR8yOvhtW5smEofqg9910I6qdpRODOeuYDrc3rJ7wBlTq3ncMadh2hYm3ZPlw9KC1
         G36b30DEKSReeOd+jCkH4mbsEuYbnY2B0sa16TC1oBgk434bM2F5iQVLHffVg7LR8BNj
         OMO+99vCKkIaELYnLMSfWY4bAmmAHBWHNV+U5xqynoO9lWTQUDi1F9E/rrlDfjbaDl0X
         yhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mT3x0356kVRWVeFjxu7KR4BK4J66kBgEfHawKmKvOdY=;
        b=sHVcIVyr+YMod6rnomGrUrXaQL2YzoefJpsUQZlfofu9vdKmiqyz6p7AnW3C7LPhNy
         0YvzwRcLsyZhMHhxGPz8Hz1nSHY+efxw0Zgr3KS+rMPZBX7WufnL2XpY6f56W6z6xbGj
         JHoA2dDBo+C2bVAluXLTA6nCcEm2o1fYZ8ORTKgLQ7r+Hd1xO5YwpFjps40m37PwZLcZ
         VuggiWZRRqn/QG9vZVmAXn1UNjmsq7cvzUoqhGDOaHNgkB2oYxCKq7ZnMCsHmtTgmhtu
         OVgD1wQpGx3+/1KLZVga1vOciSS7pWoDaPWbVu6l0UUIknT43Ar1+axu/kYkfBkbScfC
         bSpQ==
X-Gm-Message-State: AOAM531vY6OuFCiZnVwRrcR8+iNMecIl0hW+U2vHiVK/DzV+nJ8ovsvS
        ChNOUdhvKVF1lfDHNAVNNVw=
X-Google-Smtp-Source: ABdhPJzKwvZis84Ci9mOUHaNSJHVbXXWiUs9KC8kdic9FgKmdAVksNuSk2Vyu0IlY1aRqOOjt5wz1A==
X-Received: by 2002:a63:8949:: with SMTP id v70mr15267297pgd.256.1595760802207;
        Sun, 26 Jul 2020 03:53:22 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id y22sm10642055pjp.41.2020.07.26.03.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 03:53:21 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v2] staging: rtl8723bs: include: Fix coding style issues
Date:   Sun, 26 Jul 2020 16:23:02 +0530
Message-Id: <20200726105302.52188-1-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
References: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning messy function declartions and fixing code style
errors in hal_phy_cfg.h as reported by checkpatch.pl

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_cfg.h   | 118 +++++-------------
 1 file changed, 33 insertions(+), 85 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 419ddb0733aa..2f123903279c 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -8,54 +8,31 @@
 #define __INC_HAL8723BPHYCFG_H__
 
 /*--------------------------Define Parameters-------------------------------*/
-#define LOOP_LIMIT				5
-#define MAX_STALL_TIME			50		/* us */
+#define LOOP_LIMIT		5
+#define MAX_STALL_TIME		50	/* us */
 #define AntennaDiversityValue	0x80	/* Adapter->bSoftwareAntennaDiversity ? 0x00:0x80) */
 #define MAX_TXPWR_IDX_NMODE_92S	63
-#define Reset_Cnt_Limit			3
-
-#define MAX_AGGR_NUM	0x07
+#define Reset_Cnt_Limit		3
 
+#define MAX_AGGR_NUM 0x07
 
 /*--------------------------Define Parameters End-------------------------------*/
 
-
 /*------------------------------Define structure----------------------------*/
 
 /*------------------------------Define structure End----------------------------*/
 
 /*--------------------------Exported Function prototype---------------------*/
-u32
-PHY_QueryBBReg_8723B(
-struct adapter *Adapter,
-u32 	RegAddr,
-u32 	BitMask
-	);
-
-void
-PHY_SetBBReg_8723B(
-struct adapter *Adapter,
-u32 	RegAddr,
-u32 	BitMask,
-u32 	Data
-	);
-
-u32
-PHY_QueryRFReg_8723B(
-struct adapter *		Adapter,
-u8 		eRFPath,
-u32 			RegAddr,
-u32 			BitMask
-	);
-
-void
-PHY_SetRFReg_8723B(
-struct adapter *		Adapter,
-u8 		eRFPath,
-u32 			RegAddr,
-u32 			BitMask,
-u32 			Data
-	);
+u32 PHY_QueryBBReg_8723B(struct adapter *Adapter, u32 RegAddr, u32 BitMask);
+
+void PHY_SetBBReg_8723B(struct adapter *Adapter, u32 RegAddr,
+			u32 BitMask, u32 Data);
+
+u32 PHY_QueryRFReg_8723B(struct adapter *Adapter, u8 eRFPath,
+			 u32 RegAddr, u32 BitMask);
+
+void PHY_SetRFReg_8723B(struct adapter *Adapter, u8 eRFPath,
+			u32 RegAddr, u32 BitMask, u32 Data);
 
 /* MAC/BB/RF HAL config */
 int PHY_BBConfig8723B(struct adapter *Adapter);
@@ -64,57 +41,28 @@ int PHY_RFConfig8723B(struct adapter *Adapter);
 
 s32 PHY_MACConfig8723B(struct adapter *padapter);
 
-void
-PHY_SetTxPowerIndex(
-struct adapter *		Adapter,
-u32 				PowerIndex,
-u8 			RFPath,
-u8 			Rate
-	);
-
-u8
-PHY_GetTxPowerIndex(
-struct adapter *		padapter,
-u8 			RFPath,
-u8 			Rate,
-enum CHANNEL_WIDTH		BandWidth,
-u8 			Channel
-	);
-
-void
-PHY_GetTxPowerLevel8723B(
-struct adapter *	Adapter,
-	s32*			powerlevel
-	);
-
-void
-PHY_SetTxPowerLevel8723B(
-struct adapter *	Adapter,
-u8 	channel
-	);
-
-void
-PHY_SetBWMode8723B(
-struct adapter *			Adapter,
-enum CHANNEL_WIDTH			Bandwidth,	/*  20M or 40M */
-unsigned char 			Offset		/*  Upper, Lower, or Don't care */
-);
+void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
+			 u8 RFPath, u8 Rate);
 
-void
-PHY_SwChnl8723B(/*  Call after initialization */
-struct adapter *Adapter,
-u8 channel
-	);
-
-void
-PHY_SetSwChnlBWMode8723B(
-struct adapter *		Adapter,
-u8 			channel,
-enum CHANNEL_WIDTH		Bandwidth,
-u8 			Offset40,
-u8 			Offset80
+u8 PHY_GetTxPowerIndex(struct adapter *padapter, u8 RFPath, u8 Rate,
+			enum CHANNEL_WIDTH BandWidth, u8 Channel);
+
+void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
+
+void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
+
+void PHY_SetBWMode8723B(struct adapter *Adapter,
+			enum CHANNEL_WIDTH Bandwidth,	/*  20M or 40M */
+			unsigned char Offset	/*  Upper, Lower, or Don't care */
 );
 
+/*  Call after initialization */
+void PHY_SwChnl8723B(struct adapter *Adapter, u8 channel);
+
+void PHY_SetSwChnlBWMode8723B(struct adapter *Adapter, u8 channel,
+				enum CHANNEL_WIDTH Bandwidth,
+				u8 Offset40, u8 Offset80);
+
 /*--------------------------Exported Function prototype End---------------------*/
 
 #endif
-- 
2.25.1

