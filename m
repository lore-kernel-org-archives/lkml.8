Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36CDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888CD2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLoLn+HQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbgGASdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732542AbgGASc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:32:59 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22FBC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 11:32:58 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t11so9407056qvk.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 11:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMWqsRjgamvDhaqKLIZ9a9tnvYnbIff79zmxoBxUuak=;
        b=FLoLn+HQP7/uzxDpHgN+EIvDc50vL+GIHLYsU136Yg87tdiYTxFcWlvI89+G3hmDMr
         jfAq44GC57+VDkYRzkX+Y0DYaPtCCcOs0ebzG5gFazEUgZLBUVaZ5EePg4Fc/yEP6yQ8
         tQumRrSfTHtT2ZiyqN13Pd9plp82q4nEMcT5HofiEVPe/aKRp1/iQcxmNU361W5d9nuq
         z4NWQY70A4qbuBs3gtTmRiXozTLbyFnZDW27kleAuzP6lDyNRUg45lrB6tei2CB99Htl
         5H0A7eN4daGuVjQl3erOT9Xuy9PUYvwVSeEujzZwBysKN5OXfkc6j3ntUfWYKOpy33yv
         /xWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMWqsRjgamvDhaqKLIZ9a9tnvYnbIff79zmxoBxUuak=;
        b=Rj1IPLvWI9s76VTF5pGh+I9poc3COgNXsK9iJInwzZCsvTHInCy8tSKwsleItZM2Yt
         67SSMN3QNniLl2XwPrBSk9djdv1IoFYlc0ZWf+IaqCyJWS6Ymsj+EjAv2lpe7bX0fQrC
         lBBK0QRgRu9FK+5tIsKZAwHNFg/FzUCQX6GTMuDhUDSVlH082DkaB//+wIkVUSQotnp6
         6lEvZFF2spwJejIT2GVjSRlFqju3xP2CE5CIKcMd7TXRsObWNqdqRgAuZB8oeVt8ZAQ3
         dno0SKBoGczerRc6tJmwtyMw0RuyXpenUx6IJDNP8OPF1WSWyx5muOX52mdkBXlRho3c
         qvmA==
X-Gm-Message-State: AOAM5327l9Ck+FAKsn2OKL48C8W3Dqr4D9qUsaPvZSiAJeSBPpjGLQMx
        H0KXaZH7ENxkJ6DXVlIgo+I=
X-Google-Smtp-Source: ABdhPJzqaxeHeDnYKzLJ8TXnH3yXOMCxoG1iovLm50XIlqQ8xYrwyk3qfUvEsYxT5q7Wz8O+uBNj3Q==
X-Received: by 2002:a0c:b8a9:: with SMTP id y41mr12712021qvf.49.1593628377908;
        Wed, 01 Jul 2020 11:32:57 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-214.178.011.pools.vodafone-ip.de. [178.11.230.214])
        by smtp.gmail.com with ESMTPSA id x13sm5699055qkx.10.2020.07.01.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 11:32:57 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8188eu: use common ieee80211 constants
Date:   Wed,  1 Jul 2020 20:29:57 +0200
Message-Id: <20200701182957.7932-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many defined constants in wifi.h are unused and/or available from
<linux/ieee80211.h>, some with slightly different names. Use the
common ones, rename where necessary and remove unused.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ap.c       | 12 ++---
 drivers/staging/rtl8188eu/core/rtw_mlme.c     |  6 +--
 drivers/staging/rtl8188eu/include/wifi.h      | 46 -------------------
 .../staging/rtl8188eu/os_dep/ioctl_linux.c    |  2 +-
 4 files changed, 10 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ap.c b/drivers/staging/rtl8188eu/core/rtw_ap.c
index 817793b9aff2..41535441f82c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ap.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ap.c
@@ -535,7 +535,7 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 		/*  bwmode */
 		if (le16_to_cpu(phtpriv_sta->ht_cap.cap_info &
 				phtpriv_ap->ht_cap.cap_info) &
-		    IEEE80211_HT_CAP_SUP_WIDTH) {
+		    IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
 			phtpriv_sta->bwmode = pmlmeext->cur_bwmode;
 			phtpriv_sta->ch_offset = pmlmeext->cur_ch_offset;
 		}
@@ -925,12 +925,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
 		    (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP))
-			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2));
+			pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & (0x07 << 2));
 		else
-			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
+			pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 
 		/* set  Max Rx AMPDU size  to 64K */
-		pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_FACTOR & 0x03);
+		pht_cap->ampdu_params_info |= (IEEE80211_HT_AMPDU_PARM_FACTOR & 0x03);
 
 		pht_cap->mcs.rx_mask[0] = 0xff;
 		pht_cap->mcs.rx_mask[1] = 0x0;
@@ -1307,7 +1307,7 @@ static int rtw_ht_operation_update(struct adapter *padapter)
 	    (pmlmepriv->ht_op_mode & HT_INFO_OPERATION_MODE_NON_GF_DEVS_PRESENT))
 		new_op_mode = OP_MODE_MIXED;
 	else if ((le16_to_cpu(phtpriv_ap->ht_cap.cap_info) &
-		  IEEE80211_HT_CAP_SUP_WIDTH) &&
+		  IEEE80211_HT_CAP_SUP_WIDTH_20_40) &&
 		 pmlmepriv->num_sta_ht_20mhz)
 		new_op_mode = OP_MODE_20MHZ_HT_STA_ASSOCED;
 	else if (pmlmepriv->olbc_ht)
