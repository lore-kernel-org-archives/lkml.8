Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E8DC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45FD82187F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1h05tkY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgANNpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33338 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgANNpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:45:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so2359312wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H5pgahcKzcsGLYm3HCTp6kuWUGFmaO98tCAh35M9tis=;
        b=F1h05tkYwEuuSjvSlnbzm4t96VPN8YNHCB8meS50nK4gDMe0kaN6xKQGEaCnJZ3T/r
         hIb3mhhPHogJG2n+GuRytmq/YYosk5hEy5A+kP6txRhIhzoinL/sxH2sPGFR7iPLtW1q
         ekP3KPoQJdPhTALkGoxSmSENSNUeVyMJ3CtwiMkEZPzzNglU47YQbQU+ZfW4XOMv4gyb
         26tSF4W0NRHVX7SSbeS3goI8In/XJgk0JW15vGRnkB3bEn3MCS2U5NpHBXiD4/a635YZ
         I9yVpjK4WnVBY34C0s1mX8mf4Mjya2BXKO2FlqQthlWnMtP5t2hnARGPKmVHSH2tAdwt
         RgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H5pgahcKzcsGLYm3HCTp6kuWUGFmaO98tCAh35M9tis=;
        b=OI8fREdV+dEg+WpySpgWyQ+m9hVfYOsNvEaLH6iWQE0vEtnTb6boUQQGFp0pyzbjgI
         wJUYQii3/NzckdSqvIrELO5tnrz/10Zn88ZPC4bkj7YzJIE6QgorZLK1kReXJDbEhezy
         dhaYEYbc3WpvfI4PqidH0p2pIsM+QkYI/IL7HLqiCnGa3sGLzAny/cbPLaVh5AcAKuz7
         QsG9n9s7VVGUtRmVU1cmenFlsdaSt3SxdFQd74jPUKcdrxGuBTinhCfvCHMeLVCltqyg
         kTYSDmTRt8vtdb+3zI3fNDRS6uY4cmML26fJj7suzEPe4guW2nxX9A7vHeuqgPW1ipYW
         O76g==
X-Gm-Message-State: APjAAAXn9KRNdNINw9orR5sOxx3MLsi7LDANBm3ZFb87068M4hDi3t/H
        jbUKCkTPHvpjZ7AN7kOx+gU=
X-Google-Smtp-Source: APXvYqx9vqod9rD0/2L4fJTgpjwdJgh7w8NLI6DG2fuKwjp0n36+ytZMdJJ71TzFNprWaRa5t9fUog==
X-Received: by 2002:a1c:e289:: with SMTP id z131mr25829140wmg.18.1579009508086;
        Tue, 14 Jan 2020 05:45:08 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-164.088.070.pools.vodafone-ip.de. [88.70.28.164])
        by smtp.gmail.com with ESMTPSA id x10sm19361333wrp.58.2020.01.14.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:45:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/5] staging: rtl8188eu: cleanup whitespace in rtl8188e_dm.c
