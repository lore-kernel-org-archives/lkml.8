Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D35C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188E920786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 03:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0D4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 23:56:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:26018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgH0D4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 23:56:45 -0400
IronPort-SDR: sK8aqrfnso6vih/uTUJI5+zJXt6S+cyuI36RWPuzjH/3ps5wg6zG0qEK1OM2STAm8EKxcMHWY0
 2HtP16CDYeLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="136484482"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="136484482"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 20:56:45 -0700
IronPort-SDR: 1pF0W3/zv1KsciQJ3CX4yuQZcoYqiCXl8sho5I5KXylTlS6MSyrJp0mslecwv1k2jk0xvUaC6+
 W41y7Zkp5p4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="280513839"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga007.fm.intel.com with ESMTP; 26 Aug 2020 20:56:42 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     cw00.choi@samsung.com, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v2 2/2] extcon: ptn5150: Set the VBUS and POLARITY property state
Date:   Thu, 27 Aug 2020 11:56:33 +0800
Message-Id: <20200827035633.37348-3-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Set the VBUS and POLARITY property state.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/extcon/extcon-ptn5150.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/extcon/extcon-ptn5150.c b/drivers/extcon/extcon-ptn5150.c
index 8b930050a3f1..b5217a61615c 100644
--- a/drivers/extcon/extcon-ptn5150.c
+++ b/drivers/extcon/extcon-ptn5150.c
@@ -279,6 +279,12 @@ static int ptn5150_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	extcon_set_property_capability(info->edev, EXTCON_USB,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_VBUS);
+	extcon_set_property_capability(info->edev, EXTCON_USB_HOST,
+				       EXTCON_PROP_USB_TYPEC_POLARITY);
 	/* Initialize PTN5150 device and print vendor id and version id */
 	ret = ptn5150_init_dev_type(info);
 	if (ret)
-- 
2.11.0

