Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C68C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74802082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIX6XtBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgG2TWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgG2TWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:22:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E6C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:22:03 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id kr4so486606pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2grRz9PCgk2ZeVIhCfAMiKPxOtnJvOaxKg6ZGO8mUA=;
        b=dIX6XtBN+kUmQxdsfW7VBR+hCZQ5Fd9HKvN3ZdpR3J3i1X3bbfXMPofN8G0gh+h8Ee
         tm2YRFo0ttxD6LqFuxHrFCWlDvrHw0sZ+0ykWXAO/+Qbgc/PxP47xZiU3w+//Yihb+0R
         +T2rton5eG3+3k3+hjd/JIodLrXJfa4TDmBQn22vyLL+b/vezZXOj4vrSLTglbSy0ZQu
         Gevz4Y/sV/fEEBTfsSD9E6C31xHejzWHN+1Js/xH4FYwXgdrQ5bHid2CcVvWu6NKMmGi
         dluC+nfneIHvB3WKOMCDfW3tPYgg83AjLMCaE/B8cKDTPnHgYRuU7hcD+6O3dhWeSGdp
         56EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2grRz9PCgk2ZeVIhCfAMiKPxOtnJvOaxKg6ZGO8mUA=;
        b=SuxBpEuxS/oewwDcItBroADydteay/qrRMiXrxC2nkJL27V+RobyLcOmoUno9KKTkL
         4H4hRWNcvU5qiP0HLRBRIFDAEJOgHWXqF+R7FMOe7ysbdvGvkq4x1od8vX/GTMFaU+WA
         iKuAErV1NAAIE7BvJLkWTu+TK6n+TUPn/dL45+n204MXvNaQKGBroc6jGsukSBkqm1Ms
         EGgLE95Hf6wMAazFTwpt00Hyz5K+g8IXXUtbPVVvDPjdBqolHZ6Y6zrJyWajWGd/dFv8
         42SUUl371WjtAVgmdIm+QsT/cDsZjmo/RoWrQZml/yCo4lvUa1qYqPdr9qbGeD2G+bXq
         EdOA==
X-Gm-Message-State: AOAM530q9yV3GxsCQIF5Q3vCDYjfA3bzOzb/6x1vrDFBrx05bZwaW9EA
        eiYWQk0/33XM5U30oESWbzA=
X-Google-Smtp-Source: ABdhPJx9d00VTRIC589bDdRp4nk/Do8tibFvjOXpjwsfs9SJUvWMyFY5Bjf5e4Q9DNDr7bT7Ypidjw==
X-Received: by 2002:a17:902:6b08:: with SMTP id o8mr29014174plk.104.1596050522549;
        Wed, 29 Jul 2020 12:22:02 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id hg7sm599431pjb.24.2020.07.29.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:22:01 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, joe@perches.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v4 1/3] staging: rtl8723bs: Fix coding style errors
Date:   Thu, 30 Jul 2020 00:51:34 +0530
Message-Id: <20200729192136.23828-2-aditya.jainadityajain.jain@gmail.com>
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

Fixing ERROR: "foo *	bar" should be "foo *bar" in hal_phy_cfg.h
as reported by checkpatch.pl

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 .../staging/rtl8723bs/include/hal_phy_cfg.h    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 419ddb0733aa..7e48abc4c760 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -42,7 +42,7 @@ u32 	Data
 
 u32
 PHY_QueryRFReg_8723B(
-struct adapter *		Adapter,
+struct adapter *Adapter,
 u8 		eRFPath,
 u32 			RegAddr,
 u32 			BitMask
@@ -50,7 +50,7 @@ u32 			BitMask
 
 void
 PHY_SetRFReg_8723B(
-struct adapter *		Adapter,
+struct adapter *Adapter,
 u8 		eRFPath,
 u32 			RegAddr,
 u32 			BitMask,
@@ -66,7 +66,7 @@ s32 PHY_MACConfig8723B(struct adapter *padapter);
 
 void
 PHY_SetTxPowerIndex(
-struct adapter *		Adapter,
+struct adapter *Adapter,
 u32 				PowerIndex,
 u8 			RFPath,
 u8 			Rate
@@ -74,7 +74,7 @@ u8 			Rate
 
 u8
 PHY_GetTxPowerIndex(
-struct adapter *		padapter,
+struct adapter *padapter,
 u8 			RFPath,
 u8 			Rate,
 enum CHANNEL_WIDTH		BandWidth,
@@ -83,19 +83,19 @@ u8 			Channel
 
 void
 PHY_GetTxPowerLevel8723B(
-struct adapter *	Adapter,
-	s32*			powerlevel
+struct adapter *Adapter,
+	s32 *powerlevel
 	);
 
 void
 PHY_SetTxPowerLevel8723B(
-struct adapter *	Adapter,
+struct adapter *Adapter,
 u8 	channel
 	);
 
 void
 PHY_SetBWMode8723B(
-struct adapter *			Adapter,
+struct adapter *Adapter,
 enum CHANNEL_WIDTH			Bandwidth,	/*  20M or 40M */
 unsigned char 			Offset		/*  Upper, Lower, or Don't care */
 );
@@ -108,7 +108,7 @@ u8 channel
 
 void
 PHY_SetSwChnlBWMode8723B(
-struct adapter *		Adapter,
+struct adapter *Adapter,
 u8 			channel,
 enum CHANNEL_WIDTH		Bandwidth,
 u8 			Offset40,
-- 
2.25.1