@@ -1457,7 +1457,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 				pmlmepriv->num_sta_ht_no_gf);
 		}
 
-		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH) == 0) {
+		if ((ht_capab & IEEE80211_HT_CAP_SUP_WIDTH_20_40) == 0) {
 			if (!psta->ht_20mhz_set) {
 				psta->ht_20mhz_set = 1;
 				pmlmepriv->num_sta_ht_20mhz++;
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index b291ee6ca8f4..5d7a749f1aac 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1882,7 +1882,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 		memset(&ht_cap, 0, sizeof(struct ieee80211_ht_cap));
 
-		ht_cap.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH |
+		ht_cap.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 					      IEEE80211_HT_CAP_SGI_20 |
 					      IEEE80211_HT_CAP_SGI_40 |
 					      IEEE80211_HT_CAP_TX_STBC |
@@ -1900,9 +1900,9 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		ht_cap.ampdu_params_info = max_rx_ampdu_factor & 0x03;
 
 		if (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)
-			ht_cap.ampdu_params_info |= IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2);
+			ht_cap.ampdu_params_info |= IEEE80211_HT_AMPDU_PARM_DENSITY & (0x07 << 2);
 		else
-			ht_cap.ampdu_params_info |= IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00;
+			ht_cap.ampdu_params_info |= IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00;
 
 		rtw_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
 			   sizeof(struct ieee80211_ht_cap),
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index e12e3d0a45e0..791f287a546d 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -499,52 +499,6 @@ enum ht_cap_ampdu_factor {
 	MAX_AMPDU_FACTOR_64K	= 3,
 };
 
-/* 802.11n HT capabilities masks */
-#define IEEE80211_HT_CAP_SUP_WIDTH		0x0002
-#define IEEE80211_HT_CAP_SM_PS			0x000C
-#define IEEE80211_HT_CAP_GRN_FLD		0x0010
-#define IEEE80211_HT_CAP_SGI_20			0x0020
-#define IEEE80211_HT_CAP_SGI_40			0x0040
-#define IEEE80211_HT_CAP_TX_STBC		0x0080
-#define IEEE80211_HT_CAP_RX_STBC		0x0300
-#define IEEE80211_HT_CAP_DELAY_BA		0x0400
-#define IEEE80211_HT_CAP_MAX_AMSDU		0x0800
-#define IEEE80211_HT_CAP_DSSSCCK40		0x1000
-/* 802.11n HT capability AMPDU settings */
-#define IEEE80211_HT_CAP_AMPDU_FACTOR		0x03
-#define IEEE80211_HT_CAP_AMPDU_DENSITY		0x1C
-/* 802.11n HT capability MSC set */
-#define IEEE80211_SUPP_MCS_SET_UEQM		4
-#define IEEE80211_HT_CAP_MAX_STREAMS		4
-#define IEEE80211_SUPP_MCS_SET_LEN		10
-/* maximum streams the spec allows */
-#define IEEE80211_HT_CAP_MCS_TX_DEFINED		0x01
-#define IEEE80211_HT_CAP_MCS_TX_RX_DIFF		0x02
-#define IEEE80211_HT_CAP_MCS_TX_STREAMS		0x0C
-#define IEEE80211_HT_CAP_MCS_TX_UEQM		0x10
-/* 802.11n HT IE masks */
-#define IEEE80211_HT_IE_CHA_SEC_OFFSET		0x03
-#define IEEE80211_HT_IE_CHA_SEC_NONE		0x00
-#define IEEE80211_HT_IE_CHA_SEC_ABOVE		0x01
-#define IEEE80211_HT_IE_CHA_SEC_BELOW		0x03
-#define IEEE80211_HT_IE_CHA_WIDTH		0x04
-#define IEEE80211_HT_IE_HT_PROTECTION		0x0003
-#define IEEE80211_HT_IE_NON_GF_STA_PRSNT	0x0004
-#define IEEE80211_HT_IE_NON_HT_STA_PRSNT	0x0010
-
-/* block-ack parameters */
-#define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
-#define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
-#define RTW_IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
-#define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
-#define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
-
-/*
- * A-PMDU buffer sizes
- * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
- */
-#define IEEE80211_MIN_AMPDU_BUF 0x8
-
 #define OP_MODE_PURE                    0
 #define OP_MODE_MAY_BE_LEGACY_STAS      1
 #define OP_MODE_20MHZ_HT_STA_ASSOCED    2
diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 38484dffe095..5e6f7f0ed009 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -129,7 +129,7 @@ static char *translate_scan(struct adapter *padapter,
 		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
 		memcpy(&mcs_rate, pht_capie->mcs.rx_mask, 2);
 		bw_40MHz = !!(le16_to_cpu(pht_capie->cap_info) &
-			      IEEE80211_HT_CAP_SUP_WIDTH);
+			      IEEE80211_HT_CAP_SUP_WIDTH_20_40);
 		short_GI = !!(le16_to_cpu(pht_capie->cap_info) &
 			      (IEEE80211_HT_CAP_SGI_20 |
 			       IEEE80211_HT_CAP_SGI_40));
-- 
2.27.0

