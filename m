Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A16C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A39020704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uMSloQyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDYTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgDYTDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:03:12 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B3AC09B04D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:03:12 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s18so3678854pgl.12
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 12:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0bZ5VjJ8FkDX8QDaZ6M+glwwcAmsvBrwNZycn1arDdw=;
        b=uMSloQyTBo2BBQbcmlZM++8cUZ/Edn7xczg0CfThYqnENkVDSoeahYCeLQg0qwrcJq
         9Tsk6A/epQiVnjhymmdQJ361Y6x+mQqjmhWBLSO9i5xsO3Vlig/MJPCT074TSQCPGOz1
         d7NOCxM1UIbcLw5o6nHMVh6X+v9GPw+RQa3ttrpb0o2DjupnhjlV95BgaV0JmKHgeEol
         TU8NcSBrlf+I0Oe9qBIgKRs6F6Ahse5Zpc6KJk2o/2TjkJwn0/fivtOIvwKh6lP1YQeg
         rNzRvvisUmpVXHcmab0OGP1CyVjGWSht72DoIhDpmhxvVhF6XbjsKBoRF2eUeUhDi+er
         +Dkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0bZ5VjJ8FkDX8QDaZ6M+glwwcAmsvBrwNZycn1arDdw=;
        b=tjW8//HpCTbIwZOjcTwesoYQy/n+ivwP9zgb6SjQn89tZ/GppIP3bAZe/X6+zjJqec
         ClQ2+O+1LzNVBrjKfU+YyVQMkPCJm0hjwUWeJmlRx6E9MpBIKSpgaI5ys0BaQgY9zva2
         Z7pBGxOusfku4COEdOn3/IcL3BpDOWl9Rjsi0B5+ErNfBgsiJ9JIj9A1F+ExOuccYlUs
         4Mg0Juj2zj9LS2wHfWbQBvSeCbPy0m1A5/rcTMLhZ27/0d50XoWcCoWZxfHn0KyA8BRX
         +EmrprZWkryZ1qQO6iNSFTO/yjyPcuvpikIbePlORcDxdMl/SQ7D4SW84xI6TZlnQI5H
         6GGQ==
X-Gm-Message-State: AGi0PuZSepPnuH5pngTibCoIRNjhT2QS+HH+heGUg6bPqrK+Ta2j94yB
        s75vpzB3p01BnAUZ9DndQ4Y=
X-Google-Smtp-Source: APiQypLTa4n5Vc0yodD51O2gDVUV4nzX23MuF8do1XPAwLGlYYup9Ro+FlxUW6ohkGYjHrNtPI7AtQ==
X-Received: by 2002:a63:d3:: with SMTP id 202mr15187935pga.378.1587841392185;
        Sat, 25 Apr 2020 12:03:12 -0700 (PDT)
Received: from syed ([106.223.101.50])
        by smtp.gmail.com with ESMTPSA id q2sm8680937pfl.174.2020.04.25.12.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 12:03:11 -0700 (PDT)
