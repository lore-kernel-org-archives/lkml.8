Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13EDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D54320708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 05:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgESFif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 01:38:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:18092 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgESFie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:38:34 -0400
IronPort-SDR: xaFxeO+rVgF/y9mMeGPNcdPR0Jgzf9bzhJmsfT2cn6z4OQXAokjaJOsIC0rT6kcBrQ5cCezKQN
 3qyEvDaIGSTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:38:34 -0700
IronPort-SDR: rprKud2ASA/3Nc7i0qLhTHu3lEEKQpIJh3WEGfILRP9ubQiQVmzCkXJtlbDjxKz5a5DwoWHZ8V
 AMAaCIhloYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="288836611"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 22:38:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 5/5] soundwire: master: add runtime pm support
Date:   Tue, 19 May 2020 01:43:22 +0800
Message-Id: <20200518174322.31561-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
References: <20200518174322.31561-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to enable runtime_pm on master device with generic helpers,
so that a Slave-initiated wake is propagated to the bus parent.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/master.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/master.c b/drivers/soundwire/master.c
index 6be0a027def7..5411791e6aff 100644
--- a/drivers/soundwire/master.c
+++ b/drivers/soundwire/master.c
@@ -3,6 +3,7 @@
 
 #include <linux/device.h>
 #include <linux/acpi.h>
+#include <linux/pm_runtime.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
 #include "bus.h"
@@ -14,9 +15,15 @@ static void sdw_master_device_release(struct device *dev)
 	kfree(md);
 }
 
+static const struct dev_pm_ops master_dev_pm = {
+	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend,
+			   pm_generic_runtime_resume, NULL)
+};
+
 struct device_type sdw_master_type = {
 	.name =		"soundwire_master",
 	.release =	sdw_master_device_release,
+	.pm = &master_dev_pm,
 };
 
 /**
-- 
2.17.1

