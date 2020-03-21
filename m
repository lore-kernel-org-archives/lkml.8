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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A99DC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA1120775
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6cOlr5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgCUW1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:27:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38319 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgCUW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:27:41 -0400
Received: by mail-pf1-f196.google.com with SMTP id z25so1038484pfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CZqCAd8fEfoSI7i8iCIr7kIGmsBn9jsEuUmW+GsXhCw=;
        b=O6cOlr5ETmUyzJ+0hmOt4r9B6qycja6+ryhT0cWda4n8sUIFJxDIswLzkMgECizORe
         Gnu2BUcMSICoNQukwqWGDTvXjn8yit/iB1I62l3vTo95539FCjzi0HK9+g+/HcekJfXB
         afpeis7kAsk7S9khMpITb987SnzMy3Ji+qTLLxxy93+Z68rkpISWE5I/G655nu/7kdGx
         uKE5ylWCHvW37S2mb1N6Net9njkZIfoWhW9ngJb8hhc0AGejOE+iv3D/K7pCArecTOdV
         VhTuBkEg4uOZ2h9Ws3PF3QkUAEqYf3Mz2NjpHf7IfUzkWz9/zwyL3o4kbZIs/gbOzNcL
         ebpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CZqCAd8fEfoSI7i8iCIr7kIGmsBn9jsEuUmW+GsXhCw=;
        b=MOHDfRncSPn271K2qz2V9gGSZRDKK8oOH/pPSde2BE0muTc9hxdMIKrx2udlDKkitY
         wSjwjr//ODj0LvRHpN1gmh6FI5GPS5D28tNzMrSe/6IZJWmNjVAPNoN8D2Bbg5DXJ8iH
         x/VtPzNjZKf1chBnAnBeREGC9GTIoIkjg0cMYl1wxgUXCxA7ODWqrszvtZWjUYrA0dQt
         Etp8SEOuwttn4+NcSMBPh9vonC9LJmtn5O9609ve+MENz6Ji3g8HTEig7Mk06YZS8Hd/
         jh8thyBDiUHfmqENYJmPeyXl5Cmv2pPV8sxkWpfaQ2Bviw1dH6UTTMtd/JjhaN6QxwqI
         u96w==
X-Gm-Message-State: ANhLgQ06bFrzlqy9oTxDOFvLOMYoKT7lLIHzaSJE2uhgA2Klpmm3dYqc
        AilFl+2qXoWjbZKCQIywJO8=
X-Google-Smtp-Source: ADFU+vtkEXu+/KYg5vcoYBkWim4pqjtCY09Sj/CKIvKzYQetnLOD9A9vyxyjEinRHch3+mbz2gxsIA==
X-Received: by 2002:a63:f502:: with SMTP id w2mr7019455pgh.423.1584829658394;
        Sat, 21 Mar 2020 15:27:38 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id o29sm9499141pfp.208.2020.03.21.15.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:27:38 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 08/11] Staging: rtl8188eu: rtl8188e_cmd: Add space around operators
Date:   Sun, 22 Mar 2020 03:57:32 +0530
Message-Id: <ae8d35a3d8e59c6085468b21eaa760f7b57e61b0.1584826154.git.shreeya.patel23498@gmail.com>
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

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff rtl8188e_cmd_old.o rtl8188e_cmd.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 42 ++++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index 7646167a0b36..371e746915dd 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -113,24 +113,24 @@ void rtw_hal_add_ra_tid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi_le
 	struct odm_dm_struct *odmpriv = &pAdapter->HalData->odmpriv;
 	u8 macid, init_rate, raid, shortGIrate = false;
 
-	macid = arg&0x1f;
+	macid = arg & 0x1f;
 
-	raid = (bitmap>>28) & 0x0f;
+	raid = (bitmap >> 28) & 0x0f;
 	bitmap &= 0x0fffffff;
 
 	if (rssi_level != DM_RATR_STA_INIT)
 		bitmap = ODM_Get_Rate_Bitmap(odmpriv, macid, bitmap, rssi_level);
 
-	bitmap |= ((raid<<28)&0xf0000000);
+	bitmap |= ((raid << 28) & 0xf0000000);
 
-	init_rate = get_highest_rate_idx(bitmap&0x0fffffff)&0x3f;
+	init_rate = get_highest_rate_idx(bitmap & 0x0fffffff) & 0x3f;
 
 	shortGIrate = (arg & BIT(5)) ? true : false;
 
 	if (shortGIrate)
 		init_rate |= BIT(6);
 
-	raid = (bitmap>>28) & 0x0f;
+	raid = (bitmap >> 28) & 0x0f;
 
 	bitmap &= 0x0fffffff;
 
@@ -172,7 +172,7 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 		break;
 	}
 
-	H2CSetPwrMode.SmartPS_RLBM = (((pwrpriv->smart_ps<<4)&0xf0) | (RLBM & 0x0f));
+	H2CSetPwrMode.SmartPS_RLBM = (((pwrpriv->smart_ps << 4) & 0xf0) | (RLBM & 0x0f));
 
 	H2CSetPwrMode.AwakeInterval = 1;
 
@@ -239,9 +239,9 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	pframe += 2;
 	pktlen += 2;
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
 		pktlen += cur_network->ie_length - sizeof(struct ndis_802_11_fixed_ie);