Date:   Sun, 26 Apr 2020 00:33:06 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <fb1d5c03315893fab7526e68e2e1b3af9b6a775e.1587840668.git.syednwaris@gmail.com>
References: <cover.1587840667.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587840667.git.syednwaris@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The introduction of the generic for_each_set_clump macro need test
cases to verify the implementation. This patch adds test cases for
scenarios in which clump sizes are 8 bits, 24 bits, 30 bits and 6 bits.
The cases contain situations where clump is getting split at the word
boundary and also when zeroes are present in the start and middle of
bitmap.

Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v2:
 - Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - Remove unnecessary bitmap_zero calls.

 lib/test_bitmap.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150..13fe9a2 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -155,6 +155,38 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init __check_eq_clump(const char *srcfile, unsigned int line,
+				    const unsigned int offset,
+				    const unsigned int size,
+				    const unsigned long *const clump_exp,
+				    const unsigned long *const clump,
+				    const unsigned long clump_size)
+{
+	unsigned long exp;
+
+	if (offset >= size) {
+		pr_warn("[%s:%u] bit offset for clump out-of-bounds: expected less than %u, got %u\n",
+			srcfile, line, size, offset);
+		return false;
+	}
+
+	exp = clump_exp[offset / clump_size];
+	if (!exp) {
+		pr_warn("[%s:%u] bit offset for zero clump: expected nonzero clump, got bit offset %u with clump value 0",
+			srcfile, line, offset);
+		return false;
+	}
+
+	if (*clump != exp) {
+		pr_warn("[%s:%u] expected clump value of 0x%lX, got clump value of 0x%lX",
+			srcfile, line, exp, *clump);
+		return false;
+	}
+
+	return true;
+}
+
+
 #define __expect_eq(suffix, ...)					\
 	({								\
 		int result = 0;						\
@@ -172,6 +204,7 @@ static bool __init __check_eq_clump8(const char *srcfile, unsigned int line,
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
 #define expect_eq_clump8(...)		__expect_eq(clump8, ##__VA_ARGS__)
+#define expect_eq_clump(...)		__expect_eq(clump, ##__VA_ARGS__)
 
 static void __init test_zero_clear(void)
 {
@@ -588,6 +621,46 @@ static const unsigned char clump_exp[] __initconst = {
 	0x05,	/* non-adjacent 2 bits set */
 };
 
+static const unsigned long clump_exp1[] __initconst = {
+	0x01,	/* 1 bit set */
+	0x02,	/* non-edge 1 bit set */
+	0x00,	/* zero bits set */
+	0x38,	/* 3 bits set across 4-bit boundary */
+	0x38,	/* Repeated clump */
+	0x0F,	/* 4 bits set */
+	0xFF,	/* all bits set */
+	0x05,	/* non-adjacent 2 bits set */
+};
+
+static const unsigned long clump_exp2[] __initconst = {
+	0xfedcba,	/* 24 bits */
+	0xabcdef,
+	0xaabbbb,	/* Clump split between 2 words */
+	0x000000,	/* zeroes in between */
+	0x0000aa,
+	0x000000,
+	0x0000ff,
+	0xaaaaaa,
+	0x000000,
+	0x0000ff,
+};
+
+static const unsigned long clump_exp3[] __initconst = {
+	0x00000000,	/* starting with 0s*/
+	0x00000000,	/* All 0s */
+	0x00000000,
+	0x00000000,
+	0x3f00000f,     /* Non zero set */
+	0x2aa80003,
+	0x00000aaa,
+	0x00003fc0,
+};
+
+static const unsigned long clump_exp4[] __initconst = {
+	0x00,
+	0x2b,
+};
+
 static void __init test_for_each_set_clump8(void)
 {
 #define CLUMP_EXP_NUMBITS 64
@@ -610,6 +683,53 @@ static void __init test_for_each_set_clump8(void)
 		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
+static void __init execute_for_each_set_clump(unsigned long *bits,
+				unsigned long size,
+				const unsigned long *clump_exp,
+				unsigned long clump_size)
+{
+	unsigned long start, clump;
+
+	for_each_set_clump(start, clump, bits, size, clump_size)
+		expect_eq_clump(start, size, clump_exp, &clump, clump_size);
+}
+
+static void __init test_for_each_set_clump(void)
+{
+	/* common bitmap of max size for different tests */
+	DECLARE_BITMAP(bits, 256);
+
+	/* set bitmap for test case 1 with clump size as 8 bits */
+	bitmap_set_value(bits, 0x38000201, 0, 32);
+	bitmap_set_value(bits, 0x05ff0f38, 32, 32);
+
+	execute_for_each_set_clump(bits, 64, clump_exp1, 8);
+
+	/* set bitmap for test case 2 with clump size as 24 bits */
+	bitmap_set_value(bits, 0xeffedcba, 0, 32);
+	bitmap_set_value(bits, 0xbbbbabcd, 32, 32);
+	bitmap_set_value(bits, 0x000000aa, 64, 32);
+	bitmap_set_value(bits, 0x000000aa, 96, 32);
+	bitmap_set_value(bits, 0x00ff0000, 128, 32);
+	bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
+	bitmap_set_value(bits, 0xff000000, 192, 32);
+	bitmap_set_value(bits, 0x00aa0000, 224, 32);
+
+	execute_for_each_set_clump(bits, 240, clump_exp2, 24);
+
+	/* set bitmap for test case 3 with clump size as 30 bits */
+	bitmap_set_value(bits, 0x00000000, 0, 32);
+	bitmap_set_value(bits, 0x00000000, 32, 32);
+	bitmap_set_value(bits, 0x00000000, 64, 32);
+	bitmap_set_value(bits, 0x0f000000, 96, 32);
+
+	execute_for_each_set_clump(bits, 240, clump_exp3, 30);
+
+	/* set bitmap for test case 4 with clump size as 6 bits */
+	bitmap_set_value(bits, 0x00000ac0, 0, 32);
+	execute_for_each_set_clump(bits, 18, clump_exp4, 6);
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -623,6 +743,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.7.4

