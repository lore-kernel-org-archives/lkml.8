Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2537CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF071207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6V9Ua8a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387656AbgEXKRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 06:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbgEXKR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 06:17:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316CDC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 03:17:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so14292485wmd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T4m0K3FQ1TJtgciyUpUZis7pwNaXr/vlSjo6f9IEyUI=;
        b=s6V9Ua8aiZsh9BpousyxnCQ3sTeC//ibfu+YqnWX/4NE1dTifzZM49DDgaD9SgHAHW
         mtF+mq9+fEPxcgqM74/WsD8x8QZC6Hu8n735o4BRxuyjBIEv6wJwdToDsaZpm1wMu1rK
         z+eagJfwa9uqifqq0qSe8HFHQXfHRdg+Kpvt9sxSeA/5n/tvhmtTgpAR73Q7mr5Py5kJ
         +SsfmIM9vvg6v8j4zxTTDuqzkzJyyxD0kGlN4azJHSq2ypGG5RnO/o5d/YnVM5MjYwIU
         /xaIytpNmXPsNs5fk8CPLMe0v9UGn0IDWr2gAEPbzWXiJKWP3ZYHVCfH5ILcUTEDWUsP
         Wo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T4m0K3FQ1TJtgciyUpUZis7pwNaXr/vlSjo6f9IEyUI=;
        b=lnKbA/yb02EIhllGHT2dDwyWW640PHBe0P8+kcMMRjg2qDKO8jb3FBD3OtoOkPVTV2
         igj0BLVfmWkxgghT6B/EfWL9xp4eWMc1CXhwc5B53t/MXPeIfZeKo70puy2A8+L+V07c
         71aFqOFfWtJxQa0tAh087OWlc8VFcSC9UctvqN2HNrj1czKbUmW+HOs9QQtoNbuLOHDc
         YPPyCVAGmPrtVPqUtPNMuyFLLF3WnTXY/Nvi1wj4HTV/AkBwh78+klfyCPoN2NtYyBSP
         E7ddXn9Za9FcAY7zEMfaS92sBHTA8BbaFK3rpCydW6wkcTBFni9vpRLmTDDNaiUh9p0x
         QD8w==
X-Gm-Message-State: AOAM5323Mhp25fG67ZWHkJOL6Z3hxsWwi65rSV6hiBGsjdgyMTPabiik
        Ha4M580BM/6JjJyc1DQVcCo=
X-Google-Smtp-Source: ABdhPJwtQR2qyH+kWldjz/mQgH5XDqguZsV7ZVgsiWKHaIta9ODhBxa511Qn6El+zbF+yQqYd8BOqg==
X-Received: by 2002:a05:600c:48e:: with SMTP id d14mr4192893wme.133.1590315447916;
        Sun, 24 May 2020 03:17:27 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-006-252-159.178.006.pools.vodafone-ip.de. [178.6.252.159])
        by smtp.gmail.com with ESMTPSA id o6sm3819058wrp.3.2020.05.24.03.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 03:17:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/2] staging: rtl8188eu: make some arrays static const
Date:   Sun, 24 May 2020 12:15:14 +0200
Message-Id: <20200524101514.20557-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200524101514.20557-1-straube.linux@gmail.com>
References: <20200524101514.20557-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make some arrays in phy_iq_calibrate() static const and adjust
the functions that take these arrays as parameters accordingly.
Reduces object file size by 84 bytes (GCC 9.3.1 x86_64).

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/phy.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/phy.c b/drivers/staging/rtl8188eu/hal/phy.c
index a0522d6764d6..920688fc9e9f 100644
--- a/drivers/staging/rtl8188eu/hal/phy.c
+++ b/drivers/staging/rtl8188eu/hal/phy.c
@@ -786,7 +786,7 @@ static void pathb_fill_iqk(struct adapter *adapt, bool iqkok, s32 result[][8],
 	}
 }
 
