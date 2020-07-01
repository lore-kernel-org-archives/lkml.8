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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E259C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3640720702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOlYI1qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbgGAQpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgGAQpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:45:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B82C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 09:45:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u17so18963036qtq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 09:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0XJ0Slz7kZn6xQCV03ZiEkNStp45H7CUj9hGVbrJA4=;
        b=WOlYI1qysbjpCzlysPRaGJ4VaNr1szvkRUtaVRqNVOKRG2psRSUuDfXpJ8eIG0CcZo
         Xt92VQ8wVt5dL8um5nFiaX7r/CE5lvDMp5vQ/ya9ObE1d3//832zRa/psutipnrPnzhl
         JguhH+zEZNWNMvTrdoQ6HncUkyrgqu9qrpWQdkz7c2T0K7pzTswsNIGfneTQP7dv4B3S
         ZqSEw/OQoszGHqaMzuWjuWlmT0qTFF9n55zQuqJ1MgihJVkzXnBWEpbr7Uu+FmBWr2M3
         9Mvh9b/00KfZ0ohaH6mY3iXEaly5xPu40qKdcdI3Sg4xxnAqilubjcC/lfkHZWpZBU5r
         zgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0XJ0Slz7kZn6xQCV03ZiEkNStp45H7CUj9hGVbrJA4=;
        b=UMQTpg8Sgb/JINSDhXRAOOBcIBPUM4NCtcLwoOj+M9Aie/nPXOWSrqMkrT4x6lLset
         pnKDe6yTlcXhvIqj2VErcnyFPncWsje470PfHxuCE2ZLN8kCdJDRmBUqDC/eXog5dn0m
         BE6tLm4rpH60qvY81YwHMlLVypBzA+zjzeJc4zd5rDeEYxy4+k7aIsj9Z0q7GOy3s7c+
         jLWD/r7o4qEOiLOuHy/J91FKHmfejPMr3zl6j82/RfidVKCl5qjv7HsNGKodlcdKJMSZ
         QmDl/VKyDjC9BvI2SCTvOE+xFSSID09fA2eCqWqqILSV9q5ZCWKSt2ldkXeuBzbtPfmu
         Cepg==
X-Gm-Message-State: AOAM5318Vq7ity5G0AJqW0pDpP8m1udkEF95TkLj17dyx97KbJAQUw3T
        0AIMD+elfmiXs9sPoVHGr8o=
X-Google-Smtp-Source: ABdhPJx4ulb3eFwQXAKpSzVSL7OnSrOyLoX9VIXGKbnlc7gytKE2kz0+C4u+jDfXs4xlVAVxDca18w==
X-Received: by 2002:ac8:4f4c:: with SMTP id i12mr7109254qtw.17.1593621930946;
        Wed, 01 Jul 2020 09:45:30 -0700 (PDT)
Received: from localhost.localdomain (dslb-178-011-230-214.178.011.pools.vodafone-ip.de. [178.11.230.214])
        by smtp.gmail.com with ESMTPSA id w77sm6247489qka.34.2020.07.01.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 09:45:30 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8712: use common ieee80211 constants
Date:   Wed,  1 Jul 2020 18:42:13 +0200
Message-Id: <20200701164213.4205-1-straube.linux@gmail.com>
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
 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  2 +-
 drivers/staging/rtl8712/rtl871x_mlme.c        |  8 +--
 drivers/staging/rtl8712/wifi.h                | 51 -------------------
 3 files changed, 5 insertions(+), 56 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
index 36c89cde525d..81482d5ae1a3 100644
--- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
+++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
@@ -1411,7 +1411,7 @@ static int r8711_wx_get_rate(struct net_device *dev,
 		pht_capie = (struct rtl_ieee80211_ht_cap *)(p + 2);
 		memcpy(&mcs_rate, pht_capie->supp_mcs_set, 2);
 		bw_40MHz = (le16_to_cpu(pht_capie->cap_info) &
-			    IEEE80211_HT_CAP_SUP_WIDTH) ? 1 : 0;
+			    IEEE80211_HT_CAP_SUP_WIDTH_20_40) ? 1 : 0;
 		short_GI = (le16_to_cpu(pht_capie->cap_info) &
 			    (IEEE80211_HT_CAP_SGI_20 |
 			    IEEE80211_HT_CAP_SGI_40)) ? 1 : 0;
