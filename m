Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8424C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 805AA2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAQR4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:56:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:28768 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729108AbgAQR4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:56:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 09:56:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="249323711"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 17 Jan 2020 09:56:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 346664BC; Fri, 17 Jan 2020 19:56:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 8/8] rtc: cmos: Switch DMI table match to a test of variable
Date:   Fri, 17 Jan 2020 19:56:26 +0200
Message-Id: <20200117175626.56358-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117175626.56358-1-andriy.shevchenko@linux.intel.com>
References: <20200117175626.56358-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have a common x86 quirk that provides an exported variable,
use it instead of local DMI table match.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-cmos.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 09b7cdda9f55..b8b67a98c47a 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -33,6 +33,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
+#include <linux/platform_data/x86/machine.h>
 #include <linux/platform_device.h>
 #include <linux/log2.h>
 #include <linux/pm.h>
@@ -1219,16 +1220,6 @@ static void use_acpi_alarm_quirks(void)
 static inline void use_acpi_alarm_quirks(void) { }
 #endif
 
-static const struct dmi_system_id rtc_cmos_surface3_table[] = {
-	{
-		.ident = "Microsoft Surface 3",
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-	},
-	{}
-};
-
 /* Every ACPI platform has a mc146818 compatible "cmos rtc".  Here we find
  * its device node and pass extra config data.  This helps its driver use
  * capabilities that the now-obsolete mc146818 didn't have, and informs it
@@ -1243,7 +1234,7 @@ static void cmos_wake_setup(struct device *dev)
 
 	use_acpi_alarm_quirks();
 
-	if (dmi_check_system(rtc_cmos_surface3_table))
+	if (x86_microsoft_surface_3_machine)
 		acpi_rtc_info.flags |= CMOS_RTC_FLAGS_SHARED_IRQ;
 
 	rtc_wake_setup(dev);
-- 
2.24.1