-static void save_adda_registers(struct adapter *adapt, u32 *addareg,
+static void save_adda_registers(struct adapter *adapt, const u32 *addareg,
 				u32 *backup, u32 register_num)
 {
 	u32 i;
@@ -795,7 +795,7 @@ static void save_adda_registers(struct adapter *adapt, u32 *addareg,
 		backup[i] = phy_query_bb_reg(adapt, addareg[i], bMaskDWord);
 }
 
-static void save_mac_registers(struct adapter *adapt, u32 *mac_reg,
+static void save_mac_registers(struct adapter *adapt, const u32 *mac_reg,
 			       u32 *backup)
 {
 	u32 i;
@@ -806,7 +806,7 @@ static void save_mac_registers(struct adapter *adapt, u32 *mac_reg,
 	backup[i] = usb_read32(adapt, mac_reg[i]);
 }
 
-static void reload_adda_reg(struct adapter *adapt, u32 *adda_reg,
+static void reload_adda_reg(struct adapter *adapt, const u32 *adda_reg,
 			    u32 *backup, u32 regiester_num)
 {
 	u32 i;
@@ -815,8 +815,8 @@ static void reload_adda_reg(struct adapter *adapt, u32 *adda_reg,
 		phy_set_bb_reg(adapt, adda_reg[i], bMaskDWord, backup[i]);
 }
 
-static void reload_mac_registers(struct adapter *adapt,
-				 u32 *mac_reg, u32 *backup)
+static void reload_mac_registers(struct adapter *adapt, const u32 *mac_reg,
+				 u32 *backup)
 {
 	u32 i;
 
@@ -826,7 +826,7 @@ static void reload_mac_registers(struct adapter *adapt,
 	usb_write32(adapt, mac_reg[i], backup[i]);
 }
 
-static void path_adda_on(struct adapter *adapt, u32 *adda_reg,
+static void path_adda_on(struct adapter *adapt, const u32 *adda_reg,
 			 bool is_path_a_on, bool is2t)
 {
 	u32 path_on;
@@ -844,7 +844,8 @@ static void path_adda_on(struct adapter *adapt, u32 *adda_reg,
 		phy_set_bb_reg(adapt, adda_reg[i], bMaskDWord, path_on);
 }
 
-static void mac_setting_calibration(struct adapter *adapt, u32 *mac_reg, u32 *backup)
+static void mac_setting_calibration(struct adapter *adapt, const u32 *mac_reg,
+				    u32 *backup)
 {
 	u32 i = 0;
 
@@ -952,7 +953,7 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 	struct odm_dm_struct *dm_odm = &adapt->HalData->odmpriv;
 	u32 i;
 	u8 path_a_ok, path_b_ok;
-	u32 adda_reg[IQK_ADDA_REG_NUM] = {
+	static const u32 adda_reg[IQK_ADDA_REG_NUM] = {
 		rFPGA0_XCD_SwitchControl, rBlue_Tooth,
 		rRx_Wait_CCA, rTx_CCK_RFON,
 		rTx_CCK_BBON, rTx_OFDM_RFON,
@@ -962,12 +963,12 @@ static void phy_iq_calibrate(struct adapter *adapt, s32 result[][8],
 		rRx_TO_Rx, rStandby,
 		rSleep, rPMPD_ANAEN
 	};
-	u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
+	static const u32 iqk_mac_reg[IQK_MAC_REG_NUM] = {
 		REG_TXPAUSE, REG_BCN_CTRL,
 		REG_BCN_CTRL_1, REG_GPIO_MUXCFG
 	};
 	/* since 92C & 92D have the different define in IQK_BB_REG */
-	u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
+	static const u32 iqk_bb_reg_92c[IQK_BB_REG_NUM] = {
 		rOFDM0_TRxPathEnable, rOFDM0_TRMuxPar,
 		rFPGA0_XCD_RFInterfaceSW, rConfig_AntA, rConfig_AntB,
 		rFPGA0_XAB_RFInterfaceSW, rFPGA0_XA_RFInterfaceOE,
-- 
2.26.2

