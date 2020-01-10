Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FEEC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F7F2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBJoDtW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgAJVFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:05:30 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgAJVF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:05:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so3116593wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLTcmynENrIjf+Qvsvjan+Ya9hbU54HJX9wVwfakaXU=;
        b=DBJoDtW6YuAcbD/Z0pabS32JUMCsaWFrPQ5uzRENE2cIgTfV7B6udReVC9TbPNiHUI
         9y7CdTptGr08ICO/QM/2t/5hiVqJA2kq4/TbPiIXhVSrsD15XC1gibl0LRhz+2Z0IgpZ
         gMypPvFdHdb+w1Yi5EBlv+zaU7gQnMgZ3oEtN/tFjeMxj2u/4p5mcJGCZOsd0Bq+Ot6H
         GOnHVC8ZkPUI18Gw8dEHoQCygeOFvRsOLK4AI0ije69rhyoYA8vMDNCU2QEARhHhgQ5m
         olKxP8/4JcLlk1eMPhf4geempJRivjUTENl1qqsDByu/lsScLYR0WsXQR5Te1qKpFxPj
         ItgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KLTcmynENrIjf+Qvsvjan+Ya9hbU54HJX9wVwfakaXU=;
        b=U66y6CUSDRAwPjwx7CFB4dGDrg/RKj6BtERejM94lXsJHuoSs3DXz5iu0V/UURYHbF
         Hv46C9GOj9REz3yaFbYIhBsCUIcng6kUUEfwDnK6kEm4pCLNPskfgrg7P63DdCeeH5fE
         V1OdL1XE/QYm+jfsklQVgoCtTc+MqqS6fja3D7UaazopvqKUgFomUUy9Gg8nzHC80vsA
         zei6dpil2JjQTe/jbsIJbje/kOw//OS2xxFnGuR3u2wGxqjoa+ankZfEH3QY0vcARCAq
         oqbJ7uq2OvwMrMRfbudINcCZWh9c3kdemeIHIq8cKwaPMluB7Hj1ZAkc8ZoAfel0ccTp
         DNow==
X-Gm-Message-State: APjAAAW202jx6Z7BJiDWmodcmZLGrbxfPvibQiLyDYgd5Kr/evr75gtk
        n/aQVpV0Tfk/YltQ2xYzs6A=
X-Google-Smtp-Source: APXvYqzpscMcaksvbCJL3xrRPgDYJ68071VBRJNyS3I2TIL4ZIGd3d4ZhnRP35mktyDpoNtF4ofprg==
X-Received: by 2002:adf:f5cf:: with SMTP id k15mr5465352wrp.182.1578690326891;
        Fri, 10 Jan 2020 13:05:26 -0800 (PST)
Received: from localhost.localdomain (dslb-178-006-252-151.178.006.pools.vodafone-ip.de. [178.6.252.151])
        by smtp.gmail.com with ESMTPSA id n8sm3609958wrx.42.2020.01.10.13.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 13:05:26 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove ODM_GetRightChnlPlaceforIQK()
Date:   Fri, 10 Jan 2020 22:04:56 +0100
Message-Id: <20200110210456.13178-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ODM_GetRightChnlPlaceforIQK() returns non-zero values only
for channels > 14. According to the TODO code valid only for 5 GHz
should be removed.

- find and remove remaining code valid only for 5 GHz. Most of the
  obvious ones have been removed, but things like channel > 14 still
  exist.

Remove ODM_GetRightChnlPlaceforIQK() and replace the uses of the
return value with zero.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8723bs/hal/HalPhyRf.c      | 30 -------------------
 drivers/staging/rtl8723bs/hal/HalPhyRf.h      |  8 -----
 .../staging/rtl8723bs/hal/HalPhyRf_8723B.c    | 11 +++----
 3 files changed, 4 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.c b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
