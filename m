Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86BC38A2C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27C782054F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371118AbgDOO4D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:56:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:4840 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S371078AbgDOOzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:55:46 -0400
IronPort-SDR: twNmq0jvy+/fJFVhcl4o1giLPAxwMl0fDp53wcmMXOFseWQN4EqVH7/HMhoLqeZ8dYOSHvQ0pn
 EzIAh1IWqj5w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 07:55:45 -0700
IronPort-SDR: nhXPKao3eUcAfs7hM1G3XyurKB89pBd9DIjIlI85+hBdUatgdhUWqlLJvaSgeS4RpN2mUj6DyP
 g+HuEdXQj4Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; 
   d="scan'208";a="299015149"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2020 07:55:43 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 50499812; Wed, 15 Apr 2020 17:55:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 5/9] x86/quirks: Convert DMI matching to use a table
Date:   Wed, 15 Apr 2020 17:55:20 +0300
Message-Id: <20200415145524.31745-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
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
index 091d03cfbb1e..a97055599bb7 100644
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
2.25.1

