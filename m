Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9B9C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5F20774
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 06:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulwvVvdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDXGOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 02:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgDXGOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:14:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27E5C09B046
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:14:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e3so8973077ybq.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 23:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5epptiP6vyK9ksah1mqKRXgiRHBz5N7tvZFE7or+VcA=;
        b=ulwvVvdqEW+IJ4ZDJ8/ufTJ/zOyYKVP39a143BYyHnkike1p3jMupT4mYRbcDXGObR
         kt/ycV+2w4PE+xLdGnOd72QOFvCtb/zTp89MZBAKxwolAEK+nUufeHi1AZWm29hq6ZLE
         /JML3lImDzCGevk5SkhdI9IFNaCtuGfbobXCQdycrnVlghyg7LW9hskkiNHXoEiv4Q0x
         rmlxt8TuRi6I3Xvy2IO/59Thimn5irJyuGxgPvcAWQlnZx4fGRXe7BUbboXF7AhNN9A8
         foEVvkDb5g9p+3H2LXbAwJxzam5E5LlTyqgw7/J3v5JKu+oeY0LSoSUKznBIdMx96hNW
         //gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5epptiP6vyK9ksah1mqKRXgiRHBz5N7tvZFE7or+VcA=;
        b=WHByL7CR4XXYnxwFSc2Y9CLYgwCVEv0Gn7DPf4OmIuxfmoMorn1Inx9t6RLD1rt2q8
         IjfbcY7+5pWba/UwbmBM9/9LbAjpozbYi7EN2NpIwAdViV+TgAir1pda5AdWY9RfG/ux
         IvNnpOGUwzmQ/39a8E3t1VUkvkKu6Mi8MLbEOyF1g0v5FWUeBsFHs3ywLL0Cb/e25Tr7
         936n9wy/RDJ07x8dKS/aqp5a27aiBGN21EBr+T0kBJrM0q3IAep8eJQL/jrhdBUut167
         w/Ovr+rICk5q3e3F6NDpMSyVNWf0vyTwVeegOav/VKrKKqDFvsSD6NdTc+dm1/6m9tj5
         N5PA==
X-Gm-Message-State: AGi0PubQEzUEATjyX0fCxO/b6iXqDk2hN9ojSXlO2+rDv0LaqxK5P85O
        ztqZH/BEuYE2gHjSZRbh83ZnUILfEvGshA==
X-Google-Smtp-Source: APiQypJovP6+qI5o42bhNd8V9jsDjBcJywaFZ16qLB01QR5bZhAswW3ktdSN1KWfx+4lWLLGUYKhYpLKpM5S/w==
X-Received: by 2002:a25:bd4c:: with SMTP id p12mr13287597ybm.140.1587708844982;
 Thu, 23 Apr 2020 23:14:04 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:13:41 -0700
In-Reply-To: <20200424061342.212535-1-davidgow@google.com>
Message-Id: <20200424061342.212535-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200424061342.212535-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH v7 4/5] KASAN: Testing Documentation
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
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
2.26.2.303.gf8c07b1a785-goog

