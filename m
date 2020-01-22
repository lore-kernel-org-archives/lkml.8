Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34690C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055CD2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAVLXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 06:23:11 -0500
Received: from mga02.intel.com ([134.134.136.20]:19606 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgAVLXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:23:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 03:23:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,349,1574150400"; 
   d="scan'208";a="427378206"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jan 2020 03:23:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 88839202; Wed, 22 Jan 2020 13:23:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/9] x86/platform: Rename x86/apple.h -> x86/machine.h
Date:   Wed, 22 Jan 2020 13:22:58 +0200
Message-Id: <20200122112306.64598-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
References: <20200122112306.64598-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename linux/platform_data/x86/apple.h to linux/platform_data/x86/machine.h
in order to add new quirks later on. For sake of being less intrusive,
leave former file that includes a latter one.

While here, add include to linux/types.h due to bool type in use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_data/x86/apple.h   | 14 +-------------
 include/linux/platform_data/x86/machine.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 13 deletions(-)
 create mode 100644 include/linux/platform_data/x86/machine.h

diff --git a/include/linux/platform_data/x86/apple.h b/include/linux/platform_data/x86/apple.h
index 079e816c3c21..1fd0af6ffea9 100644
--- a/include/linux/platform_data/x86/apple.h
+++ b/include/linux/platform_data/x86/apple.h
@@ -1,13 +1 @@
-#ifndef PLATFORM_DATA_X86_APPLE_H
-#define PLATFORM_DATA_X86_APPLE_H
-
-#ifdef CONFIG_X86
-/**
- * x86_apple_machine - whether the machine is an x86 Apple Macintosh
- */
-extern bool x86_apple_machine;
-#else
-#define x86_apple_machine false
-#endif
-
-#endif
+#include <linux/platform_data/x86/machine.h>
diff --git a/include/linux/platform_data/x86/machine.h b/include/linux/platform_data/x86/machine.h
new file mode 100644
index 000000000000..b1e7a560a046
--- /dev/null
+++ b/include/linux/platform_data/x86/machine.h
@@ -0,0 +1,15 @@
+#ifndef PLATFORM_DATA_X86_MACHINE_H
+#define PLATFORM_DATA_X86_MACHINE_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_X86
+/**
+ * x86_apple_machine - whether the machine is an x86 Apple Macintosh
+ */
+extern bool x86_apple_machine;
+#else
+#define x86_apple_machine			false
+#endif
+
+#endif	/* PLATFORM_DATA_X86_MACHINE_H */
-- 
2.24.1

