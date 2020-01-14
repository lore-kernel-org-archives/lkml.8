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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04410C33CB2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1D024679
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 13:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyjMpUdp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANNpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 08:45:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55731 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgANNpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 08:45:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so13831407wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 05:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2EoZeO+c/poPIYPOn5vcl26D2pY2q5fzcBUdeS7xDt4=;
        b=MyjMpUdpo8WAO/sU8V5oDMi0HTUA4066v3Y6drZWzV7zF/vZ8VXw+JW2LKC2P8PpJJ
         F0by2u0IoGQHw2HMbkBMRRoMa3rk0U+CO7jOqqMOsAUvYoDh0wHCbbqp7tK6u1BjHeb1
         D0MN1q0SpRZ/qbvxRMP/kXry37CPdA/OHEcrLxHMAVcft3gF6UthImqniPlj/4zE+EAb
         IpKS70mVclhZAooZYwlRWBf2dx8xEVr8bUn5UxvydIEVBCQBm29nJEnCOmEYpLMBl/7A
         CchO4cKIgZPFdWS7RRxLxJAtJKsp5Snye3M+xRCAiLENbuiNce+cLra1fuvBYNPhhUGs
         bE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2EoZeO+c/poPIYPOn5vcl26D2pY2q5fzcBUdeS7xDt4=;
        b=IAytcMfH+nSCluumFi9YkauFEu+fmlLVxbAhWEHnJGROtBpoHeY+n7UfR7r+u/3OGM
         5ipDHs7H220ExKuO8iRvSkR/n9sZ0ucM/lkl/vCuThhC+2fHyQprqHheUbyBJOg3Ll87
         FxGX0OzltaxC/35wI8Px/2hA9Gt3UIZ9JA/Md4i6nTdHG6EQT5YUT7H8aLFflyBB9l/Y
         mBETmpJfabbxl7zsN4YCohMLwmiU0FbpnKXEM5opazaRsMMxgpgefkWtCJcA6pYSGNDS
         voVjCf2UQAq/LTjNDkK1wSmTwDCJ19FGBGhL/YnfCiW8li5awzUg+rd5fanpomEiKdtt
         ufFg==
X-Gm-Message-State: APjAAAXqtmr/mY4yclEJJGtlHIeCQmrbl3H2tKNO0nLFL5UVYHMB2G84
        5Tl7kG2PuL+x3myQwRfjie7bWz2C
X-Google-Smtp-Source: APXvYqyASaijEWhtzoj4yJw/tBI5qonz0HuDyNCmaCNPJOImenGjbP+US/LcL2vI1RGPY8hKaFrFnQ==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr27982774wmj.90.1579009505615;
        Tue, 14 Jan 2020 05:45:05 -0800 (PST)
Received: from localhost.localdomain (dslb-088-070-028-164.088.070.pools.vodafone-ip.de. [88.70.28.164])
        by smtp.gmail.com with ESMTPSA id x10sm19361333wrp.58.2020.01.14.05.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 05:45:05 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: rtl8188eu: cleanup long lines in rtl8188e_dm.c
Date:   Tue, 14 Jan 2020 14:44:20 +0100
Message-Id: <20200114134422.13598-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114134422.13598-1-straube.linux@gmail.com>
References: <20200114134422.13598-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup lines over 80 characters in rtl8188e_dm.c by adding
appropriate line breaks.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c | 26 ++++++++++++++-------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
index 756945d41412..36255199633a 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_dm.c
@@ -51,8 +51,10 @@ static void Init_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	dm_odm->AntDivType = hal_data->TRxAntDivType;
 
-	/*  Tx power tracking BB swing table. */
-	/*  The base index = 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB */
+	/* Tx power tracking BB swing table.
+	 * The base index =
+	 * 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB
+	 */
 	dm_odm->BbSwingIdxOfdm = 12; /*  Set defalut value as index 12. */
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;
@@ -106,14 +108,17 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	dm_odm->pbPowerSaving = (bool *)&pwrctrlpriv->bpower_saving;
 	dm_odm->AntDivType = hal_data->TRxAntDivType;
 
-	/*  Tx power tracking BB swing table. */
-	/*  The base index = 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB */
+	/* Tx power tracking BB swing table.
+	 * The base index =
+	 * 12. +((12-n)/2)dB 13~?? = decrease tx pwr by -((n-12)/2)dB
+	 */
 	dm_odm->BbSwingIdxOfdm = 12; /*  Set defalut value as index 12. */
 	dm_odm->BbSwingIdxOfdmCurrent = 12;
 	dm_odm->BbSwingFlagOfdm = false;
 
 	for (i = 0; i < NUM_STA; i++)
-		ODM_CmnInfoPtrArrayHook(dm_odm, ODM_CMNINFO_STA_STATUS, i, NULL);
+		ODM_CmnInfoPtrArrayHook(dm_odm, ODM_CMNINFO_STA_STATUS, i,
+					NULL);
 }
 
 void rtl8188e_InitHalDm(struct adapter *Adapter)
@@ -172,13 +177,18 @@ void rtw_hal_dm_init(struct adapter *Adapter)
 
 /*  Add new function to reset the state of antenna diversity before link. */
 /*  Compare RSSI for deciding antenna */
-void rtw_hal_antdiv_rssi_compared(struct adapter *Adapter, struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src)
+void rtw_hal_antdiv_rssi_compared(struct adapter *Adapter,
+				  struct wlan_bssid_ex *dst,
+				  struct wlan_bssid_ex *src)
 {
 	if (Adapter->HalData->AntDivCfg != 0) {
-		/* select optimum_antenna for before linked =>For antenna diversity */
+		/* select optimum_antenna for before linked => For antenna
+		 * diversity
+		 */
 		if (dst->Rssi >=  src->Rssi) {/* keep org parameter */
 			src->Rssi = dst->Rssi;
-			src->PhyInfo.Optimum_antenna = dst->PhyInfo.Optimum_antenna;
+			src->PhyInfo.Optimum_antenna =
+				dst->PhyInfo.Optimum_antenna;
 		}
 	}
 }
-- 
2.24.1

