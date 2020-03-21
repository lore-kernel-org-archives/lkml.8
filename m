Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018FFC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3672076E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de9JvBu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgCUW2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:28:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33835 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgCUW2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:28:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so5402253pfj.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FJ7czszs6QJI52MOo7v8xxGTQX047zvU5p3YQaPDb+k=;
        b=de9JvBu2UqzMxj3fuRcgHmsF8hzyM0lXaU4CooF6DJPHUeBi3LCTAal4ol13kbVilZ
         86FsZIrgyzdcrcxUhmW/A3Yd8XalKO0AcuwK4C9qjUYIXiyiIU5ggvCpa3/TIo/B+Yfn
         ylFfxDjVCOQmEi49R/+DOBPx1x+oMVYXsviaRfQr33He2KxH0tnzEBVKkcOhc0ZPDT+S
         1bDuMiUlWZT48OpLLJi3A3lwixRXplyef/AeyATPDmhJe9rhckhseiQGH9OspqXTMTY3
         xBq7vZqcBGu8FTyiHzM8g5VRx4BJzlxWs3LBXZ3ssyLYiQUJ3gTr0y1kzbivvUUqWHcO
         avYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FJ7czszs6QJI52MOo7v8xxGTQX047zvU5p3YQaPDb+k=;
        b=kYjdFnxSNW8QKiGAqzYZYOBc7bpoIiLu3UaDlKHFbQM+hkOKcWsVd84QOoLuIgH6hF
         vUIGyaujtrkhIwlnyIdxfprHqq+5GlzaDYw+OwD9qwdWSv4N/8RpbjYfWxupIFaOUsCs
         dKsexRX74zGYmkk1hJ8LgXlEG+7Ut8heb/QfMorZRODB51BarpmXuiCil6zgRSR96r+2
         8ywwQlnFyMIsotNXqByFbCPGfbnNFzqPk+1hkiqbpc9VRgX3YEn9wTDSuMus7JaOsD75
         fK8pI/Ns0iXIwLUQUcERE+PM5hFsM0IHfMM8bf+8ihC3lFpn8mLzAafxqIBlU+BQt8Ui
         ARLQ==
X-Gm-Message-State: ANhLgQ3uICDehnJoN0XLn9URn2eCAK4WdU2KpmR5nrajQqQroXEnjgei
        jVSWR8kBICmZBlCZhYyKrw0=
X-Google-Smtp-Source: ADFU+vuAsXLUZyWdCi00/+gbyfM2ZW5TuFWAHnTtWoqJPja0gR4H4X5dfAtlE4p+62pU3bHb/Ni+Eg==
X-Received: by 2002:a62:7d4e:: with SMTP id y75mr16802146pfc.32.1584829709861;
        Sat, 21 Mar 2020 15:28:29 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id l13sm2476898pjq.42.2020.03.21.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:28:29 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 09/11] Staging: rtl8188eu: rtl8188e_hal_init: Add space around operators
Date:   Sun, 22 Mar 2020 03:58:23 +0530
Message-Id: <7b214cfa7179468b7cd25759612d0f29c7fc9aed.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1584826154.git.shreeya.patel23498@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around operators for improving the code
readability.
Reported by checkpatch.pl

