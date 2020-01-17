Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C844BC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9052072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 17:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAQR4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:56:36 -0500
Received: from mga11.intel.com ([192.55.52.93]:62787 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgAQR4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 12:56:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 09:56:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="243739495"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2020 09:56:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 144BC1B4; Fri, 17 Jan 2020 19:56:27 +0200 (EET)
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
Subject: [PATCH v1 5/8] x86/quirks: Add a DMI quirk for Microsoft Surface 3
Date:   Fri, 17 Jan 2020 19:56:23 +0200
Message-Id: <20200117175626.56358-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117175626.56358-1-andriy.shevchenko@linux.intel.com>
References: <20200117175626.56358-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DMI quirk for Microsoft Surface 3 which will be utilized by few drivers.

Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jie Yang <yang.jie@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c                  | 16 ++++++++++++++++
 include/linux/platform_data/x86/machine.h |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 447d4fba8516..9574ef7eaa66 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -673,6 +673,15 @@ static int apple_machine_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
+bool x86_microsoft_surface_3_machine;
+EXPORT_SYMBOL(x86_microsoft_surface_3_machine);
+
+static int microsoft_surface_3_machine_cb(const struct dmi_system_id *id)
+{
+	x86_microsoft_surface_3_machine = true;
+	return 1;
+}
+
 static const struct dmi_system_id x86_machine_table[] = {
 	{
 		.ident = "x86 Apple Macintosh",
@@ -688,6 +697,13 @@ static const struct dmi_system_id x86_machine_table[] = {
 		},
 		.callback = apple_machine_cb,
 	},
+	{
+		.ident = "Microsoft Surface 3",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
+		},
+		.callback = microsoft_surface_3_machine_cb,
+	},
 	{}
 };
 
diff --git a/include/linux/platform_data/x86/machine.h b/include/linux/platform_data/x86/machine.h
index b1e7a560a046..9bdf5a06b490 100644
--- a/include/linux/platform_data/x86/machine.h
+++ b/include/linux/platform_data/x86/machine.h
@@ -8,8 +8,13 @@
  * x86_apple_machine - whether the machine is an x86 Apple Macintosh
  */
 extern bool x86_apple_machine;
+/**
+ * x86_microsoft_surface_3_machine - whether the machine is Microsoft Surface 3
+ */
+extern bool x86_microsoft_surface_3_machine;
 #else
 #define x86_apple_machine			false
+#define x86_microsoft_surface_3_machine		false
 #endif
 
 #endif	/* PLATFORM_DATA_X86_MACHINE_H */
-- 
2.24.1

