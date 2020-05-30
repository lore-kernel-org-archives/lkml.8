Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0634CC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A4E2076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 00:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rK2wTZV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgE3AoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 20:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgE3AoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 20:44:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC888C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 17:44:10 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k8so3073808edq.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IVM+2iuYQX6ocMaE9S2ysvmWTQDm/L7TAb7CL71ga/Y=;
        b=rK2wTZV2IVOck/1x+EU1Bbo0tHbJ/xDluHD+3lLr98k9UxJAYOYvipDjpz8G1+TCkI
         5l8azXrMuGsob51dJPCUD/PMXHYXy5/2rnjfwjEdgS+Jz0GGkqO/ePfhgoVeIsYn43GG
         T9tJjjUg7xrFhtKVRLyr8HrQRIsv3SiCS5Bj3Zr52N4+Rzk3k7kmRLdyjZhAgzv/fbLn
         R7kW+9MG+sI1zm4aBeBGeh4Hc4v8o3qi2Qj9DJcbhVOmEouAFBQJpxTCFtYCcA71tgQI
         e9EuhvnOn4knf9BBuO5qblAeXQLkzZlK2cYy2y0HrWcQKzNVWYS0jG3Ifnr98FSZ/7cN
         F9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IVM+2iuYQX6ocMaE9S2ysvmWTQDm/L7TAb7CL71ga/Y=;
        b=A78PdSiUezqOhHpuUM4A6oTPC7eKHJ/7cQKiws7a0pBXgnPu4AnnUqos29uetjg4LC
         n3PMved5lLIEmQ1tEjLbdf9TiChEDImRZH+jeIEDiGBwnVgOsQOnc0oVOggsFxOGb+gk
         aF8MnF3+gPp8JiRxCj+D7+KpUFAFYDQQx57EYD1oCzmP/SIdOvJryEoXRXERMcu+iOyi
         8W6t7kwdQvPfvI7HB0Z+zY4pW6kuS+4exMuWlMEDjKB1oVIWNcELlw0zEl1fr04F+sNX
         lTpKZA/Oau/6IDeN3xTYlJnplFb3RD+natsprvLQKagjvTF5nMa27QCkuJg4/U4bgatG
         UUtQ==
X-Gm-Message-State: AOAM5310SOlQkzt0iq8FIYrUFBLUYz6nEuABVQH7SfYvNXYiCVtq5/NV
        m9cfG1SGpTKvVjstVubmNT0=
X-Google-Smtp-Source: ABdhPJwcxOcrmU+Sscqd08YgHt8BobQ6iOY+xwgp00VfX2G9hPKJSLLXh8a/ot1qdCT7uLW5qObMcg==
X-Received: by 2002:aa7:c143:: with SMTP id r3mr11210651edp.203.1590799449452;
        Fri, 29 May 2020 17:44:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e8sm8655662edk.42.2020.05.29.17.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 17:44:08 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] lib: make a test module with get_count_order/long
Date:   Sat, 30 May 2020 00:43:28 +0000
Message-Id: <20200530004328.30530-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test module to make sure get_count_order/long returns the correct result.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 lib/Kconfig.debug                  | 13 ++++++
 lib/Makefile                       |  2 +
 lib/test_getorder.c                | 64 ++++++++++++++++++++++++++++++
 tools/testing/selftests/lib/config |  1 +
 4 files changed, 80 insertions(+)
 create mode 100644 lib/test_getorder.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index c0ef216bb803..01e671151f42 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1999,6 +1999,19 @@ config TEST_BITOPS
 
 	  If unsure, say N.
 
+config TEST_GETORDER
+	tristate "Test module for compilation of get_count_order operations"
+	depends on m
+	help
+	  This builds the "test_getorder" module that is much like the
+	  TEST_LKM module except that it does a basic exercise of the
+	  get_count_order and get_count_order_long to make sure there are no
+	  compiler warnings from C=1 sparse checker or -Wextra compilations.
+	  It has no dependencies and doesn't run or load unless explicitly
+	  requested by name. For example: modprobe test_getorder.
+
+	  If unsure, say N.
+
 config TEST_VMALLOC
 	tristate "Test module for stress/performance analysis of vmalloc allocator"
 	default n
diff --git a/lib/Makefile b/lib/Makefile
index 0d942f7c7478..806d4df8f7c7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -81,6 +81,8 @@ obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_BITOPS) += test_bitops.o
 CFLAGS_test_bitops.o += -Werror
+obj-$(CONFIG_TEST_GETORDER) += test_getorder.o
+CFLAGS_test_getorder.o += -Werror
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 obj-$(CONFIG_TEST_STRSCPY) += test_strscpy.o
diff --git a/lib/test_getorder.c b/lib/test_getorder.c
new file mode 100644
index 000000000000..6492abc793af
--- /dev/null
+++ b/lib/test_getorder.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Author: Wei Yang <richard.weiyang@gmail.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/printk.h>
+
+/* a tiny module only meant to test get_count_order/long */
+unsigned int order_comb[][2] = {
+	{0x00000003,  2},
+	{0x00000004,  2},
+	{0x00001fff, 13},
+	{0x00002000, 13},
+	{0x50000000, 31},
+	{0x80000000, 31},
+	{0x80003000, 32},
+};
+
+unsigned long order_comb_long[][2] = {
+	{0x0000000300000000, 34},
+	{0x0000000400000000, 34},
+	{0x00001fff00000000, 45},
+	{0x0000200000000000, 45},
+	{0x5000000000000000, 63},
+	{0x8000000000000000, 63},
+	{0x8000300000000000, 64},
+};
+
+static int __init test_getorder_startup(void)
+{
+	int i;
+
+	pr_warn("Loaded test module\n");
+	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
+		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
+			pr_warn("get_count_order wrong for %x\n",
+					order_comb[i][0]);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
+		if (order_comb_long[i][1] !=
+				get_count_order_long(order_comb_long[i][0]))
+			pr_warn("get_count_order_long wrong for %lx\n",
+					order_comb_long[i][0]);
+	}
+
+	return 0;
+}
+
+static void __exit test_getorder_unstartup(void)
+{
+	pr_warn("Unloaded test module\n");
+}
+
+module_init(test_getorder_startup);
+module_exit(test_getorder_unstartup);
+
+MODULE_AUTHOR("Wei Yang <richard.weiyang@gmail.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("get_count_order/long testing module");
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..2ad467d34648 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -3,3 +3,4 @@ CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
+CONFIG_TEST_GETORDER=m
-- 
2.23.0

