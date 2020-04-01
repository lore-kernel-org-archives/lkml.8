Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9269FC2BA12
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA6A2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HYgbJZF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732854AbgDASJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:09:20 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:54902 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732774AbgDASJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:09:16 -0400
Received: by mail-pf1-f201.google.com with SMTP id t19so302524pfq.21
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sl7H9I59bpRm4U1wnt7pV7FscJTzqhyyGtH4qFo0cnw=;
        b=HYgbJZF8sm1qparMe06AkzEc7qaGGH00lW1rsjBbEkAm8hVh0ErgODtVtBimJrCQKr
         izVCXd27uTvHIiFZcFSolrMk4j9kkkXLAkNIqviK3a9zFOA3obVvQ3//vZSkn5bf4Sc/
         IZmLwScnjwG3ATFT8gU4QZkTkia9hI/c7d+sB1ymo2ZfaiKL6rMoDlC82gdfSATD3X4N
         hcUJltIV1nueLJlGLp6Qm5hGbkI9juzDoI+eSZ7ov5wN/vIsrL7HtZ1DRlx+Rv85RTND
         URHjv7vebuTNo+8QvzCBRYKrDS6G1ve3h4D85/g4u/eY/kmhnWD68UVA7FfPFkjL1cE9
         /W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sl7H9I59bpRm4U1wnt7pV7FscJTzqhyyGtH4qFo0cnw=;
        b=dXpUhcyIPP3IxW9o0trGy8Y9L5tiId9K5dEOj8g4SANwd46qrmYytwixowdERjX7W8
         z0czxJ0TqNNHg8mjEzTtqdqYQrSUaQK/HfHkNNYCJSnIgISR6Y1FogDF9aM6Vpmw/8t+
         3yjKDiwy42rMpADOkzpnfCwTyMN7ww47vD0CtUgY0YW5jGI3m/+CptLkI1HWI2A4cSVI
         cJlEz8xCO9hsNhUCvCk7m8spZFVfXBKIRzDn15xuKyFSGKZ/x9UQzqLYds+5+S/Zw3Dv
         gemV+N2ZgCCEjeH/Rsc9lYLSzfsX0LHFOlAZHlMZ1T5MxpjfxlZ3ke29o0NIz5XsbCLA
         kFdQ==
X-Gm-Message-State: AGi0PubxWzX6TnZFeqe3HXqBSyxlg27XFpRA69NXbFLIsXuEUNp7hmV/
        i7jxua8JCo0Out5Q3D1xTF6EeLWa+jv66k4MIIw=
X-Google-Smtp-Source: APiQypLF1qWNJXD1fT9nzFedbjzAuhNuOmVK3uF6dZCjbiYe/bcZ6RjhyP2JoayHnVPnI8FMUp4QiYMmTB/RaKvdioc=
X-Received: by 2002:a17:90b:3610:: with SMTP id ml16mr6405214pjb.106.1585764555886;
 Wed, 01 Apr 2020 11:09:15 -0700 (PDT)
Date:   Wed,  1 Apr 2020 11:09:05 -0700
In-Reply-To: <20200401180907.202604-1-trishalfonso@google.com>
Message-Id: <20200401180907.202604-3-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200401180907.202604-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v3 4/4] KASAN: Testing Documentation
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
CONFIG_TEST_KASAN_USER.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..287ba063d9f6 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
 
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
+
+CONFIG_TEST_KASAN & CONFIG_TEST_KASAN_USER
+-------------------------------------------
+
+``CONFIG_TEST_KASAN`` utilizes the KUnit Test Framework for testing.
+This means each test focuses on a small unit of functionality and
+there are a few ways these tests can be run.
+
+Each test will print the KASAN report if an error is detected and then
+print the number of the test and the status of the test:
+
+pass::
+
+        ok 28 - kmalloc_double_kzfree
+or, if kmalloc failed::
+
+        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
+        Expected ptr is not null, but is
+        not ok 4 - kmalloc_large_oob_right
+or, if a KASAN report was expected, but not found::
+
+        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
+        Expected kasan_data->report_expected == kasan_data->report_found, but
+        kasan_data->report_expected == 1
+        kasan_data->report_found == 0
+        not ok 28 - kmalloc_double_kzfree
+
+All test statuses are tracked as they run and an overall status will
+be printed at the end::
+
+        ok 1 - kasan_kunit_test
+
+or::
+
+        not ok 1 - kasan_kunit_test
+
+(1) Loadable Module
+~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe.
+
+(2) Built-In
+~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built-in
+on any architecure that supports KASAN. These and any other KUnit
+tests enabled will run and print the results at boot as a late-init
+call.
+
+(3) Using kunit_tool
+~~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN`` built-in, we can also
+use kunit_tool to see the results of these along with other KUnit
+tests in a more readable way. This will not print the KASAN reports
+of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
+information on kunit_tool.
+
+.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+
+``CONFIG_TEST_KASAN_USER`` is a set of KASAN tests that could not be
+converted to KUnit. These tests can be run only as a module with
+``CONFIG_TEST_KASAN_USER`` built as a loadable module and
+``CONFIG_KASAN`` built-in. The type of error expected and the
+function being run is printed before the expression expected to give
+an error. Then the error is printed, if found, and that test
+should be interpretted to pass only if the error was the one expected
+by the test.
-- 
2.26.0.rc2.310.g2932bb562d-goog

