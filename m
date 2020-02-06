Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB6C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC4F20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fS6WBSvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgBFPv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:51:56 -0500
Received: from mail-wm1-f74.google.com ([209.85.128.74]:33787 "EHLO
        mail-wm1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBFPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:51:55 -0500
Received: by mail-wm1-f74.google.com with SMTP id l11so629791wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJMzj3shZa2WtTpFPhLyRyZzYBIlQLsl5gnyIHG8III=;
        b=fS6WBSvHWKHwTXDCVAu4fKASHYayWHCksUseKksJqEPSb5186BEYznh/NpvlIsHwx5
         2tCtRb8i3L6HjO3y8at3R8fkeXFBmYOXM+sMlCflzIhaOIwb6a/QUUj29/8X+jQTKSSc
         yYCjT1dTI8Sv6NbSM4s+9rMDTONHvSmbhgJwDFvBZpU1TfXwPI62foH8Pn/AJk4kBOkY
         Mrgz3tx3CJzj5gA7536avTYbm1GdCphSvyKtFjiozUUV1Xu46i5FLstPijFkqhKaSx6+
         4k9vvncK9m1CJ/VE67X3jY7sDI9tmf10wEgjNI8ydrCfHAMaSkddTQKE98ZdAI963aR1
         N5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJMzj3shZa2WtTpFPhLyRyZzYBIlQLsl5gnyIHG8III=;
        b=NvObmTTw3VvDnW7iTVtNbx2RC/d0SLLq9g+xw24LPxUE2m+ebyPcvpo+BRBOkF41Wt
         dGd+10mDxr7mkzrhonYE1tNk0PsM4UWyd5Ir9woTqN6SLZsuva9VCO8tQCIOzAgDsiEs
         NhPoiY/Y3nJ2oGKxksoq1vLfsAuNhz4yI8i34py2gVwH6f7gmnLJnoTtUOPfUYJopfVB
         6LtMmEM49cM2jKBhiLD8lW6jIFla+boKbEx4hHJ8P6jdXFIaI2jme0PG2GbQorFS+QoX
         dzfTL7/dbcOgWLKVwxW2Ypj4XfBrUJ1NOV/Nh4SoVMSV1I3T4eTBg1imnvrREQlDLITN
         aCog==
X-Gm-Message-State: APjAAAVCaHV/tOKPkAb4GQO/nrFQM3Qh4vicU7apuIM/a9aens00rd+d
        UyIjwESh/wrYSFAY6a/Z/m4cJA77LA==
X-Google-Smtp-Source: APXvYqwooqaGqTrAUnqlOjW1UzTY9jSbItVxwgGd6O8cWAgC6MRW/FckXf7Zffr7dksz8R8I284lctmBVQ==
X-Received: by 2002:a5d:4692:: with SMTP id u18mr4511821wrq.206.1581004313452;
 Thu, 06 Feb 2020 07:51:53 -0800 (PST)
Date:   Thu,  6 Feb 2020 16:46:26 +0100
In-Reply-To: <20200206154626.243230-1-elver@google.com>
Message-Id: <20200206154626.243230-3-elver@google.com>
Mime-Version: 1.0
References: <20200206154626.243230-1-elver@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2 3/3] kcsan: Add test to generate conflicts via debugfs
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add 'test=<iters>' option to KCSAN's debugfs interface to invoke KCSAN
checks on a dummy variable. By writing 'test=<iters>' to the debugfs
file from multiple tasks, we can generate real conflicts, and trigger
data race reports.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/debugfs.c | 51 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 5 deletions(-)

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index a9dad44130e62..9bbba0e57c9b3 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -6,6 +6,7 @@
 #include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
+#include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
@@ -69,9 +70,9 @@ void kcsan_counter_dec(enum kcsan_counter_id id)
 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
  * multiple threads, pipe 'microbench=<iters>' from multiple tasks into the
- * debugfs file.
+ * debugfs file. This will not generate any conflicts, and tests fast-path only.
  */
-static void microbenchmark(unsigned long iters)
+static noinline void microbenchmark(unsigned long iters)
 {
 	cycles_t cycles;
 
@@ -81,18 +82,52 @@ static void microbenchmark(unsigned long iters)
 	while (iters--) {
 		/*
 		 * We can run this benchmark from multiple tasks; this address
-		 * calculation increases likelyhood of some accesses overlapping
-		 * (they still won't conflict because all are reads).
+		 * calculation increases likelyhood of some accesses
+		 * overlapping. Make the access type an atomic read, to never
+		 * set up watchpoints and test the fast-path only.
 		 */
 		unsigned long addr =
 			iters % (CONFIG_KCSAN_NUM_WATCHPOINTS * PAGE_SIZE);
-		__kcsan_check_read((void *)addr, sizeof(long));
+		__kcsan_check_access((void *)addr, sizeof(long), KCSAN_ACCESS_ATOMIC);
 	}
 	cycles = get_cycles() - cycles;
 
 	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
 }
 
+/*
+ * Simple test to create conflicting accesses. Write 'test=<iters>' to KCSAN's
+ * debugfs file from multiple tasks to generate real conflicts and show reports.
+ */
+static long test_dummy;
+static noinline void test_thread(unsigned long iters)
+{
+	const struct kcsan_ctx ctx_save = current->kcsan_ctx;
+	cycles_t cycles;
+
+	/* We may have been called from an atomic region; reset context. */
+	memset(&current->kcsan_ctx, 0, sizeof(current->kcsan_ctx));
+
+	pr_info("KCSAN: %s begin | iters: %lu\n", __func__, iters);
+
+	cycles = get_cycles();
+	while (iters--) {
+		__kcsan_check_read(&test_dummy, sizeof(test_dummy));
+		__kcsan_check_write(&test_dummy, sizeof(test_dummy));
+		ASSERT_EXCLUSIVE_WRITER(test_dummy);
+		ASSERT_EXCLUSIVE_ACCESS(test_dummy);
+
+		/* not actually instrumented */
+		WRITE_ONCE(test_dummy, iters);  /* to observe value-change */
+	}
+	cycles = get_cycles() - cycles;
+
+	pr_info("KCSAN: %s end   | cycles: %llu\n", __func__, cycles);
+
+	/* restore context */
+	current->kcsan_ctx = ctx_save;
+}
+
 static int cmp_filterlist_addrs(const void *rhs, const void *lhs)
 {
 	const unsigned long a = *(const unsigned long *)rhs;
@@ -242,6 +277,12 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 		if (kstrtoul(&arg[sizeof("microbench=") - 1], 0, &iters))
 			return -EINVAL;
 		microbenchmark(iters);
+	} else if (!strncmp(arg, "test=", sizeof("test=") - 1)) {
+		unsigned long iters;
+
+		if (kstrtoul(&arg[sizeof("test=") - 1], 0, &iters))
+			return -EINVAL;
+		test_thread(iters);
 	} else if (!strcmp(arg, "whitelist")) {
 		set_report_filterlist_whitelist(true);
 	} else if (!strcmp(arg, "blacklist")) {
-- 
2.25.0.341.g760bfbb309-goog

