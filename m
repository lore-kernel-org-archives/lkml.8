Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BC2C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F03222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ib3HXPLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgCKNRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:17:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39628 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCKNRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:17:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so1319357pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=vrtm4mTBXLkyB+Sw62aumVRdIfeHDvffoJwWFM/8N3Y=;
        b=Ib3HXPLIXFOBbWd+GDPehqS/CfQFc0ubSOsPABUHVsJMsJzu7B74aQP8OEzbVXoBdC
         Fsbcx/GcKDDoG4Cbz4wlOLbGgsIxMYbfdokVaCHR5HqmyTPyA8hi+JTKsgQgu1QdvAlR
         R9zzJhro1lKKzRVqYXnTEYQwolr/0e1WfDQSEklDyIqVIY2CnsAvGDPkjOD2t43qYpRJ
         B9LkIseutQRVjumEytN2E3QKCK+5QgrPZo6MsxxL30VcXvP/rhAA/cP4p9/fbdLm+Y5L
         s1/iwO4Tthwtej2xoKeyCO6tNFtk9XcNMQE0VdjRTgJ/i2wFY/eyUY/fUqLS0pznHBOo
         c+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=vrtm4mTBXLkyB+Sw62aumVRdIfeHDvffoJwWFM/8N3Y=;
        b=nCK+wdH8UM5V6HSSlT1xvex7egYn9+CjB+IGVOVGYXp9JXWCYWQBdjHfr576E7FmKp
         sfShgArTjV7xETOmQgztyJ6n3nEpdcUk0HkDXH9WdO+TOvJXbp8534ta9d3KWP9D8wMh
         NozR91XZ5gi0MeRS1Ehj1P38Cgd8UO4RCzc/sbkdTYK5HnvRcvIEBLJ0EatOSCrdJTFq
         34JhkZzc/E1CxiNhhDHUHLLZQUQQ2uZe/bhsYBEB5MQvuJWtTCReOXkdXCG50RObcCjq
         TlWUptMW+R6kTstQuNkERQh9f2LLh4kBxuWmrVwKSe6D2UzrUZFVzVNFC2YPCtE/d7h2
         o2cA==
X-Gm-Message-State: ANhLgQ3EOXcqJAHyvMRzNh0MFwigitcjGdCLUXEkRZtEle3Eafarqkju
        CZsW56C12h634qOHMIaVuqM=
X-Google-Smtp-Source: ADFU+vtq1nWVaSzlbgb6ufEbxbvcCnfC+F9Npcyl4jGZnsg6Jp5RR8NJfxXGq4d+0B0QQ7ozSM5qOA==
X-Received: by 2002:a62:6490:: with SMTP id y138mr2854394pfb.96.1583932673834;
        Wed, 11 Mar 2020 06:17:53 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:287:fb4d:18bc:a849:c699:3914])
        by smtp.gmail.com with ESMTPSA id s18sm637434pfe.194.2020.03.11.06.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:17:53 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        shreeya.patel23498@gmail.com, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] [PATCH v4] Staging: rtl8188eu: rtw_mlme: Add space around operators
Date:   Wed, 11 Mar 2020 18:47:42 +0530
Message-Id: <20200311131742.31068-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
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

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/core/
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/core$ diff rtw_mlme_old.o rtw_mlme.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/core$

Changes in v4
  - Move important statements into the commit message.
Changes in v3
  - Make the diff output explanation more readable.

Changes in v2
  - Include the file name in Subject to make it more specific.
  - Add the output of diff of the .o files before and after the changes
to show no difference.
  - Add the output of git diff -w to show no difference.

 drivers/staging/rtl8188eu/core/rtw_mlme.c | 40 +++++++++++------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index 8da955e8343b..9de2d421f6b1 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -149,7 +149,7 @@ static void _rtw_free_network(struct mlme_priv *pmlmepriv, struct wlan_network *
 	    (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE)))
 		lifetime = 1;
 	if (!isfreeall) {
-		delta_time = (curr_time - pnetwork->last_scanned)/HZ;
+		delta_time = (curr_time - pnetwork->last_scanned) / HZ;
 		if (delta_time < lifetime)/*  unit:sec */
 			return;
 	}
