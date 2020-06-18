Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61263C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35EAA20739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZRw1G/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgFROLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730457AbgFROLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:11:21 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E662C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:11:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so6559870ejr.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Yg54d7njUgJIr5/oOvMr1TqPWbfMjWXQqQsrZ0cQ9xU=;
        b=dZRw1G/ge2Pyp9lVS/oz979LwAUvoLOJ+pApWvx33HkscEqwAb2sNzUKblOK9Vii/F
         uhfq8K5TkiJ2Vdy7Jr/w7B2vrb4rG2AwreV0WjERod7fGSuJD3bGPZ5oZyJb6gJL0/si
         Ab653+fNBhymx/gp+e0qwRvfxxEYRFfVXeEMEfy89SMtqwR1whJI0k3vbOV1HTeL+uU8
         h9bPwab6FXSn8XuvIMDKqSQY4Hfk025/nkLhf4pniJuzwscrGO0p5ej5GB/dJLT8PQBz
         zMJxFzhRzBmZQbIlqJ7xhd2jnNDA51uXoXd03SRBqOIOgVWZewxb677lwV5U381/TTaU
         piZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Yg54d7njUgJIr5/oOvMr1TqPWbfMjWXQqQsrZ0cQ9xU=;
        b=ByYbkzKKDwlE/UjpWavV/DfQdOz3aLJrqvNjizR7mqNprlLXkFjGoCL1cuZjKJSzfY
         BeQ0h3snL7bcC7Cxwn8vNAsRgZYsENshDU9O2F7X/pfaorwvjE9TtzBTISwt59YufJEa
         Md7ngDMXSGUztpHbhO9y5FGTVPPti81NWUQ1aQykvZDYf8pZy/yrBUmFGjWMii+aoQD/
         fJqvRDQbFmIsNTJFVQ3Wwm+HqN2Qm9LYOR/DwMmpMkMeTrBdNCcji8H+nxCuK5/w3rQ1
         aHmsz3dclLckuCZnVhoGaUdH68oU2oDeeNTEV5wCrPmwzYU1aGZjR2/oHdkxf9EMlWKU
         fz1Q==
X-Gm-Message-State: AOAM532M+MbRk6WJ/UegbZTM840ucEtsKVMXlEyreohbf2Uq0HjJTItK
        7OqCqYclP0OOzZbh7ZCkR2Gx42kVD9XSv3H7
X-Google-Smtp-Source: ABdhPJwhOyw2Vz5MOw49Q+Yb8S5U1I4OIIY0lq3QDOnO+74vPUmR9VwzOhoPR84HycniT3kgPo1blQ==
X-Received: by 2002:a17:906:cede:: with SMTP id si30mr4271836ejb.315.1592489478817;
        Thu, 18 Jun 2020 07:11:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:908:d70:b300:c943:7d59:8784:d6c9])
        by smtp.googlemail.com with ESMTPSA id y26sm2167230edv.91.2020.06.18.07.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:11:18 -0700 (PDT)
From:   Shihab Rashed <shihab.rashed97@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shihab Rashed <shihab.rashed97@gmail.com>
Subject: [PATCH] staging: rtl8723bs: os_dep: ioctl_cfg80211: fixed code styl issues
Date:   Thu, 18 Jun 2020 16:10:02 +0200
Message-Id: <20200618141002.18895-1-shihab.rashed97@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed two brace coding style issues and one comment style issue found by
checkpatch.

Signed-off-by: Shihab Rashed <shihab.rashed97@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 2fb80b6eb51d..3b06b60cdfd1 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -117,15 +117,12 @@ static struct ieee80211_supported_band *rtw_spt_band_alloc(
 	struct ieee80211_supported_band *spt_band = NULL;
 	int n_channels, n_bitrates;
 
-	if (band == NL80211_BAND_2GHZ)
-	{
+	if (band == NL80211_BAND_2GHZ)	{
 		n_channels = RTW_2G_CHANNELS_NUM;
 		n_bitrates = RTW_G_RATES_NUM;
-	}
-	else
-	{
+	} else	{
 		goto exit;
-	}
+		}
 
 	spt_band = rtw_zmalloc(sizeof(struct ieee80211_supported_band) +
 			       sizeof(struct ieee80211_channel) * n_channels +
@@ -203,8 +200,10 @@ rtw_cfg80211_default_mgmt_stypes[NUM_NL80211_IFTYPES] = {
 
 static int rtw_ieee80211_channel_to_frequency(int chan, int band)
 {
-	/* see 802.11 17.3.8.3.2 and Annex J
-	* there are overlapping channel numbers in 5GHz and 2GHz bands */
+	/*
+	 * see 802.11 17.3.8.3.2 and Annex J
+	 * there are overlapping channel numbers in 5GHz and 2GHz bands
+	 */
 	if (band == NL80211_BAND_2GHZ) {
 		if (chan == 14)
 			return 2484;
-- 
2.17.1

