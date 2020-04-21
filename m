Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A9ADC55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A9C32072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDUVZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:25:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45840 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgDUVZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:25:48 -0400
Received: from localhost.localdomain (unknown [188.123.230.157])
        by mail.ispras.ru (Postfix) with ESMTPSA id 6DAFBCD46A;
        Wed, 22 Apr 2020 00:25:46 +0300 (MSK)
From:   Denis Straghkov <d.straghkov@ispras.ru>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Denis Straghkov <d.straghkov@ispras.ru>
Subject: [PATCH v2] Staging: rtl8723bs: rtw_wlan_util: Add size check of SSID IE
Date:   Wed, 22 Apr 2020 00:25:25 +0300
Message-Id: <20200421212525.24962-1-d.straghkov@ispras.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add size check of SSID information element in incoming 802.11
frames, to prevent memcpy() of IE in array bssid->Ssid.Ssid, with
size more than 32 bytes.

Signed-off-by: Denis Straghkov <d.straghkov@ispras.ru>
---
Changes in v2:
  - Replace spaces on tabs.

 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 22 +++++++------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 110338dbe372..69bcd172b298 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1271,13 +1271,13 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	unsigned char *pbuf;
 	u32 wpa_ielen = 0;
 	u8 *pbssid = GetAddr3Ptr(pframe);
-	u32 hidden_ssid = 0;
 	struct HT_info_element *pht_info = NULL;
 	struct rtw_ieee80211_ht_cap *pht_cap = NULL;
 	u32 bcn_channel;
 	unsigned short	ht_cap_info;
 	unsigned char ht_info_infos_0;
 	struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
+	int ssid_len;
 
 	if (is_client_associated_to_ap(Adapter) == false)
 		return true;
@@ -1370,21 +1370,15 @@ int rtw_check_bcn_info(struct adapter *Adapter, u8 *pframe, u32 packet_len)
 	}
 
 	/* checking SSID */
+	ssid_len = 0;
 	p = rtw_get_ie(bssid->IEs + _FIXED_IE_LENGTH_, _SSID_IE_, &len, bssid->IELength - _FIXED_IE_LENGTH_);
-	if (!p) {
-		DBG_871X("%s marc: cannot find SSID for survey event\n", __func__);
-		hidden_ssid = true;
-	} else {
-		hidden_ssid = false;
-	}
-
-	if ((NULL != p) && (false == hidden_ssid && (*(p + 1)))) {
-		memcpy(bssid->Ssid.Ssid, (p + 2), *(p + 1));
-		bssid->Ssid.SsidLength = *(p + 1);
-	} else {
-		bssid->Ssid.SsidLength = 0;
-		bssid->Ssid.Ssid[0] = '\0';
+	if (p) {
+		ssid_len = *(p + 1);
+		if (ssid_len > NDIS_802_11_LENGTH_SSID)
+			ssid_len = 0;
 	}
+	memcpy(bssid->Ssid.Ssid, (p + 2), ssid_len);
+	bssid->Ssid.SsidLength = ssid_len;
 
 	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s bssid.Ssid.Ssid:%s bssid.Ssid.SsidLength:%d "
 				"cur_network->network.Ssid.Ssid:%s len:%d\n", __func__, bssid->Ssid.Ssid,
-- 
2.17.1

