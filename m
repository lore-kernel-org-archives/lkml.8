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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B671CC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7020722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/oClR7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgCUWXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:23:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41678 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:23:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so4129873plr.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QuTjrbwPSgvBw7KasH82kLdGIg2Chd4cyvMlvYtc5+8=;
        b=O/oClR7LFycFGyWRmdp0FutAkv682n49Tv/ROjxJEk2TGJ+f81Kd4hNCtd4Po5wKJf
         +6QuMqv6Rg04Byb0LbZ00FZNUhgDN1plHdtkWY5eG9kpEHkr2P8Albj5QBLXC5DDSpfu
         MXyzRH/l4qflF/OLPR/doj0oe8jIyF6+5HnsAPg9mSR+fWi5B1SX0rq/0gfBCXRqWue7
         a23oOmCbNEM+qIVfB0W3I6d8kviNNR2CIciNMhTifGSVFvzkeZzZi2nMZfXRKeRRDqlT
         PJ7ppLtVuLYpFwsxc5b5M7+mX2krnDax3SFxte90OtcIUVj/RX3lJHtNaHijVmBdNQcD
         S/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QuTjrbwPSgvBw7KasH82kLdGIg2Chd4cyvMlvYtc5+8=;
        b=IeaqNh6DyV90yNCgyqyqof1NN5VGyFYUuvJ0fenM+h9fuQHV/Eu9x0G002jv5b3t5Y
         pqu04yfmeJMvVd7qn78VS045SsY1wzpc5/LZByKY8dHC5YUDCkigDnDAdvSLdOL2UqJ5
         rcuqXXIr4vW/z3igmDpj5SvVEZAtwabN/a5NX4I8FeiFgvyEKl7XMT3GUfBDTW+MVn4+
         0lF3andeu8X8fAsOFM6tK7hVW5v4EQLkOwSYWrEo3eMEQrmxGF28hfznbr510PqOoEFR
         pjBICYvegJRVNFv6uD4mlZbWBP/Iz7Yve2u866sjB6eFNqxgPRKVq9kt7SkGJbzJmQ3D
         K8fw==
X-Gm-Message-State: ANhLgQ1Dsr6M2GTLVPt+QwXExkWy8PTRRs9kFMjaicVgR8IdE4VwWlcC
        iHa6hE+f7uxFBrVrW8xicVtE+jPBPcg=
X-Google-Smtp-Source: ADFU+vtS8t3LfWBQYJx/48H+cVA7Xza6bpww15K6hSVoarkZA3CgDyd9+7JWxTam3liu7bHpT+tXRQ==
X-Received: by 2002:a17:902:b710:: with SMTP id d16mr14244709pls.293.1584829416342;
        Sat, 21 Mar 2020 15:23:36 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id f69sm9252124pfa.124.2020.03.21.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:23:36 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 03/11] Staging: rtl8188eu: odm_hwconfig: Add space around operators
