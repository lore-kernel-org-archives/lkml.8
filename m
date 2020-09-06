Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ACFC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 13:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 614DB20760
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 13:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3xN9/vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgIFNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 09:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgIFN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 09:27:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58583C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 06:27:56 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w3so13011138ljo.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 06:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9X2quCT3ijRZbfEg1lBDRxkIX0ndQZpXitZWRbnil4=;
        b=a3xN9/vEhqSkTymr7qjQlPOQeFnCLASezuSHqkwv8HH1ND3Z3EpFQxbFbASRaNolJq
         kQBpsEKe32xsLDG1rPZzIYqgsh7pbpnjtCsa+8Yx/GvBfsUzX09rvaIsADacDbxH0u3J
         zMugpdzVAseTcZm+YKs1D86xsA2ynVvJjTFTRnMZPK9l+e01H+hWcH1o47qDsQamz4oM
         liGr32QxprkkXSbH15BezBZAbmtlizKcN3fiv7+IpAKipENAqri75fZYj+3u+MalZPgo
         PlmVBS34n0xmcr8vzQXFl6RByJVL0OicuyG0jfN1T2fwcV7wwMlDw+bNuhZz63PLdE7a
         UWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o9X2quCT3ijRZbfEg1lBDRxkIX0ndQZpXitZWRbnil4=;
        b=bXPp6quWWmUHe8XoxPcGhFcP/fPFgjCaMYdxS3Unl4Hxu24KFyogixOMWy39G21UH4
         I/dtB+j2FPP6OonaQuP+wgRKGxAuAljAq8o2TTh/2YBI7YWHKNEVs0rX9cvTBA18mjix
         u94j6kB/MwrJ25/3g3T0zeVbEGSRsK78NA8yg3SrIIbonDBsucgi1xt4RhErrdr1Tr13
         yFWLd9vPu6/fhX+dZTenJlFP9QgN0iaRIcsYO/yJVeMD6AYgzxWOBDm3Difod5B1uZ5G
         4EwCRH8WoqZCseb7v7dhChuDO1s9m/45xjhlyPE5NmOLcGMhsDIxycNuc7AreUQl97OS
         jisg==
X-Gm-Message-State: AOAM533QtOiSjQK/zcCi+KklCcc4iTX+slqQK8GTnpEgN/jJeMwWxGpv
        TWej6wyvezYa9MWZx2RFzIAfVQMGd30=
X-Google-Smtp-Source: ABdhPJxi6jKv3UU4V74z8BpHT0legfyJ6m4liwDjnUs26TCqWbf+zXKSGEFe/8+C6okzWB2llg7JkA==
X-Received: by 2002:a2e:7c18:: with SMTP id x24mr8025546ljc.402.1599398874492;
        Sun, 06 Sep 2020 06:27:54 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id k10sm4219247lja.112.2020.09.06.06.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 06:27:53 -0700 (PDT)
Received: (nullmailer pid 556475 invoked by uid 1000);
        Sun, 06 Sep 2020 13:33:01 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: replace enum rtw_ieee80211_spectrum_mgmt_actioncode with ieee80211_spectrum_mgmt_actioncode
Date:   Sun,  6 Sep 2020 16:32:37 +0300
Message-Id: <20200906133236.556427-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enum rtw_ieee80211_spectrum_mgmt_actioncode is a duplication
of ieee80211_spectrum_mgmt_actioncode from include/linux/ieee80211.h.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 10 +++++-----
 drivers/staging/rtl8188eu/include/ieee80211.h | 10 ----------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index 98b1ba2e489f..0eaf81e83ddc 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -3546,12 +3546,12 @@ static unsigned int on_action_spct(struct adapter *padapter,
 
 	action = frame_body[1];
 	switch (action) {
-	case RTW_WLAN_ACTION_SPCT_MSR_REQ:
-	case RTW_WLAN_ACTION_SPCT_MSR_RPRT:
-	case RTW_WLAN_ACTION_SPCT_TPC_REQ:
-	case RTW_WLAN_ACTION_SPCT_TPC_RPRT:
+	case WLAN_ACTION_SPCT_MSR_REQ:
+	case WLAN_ACTION_SPCT_MSR_RPRT:
+	case WLAN_ACTION_SPCT_TPC_REQ:
+	case WLAN_ACTION_SPCT_TPC_RPRT:
 		break;
-	case RTW_WLAN_ACTION_SPCT_CHL_SWITCH:
+	case WLAN_ACTION_SPCT_CHL_SWITCH:
 		break;
 	default:
 		break;
diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index 83218e7ec0a9..cb6940d2aeab 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -526,16 +526,6 @@ enum rtw_ieee80211_category {
 	RTW_WLAN_CATEGORY_P2P = 0x7f,/* P2P action frames */
 };
 
-/* SPECTRUM_MGMT action code */
-enum rtw_ieee80211_spectrum_mgmt_actioncode {
-	RTW_WLAN_ACTION_SPCT_MSR_REQ = 0,
-	RTW_WLAN_ACTION_SPCT_MSR_RPRT = 1,
-	RTW_WLAN_ACTION_SPCT_TPC_REQ = 2,
-	RTW_WLAN_ACTION_SPCT_TPC_RPRT = 3,
-	RTW_WLAN_ACTION_SPCT_CHL_SWITCH = 4,
-	RTW_WLAN_ACTION_SPCT_EXT_CHL_SWITCH = 5,
-};
-
 enum _PUBLIC_ACTION {
 	ACT_PUBLIC_BSSCOEXIST = 0, /*  20/40 BSS Coexistence */
 	ACT_PUBLIC_DSE_ENABLE = 1,
-- 
2.26.2

