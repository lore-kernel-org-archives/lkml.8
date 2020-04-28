Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F24C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65602206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgD1NcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:32:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgD1NcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:32:05 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6DBB7485DB123A2BECDA;
        Tue, 28 Apr 2020 21:32:00 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Apr 2020
 21:31:49 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <gregkh@linuxfoundation.org>, <luk@wybcz.pl>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] staging: rtl8723bs: os_dep: remove rtw_spt_band_free()
Date:   Tue, 28 Apr 2020 21:31:15 +0800
Message-ID: <20200428133115.28072-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that rtw_spt_band_free() is only a direct wrapper of kfree, we can
remove it and just use kfree().

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index b037868fbf22..478e10d708e9 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -152,11 +152,6 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 	return spt_band;
 }
 
-static void rtw_spt_band_free(struct ieee80211_supported_band *spt_band)
-{
-	kfree(spt_band);
-}
-
 static const struct ieee80211_txrx_stypes
 rtw_cfg80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 	[NL80211_IFTYPE_ADHOC] = {
@@ -3476,7 +3471,7 @@ void rtw_wdev_free(struct wireless_dev *wdev)
 	if (!wdev)
 		return;
 
-	rtw_spt_band_free(wdev->wiphy->bands[NL80211_BAND_2GHZ]);
+	kfree(wdev->wiphy->bands[NL80211_BAND_2GHZ]);
 
 	wiphy_free(wdev->wiphy);
 
-- 
2.21.1

