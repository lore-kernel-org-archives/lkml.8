Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B55BC433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB57E2070A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="DNopG01W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGRAub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbgGRAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:50:30 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0F5C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:50:30 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h18so5045043qvl.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ropALfHo2IvR5T23vKKGhsuUheVbO2NjXVQ5Zr9SRlU=;
        b=DNopG01WNl07mIZ+CvyOYvXSwX6B5gomk7j5uvYELm20sKi8Svy3hdKCSl+Vpm0Uom
         QYpu9kdBfFL9JpMddqyjBWeRjqm1GBAExwWrBQJnjwnov+oML1QwUfLx28P7OqmnbpF0
         vSZJ4QHTDqFHCJZV31fhHPcwzNJLc9UTlyWFZ2orEpVgp+h/6oPDeIUjrbg9ldeucZwb
         EDY/fr7UXbukdksP59SF4Phzqc0lIRjfw9RQ2NpIJYLuH3XAxXbnkRk1BYqF09HiM2oW
         A9hn3NeLOQN0o8Crwb1ehHgQzdwcGQxhE+/uuwVUWzG2rbRwZIptEbCQv0nPZKTy6RO2
         i8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ropALfHo2IvR5T23vKKGhsuUheVbO2NjXVQ5Zr9SRlU=;
        b=CZCdV7Tg6ETbAyeMfm1l/2+sCsHnLTgw88+JXB7QVQpLQdXR7o8BxxZK4WGGHJClg9
         I9uO88ziZKoMXMTLo2Ow34rVHsVMbdig9eM4ulMpGm3rx9QXUZZNcG8C2P28DNdw6GLn
         st0Th5gjuGkGn0oIs09B7YpxAa2Vf3gBuBIlJTgIpm05pXAycyiAcUTaeuPNcmrRLXYE
         QAwfrNCjQLlhs8XWq5EwYlQxx0HWCGaTh5vbOyosIdu9OeNuvx7+2yowaOQvGNVE4/gC
         acbxFjZddhDpQBSOMe3vPp/Zxl6Xb6+3OM6mDB2boSpAWUa84nn9lbADAI3CEhb0vdIm
         ag4w==
X-Gm-Message-State: AOAM5329hZfz874vXUo1KCGUkcQVNpEhub10ys8hJuYKuICrdUfPEnso
        MUiwzS7+YTcHV9fdpIsJ/3NJCw==
X-Google-Smtp-Source: ABdhPJx5XDgTw11dxiZmyPzYo9WK/A9Pl4KUZEYxlSuz2+9IjL5NjwcrfpBRTD6O2zO9SFrxTpPSuQ==
X-Received: by 2002:a05:6214:289:: with SMTP id l9mr11698857qvv.238.1595033429865;
        Fri, 17 Jul 2020 17:50:29 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id q65sm4003557qkf.50.2020.07.17.17.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 17:50:29 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] lib: kunit: Provides a userspace memory context when tests are compiled as module
Date:   Fri, 17 Jul 2020 21:50:25 -0300
Message-Id: <20200718005025.440320-1-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUnit test cases run on kthreads, and kthreads don't have an
adddress space (current->mm is NULL), but processes have mm.

The purpose of this patch is to allow to borrow mm to KUnit kthread
after userspace is brought up, because we know that there are processes
running, at least the process that loaded the module to borrow mm.

This allows, for example, tests such as user_copy_kunit, which uses
vm_mmap, which needs current->mm.

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
v2:
    * splitted patch in 3:
        - Allows to install and load modules in root filesystem;
        - Provides an userspace memory context when tests are compiled
          as module;
        - Convert test_user_copy to KUnit test;
    * added documentation;
    * added more explanation;
    * tested a pointer;
    * released mput();
---
 Documentation/dev-tools/kunit/usage.rst | 14 ++++++++++++++
 include/kunit/test.h                    | 12 ++++++++++++
 lib/kunit/try-catch.c                   | 15 ++++++++++++++-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 3c3fe8b5fecc..9f909157be34 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -448,6 +448,20 @@ We can now use it to test ``struct eeprom_buffer``:
 
 .. _kunit-on-non-uml:
 
+User-space context
+------------------
+
+I case you need a user-space context, for now this is only possible through
+tests compiled as a module. And it will be necessary to use a root filesystem
+and uml_utilities.
+
+Example:
+
+.. code-block:: bash
+
+   ./tools/testing/kunit/kunit.py run --timeout=60 --uml_rootfs_dir=.uml_rootfs
+
+
 KUnit on non-UML architectures
 ==============================
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..ae3337139c65 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -222,6 +222,18 @@ struct kunit {
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+	/*
+	 * KUnit test cases run on kthreads, and kthreads don't have an
+	 * adddress space (current->mm is NULL), but processes have mm.
+	 *
+	 * The purpose of this mm_struct is to allow to borrow mm to KUnit kthread
+	 * after userspace is brought up, because we know that there are processes
+	 * running, at least the process that loaded the module to borrow mm.
+	 * 
+	 * This allows, for example, tests such as user_copy_kunit, which uses
+	 * vm_mmap, which needs current->mm.
+	 */
+	struct mm_struct *mm;
 };
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 0dd434e40487..d03e2093985b 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,7 +11,8 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include "try-catch-impl.h"
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
@@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
 	struct kunit_try_catch *try_catch = data;
+	struct kunit *test = try_catch->test;
+	
+	if (test != NULL && test->mm != NULL)
+		kthread_use_mm(test->mm);
 
 	try_catch->try(try_catch->context);
+	if (test != NULL && test->mm != NULL) {
+		kthread_unuse_mm(test->mm);
+		mmput(test->mm);
+		test->mm = NULL;
+	}
 
 	complete_and_exit(try_catch->try_completion, 0);
 }
@@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	try_catch->context = context;
 	try_catch->try_completion = &try_completion;
 	try_catch->try_result = 0;
+
+	test->mm = get_task_mm(current);
+
 	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
 				  try_catch,
 				  "kunit_try_catch_thread");

base-commit: 725aca9585956676687c4cb803e88f770b0df2b2
prerequisite-patch-id: 5e5f9a8a05c5680fda1b04c9ab1b95ce91dc88b2
prerequisite-patch-id: 4d997940f4a9f303424af9bac412de1af861f9d9
prerequisite-patch-id: 582b6d9d28ce4b71628890ec832df6522ca68de0
-- 
2.26.2