Date:   Tue, 14 Jan 2020 14:44:22 +0100
Message-Id: <20200114134422.13598-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114134422.13598-1-straube.linux@gmail.com>
References: <20200114134422.13598-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace tabs with spaces and/or remove spaces to use typical kernel
horizontal whitespace.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 44 ++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 5348db2725a1..241f55b92808 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -21,7 +21,7 @@
 /*  Initialize GPIO setting registers */
 static void dm_InitGPIOSetting(struct adapter *Adapter)
 {
-	u8	tmp1byte;
+	u8 tmp1byte;
 
 	tmp1byte = usb_read8(Adapter, REG_GPIO_MUXCFG);
 	tmp1byte &= (GPIOSEL_GPIO | ~GPIOSEL_ENBT);
@@ -35,7 +35,7 @@ static void dm_InitGPIOSetting(struct adapter *Adapter)
 static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 {
 	struct hal_data_8188e *hal_data = Adapter->HalData;
-	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	struct dm_priv *pdmpriv = &hal_data->dmpriv;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
 
 	/*  Init Value */
@@ -59,38 +59,38 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;
 
-	pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION |
-				ODM_RF_TX_PWR_TRACK;
+	pdmpriv->InitODMFlag = ODM_RF_CALIBRATION |
+			       ODM_RF_TX_PWR_TRACK;
 
 	dm_odm->SupportAbility = pdmpriv->InitODMFlag;
 }
 
 static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 {
-	struct mlme_ext_priv	*pmlmeext = &Adapter->mlmeextpriv;
-	struct mlme_priv	*pmlmepriv = &Adapter->mlmepriv;
+	struct mlme_ext_priv *pmlmeext = &Adapter->mlmeextpriv;
+	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
 	struct pwrctrl_priv *pwrctrlpriv = &Adapter->pwrctrlpriv;
 	struct hal_data_8188e *hal_data = Adapter->HalData;
 	struct odm_dm_struct *dm_odm = &hal_data->odmpriv;
-	struct dm_priv	*pdmpriv = &hal_data->dmpriv;
+	struct dm_priv *pdmpriv = &hal_data->dmpriv;
 	int i;
 
-	pdmpriv->InitODMFlag =	ODM_BB_DIG |
-				ODM_BB_RA_MASK |
-				ODM_BB_DYNAMIC_TXPWR |
-				ODM_BB_FA_CNT |
-				ODM_BB_RSSI_MONITOR |
-				ODM_BB_CCK_PD |
-				ODM_BB_PWR_SAVE |
-				ODM_MAC_EDCA_TURBO |
-				ODM_RF_CALIBRATION |
-				ODM_RF_TX_PWR_TRACK;
+	pdmpriv->InitODMFlag = ODM_BB_DIG |
+			       ODM_BB_RA_MASK |
+			       ODM_BB_DYNAMIC_TXPWR |
+			       ODM_BB_FA_CNT |
+			       ODM_BB_RSSI_MONITOR |
+			       ODM_BB_CCK_PD |
+			       ODM_BB_PWR_SAVE |
+			       ODM_MAC_EDCA_TURBO |
+			       ODM_RF_CALIBRATION |
+			       ODM_RF_TX_PWR_TRACK;
 	if (hal_data->AntDivCfg)
 		pdmpriv->InitODMFlag |= ODM_BB_ANT_DIV;
 
 	if (Adapter->registrypriv.mp_mode == 1) {
-		pdmpriv->InitODMFlag =	ODM_RF_CALIBRATION |
-					ODM_RF_TX_PWR_TRACK;
+		pdmpriv->InitODMFlag = ODM_RF_CALIBRATION |
+				       ODM_RF_TX_PWR_TRACK;
 	}
 
 	dm_odm->SupportAbility = pdmpriv->InitODMFlag;
@@ -123,7 +123,7 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 void rtl8188e_InitHalDm(struct adapter *Adapter)
 {
-	struct dm_priv	*pdmpriv = &Adapter->HalData->dmpriv;
+	struct dm_priv *pdmpriv = &Adapter->HalData->dmpriv;
 	struct odm_dm_struct *dm_odm = &Adapter->HalData->odmpriv;
 
 	dm_InitGPIOSetting(Adapter);
@@ -167,7 +167,7 @@ void rtw_hal_dm_watchdog(struct adapter *Adapter)
 
 void rtw_hal_dm_init(struct adapter *Adapter)
 {
-	struct dm_priv	*pdmpriv = &Adapter->HalData->dmpriv;
+	struct dm_priv *pdmpriv = &Adapter->HalData->dmpriv;
 	struct odm_dm_struct *podmpriv = &Adapter->HalData->odmpriv;
 
 	memset(pdmpriv, 0, sizeof(struct dm_priv));
@@ -185,7 +185,7 @@ void rtw_hal_antdiv_rssi_compared(struct adapter *Adapter,
 		/* select optimum_antenna for before linked => For antenna
 		 * diversity
 		 */
-		if (dst->Rssi >=  src->Rssi) {/* keep org parameter */
+		if (dst->Rssi >= src->Rssi) {/* keep org parameter */
 			src->Rssi = dst->Rssi;
 			src->PhyInfo.Optimum_antenna =
 				dst->PhyInfo.Optimum_antenna;
-- 
2.24.1

