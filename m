Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455B2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F49A214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgCBNeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:34:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:64720 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgCBNdl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:33:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 05:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,507,1574150400"; 
   d="scan'208";a="440136242"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 02 Mar 2020 05:33:37 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2D78CB5B; Mon,  2 Mar 2020 15:33:28 +0200 (EET)
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
Subject: [PATCH v7 17/19] platform/x86: intel_telemetry: Add telemetry_get_pltdata()
Date:   Mon,  2 Mar 2020 16:33:25 +0300
Message-Id: <20200302133327.55929-18-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
References: <20200302133327.55929-1-mika.westerberg@linux.intel.com>
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