git diff -w shows no difference.
diff of the .o files before and after the changes shows no difference.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff rtl8188e_hal_init_old.o rtl8188e_hal_init.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 .../staging/rtl8188eu/hal/rtl8188e_hal_init.c | 44 +++++++++----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
index 57ae0e83dd3e..740004d71a15 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_hal_init.c
@@ -22,7 +22,7 @@ void iol_mode_enable(struct adapter *padapter, u8 enable)
 	if (enable) {
 		/* Enable initial offload */
 		reg_0xf0 = usb_read8(padapter, REG_SYS_CFG);
-		usb_write8(padapter, REG_SYS_CFG, reg_0xf0|SW_OFFLOAD_EN);
+		usb_write8(padapter, REG_SYS_CFG, reg_0xf0 | SW_OFFLOAD_EN);
 
 		if (!padapter->bFWReady) {
 			DBG_88E("bFWReady == false call reset 8051...\n");
@@ -42,9 +42,9 @@ s32 iol_execute(struct adapter *padapter, u8 control)
 	u8 reg_0x88 = 0;
 	unsigned long start = 0;
 
-	control = control&0x0f;
+	control = control & 0x0f;
 	reg_0x88 = usb_read8(padapter, REG_HMEBOX_E0);
-	usb_write8(padapter, REG_HMEBOX_E0,  reg_0x88|control);
+	usb_write8(padapter, REG_HMEBOX_E0,  reg_0x88 | control);
 
 	start = jiffies;
 	while ((reg_0x88 = usb_read8(padapter, REG_HMEBOX_E0)) & control &&
@@ -54,7 +54,7 @@ s32 iol_execute(struct adapter *padapter, u8 control)
 
 	reg_0x88 = usb_read8(padapter, REG_HMEBOX_E0);
 	status = (reg_0x88 & control) ? _FAIL : _SUCCESS;
-	if (reg_0x88 & control<<4)
+	if (reg_0x88 & control << 4)
 		status = _FAIL;
 	return status;
 }
@@ -64,7 +64,7 @@ static s32 iol_InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy)
 	s32 rst = _SUCCESS;
 
 	iol_mode_enable(padapter, 1);
-	usb_write8(padapter, REG_TDECTRL+1, txpktbuf_bndy);
+	usb_write8(padapter, REG_TDECTRL + 1, txpktbuf_bndy);
 	rst = iol_execute(padapter, CMD_INIT_LLT);
 	iol_mode_enable(padapter, 0);
 	return rst;
@@ -92,9 +92,9 @@ void _8051Reset88E(struct adapter *padapter)
 {
 	u8 u1bTmp;
 
-	u1bTmp = usb_read8(padapter, REG_SYS_FUNC_EN+1);
-	usb_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp&(~BIT(2)));
-	usb_write8(padapter, REG_SYS_FUNC_EN+1, u1bTmp|(BIT(2)));
+	u1bTmp = usb_read8(padapter, REG_SYS_FUNC_EN + 1);
+	usb_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp & (~BIT(2)));
+	usb_write8(padapter, REG_SYS_FUNC_EN + 1, u1bTmp | (BIT(2)));
 	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
 }
 
@@ -122,7 +122,7 @@ void rtw_hal_read_chip_version(struct adapter *padapter)
 	value32 = usb_read32(padapter, REG_SYS_CFG);
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
-	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK)>>CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
+	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK) >> CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
 
 	dump_chip_info(ChipVersion);
 
@@ -163,10 +163,10 @@ void rtw_hal_notch_filter(struct adapter *adapter, bool enable)
 {
 	if (enable) {
 		DBG_88E("Enable notch filter\n");
-		usb_write8(adapter, rOFDM0_RxDSP+1, usb_read8(adapter, rOFDM0_RxDSP+1) | BIT(1));
+		usb_write8(adapter, rOFDM0_RxDSP + 1, usb_read8(adapter, rOFDM0_RxDSP + 1) | BIT(1));
 	} else {
 		DBG_88E("Disable notch filter\n");
-		usb_write8(adapter, rOFDM0_RxDSP+1, usb_read8(adapter, rOFDM0_RxDSP+1) & ~BIT(1));
+		usb_write8(adapter, rOFDM0_RxDSP + 1, usb_read8(adapter, rOFDM0_RxDSP + 1) & ~BIT(1));
 	}
 }
 
@@ -308,7 +308,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 			if (pwrInfo24G->IndexCCK_Base[rfPath][group] == 0xFF)
 				pwrInfo24G->IndexCCK_Base[rfPath][group] = EEPROM_DEFAULT_24G_INDEX;
 		}