Date:   Sun, 22 Mar 2020 03:53:30 +0530
Message-Id: <42b670d93cbacd0413207b59f587e0147eb618fb.1584826154.git.shreeya.patel23498@gmail.com>
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

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/odm_hwconfig.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff odm_hwconfig_old.o odm_hwconfig.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 drivers/staging/rtl8188eu/hal/odm_hwconfig.c | 54 ++++++++++----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
index d5a9ac51e907..a6f2731b076d 100644
--- a/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
+++ b/drivers/staging/rtl8188eu/hal/odm_hwconfig.c
@@ -103,33 +103,33 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		switch (LNA_idx) {
 		case 7:
 			if (VGA_idx <= 27)
-				rx_pwr_all = -100 + 2 * (27-VGA_idx); /* VGA_idx = 27~2 */
+				rx_pwr_all = -100 + 2 * (27 - VGA_idx); /* VGA_idx = 27~2 */
 			else
 				rx_pwr_all = -100;
 			break;
 		case 6:
-			rx_pwr_all = -48 + 2 * (2-VGA_idx); /* VGA_idx = 2~0 */
+			rx_pwr_all = -48 + 2 * (2 - VGA_idx); /* VGA_idx = 2~0 */
 			break;
 		case 5:
-			rx_pwr_all = -42 + 2 * (7-VGA_idx); /* VGA_idx = 7~5 */
+			rx_pwr_all = -42 + 2 * (7 - VGA_idx); /* VGA_idx = 7~5 */
 			break;
 		case 4:
-			rx_pwr_all = -36 + 2 * (7-VGA_idx); /* VGA_idx = 7~4 */
+			rx_pwr_all = -36 + 2 * (7 - VGA_idx); /* VGA_idx = 7~4 */
 			break;
 		case 3:
-			rx_pwr_all = -24 + 2 * (7-VGA_idx); /* VGA_idx = 7~0 */
+			rx_pwr_all = -24 + 2 * (7 - VGA_idx); /* VGA_idx = 7~0 */
 			break;
 		case 2:
 			if (cck_highpwr)
-				rx_pwr_all = -12 + 2 * (5-VGA_idx); /* VGA_idx = 5~0 */
+				rx_pwr_all = -12 + 2 * (5 - VGA_idx); /* VGA_idx = 5~0 */
 			else
-				rx_pwr_all = -6 + 2 * (5-VGA_idx);
+				rx_pwr_all = -6 + 2 * (5 - VGA_idx);
 			break;
 		case 1:
-			rx_pwr_all = 8-2 * VGA_idx;
+			rx_pwr_all = 8 - 2 * VGA_idx;
 			break;
 		case 0:
-			rx_pwr_all = 14-2 * VGA_idx;
+			rx_pwr_all = 14 - 2 * VGA_idx;
 			break;
 		default:
 			break;
@@ -138,7 +138,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 		PWDB_ALL = odm_query_rxpwrpercentage(rx_pwr_all);
 		if (!cck_highpwr) {
 			if (PWDB_ALL >= 80)
-				PWDB_ALL = ((PWDB_ALL-80)<<1) + ((PWDB_ALL-80)>>1) + 80;
+				PWDB_ALL = ((PWDB_ALL - 80) << 1) + ((PWDB_ALL - 80) >> 1) + 80;
 			else if ((PWDB_ALL <= 78) && (PWDB_ALL >= 20))
 				PWDB_ALL += 3;
 			if (PWDB_ALL > 100)
@@ -162,7 +162,7 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 				else if (SQ_rpt < 20)
 					SQ = 100;
 				else
-					SQ = ((64-SQ_rpt) * 100) / 44;
+					SQ = ((64 - SQ_rpt) * 100) / 44;
 			}
 			pPhyInfo->SignalQuality = SQ;
 			pPhyInfo->RxMIMOSignalQuality[RF_PATH_A] = SQ;
@@ -200,8 +200,8 @@ static void odm_RxPhyStatus92CSeries_Parsing(struct odm_dm_struct *dm_odm,
 			pPhyInfo->RxMIMOSignalStrength[i] = (u8)RSSI;
 
 			/* Get Rx snr value in DB */
-			pPhyInfo->RxSNR[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
-			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i]/2);
+			pPhyInfo->RxSNR[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
+			dm_odm->PhyDbgInfo.RxSNRdB[i] = (s32)(pPhyStaRpt->path_rxsnr[i] / 2);
 		}
 		/*  (2)PWDB, Average PWDB calculated by hardware (for rate adaptive) */
 		rx_pwr_all = (((pPhyStaRpt->cck_sig_qual_ofdm_pwdb_all) >> 1) & 0x7f) - 110;
@@ -280,8 +280,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 	if (dm_odm->AntDivType == CG_TRX_SMART_ANTDIV) {
 		if (pDM_FatTable->FAT_State == FAT_TRAINING_STATE) {
 			if (pPktinfo->bPacketToSelf) {
-				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2<<2) |
-						(pDM_FatTable->antsel_rx_keep_1<<1) |
+				antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
+						(pDM_FatTable->antsel_rx_keep_1 << 1) |
 						pDM_FatTable->antsel_rx_keep_0;
 				pDM_FatTable->antSumRSSI[antsel_tr_mux] += pPhyInfo->RxPWDBAll;
 				pDM_FatTable->antRSSIcnt[antsel_tr_mux]++;
@@ -289,8 +289,8 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 		}
 	} else if ((dm_odm->AntDivType == CG_TRX_HW_ANTDIV) || (dm_odm->AntDivType == CGCS_RX_HW_ANTDIV)) {
 		if (pPktinfo->bPacketToSelf || pPktinfo->bPacketBeacon) {
-			antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2<<2) |
-					(pDM_FatTable->antsel_rx_keep_1<<1) | pDM_FatTable->antsel_rx_keep_0;
+			antsel_tr_mux = (pDM_FatTable->antsel_rx_keep_2 << 2) |
+					(pDM_FatTable->antsel_rx_keep_1 << 1) | pDM_FatTable->antsel_rx_keep_0;
 			rtl88eu_dm_ant_sel_statistics(dm_odm, antsel_tr_mux, pPktinfo->StationID, pPhyInfo->RxPWDBAll);
 		}
 	}
