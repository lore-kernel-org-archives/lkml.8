Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC7AC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDA5208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBKN0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:26:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:3599 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbgBKN0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:26:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 05:26:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="347279670"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Feb 2020 05:26:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 8210764B; Tue, 11 Feb 2020 15:26:04 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 16/18] platform/x86: intel_telemetry: Add telemetry_get_pltdata()
Date:   Tue, 11 Feb 2020 16:26:01 +0300
Message-Id: <20200211132603.73509-17-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
References: <20200211132603.73509-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new function that allows telemetry modules to get pointer to the
platform specific configuration. This is needed to allow the telemetry
debugfs module to fetch PMC IPC instance in the subsequent patch.

This also allows us to replace telemetry_pltconfig_valid() with
telemetry_get_pltdata() as well.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/include/asm/intel_telemetry.h         |  2 +-
 drivers/platform/x86/intel_telemetry_core.c    | 17 ++++++-----------
 drivers/platform/x86/intel_telemetry_debugfs.c |  3 +--
 3 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/intel_telemetry.h b/arch/x86/include/asm/intel_telemetry.h
index 274aaf0dae48..2c0e7d7a10e9 100644
--- a/arch/x86/include/asm/intel_telemetry.h
+++ b/arch/x86/include/asm/intel_telemetry.h
@@ -95,7 +95,7 @@ int telemetry_set_pltdata(const struct telemetry_core_ops *ops,
 
 int telemetry_clear_pltdata(void);
 
-int telemetry_pltconfig_valid(void);
+struct telemetry_plt_config *telemetry_get_pltdata(void);
 
 int telemetry_get_evtname(enum telemetry_unit telem_unit,
 			  const char **name, int len);
diff --git a/drivers/platform/x86/intel_telemetry_core.c b/drivers/platform/x86/intel_telemetry_core.c
index d4040bb222b4..fdf55b5d6948 100644
--- a/drivers/platform/x86/intel_telemetry_core.c
+++ b/drivers/platform/x86/intel_telemetry_core.c
@@ -353,21 +353,16 @@ int telemetry_clear_pltdata(void)
 EXPORT_SYMBOL_GPL(telemetry_clear_pltdata);
 
 /**
- * telemetry_pltconfig_valid() - Checkif platform config is valid
+ * telemetry_get_pltdata() - Return telemetry platform config
  *
- * Usage by other than telemetry module is invalid
- *
- * Return: 0 success, < 0 for failure
+ * May be used by other telemetry modules to get platform specific
+ * configuration.
  */
-int telemetry_pltconfig_valid(void)
+struct telemetry_plt_config *telemetry_get_pltdata(void)
 {
-	if (telm_core_conf.plt_config)
-		return 0;
-
-	else
-		return -EINVAL;
+	return telm_core_conf.plt_config;
 }
-EXPORT_SYMBOL_GPL(telemetry_pltconfig_valid);
+EXPORT_SYMBOL_GPL(telemetry_get_pltdata);
 
 static inline int telemetry_get_pssevtname(enum telemetry_unit telem_unit,
 					   const char **name, int len)
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index 8e3fb55ac1ae..85a456aa0ab9 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -911,8 +911,7 @@ static int __init telemetry_debugfs_init(void)
 
 	debugfs_conf = (struct telemetry_debugfs_conf *)id->driver_data;
 
-	err = telemetry_pltconfig_valid();
-	if (err < 0) {
+	if (!telemetry_get_pltdata()) {
 		pr_info("Invalid pltconfig, ensure IPC1 device is enabled in BIOS\n");
 		return -ENODEV;
 	}
-- 
2.25.0

