Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9E9C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBEC2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAQR6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:58:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:44893 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgAQR6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:58:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 09:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="426077015"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2020 09:56:31 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2951634A; Fri, 17 Jan 2020 19:56:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH v1 7/8] ASoC: Intel: Switch DMI table match to a test of variable
Date:   Fri, 17 Jan 2020 19:56:25 +0200
Message-Id: <20200117175626.56358-7-andriy.shevchenko@linux.intel.com>
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

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-cht-match.c   | 28 ++-----------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index d0fb43c2b9f6..833d2e130e6e 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -5,31 +5,11 @@
  * Copyright (c) 2017, Intel Corporation.
  */
 
-#include <linux/dmi.h>
+#include <linux/platform_data/x86/machine.h>
+
 #include <sound/soc-acpi.h>
 #include <sound/soc-acpi-intel-match.h>
 
-static unsigned long cht_machine_id;
-
-#define CHT_SURFACE_MACH 1
-
-static int cht_surface_quirk_cb(const struct dmi_system_id *id)
-{
-	cht_machine_id = CHT_SURFACE_MACH;
-	return 1;
-}
-
-static const struct dmi_system_id cht_table[] = {
-	{
-		.callback = cht_surface_quirk_cb,
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
-		},
-	},
-	{ }
-};
-
 static struct snd_soc_acpi_mach cht_surface_mach = {
 	.id = "10EC5640",
 	.drv_name = "cht-bsw-rt5645",
@@ -43,9 +23,7 @@ static struct snd_soc_acpi_mach *cht_quirk(void *arg)
 {
 	struct snd_soc_acpi_mach *mach = arg;
 
-	dmi_check_system(cht_table);
-
-	if (cht_machine_id == CHT_SURFACE_MACH)
+	if (x86_microsoft_surface_3_machine)
 		return &cht_surface_mach;
 	else
 		return mach;
-- 
2.24.1

