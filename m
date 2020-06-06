Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CC7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9EC207DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 04:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeSUTQIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFFEEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 00:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFFEED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 00:04:03 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E8FC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 21:04:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k186so14062505ybc.19
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 21:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LRVbJ2IzntUJ3rFAogfVmsjnLs4DtIrCaWey4mp2L10=;
        b=SeSUTQIoS5KBxUNns3vhXOLxzCuHPitMl0Aw8ZqFbQxtsIZgPssjlMMQr6EhJg6or0
         5CYrWi61PMDIKkTSNqDGSDtpUo7fr71ykQhgZJya/77gBGAF4aEZM2/KBfXmIz8dBf5t
         0SbgOBzAN8G8jpjzEnC6lhPyCmTWXdfOOSbIsu9lBqeSlY5+Ipqvt8IQk/fhIJlpofGj
         h/3PpS0tHl4+QQpfkozW9Ud+wRnFLtmfl6xu5FYANVXHQP61TIKgKcvSsoqNtgVPi48O
         j4oXqSIPmjUmi7PboCDnYtDpxEBMx6tT/hoEVmFcFve9PZXby44sts3x9G8512DsVZcp
         6oBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LRVbJ2IzntUJ3rFAogfVmsjnLs4DtIrCaWey4mp2L10=;
        b=iY4IXWka87DDpfSORISPc/YuS3pl261B3ulFlDk+rlyc/wFtXt8+JwUj21OlopbhEw
         d+Gev1WJWSgcJS2ZooDDDzecn+se53OviAyTuZyvWCyRglXVLPfv5HjpvSRXUdq2dAfB
         6QrdusOSBnCPw+sJ4T6e1p30yu309sjvT9QuhcNyzkC+gPUR7MaPXjsLSpwfONMO8VEj
         tly6PYE0uL8PldzChgKkY1p+qClRmOOXNORgGRWSBCOYOE7+4e8ES/HRdV1mIddqOD7B
         /YgC0nXm7HjI099VvVxc4zHNvq+ixYcGt+kJ4478ZPEzGLhQaFATnCqCBiF4v14XB6He
         Zh6Q==
X-Gm-Message-State: AOAM530rbFiGwTGtsMmX8laM9hpBN9p4wMjfz9kPrIHYCbMhquIOzs75
        Cb6dL/uSaf/mmJqGujYTrOzFID+TjepPkA==
X-Google-Smtp-Source: ABdhPJzMRf6MxnJE7ZzaLIOPvUIqU9bM0F72J+tmpYHrGd1C9wffpnYL+0o+BdYK1pKGlwnPK9f4EyEHq0ocGQ==
X-Received: by 2002:a25:b5c2:: with SMTP id d2mr22710530ybg.9.1591416242137;
 Fri, 05 Jun 2020 21:04:02 -0700 (PDT)
Date:   Fri,  5 Jun 2020 21:03:48 -0700
In-Reply-To: <20200606040349.246780-1-davidgow@google.com>
Message-Id: <20200606040349.246780-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200606040349.246780-1-davidgow@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v8 4/5] KASAN: Testing Documentation
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, andreyknvl@google.com, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Include documentation on how to test KASAN using CONFIG_TEST_KASAN_KUNIT
and CONFIG_TEST_KASAN_MODULE.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..b4b109d88f9e 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
 
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
+
+CONFIG_TEST_KASAN_KUNIT & CONFIG_TEST_KASAN_MODULE
+--------------------------------------------------
+
+``CONFIG_TEST_KASAN_KUNIT`` utilizes the KUnit Test Framework for testing.
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
+With ``CONFIG_KUNIT`` enabled, ``CONFIG_TEST_KASAN_KUNIT`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe.
+
+(2) Built-In
+~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN_KUNIT`` can be built-in
+on any architecure that supports KASAN. These and any other KUnit
+tests enabled will run and print the results at boot as a late-init
+call.
+
+(3) Using kunit_tool
+~~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN_KUNIT`` built-in, we can also
+use kunit_tool to see the results of these along with other KUnit
+tests in a more readable way. This will not print the KASAN reports
+of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
+information on kunit_tool.
+
+.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+
+``CONFIG_TEST_KASAN_MODULE`` is a set of KASAN tests that could not be
+converted to KUnit. These tests can be run only as a module with
+``CONFIG_TEST_KASAN_MODULE`` built as a loadable module and
+``CONFIG_KASAN`` built-in. The type of error expected and the
+function being run is printed before the expression expected to give
+an error. Then the error is printed, if found, and that test
+should be interpretted to pass only if the error was the one expected
+by the test.
-- 
2.27.0.278.ge193c7cf3a9-goog

