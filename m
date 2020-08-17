Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E914FC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC4A2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597687604;
	bh=t8u8w4IGBunvHTL3i9cw06q3NxV02b8DyyxeDpT+qWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lELVPANVBR9LXql8R6hhVoOLd3yv/5bCEY1pWauw3aju5zBjFqNIlKlTrtyGu82UT
	 kWmelC/VJeMl1UMIw/ZgmRoMrilsSrFQf+5NA4y1GeUc7yMw1iVvB2H5c/UzFAItId
	 6kysuz2x3kVrdNkZASmDqrrVBl7g03kSaKrT+m9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390296AbgHQSGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388471AbgHQQIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:08:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9653A22CAF;
        Mon, 17 Aug 2020 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680526;
        bh=t8u8w4IGBunvHTL3i9cw06q3NxV02b8DyyxeDpT+qWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbY9nf85bzQb3l5gsHv++UjwxY0xhWtIpIVF7y3+Nnhw1BQyteo01/ZiAzhqyebea
         xo/BQr2p//MHgIZGsp45ABMYj4IpVVIHNINb/XESFWv7AJad3EuM2a5ztNnwIwWklc
         h37fVclM9Gh5RWqxlrmcY8bOVVnnz/JMwFqo64vs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tsang-Shian Lin <thlin@realtek.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 194/270] rtw88: fix short GI capability based on current bandwidth
Date:   Mon, 17 Aug 2020 17:16:35 +0200
Message-Id: <20200817143805.454346390@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tsang-Shian Lin <thlin@realtek.com>

[ Upstream commit 4dd86b901d1373ef8446ecb50a7ca009f3475211 ]

Fix the transmission is not sent with short GI under
some conditions even if the receiver supports short GI.
If VHT capability IE exists in the beacon, the original
code uses the short GI for 80M field as driver's short GI
setting for transmission, even the current bandwidth is
not 80MHz.

Short GI supported fields for 20M/40M are informed in HT
capability information element, and short GI supported
field for 80M is informed in VHT capability information
element.

These three fields may be set to different values.
Driver needs to record each short GI support field for
each bandwidth, and send correct info depends on current
bandwidth to the WiFi firmware.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20200717064937.27966-3-yhchuang@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 88e2252bf8a2b..15c7a6fc37b90 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -553,8 +553,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 			stbc_en = VHT_STBC_EN;
 		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_RXLDPC)
 			ldpc_en = VHT_LDPC_EN;
-		if (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80)
-			is_support_sgi = true;
 	} else if (sta->ht_cap.ht_supported) {
 		ra_mask |= (sta->ht_cap.mcs.rx_mask[1] << 20) |
 			   (sta->ht_cap.mcs.rx_mask[0] << 12);
@@ -562,9 +560,6 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 			stbc_en = HT_STBC_EN;
 		if (sta->ht_cap.cap & IEEE80211_HT_CAP_LDPC_CODING)
 			ldpc_en = HT_LDPC_EN;
-		if (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20 ||
-		    sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40)
-			is_support_sgi = true;
 	}
 
 	if (efuse->hw_cap.nss == 1)
@@ -606,12 +601,18 @@ void rtw_update_sta_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si)
 	switch (sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_80:
 		bw_mode = RTW_CHANNEL_WIDTH_80;
+		is_support_sgi = sta->vht_cap.vht_supported &&
+				 (sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		bw_mode = RTW_CHANNEL_WIDTH_40;
+		is_support_sgi = sta->ht_cap.ht_supported &&
+				 (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
 		break;
 	default:
 		bw_mode = RTW_CHANNEL_WIDTH_20;
+		is_support_sgi = sta->ht_cap.ht_supported &&
+				 (sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
 		break;
 	}
 
-- 
2.25.1



