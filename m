Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F36C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3224E207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgH0Gvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:51:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:32222 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0Gvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:51:38 -0400
IronPort-SDR: FJOLZp7GuhgT9V7jFyk5ExVwaQ+0JDw4VoshMNvSVKYVIlGMZhLG0iH34qd1lpQC4aJnsxzlO2
 BPnooTLO1bIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153995392"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="153995392"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 23:51:37 -0700
IronPort-SDR: JIzzDn9OhFzxbBRgEzVTX1f/LeBQlkKV1k+ojtu+h/3hBF3kfXdrsGOSjR45iG37syf+LTTtpc
 TAVZVV2M1gDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="444336876"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga004.jf.intel.com with ESMTP; 26 Aug 2020 23:51:34 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v3 1/1] extcon: ptn5150: Set the VBUS and POLARITY property capability
Date:   Thu, 27 Aug 2020 14:51:28 +0800
Message-Id: <20200827065128.55094-2-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200827065128.55094-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Set the capability value of property for VBUS and POLARITY.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 841c9fe211f1..20d49a54c36e 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -275,6 +275,13 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	extcon_set_property_capability(info->edev, EXTCON_USB,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
+
 	/* Initialize PTN5150 device and print vendor id and version id */
 	ret = ptn5150_init_dev_type(info);
 	if (ret)
-- 
2.11.0