@@ -249,8 +249,8 @@ void rtw_generate_random_ibss(u8 *pibss)
 	pibss[1] = 0x11;
 	pibss[2] = 0x87;
 	pibss[3] = (u8)(curtime & 0xff);/* p[0]; */
-	pibss[4] = (u8)((curtime>>8) & 0xff);/* p[1]; */
-	pibss[5] = (u8)((curtime>>16) & 0xff);/* p[2]; */
+	pibss[4] = (u8)((curtime >> 8) & 0xff);/* p[1]; */
+	pibss[5] = (u8)((curtime >> 16) & 0xff);/* p[2]; */
 }
 
 u8 *rtw_get_capability_from_ie(u8 *ie)
@@ -357,9 +357,9 @@ void update_network(struct wlan_bssid_ex *dst, struct wlan_bssid_ex *src,
 			rssi_final = rssi_ori;
 	} else {
 		if (sq_smp != 101) { /* from the right channel */
-			ss_final = ((u32)(src->PhyInfo.SignalStrength)+(u32)(dst->PhyInfo.SignalStrength)*4)/5;
-			sq_final = ((u32)(src->PhyInfo.SignalQuality)+(u32)(dst->PhyInfo.SignalQuality)*4)/5;
-			rssi_final = (src->Rssi+dst->Rssi*4)/5;
+			ss_final = ((u32)(src->PhyInfo.SignalStrength) + (u32)(dst->PhyInfo.SignalStrength) * 4) / 5;
+			sq_final = ((u32)(src->PhyInfo.SignalQuality) + (u32)(dst->PhyInfo.SignalQuality) * 4) / 5;
+			rssi_final = (src->Rssi + dst->Rssi * 4) / 5;
 		} else {
 			/* bss info not receiving from the right channel, use the original RX signal infos */
 			ss_final = dst->PhyInfo.SignalStrength;
@@ -510,7 +510,7 @@ static int rtw_is_desired_network(struct adapter *adapter, struct wlan_network *
 	privacy = pnetwork->network.Privacy;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		if (rtw_get_wps_ie(pnetwork->network.ies+_FIXED_IE_LENGTH_, pnetwork->network.ie_length-_FIXED_IE_LENGTH_, NULL, &wps_ielen))
+		if (rtw_get_wps_ie(pnetwork->network.ies + _FIXED_IE_LENGTH_, pnetwork->network.ie_length - _FIXED_IE_LENGTH_, NULL, &wps_ielen))
 			return true;
 		else
 			return false;
@@ -925,7 +925,7 @@ static void rtw_joinbss_update_network(struct adapter *padapter, struct wlan_net
 	switch (pnetwork->network.InfrastructureMode) {
 	case Ndis802_11Infrastructure:
 		if (pmlmepriv->fw_state & WIFI_UNDER_WPS)
-			pmlmepriv->fw_state = WIFI_STATION_STATE|WIFI_UNDER_WPS;
+			pmlmepriv->fw_state = WIFI_STATION_STATE | WIFI_UNDER_WPS;
 		else
 			pmlmepriv->fw_state = WIFI_STATION_STATE;
 		break;
@@ -1097,14 +1097,14 @@ static u8 search_max_mac_id(struct adapter *padapter)
 #if defined(CONFIG_88EU_AP_MODE)
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 		for (aid = pstapriv->max_num_sta; aid > 0; aid--) {
-			if (pstapriv->sta_aid[aid-1])
+			if (pstapriv->sta_aid[aid - 1])
 				break;
 		}
 		mac_id = aid + 1;
 	} else
 #endif
 	{/* adhoc  id =  31~2 */
-		for (mac_id = NUM_STA-1; mac_id >= IBSS_START_MAC_ID; mac_id--) {
+		for (mac_id = NUM_STA - 1; mac_id >= IBSS_START_MAC_ID; mac_id--) {
 			if (pmlmeinfo->FW_sta_info[mac_id].status == 1)
 				break;
 		}
@@ -1123,7 +1123,7 @@ void rtw_stassoc_hw_rpt(struct adapter *adapter, struct sta_info *psta)
 
 	macid = search_max_mac_id(adapter);
 	rtw_hal_set_hwreg(adapter, HW_VAR_TX_RPT_MAX_MACID, (u8 *)&macid);
-	media_status = (psta->mac_id<<8)|1; /*   MACID|OPMODE:1 connect */
+	media_status = (psta->mac_id << 8) | 1; /*   MACID|OPMODE:1 connect */
 	rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 }
 
@@ -1213,7 +1213,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 	if (mac_id >= 0) {
 		u16 media_status;
 
-		media_status = (mac_id<<8)|0; /*   MACID|OPMODE:0 means disconnect */
+		media_status = (mac_id << 8) | 0; /*   MACID|OPMODE:0 means disconnect */
 		/* for STA, AP, ADHOC mode, report disconnect stauts to FW */
 		rtw_hal_set_hwreg(adapter, HW_VAR_H2C_MEDIA_STATUS_RPT, (u8 *)&media_status);
 	}
@@ -1640,7 +1640,7 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 	for (i = 12; i < in_len; i += (in_ie[i + 1] + 2) /* to the next IE element */) {
 		ielength = initial_out_len;
 
-		if (in_ie[i] == 0xDD && in_ie[i+2] == 0x00 && in_ie[i+3] == 0x50  && in_ie[i+4] == 0xF2 && in_ie[i+5] == 0x02 && i+5 < in_len) {
+		if (in_ie[i] == 0xDD && in_ie[i + 2] == 0x00 && in_ie[i + 3] == 0x50  && in_ie[i + 4] == 0xF2 && in_ie[i + 5] == 0x02 && i + 5 < in_len) {
 			/* WMM element ID and OUI */
 			/* Append WMM IE to the last index of out_ie */
 
@@ -1734,13 +1734,13 @@ int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 		authmode = _WPA2_IE_ID_;
 
 	if (check_fwstate(pmlmepriv, WIFI_UNDER_WPS)) {
-		memcpy(out_ie+ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
+		memcpy(out_ie + ielength, psecuritypriv->wps_ie, psecuritypriv->wps_ie_len);
 
 		ielength += psecuritypriv->wps_ie_len;
 	} else if ((authmode == _WPA_IE_ID_) || (authmode == _WPA2_IE_ID_)) {
 		/* copy RSN or SSN */
-		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1]+2);
-		ielength += psecuritypriv->supplicant_ie[1]+2;
+		memcpy(&out_ie[ielength], &psecuritypriv->supplicant_ie[0], psecuritypriv->supplicant_ie[1] + 2);
+		ielength += psecuritypriv->supplicant_ie[1] + 2;
 		rtw_report_sec_ie(adapter, authmode, psecuritypriv->supplicant_ie);
 	}
 
@@ -1865,7 +1865,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 
 	phtpriv->ht_option = false;
 
-	p = rtw_get_ie(in_ie+12, _HT_CAPABILITY_IE_, &ielen, in_len-12);
+	p = rtw_get_ie(in_ie + 12, _HT_CAPABILITY_IE_, &ielen, in_len - 12);
 
 	if (p && ielen > 0) {
 		struct ieee80211_ht_cap ht_cap;
@@ -1904,16 +1904,16 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		else
 			ht_cap.ampdu_params_info |= IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00;
 
-		rtw_set_ie(out_ie+out_len, _HT_CAPABILITY_IE_,
+		rtw_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
 			   sizeof(struct ieee80211_ht_cap),
 			   (unsigned char *)&ht_cap, pout_len);
 
 		phtpriv->ht_option = true;
 
-		p = rtw_get_ie(in_ie+12, _HT_ADD_INFO_IE_, &ielen, in_len-12);
+		p = rtw_get_ie(in_ie + 12, _HT_ADD_INFO_IE_, &ielen, in_len - 12);
 		if (p && (ielen == sizeof(struct ieee80211_ht_addt_info))) {
 			out_len = *pout_len;
-			rtw_set_ie(out_ie+out_len, _HT_ADD_INFO_IE_, ielen, p+2, pout_len);
+			rtw_set_ie(out_ie + out_len, _HT_ADD_INFO_IE_, ielen, p + 2, pout_len);
 		}
 	}
 	return phtpriv->ht_option;
-- 
2.17.1

