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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4288720714
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKOZq2jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGZICr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZICq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:02:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F930C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:02:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f7so1671346pln.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYKrfpkuYtuN4Vp3wBicq+wnj7FGd9Dpk+b0emDqktc=;
        b=GKOZq2jvqXpFVrX7fzgIYcV5k+gMS4l2jCKOJkM1TBvU9XYh2sZTr9497nDA6VkdDy
         lPB8S+gttfKfwT/puQwBkmRB5SFr+Jr+juE61S8BqG4b9LkYd29DZCcuUWgYiLD0wSJA
         p6IUdl9E2C8lNrSlEe3038dUFQEq7PlikztdfWq52T61dgTvEhvWxQNQWn02y4JF13PD
         Pzsc8OsqELZezRT0MqhzjsU3L+j6N3KfTxSAxY1AwumNEmgQjEmSPIqAfcuEvqnYKe2T
         54Z9j9NHpGfX/6hBRdamyjg2frMEXrILFIWRz5578d+w64z5GPq+nmnVMdaB4h1BMSAn
         kXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dYKrfpkuYtuN4Vp3wBicq+wnj7FGd9Dpk+b0emDqktc=;
        b=GhFVj2qt1Jykx1xYxeLWU6biMWWDmAWCrSx48W9aUZrnUMH86tm08neNUGQuqvPwSu
         VLf0SFDA3ZdIz/tIxpY8pXLRRXkcPvKrXWLPomtk1iGr+KBJCBV6mjqp3RYcoN04/GwP
         bm3lWjnA0WgQUyr487rR3ThGYE/djb3FExbRuIFBz8jE2QhJY+c3QwZLkzZu0NBiH5nN
         p/M/z8dB1Fg5sskc9wSy67fM0NlIW7+dbYbp1p958bWFETbsQMmZ7DbwhnLxVttrmt4H
         V5zQ0Da2iJ62Z9hZPPK9cQ+HmxIyHwQzphSPSresXE6cbxmo4ARh51g7gmJ2g0x6qNDz
         d55A==
X-Gm-Message-State: AOAM531cdCXBmQ/OnkvT9zr+q0BKkMVm69fD7kBhNOWJghh5QM3ztXoR
        lgJDyPHqOpzpfU1DXkdce2o=
X-Google-Smtp-Source: ABdhPJxgk0aUpcj/s5echwyaxidiIDyMu+dypbH26R8zqWRkTfkjjahVJiitm2CYLcXq2KK0nbFzsw==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr14567125pls.61.1595750566008;
        Sun, 26 Jul 2020 01:02:46 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id b18sm10638648pju.10.2020.07.26.01.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 01:02:45 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH] staging: rtl8723bs: include: Fix coding style errors
Date:   Sun, 26 Jul 2020 13:32:15 +0530
Message-Id: <20200726080215.41501-1-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing ERROR: "foo *	bar" should be "foo *bar" in hal_phy_cfg.h
as reported by checkpatch.pl

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_cfg.h    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 419ddb0733aa..fd5f377bad4f 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -42,7 +42,7 @@ u32 	Data
 
 u32
 PHY_QueryRFReg_8723B(
-struct adapter *		Adapter,
+struct adapter 		*Adapter,
 u8 		eRFPath,
 u32 			RegAddr,
 u32 			BitMask
@@ -50,7 +50,7 @@ u32 			BitMask
 
 void
 PHY_SetRFReg_8723B(
-struct adapter *		Adapter,
+struct adapter 		*Adapter,
 u8 		eRFPath,
 u32 			RegAddr,
 u32 			BitMask,
@@ -66,7 +66,7 @@ s32 PHY_MACConfig8723B(struct adapter *padapter);
 
 void
 PHY_SetTxPowerIndex(
-struct adapter *		Adapter,
+struct adapter 			*Adapter,
 u32 				PowerIndex,
 u8 			RFPath,
 u8 			Rate
@@ -74,7 +74,7 @@ u8 			Rate
 
 u8
 PHY_GetTxPowerIndex(
-struct adapter *		padapter,
+struct adapter 			*padapter,
 u8 			RFPath,
 u8 			Rate,
 enum CHANNEL_WIDTH		BandWidth,
@@ -83,19 +83,19 @@ u8 			Channel
 
 void
 PHY_GetTxPowerLevel8723B(
-struct adapter *	Adapter,
-	s32*			powerlevel
+struct adapter 			*Adapter,
+	s32			*powerlevel
 	);
 
 void
 PHY_SetTxPowerLevel8723B(
-struct adapter *	Adapter,
+struct adapter 		*Adapter,
 u8 	channel
 	);
 
 void
 PHY_SetBWMode8723B(
-struct adapter *			Adapter,
+struct adapter 				*Adapter,
 enum CHANNEL_WIDTH			Bandwidth,	/*  20M or 40M */
 unsigned char 			Offset		/*  Upper, Lower, or Don't care */
 );
@@ -108,7 +108,7 @@ u8 channel
 
 void
 PHY_SetSwChnlBWMode8723B(
-struct adapter *		Adapter,
+struct adapter 		*Adapter,
 u8 			channel,
 enum CHANNEL_WIDTH		Bandwidth,
 u8 			Offset40,
-- 
2.25.1

