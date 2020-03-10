Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E9EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3299822522
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCJWSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:18:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:2024 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgCJWSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:18:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:18:00 -0700
X-IronPort-AV: E=Sophos;i="5.70,538,1574150400"; 
   d="scan'208";a="277130850"
Received: from jbrandeb-desk.jf.intel.com ([10.166.244.152])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 15:17:59 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com,
        peterz@infradead.org
Subject: [PATCH v6 2/2] lib: make a test module with set/clear bit
Date:   Tue, 10 Mar 2020 15:17:47 -0700
Message-Id: <20200310221747.2848474-2-jesse.brandeburg@intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test some bit clears/sets to make sure assembly doesn't change, and
that the set_bit and clear_bit functions work and don't cause sparse
warnings.

Instruct Kbuild to build this file with extra warning level -Wextra,
to catch new issues, and also doesn't hurt to build with C=1.

This was used to test changes to arch/x86/include/asm/bitops.h.

In particular, sparse (C=1) was very concerned when the last bit
before a natural boundary, like 7, or 31, was being tested, as this
causes sign extension (0xffffff7f) for instance when clearing bit 7.

Recommended usage:
make defconfig
scripts/config -m CONFIG_TEST_BITOPS
make modules_prepare
make C=1 W=1 lib/test_bitops.ko
objdump -S -d lib/test_bitops.ko
insmod lib/test_bitops.ko
rmmod lib/test_bitops.ko
<check dmesg>, there should be no compiler/sparse warnings and no
error messages in log.

Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v5: no change
v4: Slight change to bitops_fun last member, as suggested by Andy, added
his reviewed-by too. Added module load/unload to usage. Added copyright.
v3: Update the test to fail if bits aren't cleared, and make the
test reproduce the original issue without patch 1/2, showing that
the issue is fixed in patch 1/2. Thanks PeterZ!
v2: Correct CC: list
---
 lib/Kconfig.debug                  | 13 +++++++
 lib/Makefile                       |  2 +
 lib/test_bitops.c                  | 60 ++++++++++++++++++++++++++++++
 tools/testing/selftests/lib/config |  1 +
 4 files changed, 76 insertions(+)
 create mode 100644 lib/test_bitops.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 69def4a9df00..61a5d00ea064 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1947,6 +1947,19 @@ config TEST_LKM
 
 	  If unsure, say N.
 
+config TEST_BITOPS
+	tristate "Test module for compilation of clear_bit/set_bit operations"
+	depends on m
+	help
+	  This builds the "test_bitops" module that is much like the
+	  TEST_LKM module except that it does a basic exercise of the
+	  clear_bit and set_bit macros to make sure there are no compiler
+	  warnings from C=1 sparse checker or -Wextra compilations. It has
+	  no dependencies and doesn't run or load unless explicitly requested
+	  by name.  for example: modprobe test_bitops.
+
+	  If unsure, say N.
+
 config TEST_VMALLOC
 	tristate "Test module for stress/performance analysis of vmalloc allocator"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 611872c06926..b18db565b355 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -89,6 +89,8 @@ obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
 obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
+obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
+CFLAGS_test_bitops.o += -Werror
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_bitops.c b/lib/test_bitops.c
new file mode 100644
index 000000000000..fd50b3ae4a14
--- /dev/null
+++ b/lib/test_bitops.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Intel Corporation
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+/* a tiny module only meant to test set/clear_bit */
+
+/* use an enum because thats the most common BITMAP usage */
+enum bitops_fun {
+	BITOPS_4 = 4,
+	BITOPS_7 = 7,
+	BITOPS_11 = 11,
+	BITOPS_31 = 31,
+	BITOPS_88 = 88,
+	BITOPS_LAST = 255,
+	BITOPS_LENGTH = 256
+};
+
+static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
+
+static int __init test_bitops_startup(void)
+{
+	pr_warn("Loaded test module\n");
+	set_bit(BITOPS_4, g_bitmap);
+	set_bit(BITOPS_7, g_bitmap);
+	set_bit(BITOPS_11, g_bitmap);
+	set_bit(BITOPS_31, g_bitmap);
+	set_bit(BITOPS_88, g_bitmap);
+	return 0;
+}
+
+static void __exit test_bitops_unstartup(void)
+{
+	int bit_set;
+
+	clear_bit(BITOPS_4, g_bitmap);
+	clear_bit(BITOPS_7, g_bitmap);
+	clear_bit(BITOPS_11, g_bitmap);
+	clear_bit(BITOPS_31, g_bitmap);
+	clear_bit(BITOPS_88, g_bitmap);
+
+	bit_set = find_first_bit(g_bitmap, BITOPS_LAST);
+	if (bit_set != BITOPS_LAST)
+		pr_err("ERROR: FOUND SET BIT %d\n", bit_set);
+
+	pr_warn("Unloaded test module\n");
+}
+
+module_init(test_bitops_startup);
+module_exit(test_bitops_unstartup);
+
+MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Bit testing module");
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index 14a77ea4a8da..b80ee3f6e265 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -2,3 +2,4 @@ CONFIG_TEST_PRINTF=m
 CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
+CONFIG_TEST_BITOPS=m
-- 
2.24.1

