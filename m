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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E76C433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B522065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsukc+9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGZOVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGZOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:21:12 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325DFC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:21:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x9so6789953plr.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UgM1BsVmHsaMzzh6ewj32thGL7e0nNE7YBRNdbvAIEA=;
        b=gsukc+9ErkFCyi89t3AC6ZJcFp8qIEFMwV6A/bwEHK7iz7k7a29c86cWKFqkVjrW1b
         tusATpd5NnUhsLj0LZpN79OoLJlCuN213k/kobruj/UbhGmkDEpV0l5OUdNpZcV/TtFQ
         H+9G1GHlv9aK3DqN9DnKNsGoRW1lgF6F0yQCY6ZVfdhZnJjm4vKuB9YYwhbmfsG0Vqha
         FVHd469K1eSlD8mNX5kLGlavDEgtFHEXdkoDgNLuJCkcoGKF8HnLXSdOpSYPxbFPOJkj
         kHtzq/KNNQvclywfxZVqngDdyptOTx0AXGXHfnZjDDcHYXQuauPXRy9aX/ZFYkToW2pb
         Y8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgM1BsVmHsaMzzh6ewj32thGL7e0nNE7YBRNdbvAIEA=;
        b=mJls6HNxhdmmPMFm/9p8FUnOK1HhMoVdpomJHSGiTCDGlQ7oNkWmjWruJ7VSmC2G8x
         F5k5f5tLcVFR4w2LZ41EQUDhzJWQXZH+a4ZndYCDO1rz1zjBVo9/Mr+clFmlnu2SMZKt
         fW4DGegf3f6/EOZ+wd/7h9W+pbtnpplyb39RS7gzubxVJr36d1fEpGoHdaEYFj+BekV1
         rGORCpnZIeNd5cTDBBBPa8ASi/F5JTHYJGrU0c8uqTXCUDRpd2bZAGXA31UJFVokrHwe
         Qx0IhimtJoX87yZ4HK8nhBb+62ITu2e0UXbyOCktpOUfIQPRurYOpUYKrjbKsJ7tJLFG
         6s9A==
X-Gm-Message-State: AOAM530Z2fccvPvdzQqRmg0Ft87AaMr5H3z42I2YcBeTSkUixxxEb29+
        Ih5rDL7Zr6xBjcuh1wY5KIk=
X-Google-Smtp-Source: ABdhPJyTUPuiH/cTXDX2JNf0mNI4SIcdaCQtS70FQd6dN8+Gd87+hOMTM4tVvDvRmY+FAzjnucndaQ==
X-Received: by 2002:a17:90a:3044:: with SMTP id q4mr13266242pjl.81.1595773271686;
        Sun, 26 Jul 2020 07:21:11 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id a13sm12493235pfn.171.2020.07.26.07.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:21:11 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v3 3/4] staging: rtl8723bs: include: Further clean up function declarations
Date:   Sun, 26 Jul 2020 19:50:12 +0530
Message-Id: <20200726142013.2891-3-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleaning up messy multiline function declarations in hal_phy_cfg.h

This patch is a continuation of patch "Clean up function declarations"

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_cfg.h   | 56 ++++++-------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 3cec06e9f359..2b059c9c7851 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -46,49 +46,25 @@ s32 PHY_MACConfig8723B(struct adapter *padapter);
 void PHY_SetTxPowerIndex(struct adapter *Adapter, u32 PowerIndex,
 			 u8 RFPath, u8 Rate);
 
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
+u8 PHY_GetTxPowerIndex(struct adapter *padapter, u8 RFPath, u8 Rate,
+			enum CHANNEL_WIDTH BandWidth, u8 Channel);
+
+void PHY_GetTxPowerLevel8723B(struct adapter *Adapter, s32 *powerlevel);
+
+void PHY_SetTxPowerLevel8723B(struct adapter *Adapter, u8 channel);
 
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

