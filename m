Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4405C35249
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7CA24682
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9Rb2a9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgA1HUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:20:33 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42317 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgA1HUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:20:31 -0500
Received: by mail-pf1-f201.google.com with SMTP id i20so8094139pfo.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ef0MAJ1wuFu9y6HizHmc+/vFBSY+7F2zQHC6+1+Hv1k=;
        b=Z9Rb2a9OQQHmevk8nrBhA6nMqohaXS+cG6wGimkIIX5tHmd4Pla36/oP2X+CBhBu+I
         MZIwM4ZWPLsGyRKF+THFYAWYcrFw4AOPprobTmns1Y4xUpQZDFGHWhylzEMDgvhPIWTw
         s0rhejVCZb6PwJGu/hcxbA6wWyRhioPtQqiA6KNwkqRiDwHD9IWqpxxO3p77HSNL6oSz
         PZ5RN2GLx7NCetNZWXyjyLHYApiADsuou7UdhE0NpbtXfdxNLo4Lf1wa8CGK6BYNTdbF
         n1fGAt/9obdNBLBZ/c8m0DnIeUsAhvgCBZr/Obx1G05HyHiH1ApxH0jtUzg/SLSE/jav
         PYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ef0MAJ1wuFu9y6HizHmc+/vFBSY+7F2zQHC6+1+Hv1k=;
        b=fyzBJe1q9MGEmPXWotqqdgpuufqtV/OKylir533tVNvwrLEg7imtnMV4eyqNqlE+YY
         dRCtyEckwtIvD/vkig/rmoQuuYwGHYESbsYdZOmQc5qrhH2urCTAgE9+IVxWlr+ygE4U
         NG9VG+8gycKDgZpYAcmafVAyd126NMJxgGGS5lpyQcS78amPAFssNAyaWRpHkJ66ffek
         HgpU/viayzQ7tN0aBcwacplcALo+1Oy3QQe0KX+ITbUVTavJTuu7kZGzrwTpZjrkYKDs
         43eLo90Dfp2TZStEPaR7naQ5Dkt1o6p4rcnVBLkhhqxfqVrbLgKGaReXu/B1ydQOoAY1
         IHeg==
X-Gm-Message-State: APjAAAXcDFbrT6XV5dA3P+hNJukobE4vFH+OG64TugPLvvTLP8zB3tif
        IVe4YxNxB0M69aXuObmsdGfxhU9XmG4llTmfJKMuGA==
X-Google-Smtp-Source: APXvYqy+iukg1YFtkL0zEsGFAFKLSUcupLf+r9TZ5GGj6CTFqS5Dypdm73H+Nj4kyXHdRRRLEEtoMmp3GQtENLhfPkCjiQ==
X-Received: by 2002:a63:4d4c:: with SMTP id n12mr24215375pgl.212.1580196030652;
 Mon, 27 Jan 2020 23:20:30 -0800 (PST)
Date:   Mon, 27 Jan 2020 23:20:01 -0800
In-Reply-To: <20200128072002.79250-1-brendanhiggins@google.com>
Message-Id: <20200128072002.79250-7-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200128072002.79250-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v1 6/7] kunit: Add 'kunit_shutdown' option
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, knut.omang@oracle.com,
        linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Gow <davidgow@google.com>

Add a new kernel command-line option, 'kunit_shutdown', which allows the
user to specify that the kernel poweroff, halt, or reboot after
completing all KUnit tests; this is very handy for running KUnit tests
on UML or a VM so that the UML/VM process exits cleanly immediately
after running all tests without needing a special initramfs.

Signed-off-by: David Gow <davidgow@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 lib/kunit/executor.c                | 20 ++++++++++++++++++++
 tools/testing/kunit/kunit_kernel.py |  2 +-
 tools/testing/kunit/kunit_parser.py |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 7fd16feff157e..d3ec1265a72fd 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <kunit/test.h>
+#include <linux/reboot.h>
 
 /*
  * These symbols point to the .kunit_test_suites section and are defined in
@@ -11,6 +12,23 @@ extern struct kunit_suite * const * const __kunit_suites_end[];
 
 #if IS_BUILTIN(CONFIG_KUNIT)
 
+static char *kunit_shutdown;
+core_param(kunit_shutdown, kunit_shutdown, charp, 0644);
+
+static void kunit_handle_shutdown(void)
+{
+	if (!kunit_shutdown)
+		return;
+
+	if (!strcmp(kunit_shutdown, "poweroff")) {
+		kernel_power_off();
+	} else if (!strcmp(kunit_shutdown, "halt")) {
+		kernel_halt();
+	} else if (!strcmp(kunit_shutdown, "reboot")) {
+		kernel_restart(NULL);
+	}
+}
+
 static void kunit_print_tap_header(void)
 {
 	struct kunit_suite * const * const *suites, * const *subsuite;
@@ -42,6 +60,8 @@ int kunit_run_all_tests(void)
 		}
 	}
 
+	kunit_handle_shutdown();
+
 	if (has_test_failed)
 		return -EFAULT;
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index cc5d844ecca13..43314aa537d30 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -141,7 +141,7 @@ class LinuxSourceTree(object):
 		return True
 
 	def run_kernel(self, args=[], timeout=None, build_dir=''):
-		args.extend(['mem=256M'])
+		args.extend(['mem=256M', 'kunit_shutdown=halt'])
 		process = self._ops.linux_bin(args, timeout, build_dir)
 		with open(os.path.join(build_dir, 'test.log'), 'w') as f:
 			for line in process.stdout:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 78b3bdd03b1e4..633811dd9bce8 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -48,7 +48,7 @@ class TestStatus(Enum):
 	FAILURE_TO_PARSE_TESTS = auto()
 
 kunit_start_re = re.compile(r'^TAP version [0-9]+$')
-kunit_end_re = re.compile('List of all partitions:')
+kunit_end_re = re.compile(r'reboot: System halted')
 
 def isolate_kunit_output(kernel_output):
 	started = False
-- 
2.25.0.341.g760bfbb309-goog