-		memcpy(pframe, cur_network->ies+sizeof(struct ndis_802_11_fixed_ie), pktlen);
+		memcpy(pframe, cur_network->ies + sizeof(struct ndis_802_11_fixed_ie), pktlen);
 
 		goto _ConstructBeacon;
 	}
@@ -258,7 +258,7 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 	/*  DS parameter set */
 	pframe = rtw_set_ie(pframe, _DSSET_IE_, 1, (unsigned char *)&(cur_network->Configuration.DSConfig), &pktlen);
 
-	if ((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) {
+	if ((pmlmeinfo->state & 0x03) == WIFI_FW_ADHOC_STATE) {
 		u32 ATIMWindow;
 		/*  IBSS Parameter Set... */
 		ATIMWindow = 0;
@@ -473,7 +473,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	/* 3 (2) ps-poll *1 page */
 	RsvdPageLoc.LocPsPoll = PageNum;
 	ConstructPSPoll(adapt, &ReservedPagePacket[BufIndex], &PSPollLength);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], PSPollLength, true, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], PSPollLength, true, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + PSPollLength);
 	PageNum += PageNeed;
@@ -483,7 +483,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	/* 3 (3) null data * 1 page */
 	RsvdPageLoc.LocNullData = PageNum;
 	ConstructNullFunctionData(adapt, &ReservedPagePacket[BufIndex], &NullDataLength, pnetwork->MacAddress, false, 0, 0, false);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], NullDataLength, false, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], NullDataLength, false, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + NullDataLength);
 	PageNum += PageNeed;
@@ -493,7 +493,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	/* 3 (4) probe response * 1page */
 	RsvdPageLoc.LocProbeRsp = PageNum;
 	ConstructProbeRsp(adapt, &ReservedPagePacket[BufIndex], &ProbeRspLength, pnetwork->MacAddress, false);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], ProbeRspLength, false, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], ProbeRspLength, false, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + ProbeRspLength);
 	PageNum += PageNeed;
@@ -504,7 +504,7 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	RsvdPageLoc.LocQosNull = PageNum;
 	ConstructNullFunctionData(adapt, &ReservedPagePacket[BufIndex],
 				  &QosNullLength, pnetwork->MacAddress, true, 0, 0, false);
-	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex-TxDescLen], QosNullLength, false, false);
+	rtl8188e_fill_fake_txdesc(adapt, &ReservedPagePacket[BufIndex - TxDescLen], QosNullLength, false, false);
 
 	PageNeed = (u8)PageNum_128(TxDescLen + QosNullLength);
 	PageNum += PageNeed;
@@ -546,17 +546,17 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	if (mstatus == 1) {
 		/*  We should set AID, correct TSF, HW seq enable before set JoinBssReport to Fw in 88/92C. */
 		/*  Suggested by filen. Added by tynli. */
-		usb_write16(adapt, REG_BCN_PSR_RPT, (0xC000|pmlmeinfo->aid));
+		usb_write16(adapt, REG_BCN_PSR_RPT, (0xC000 | pmlmeinfo->aid));
 		/*  Do not set TSF again here or vWiFi beacon DMA INT will not work. */
 
 		/* Set REG_CR bit 8. DMA beacon by SW. */
 		haldata->RegCR_1 |= BIT(0);
-		usb_write8(adapt,  REG_CR+1, haldata->RegCR_1);
+		usb_write8(adapt,  REG_CR + 1, haldata->RegCR_1);
 
 		/*  Disable Hw protection for a time which revserd for Hw sending beacon. */
 		/*  Fix download reserved page packet fail that access collision with the protection time. */
 		/*  2010.05.11. Added by tynli. */
-		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL)&(~BIT(3)));
+		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
 		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL) | BIT(4));
 
 		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
@@ -565,7 +565,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		}
 
 		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
-		usb_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl&(~BIT(6))));
+		usb_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
 		haldata->RegFwHwTxQCtrl &= (~BIT(6));
 
 		/*  Clear beacon valid check bit. */
@@ -582,7 +582,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 				/*  check rsvd page download OK. */
 				rtw_hal_get_hwreg(adapt, HW_VAR_BCN_VALID, (u8 *)(&bcn_valid));
 				poll++;
-			} while (!bcn_valid && (poll%10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
+			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 
 		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
@@ -600,7 +600,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 
 		/*  Enable Bcn */
 		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL) | BIT(3));
-		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL)&(~BIT(4)));
+		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL) & (~BIT(4)));
 
 		/*  To make sure that if there exists an adapter which would like to send beacon. */
 		/*  If exists, the origianl value of 0x422[6] will be 1, we should check this to */
@@ -608,7 +608,7 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  the beacon cannot be sent by HW. */
 		/*  2010.06.23. Added by tynli. */
 		if (bSendBeacon) {
-			usb_write8(adapt, REG_FWHW_TXQ_CTRL+2, (haldata->RegFwHwTxQCtrl | BIT(6)));
+			usb_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl | BIT(6)));
 			haldata->RegFwHwTxQCtrl |= BIT(6);
 		}
 
@@ -621,6 +621,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
 		haldata->RegCR_1 &= (~BIT(0));
-		usb_write8(adapt,  REG_CR+1, haldata->RegCR_1);
+		usb_write8(adapt,  REG_CR + 1, haldata->RegCR_1);
 	}
 }
-- 
2.17.1

