Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE42C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58AE24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgAVLX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:23:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:7011 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729158AbgAVLXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:23:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 03:23:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; 
   d="scan'208";a="374893591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Jan 2020 03:23:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A69D8494; Wed, 22 Jan 2020 13:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 5/9] x86/quirks: Convert DMI matching to use a table
Date:   Wed, 22 Jan 2020 13:23:02 +0200
Message-Id: <20200122112306.64598-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to extend the DMI based quirks, convert them to a table.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/quirks.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
index 6c122f35508a..3867f81baae7 100644
--- a/arch/x86/kernel/quirks.c
+++ b/arch/x86/kernel/quirks.c
@@ -658,8 +658,37 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
 bool x86_apple_machine;
 EXPORT_SYMBOL(x86_apple_machine);
 
+static const struct dmi_system_id x86_machine_table[] __initconst = {
+	{
+		.ident = "x86 Apple Macintosh",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+		},
+		.driver_data = &x86_apple_machine,
+	},
+	{
+		.ident = "x86 Apple Macintosh",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
+		},
+		.driver_data = &x86_apple_machine,
+	},
+	{}
+};
+
+static void __init early_platform_detect_quirk(void)
+{
+	const struct dmi_system_id *id;
+
+	id = dmi_first_match(x86_machine_table);
+	if (!id)
+		return;
+
+	printk(KERN_DEBUG "Detected %s platform\n", id->ident);
+	*((bool *)id->driver_data) = true;
+}
+
 void __init early_platform_quirks(void)
 {
-	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
-			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
+	early_platform_detect_quirk();
 }
-- 
2.24.1