@@ -328,17 +328,17 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			} else {
 				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedOFDM) {
 					UndecoratedSmoothedOFDM =
-							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor-1)) +
+							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor - 1)) +
 							(RSSI_Ave)) / (Rx_Smooth_Factor);
 					UndecoratedSmoothedOFDM = UndecoratedSmoothedOFDM + 1;
 				} else {
 					UndecoratedSmoothedOFDM =
-							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor-1)) +
+							(((UndecoratedSmoothedOFDM) * (Rx_Smooth_Factor - 1)) +
 							(RSSI_Ave)) / (Rx_Smooth_Factor);
 				}
 			}
 
-			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap<<1) | BIT(0);
+			pEntry->rssi_stat.PacketMap = (pEntry->rssi_stat.PacketMap << 1) | BIT(0);
 
 		} else {
 			RSSI_Ave = pPhyInfo->RxPWDBAll;
@@ -349,16 +349,16 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			} else {
 				if (pPhyInfo->RxPWDBAll > (u32)UndecoratedSmoothedCCK) {
 					UndecoratedSmoothedCCK =
-							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor-1)) +
+							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor - 1)) +
 							pPhyInfo->RxPWDBAll) / Rx_Smooth_Factor;
 					UndecoratedSmoothedCCK = UndecoratedSmoothedCCK + 1;
 				} else {
 					UndecoratedSmoothedCCK =
-							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor-1)) +
+							((UndecoratedSmoothedCCK * (Rx_Smooth_Factor - 1)) +
 							pPhyInfo->RxPWDBAll) / Rx_Smooth_Factor;
 				}
 			}
-			pEntry->rssi_stat.PacketMap = pEntry->rssi_stat.PacketMap<<1;
+			pEntry->rssi_stat.PacketMap = pEntry->rssi_stat.PacketMap << 1;
 		}
 		/* 2011.07.28 LukeLee: modified to prevent unstable CCK RSSI */
 		if (pEntry->rssi_stat.ValidBit >= 64)
@@ -367,16 +367,16 @@ static void odm_Process_RSSIForDM(struct odm_dm_struct *dm_odm,
 			pEntry->rssi_stat.ValidBit++;
 
 		for (i = 0; i < pEntry->rssi_stat.ValidBit; i++)
-			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap>>i) & BIT(0);
+			OFDM_pkt += (u8)(pEntry->rssi_stat.PacketMap >> i) & BIT(0);
 
 		if (pEntry->rssi_stat.ValidBit == 64) {
 			Weighting = min_t(u32, OFDM_pkt << 4, 64);
-			UndecoratedSmoothedPWDB = (Weighting * UndecoratedSmoothedOFDM + (64-Weighting) * UndecoratedSmoothedCCK)>>6;
+			UndecoratedSmoothedPWDB = (Weighting * UndecoratedSmoothedOFDM + (64 - Weighting) * UndecoratedSmoothedCCK) >> 6;
 		} else {
 			if (pEntry->rssi_stat.ValidBit != 0)
 				UndecoratedSmoothedPWDB = (OFDM_pkt * UndecoratedSmoothedOFDM +
-							  (pEntry->rssi_stat.ValidBit-OFDM_pkt) *
-							  UndecoratedSmoothedCCK)/pEntry->rssi_stat.ValidBit;
+							  (pEntry->rssi_stat.ValidBit - OFDM_pkt) *
+							  UndecoratedSmoothedCCK) / pEntry->rssi_stat.ValidBit;
 			else
 				UndecoratedSmoothedPWDB = 0;
 		}
-- 
2.17.1

