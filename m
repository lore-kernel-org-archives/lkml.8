Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B965BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C15A206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 22:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hO3S5wOH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728638AbgFBWh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 18:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgFBWhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 18:37:55 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10738C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 15:37:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id gl26so31886ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 15:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dTOg4iJPaO2+hu4VFAwyDGx+WJrKRTck4vVqHhEIgsM=;
        b=hO3S5wOHJBuq6I3LgVkwqelfWWVmlr6PakD5qGGxkNOpkBBhdY7qRBVo+iVVs0FhAS
         8Re9L/ykP2mpMcMFtCjoPrBLFuzCt3O1rxc/aFpPPpZVbkQE3F/z9crIYZoWLlUhb32h
         KcovkBYsra1p7r+ZYEnww9oLMAigO8aGXNzDEdLRfUKOl+4X9kkejvYgQ4eHXMU6VsdK
         ITfKz6Ses+mPwf3DyKTD4/WJQjmv7WmIQD+EzUhzci/oh6YDQyjwst1KJ48CJeyRrIhK
         4059mGxB2k1nCDnSmHzXV9sz1cLM8VhYQxwpNrG4728jJLHLPfLvuhpKR0/stxR3ngEJ
         7tIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dTOg4iJPaO2+hu4VFAwyDGx+WJrKRTck4vVqHhEIgsM=;
        b=hJ9SlQ/KicdHYuBfez1aUR+n5FXsBNTdvDOaWBmkuhqkd66Dn4EkYbZM/e6gWAJTtU
         IyVgMyZ/ydW6Iln9i1k+/C3Mnnt/KHNjio4eWN+BF3DgCsfccyN3wRZtF9WJ5nQajtjq
         AsxBOcR7u1MiyF1MwcXMmCkeqRlKPNXPYO9fcMRIO/VfB0YFb1f5xtYvfbOjwjwJZMow
         AumFLOaVjR4+ZZAh6BkbmY5z03GSAuOGWt+KinQmMy7D2Om1KEgLs2zBznKydztJxkoa
         oluSufYt4k40xoXet4+NVyxd3onJZWV4RW0b79ezGAq1RI4qHcVIPEjH+l9WG11ADaNZ
         VFsA==
X-Gm-Message-State: AOAM533LliufjWGHTmeIDrMt//2BFESF3rqxeRCfV5Qp/s1q+Y84H8NJ
        Aaybtvbvhg4Gqov65ez+TAbnW8aP
X-Google-Smtp-Source: ABdhPJzq8eovDiFfA3QUkEFbv5ch+q9p9jsJ+rldlIUAsJv+PgFLaNRmzEkCbQ6+82ZmTFX0g3EqJQ==
X-Received: by 2002:a17:906:7f05:: with SMTP id d5mr16422695ejr.70.1591137473738;
        Tue, 02 Jun 2020 15:37:53 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id d3sm107059eje.7.2020.06.02.15.37.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 15:37:53 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2] lib: test get_count_order/long in test_bitops.c
Date:   Tue,  2 Jun 2020 22:37:28 +0000
Message-Id: <20200602223728.32722-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some test for get_count_order/long in test_bitops.c.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

---
v2: merge the test into test_bitops.c
---
 lib/Kconfig.debug | 10 +++++-----
 lib/test_bitops.c | 40 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index f80d5609798f..512111a72e34 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1987,15 +1987,15 @@ config TEST_LKM
 	  If unsure, say N.
 
 config TEST_BITOPS
-	tristate "Test module for compilation of clear_bit/set_bit operations"
+	tristate "Test module for compilation of bitops operations"
 	depends on m
 	help
 	  This builds the "test_bitops" module that is much like the
 	  TEST_LKM module except that it does a basic exercise of the
-	  clear_bit and set_bit macros to make sure there are no compiler
-	  warnings from C=1 sparse checker or -Wextra compilations. It has
-	  no dependencies and doesn't run or load unless explicitly requested
-	  by name.  for example: modprobe test_bitops.
+	  set/clear_bit macros and get_count_order/long to make sure there are
+	  no compiler warnings from C=1 sparse checker or -Wextra
+	  compilations. It has no dependencies and doesn't run or load unless
+	  explicitly requested by name.  for example: modprobe test_bitops.
 
 	  If unsure, say N.
 
diff --git a/lib/test_bitops.c b/lib/test_bitops.c
index fd50b3ae4a14..702d5973a5b6 100644
--- a/lib/test_bitops.c
+++ b/lib/test_bitops.c
@@ -9,7 +9,11 @@
 #include <linux/module.h>
 #include <linux/printk.h>
 
-/* a tiny module only meant to test set/clear_bit */
+/* a tiny module only meant to test
+ *
+ *   set/clear_bit
+ *   get_count_order/long
+ */
 
 /* use an enum because thats the most common BITMAP usage */
 enum bitops_fun {
@@ -24,6 +28,26 @@ enum bitops_fun {
 
 static DECLARE_BITMAP(g_bitmap, BITOPS_LENGTH);
 
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
 static int __init test_bitops_startup(void)
 {
 	pr_warn("Loaded test module\n");
@@ -32,6 +56,18 @@ static int __init test_bitops_startup(void)
 	set_bit(BITOPS_11, g_bitmap);
 	set_bit(BITOPS_31, g_bitmap);
 	set_bit(BITOPS_88, g_bitmap);
+
+	for (i = 0; i < ARRAY_SIZE(order_comb); i++) {
+		if (order_comb[i][1] != get_count_order(order_comb[i][0]))
+			pr_warn("get_count_order wrong for %x\n",
+				       order_comb[i][0]); }
+
+	for (i = 0; i < ARRAY_SIZE(order_comb_long); i++) {
+		if (order_comb_long[i][1] !=
+			       get_count_order_long(order_comb_long[i][0]))
+			pr_warn("get_count_order_long wrong for %lx\n",
+				       order_comb_long[i][0]); }
+
 	return 0;
 }
 
@@ -55,6 +91,6 @@ static void __exit test_bitops_unstartup(void)
 module_init(test_bitops_startup);
 module_exit(test_bitops_unstartup);
 
-MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>");
+MODULE_AUTHOR("Jesse Brandeburg <jesse.brandeburg@intel.com>, Wei Yang <richard.weiyang@gmail.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Bit testing module");
-- 
2.23.0

