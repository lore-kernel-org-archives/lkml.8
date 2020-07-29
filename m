Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB12DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95D42075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luCydVO9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG2TWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgG2TWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:22:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7C8C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:22:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z188so5633264pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sxdfgFg/+YKF2vVbSCxbDEow+54W6Crwq1vgBu5NBEs=;
        b=luCydVO9DWb8AUtr2HzSKMOCmL4a6u5HHJ8WUXnbsPvghNMRuqUjH8IvhTSeWJ9v8t
         lebJddla/iyAPy9GmxWlYtGhwhpqAKbt3XjBCHRe/ZP7KHrum6GkVqXlvjTSSFou5KPk
         pJZhA56FClTffQw9gBJ+KfHzh+q7YtsxJqBZXQsBLsyimz7jUGt2DW/1SrIdZ37u4OJ3
         1JFeTTmNl/Gj1vTczhkuUsUsx2xAo9kVM6UA1US3KKZKegiYxBmoJD+Agxm4Tv7qCd8Z
         xIaoazZaqfFqepWqc7Aa4Nu7Q4J+57ISA4srXQrHdzM923IoBy873FaBieqEBEmRVbon
         KTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sxdfgFg/+YKF2vVbSCxbDEow+54W6Crwq1vgBu5NBEs=;
        b=kI9Uif9vGh/uIgJla17JI68/6GRnGoEFGSmTCnx8eZ0j1lhFZG9O23PYyOVLolpkw3
         80IkvlvGwHuGypBLAkFv6NjRqjobsZ3WpXXpvIv2nDko5SQq/3ckRmboyfUo0XzWpXo7
         yKpWIcm9u46HMv4fL+PiVnWW/Vd+Uw00QnFqWXES3b8RhdOjSnqigiHj/2PM2pGgtpBs
         YVUPuI4atR0AuAm5meO4CzqKPMFUZl+FzzgoFQyo+qVkpZAZ50M9HDF5Adgg2F9zDKBl
         odNMZA6I+isMnKHjek86SddCeypNq72CoW0AFnJg6X+VrjFYUOBjZsTsbvHrdAe2a11K
         sdKg==
X-Gm-Message-State: AOAM530tCFYEg3Am/8WoqF5Sqi8BCScQvKbn/bzrV6msQpXQZj+4VCMG
        NKa22CA8in5SCfBt8gtHazM=
X-Google-Smtp-Source: ABdhPJyKiyRtOMcLkIJ0dDVgMCU3eDC6dC8GyPT1NQ2lR8sKkgj0IpIhsGZmgOklXEg9n0wu6RL3Ag==
X-Received: by 2002:a63:1408:: with SMTP id u8mr31585696pgl.282.1596050525566;
        Wed, 29 Jul 2020 12:22:05 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id hg7sm599431pjb.24.2020.07.29.12.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:22:04 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, joe@perches.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v4 2/3] staging: rtl8723bs: Clean up function declations
Date:   Thu, 30 Jul 2020 00:51:35 +0530
Message-Id: <20200729192136.23828-3-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729192136.23828-1-aditya.jainadityajain.jain@gmail.com>
References: <CAJAoDUjVBon2iiztdER82mHgJtVS6s5XYSajbCTne0KWAzoLvg@mail.gmail.com>
 <20200729192136.23828-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up multiline function declartions in hal_phy_cfg.h
to improve code readablility

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_cfg.h   | 110 +++++-------------
 1 file changed, 29 insertions(+), 81 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 7e48abc4c760..0eb3e57f4082 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -25,37 +25,16 @@
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
-struct adapter *Adapter,
-u8 		eRFPath,
-u32 			RegAddr,
-u32 			BitMask
-	);
-
-void
-PHY_SetRFReg_8723B(
-struct adapter *Adapter,
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
@@ -64,56 +43,25 @@ int PHY_RFConfig8723B(struct adapter *Adapter);
 
 s32 PHY_MACConfig8723B(struct adapter *padapter);
 
-void
-PHY_SetTxPowerIndex(
-struct adapter *Adapter,
-u32 				PowerIndex,
-u8 			RFPath,
-u8 			Rate
-	);
-
-u8
-PHY_GetTxPowerIndex(
-struct adapter *padapter,
-u8 			RFPath,
-u8 			Rate,
-enum CHANNEL_WIDTH		BandWidth,
-u8 			Channel
-	);
-
-void
-PHY_GetTxPowerLevel8723B(
-struct adapter *Adapter,
-	s32 *powerlevel
-	);
-
-void
-PHY_SetTxPowerLevel8723B(
-struct adapter *Adapter,
-u8 	channel
-	);
-
-void
-PHY_SetBWMode8723B(
-struct adapter *Adapter,
-enum CHANNEL_WIDTH			Bandwidth,	/*  20M or 40M */
-unsigned char 			Offset		/*  Upper, Lower, or Don't care */
-);
-
-void
-PHY_SwChnl8723B(/*  Call after initialization */
-struct adapter *Adapter,
-u8 channel
-	);
-
-void
-PHY_SetSwChnlBWMode8723B(
-struct adapter *Adapter,
-u8 			channel,
-enum CHANNEL_WIDTH		Bandwidth,
-u8 			Offset40,
-u8 			Offset80
-);
+void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
+			 u8 RFPath, u8 Rate);
+
+u8 PHY_GetTxPowerIndex(struct adapter *padapter, u8 RFPath, u8 Rate,
+			enum CHANNEL_WIDTH BandWidth, u8 Channel);
+
+void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
+
+void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
+
+void PHY_SetBWMode8723B(struct adapter *Adapter, enum CHANNEL_WIDTH Bandwidth,
+			unsigned char Offset);
+
+/*  Call after initialization */
+void PHY_SwChnl8723B(struct adapter *Adapter, u8 channel);
+
+void PHY_SetSwChnlBWMode8723B(struct adapter *Adapter, u8 channel,
+				enum CHANNEL_WIDTH Bandwidth,
+				u8 Offset40, u8 Offset80);
 
 /*--------------------------Exported Function prototype End---------------------*/
 
-- 
2.25.1