-		for (group = 0; group < MAX_CHNL_GROUP_24G-1; group++) {
+		for (group = 0; group < MAX_CHNL_GROUP_24G - 1; group++) {
 			pwrInfo24G->IndexBW40_Base[rfPath][group] =	PROMContent[eeAddr++];
 			if (pwrInfo24G->IndexBW40_Base[rfPath][group] == 0xFF)
 				pwrInfo24G->IndexBW40_Base[rfPath][group] =	EEPROM_DEFAULT_24G_INDEX;
@@ -319,7 +319,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] = EEPROM_DEFAULT_24G_HT20_DIFF;
 				} else {
-					pwrInfo24G->BW20_Diff[rfPath][TxCount] = (PROMContent[eeAddr]&0xf0)>>4;
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] = (PROMContent[eeAddr] & 0xf0) >> 4;
 					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -327,7 +327,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_24G_OFDM_DIFF;
 				} else {
-					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0x0f);
 					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -337,7 +337,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
+					pwrInfo24G->BW40_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0xf0) >> 4;
 					if (pwrInfo24G->BW40_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW40_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -345,7 +345,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					pwrInfo24G->BW20_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0x0f);
 					if (pwrInfo24G->BW20_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->BW20_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -354,7 +354,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->OFDM_Diff[rfPath][TxCount] = EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0xf0)>>4;
+					pwrInfo24G->OFDM_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0xf0) >> 4;
 					if (pwrInfo24G->OFDM_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->OFDM_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -362,7 +362,7 @@ static void Hal_ReadPowerValueFromPROM_8188E(struct txpowerinfo24g *pwrInfo24G,
 				if (PROMContent[eeAddr] == 0xFF) {
 					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	EEPROM_DEFAULT_DIFF;
 				} else {
-					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	(PROMContent[eeAddr]&0x0f);
+					pwrInfo24G->CCK_Diff[rfPath][TxCount] =	(PROMContent[eeAddr] & 0x0f);
 					if (pwrInfo24G->CCK_Diff[rfPath][TxCount] & BIT(3))		/* 4bit sign number to 8 bit sign number */
 						pwrInfo24G->CCK_Diff[rfPath][TxCount] |= 0xF0;
 				}
@@ -450,9 +450,9 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 	/*  2010/10/19 MH Add Regulator recognize for CU. */
 	if (!AutoLoadFail) {
-		pHalData->EEPROMRegulatory = (PROMContent[EEPROM_RF_BOARD_OPTION_88E]&0x7);	/* bit0~2 */
+		pHalData->EEPROMRegulatory = (PROMContent[EEPROM_RF_BOARD_OPTION_88E] & 0x7);	/* bit0~2 */
 		if (PROMContent[EEPROM_RF_BOARD_OPTION_88E] == 0xFF)
-			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION&0x7);	/* bit0~2 */
+			pHalData->EEPROMRegulatory = (EEPROM_DEFAULT_BOARD_OPTION & 0x7);	/* bit0~2 */
 	} else {
 		pHalData->EEPROMRegulatory = 0;
 	}
@@ -532,9 +532,9 @@ void Hal_ReadAntennaDiversity88E(struct adapter *pAdapter, u8 *PROMContent, bool
 	if (!AutoLoadFail) {
 		/*  Antenna Diversity setting. */
 		if (registry_par->antdiv_cfg == 2) { /*  2:By EFUSE */
-			pHalData->AntDivCfg = (PROMContent[EEPROM_RF_BOARD_OPTION_88E]&0x18)>>3;
+			pHalData->AntDivCfg = (PROMContent[EEPROM_RF_BOARD_OPTION_88E] & 0x18) >> 3;
 			if (PROMContent[EEPROM_RF_BOARD_OPTION_88E] == 0xFF)
-				pHalData->AntDivCfg = (EEPROM_DEFAULT_BOARD_OPTION&0x18)>>3;
+				pHalData->AntDivCfg = (EEPROM_DEFAULT_BOARD_OPTION & 0x18) >> 3;
 		} else {
 			pHalData->AntDivCfg = registry_par->antdiv_cfg;  /*  0:OFF , 1:ON, 2:By EFUSE */
 		}
-- 
2.17.1