diff --git a/drivers/staging/rtl8712/rtl871x_mlme.c b/drivers/staging/rtl8712/rtl871x_mlme.c
index efd75add8e35..9ee1bfac0763 100644
--- a/drivers/staging/rtl8712/rtl871x_mlme.c
+++ b/drivers/staging/rtl8712/rtl871x_mlme.c
@@ -1660,14 +1660,14 @@ unsigned int r8712_restructure_ht_ie(struct _adapter *padapter, u8 *in_ie,
 		}
 		out_len = *pout_len;
 		memset(&ht_capie, 0, sizeof(struct rtl_ieee80211_ht_cap));
-		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH |
+		ht_capie.cap_info = cpu_to_le16(IEEE80211_HT_CAP_SUP_WIDTH_20_40 |
 				    IEEE80211_HT_CAP_SGI_20 |
 				    IEEE80211_HT_CAP_SGI_40 |
 				    IEEE80211_HT_CAP_TX_STBC |
 				    IEEE80211_HT_CAP_MAX_AMSDU |
 				    IEEE80211_HT_CAP_DSSSCCK40);
-		ht_capie.ampdu_params_info = (IEEE80211_HT_CAP_AMPDU_FACTOR &
-				0x03) | (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
+		ht_capie.ampdu_params_info = (IEEE80211_HT_AMPDU_PARM_FACTOR &
+				0x03) | (IEEE80211_HT_AMPDU_PARM_DENSITY & 0x00);
 		r8712_set_ie(out_ie + out_len, _HT_CAPABILITY_IE_,
 			     sizeof(struct rtl_ieee80211_ht_cap),
 			     (unsigned char *)&ht_capie, pout_len);
@@ -1705,7 +1705,7 @@ static void update_ht_cap(struct _adapter *padapter, u8 *pie, uint ie_len)
 	if (p && len > 0) {
 		pht_capie = (struct rtl_ieee80211_ht_cap *)(p + 2);
 		max_ampdu_sz = (pht_capie->ampdu_params_info &
-				IEEE80211_HT_CAP_AMPDU_FACTOR);
+				IEEE80211_HT_AMPDU_PARM_FACTOR);
 		/* max_ampdu_sz (kbytes); */
 		max_ampdu_sz = 1 << (max_ampdu_sz + 3);
 		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
index 66e0634f07ba..601d4ff607bc 100644
--- a/drivers/staging/rtl8712/wifi.h
+++ b/drivers/staging/rtl8712/wifi.h
@@ -437,13 +437,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
  *------------------------------------------------------------------------------
  */
 
-/* block-ack parameters */
-#define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
-#define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
-#define IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
-#define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
-#define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800
-
 #define SetOrderBit(pbuf) ({ \
 	*(__le16 *)(pbuf) |= cpu_to_le16(_ORDER_); \
 })
@@ -481,49 +474,5 @@ struct ieee80211_ht_addt_info {
 	unsigned char		basic_set[16];
 } __packed;
 
-/* 802.11n HT capabilities masks */
-#define IEEE80211_HT_CAP_SUP_WIDTH		0x0002
-#define IEEE80211_HT_CAP_SM_PS			0x000C
-#define IEEE80211_HT_CAP_GRN_FLD		0x0010
-#define IEEE80211_HT_CAP_SGI_20			0x0020
-#define IEEE80211_HT_CAP_SGI_40			0x0040
-#define IEEE80211_HT_CAP_TX_STBC			0x0080
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
-/*
- * A-PMDU buffer sizes
- * According to IEEE802.11n spec size varies from 8K to 64K (in powers of 2)
- */
-#define IEEE80211_MIN_AMPDU_BUF 0x8
-
-/* Spatial Multiplexing Power Save Modes */
-#define WLAN_HT_CAP_SM_PS_STATIC		0
-#define WLAN_HT_CAP_SM_PS_DYNAMIC	1
-#define WLAN_HT_CAP_SM_PS_INVALID	2
-#define WLAN_HT_CAP_SM_PS_DISABLED	3
-
 #endif /* _WIFI_H_ */
 
-- 
2.27.0