index beb4002a40e1..357802db9aed 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.c
@@ -622,33 +622,3 @@ void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter)
 
 	pDM_Odm->RFCalibrateInfo.TXPowercount = 0;
 }
-
-
-
-
-/* 3 ============================================================ */
-/* 3 IQ Calibration */
-/* 3 ============================================================ */
-
-u8 ODM_GetRightChnlPlaceforIQK(u8 chnl)
-{
-	u8 channel_all[ODM_TARGET_CHNL_NUM_2G_5G] = {
-		1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
-		36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58,
-		60, 62, 64, 100, 102, 104, 106, 108, 110, 112,
-		114, 116, 118, 120, 122, 124, 126, 128, 130, 132,
-		134, 136, 138, 140, 149, 151, 153, 155, 157, 159,
-		161, 163, 165
-	};
-	u8 place = chnl;
-
-
-	if (chnl > 14) {
-		for (place = 14; place < sizeof(channel_all); place++) {
-			if (channel_all[place] == chnl)
-				return place-13;
-		}
-	}
-	return 0;
-
-}
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf.h b/drivers/staging/rtl8723bs/hal/HalPhyRf.h
index 3d6f68bc61d7..643fcf37c9ad 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf.h
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf.h
@@ -44,12 +44,4 @@ void ODM_ClearTxPowerTrackingState(PDM_ODM_T pDM_Odm);
 
 void ODM_TXPowerTrackingCallback_ThermalMeter(struct adapter *Adapter);
 
-
-
-#define ODM_TARGET_CHNL_NUM_2G_5G 59
-
-
-u8 ODM_GetRightChnlPlaceforIQK(u8 chnl);
-
-
 #endif	/*  #ifndef __HAL_PHY_RF_H__ */
diff --git a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
index 338dd0b7a6eb..85ea535dd6e9 100644
--- a/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
+++ b/drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c
@@ -1792,7 +1792,7 @@ void PHY_IQCalibrate_8723B(
 	PDM_ODM_T pDM_Odm = &pHalData->odmpriv;
 
 	s32 result[4][8];	/* last is final result */
-	u8 i, final_candidate, Indexforchannel;
+	u8 i, final_candidate;
 	bool bPathAOK, bPathBOK;
 	s32 RegE94, RegE9C, RegEA4, RegEAC, RegEB4, RegEBC, RegEC4, RegECC, RegTmp = 0;
 	bool is12simular, is13simular, is23simular;
@@ -1997,17 +1997,14 @@ void PHY_IQCalibrate_8723B(
 			_PHY_PathBFillIQKMatrix8723B(padapter, bPathBOK, result, final_candidate, (RegEC4 == 0));
 	}
 
-	Indexforchannel = ODM_GetRightChnlPlaceforIQK(pHalData->CurrentChannel);
-
 /* To Fix BSOD when final_candidate is 0xff */
 /* by sherry 20120321 */
 	if (final_candidate < 4) {
 		for (i = 0; i < IQK_Matrix_REG_NUM; i++)
-			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].Value[0][i] = result[final_candidate][i];
-		pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[Indexforchannel].bIQKDone = true;
+			pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].Value[0][i] = result[final_candidate][i];
+		pDM_Odm->RFCalibrateInfo.IQKMatrixRegSetting[0].bIQKDone = true;
 	}
-	/* RT_DISP(FINIT, INIT_IQK, ("\nIQK OK Indexforchannel %d.\n", Indexforchannel)); */
-	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("\nIQK OK Indexforchannel %d.\n", Indexforchannel));
+	ODM_RT_TRACE(pDM_Odm, ODM_COMP_CALIBRATION, ODM_DBG_LOUD,  ("\nIQK OK Indexforchannel %d.\n", 0));
 
 	_PHY_SaveADDARegisters8723B(padapter, IQK_BB_REG_92C, pDM_Odm->RFCalibrateInfo.IQK_BB_backup_recover, 9);
 
-- 
2.24.1

