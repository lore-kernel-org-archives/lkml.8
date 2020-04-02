Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267EAC2BA18
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F070120719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQMfb0xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgDBUqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:46:53 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45524 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388239AbgDBUqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:46:49 -0400
Received: by mail-pg1-f201.google.com with SMTP id v29so4034397pgo.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u9tYGbzZUoeKacfHKj+okUgzHoM8x17MGKsRKBVzF6I=;
        b=uQMfb0xxAIExjb63NAfWbxNzX58IUh4kx7YoqwNgrBWsfj/lhHMrIdkYIx2al0nsxy
         UfqRTHYpcFcUV6WBrfwFPIEe+gJwjPlDCB3FPhqVw72U09ICHXpJxPv5jaaTW1L2PpKI
         X0G1XL7JYM+UcxPWcjBFn/2eVGMHfwjdjTCjip/S1RIaycD23/Gax6iURzYDzAgLWPzk
         saCWrOIIbKhsXSlG1gus8JbBGskce9oOFzvRPtS6bVs7vSd+LVY9Mszb5Y7jVfkRpMGj
         b0H1AyBceSSYEILo57evwEUZ011Z/GKyREZAbPrWgrldD31hVWpN560HYE1wCITA6FvP
         wv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u9tYGbzZUoeKacfHKj+okUgzHoM8x17MGKsRKBVzF6I=;
        b=dejj+o6IqI6P11lmDSBOS6SyTKCR3NCM0IVvIqW/s9o+1OvTgae2LxwcYBUQu1EPR0
         elg/jycofD91HNdbt38K1dCm0Y8Ud6pit81Rkz4Rga9+xy6Hpvi89boEJKBsEfYMvMhg
         XTju65r11xJwy5lShePqlkmUJUuoehPW1B4V7vmiqL51zBQqvGcPR4lqPruAlQw/zXHZ
         Z/Oc+dSkr/O4BjLcYPNlTTkQpJgJn+jBh9xOQXOvXC93aEQzzWbEgVues099xj2HdvNY
         AQ+reEyk0DArkwGVZV7ytU9eKYRiVUT6IG9vY/b/HcE4qTjzQM+G+uHIm8VAvZzpRye+
         CLyQ==
X-Gm-Message-State: AGi0PuZ07oPRL0ABObdSMFFL91/W1kvZl9M4dBZew4GycoTBzGFevfdd
        ZM2JB2Qql3R1y1nOGYZhXwgbgGxS6Dgkhu5mxBE=
X-Google-Smtp-Source: APiQypLt8J4TrsEIIQmwcI8PNHLIDMU2NUDRIAyuTZFgrBUPPoV3kJF3jVa/J06xQbLRVn+3EFvxF8aGXrT1NlncZ0Y=
X-Received: by 2002:a17:90a:2663:: with SMTP id l90mr5314572pje.188.1585860408019;
 Thu, 02 Apr 2020 13:46:48 -0700 (PDT)
Date:   Thu,  2 Apr 2020 13:46:37 -0700
In-Reply-To: <20200402204639.161637-1-trishalfonso@google.com>
Message-Id: <20200402204639.161637-3-trishalfonso@google.com>
Mime-Version: 1.0
References: <20200402204639.161637-1-trishalfonso@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v4 4/4] KASAN: Testing Documentation
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
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
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
2.26.0.292.g33ef6b2f38-goog

