Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB08DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0872065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcfrRZfx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgGZOU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgGZOUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:20:55 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A716C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:20:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id il6so2075100pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P2grRz9PCgk2ZeVIhCfAMiKPxOtnJvOaxKg6ZGO8mUA=;
        b=hcfrRZfxRlpKHNckV4E8H1IKWMM0vPYAHOtfhkmGQjX0JJ1QCW7j5SYe7y7S5pA/zf
         HH3yopq6H5Q+6RNUvvXsuyNdk9bmFbCbgkIkbGMA618ccXHa8ICHjWtKk5H11tTNRvJ3
         78IdZ/TKuBdZ/SWelUV2/hF83FekXYXm9/o/gV0XksI6YRPRR+P4ovy3na0j7AlOrjUM
         hnCqZQNRnI630pOqVoKvOgAKhncZQe/mLsBI66NbZ43JNaiz/4pq+DutgSQJhPP6C892
         uedOKP/LbBao53k8snid2j938wRM2Hxjv5enLAaDdvak08tTPz//QTOTRF3aQjPJvjpA
         QgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P2grRz9PCgk2ZeVIhCfAMiKPxOtnJvOaxKg6ZGO8mUA=;
        b=K91gIn60AWIOLXp67aPUlg9y+J8CBJZnTaPdAtlzKdxdQoD9SKfUavFeQ2BGpp8kBH
         W7FLETWzd1S0osNVG2tnvYqbDSwqS9HGqzm4YA+fbL9ydQeOZiLgwgRyqxUx37LIede4
         fJ2XzTjrw5NLMjrs5wUIG+kF+ejcrORjy/LgS4ntuhqky0QCEHSJMD1pE5LKVuqhjN2b
         OctXbQ/33avXGNeFlcZ/ePgWNDT6zYsafgtqayQhe3cvKfos2LmIjSGp59hcWYxeaEKK
         gIusapBtLaQcjqR6U6BmsL7oAM4O1cHOSh3Afl2kdvODgCX+mgXiCT/ILkWD7fSkwxDx
         E3xA==
X-Gm-Message-State: AOAM530m7yNznNtzU63igii7MqbmQaLH1779O4OaljnA+uKICLDtc2ZS
        +yfnVJPjpec1S8suPKeeJPw=
X-Google-Smtp-Source: ABdhPJygNGTI0zcgc9LqGwKZYLNdXl6au3JVqqLPnPlkTPZpjgBPnWtn6+c7xroCfRWJ2eA141lhug==
X-Received: by 2002:a17:90a:d306:: with SMTP id p6mr13467646pju.25.1595773254709;
        Sun, 26 Jul 2020 07:20:54 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id a13sm12493235pfn.171.2020.07.26.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:20:54 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v3 1/4] staging: rtl8723bs: include: Fix coding style errors
Date:   Sun, 26 Jul 2020 19:50:10 +0530
Message-Id: <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
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

