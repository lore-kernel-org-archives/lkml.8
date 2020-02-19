Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40ECC5ACC4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673B124670
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fCODj54Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgBSWCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:02:35 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39515 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgBSWCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:02:35 -0500
Received: by mail-pj1-f66.google.com with SMTP id e9so646398pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=BHUkyaNS57rnl1EShz+sW2LkBqKJsXPNkmOK4nC4xww=;
        b=fCODj54QlcJdF3DJZuPzpkUj700XWSIAJNWjJl/LcjnyPKkaJA5/S3Q0KbbY4VoHoC
         nHsoPKQYB9952fMecgxmk9zKqZvKlzI0jv87DyzrpVJWpbfqjyZ23rOZq0WYDQ44HntB
         U16oAGxEDWodeVhpz3fu3B8Qq0poJhQ6sGwd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=BHUkyaNS57rnl1EShz+sW2LkBqKJsXPNkmOK4nC4xww=;
        b=ZlD52KMGN+FSUlvEbbAzrfcsKA2B9atWLj2QAof+qkl7E0aYzIXyF38ibpPdZDKRY8
         DSRmEt/db78tEPq7vmvfV1YZO90QHIq1aBW0u0CppcO8S4bxwMyRoJFkaRuRfGY+gO5P
         biy0MUAXJtPzO2WXQzyiATBB80GgM86Sr1tb2FuozRX6X8tOjbt4+3is8hgEAKaG6E43
         yQaLQmo0BrBCZP4WVlJHob5A5kFt0jzhzC0eOSgsISu6RYxk/a3A90oefS+5PSImqEcp
         nYYedSoza9cfE8sDWEKI0TvCDxpA4I8VSBiBYTO3h6EHW+gC51WkN2bMXRMxxuuinAdJ
         yYYg==
X-Gm-Message-State: APjAAAUjpeONxvMT2KZpETvy2nPPEVW+bppByRW1EPnEzAgg8MT3pQNo
        MODL28PpnnTlgbpkBSwFK1mMVA==
X-Google-Smtp-Source: APXvYqwEHKl2oIyKRvR+0eYt/6ZNRQXy1X0VLqCzXtIaaU5mAtwosvdduzl2Yh5va9z/mCTOooFxCQ==
X-Received: by 2002:a17:90a:8902:: with SMTP id u2mr11310547pjn.79.1582149754268;
        Wed, 19 Feb 2020 14:02:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l25sm660753pgt.85.2020.02.19.14.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 14:02:33 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:02:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] lib: test_stackinit.c: XFAIL switch variable init tests
Message-ID: <202002191358.2897A07C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tests for initializing a variable defined between a switch
statement's test and its first "case" statement are currently not
initialized in Clang[1] nor the proposed auto-initialization feature in
GCC.

We should retain the test (so that we can evaluate compiler fixes),
but mark it as an "expected fail". The rest of the kernel source will
be adjusted to avoid this corner case.

Also disable -Wswitch-unreachable for the test so that the intentionally
broken code won't trigger warnings for GCC (nor future Clang) when
initialization happens this unhandled place.

[1] https://bugs.llvm.org/show_bug.cgi?id=44916

Suggested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/Makefile         |  1 +
 lib/test_stackinit.c | 28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index 611872c06926..08c2b6d32900 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_TEST_KMOD) += test_kmod.o
 obj-$(CONFIG_TEST_DEBUG_VIRTUAL) += test_debug_virtual.o
 obj-$(CONFIG_TEST_MEMCAT_P) += test_memcat_p.o
 obj-$(CONFIG_TEST_OBJAGG) += test_objagg.o
+CFLAGS_test_stackinit.o += $(call cc-disable-warning, switch-unreachable)
 obj-$(CONFIG_TEST_STACKINIT) += test_stackinit.o
 obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
diff --git a/lib/test_stackinit.c b/lib/test_stackinit.c
index 2d7d257a430e..f93b1e145ada 100644
--- a/lib/test_stackinit.c
+++ b/lib/test_stackinit.c
@@ -92,8 +92,9 @@ static bool range_contains(char *haystack_start, size_t haystack_size,
  * @var_type: type to be tested for zeroing initialization
  * @which: is this a SCALAR, STRING, or STRUCT type?
  * @init_level: what kind of initialization is performed
+ * @xfail: is this test expected to fail?
  */
-#define DEFINE_TEST_DRIVER(name, var_type, which)		\
+#define DEFINE_TEST_DRIVER(name, var_type, which, xfail)	\
 /* Returns 0 on success, 1 on failure. */			\
 static noinline __init int test_ ## name (void)			\
 {								\
@@ -139,13 +140,14 @@ static noinline __init int test_ ## name (void)			\
 	for (sum = 0, i = 0; i < target_size; i++)		\
 		sum += (check_buf[i] == 0xFF);			\
 								\
-	if (sum == 0)						\
+	if (sum == 0) {						\
 		pr_info(#name " ok\n");				\
-	else							\
-		pr_warn(#name " FAIL (uninit bytes: %d)\n",	\
-			sum);					\
-								\
-	return (sum != 0);					\
+		return 0;					\
+	} else {						\
+		pr_warn(#name " %sFAIL (uninit bytes: %d)\n",	\
+			(xfail) ? "X" : "", sum);		\
+		return (xfail) ? 0 : 1;				\
+	}							\
 }
 #define DEFINE_TEST(name, var_type, which, init_level)		\
 /* no-op to force compiler into ignoring "uninitialized" vars */\
@@ -189,7 +191,7 @@ static noinline __init int leaf_ ## name(unsigned long sp,	\
 								\
 	return (int)buf[0] | (int)buf[sizeof(buf) - 1];		\
 }								\
-DEFINE_TEST_DRIVER(name, var_type, which)
+DEFINE_TEST_DRIVER(name, var_type, which, 0)
 
 /* Structure with no padding. */
 struct test_packed {
@@ -326,8 +328,14 @@ static noinline __init int leaf_switch_2_none(unsigned long sp, bool fill,
 	return __leaf_switch_none(2, fill);
 }
 
-DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR);
-DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR);
+/*
+ * These are expected to fail for most configurations because neither
+ * GCC nor Clang have a way to perform initialization of variables in
+ * non-code areas (i.e. in a switch statement before the first "case").
+ * https://bugs.llvm.org/show_bug.cgi?id=44916
+ */
+DEFINE_TEST_DRIVER(switch_1_none, uint64_t, SCALAR, 1);
+DEFINE_TEST_DRIVER(switch_2_none, uint64_t, SCALAR, 1);
 
 static int __init test_stackinit_init(void)
 {
-- 
2.20.1


-- 
Kees Cook
