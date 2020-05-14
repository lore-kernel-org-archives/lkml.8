Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E5DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45DB1204EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJWhed2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgENXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgENXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:19:03 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FA9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:19:02 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so65764pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AqE1ZVG1b8bryM0cZNxbwIGFwr67seBndN946MlU8vk=;
        b=qJWhed2GQsIJhqFeYgctt7GYJW/lEnPSY0vDCL5et4njxAC/yc0AuyM/czQhoBwO/r
         ExrKt/Z59MeoCKnjd3svn3pENti7IjKNjT9JfEXr1AX49KQs0mfw8kRHr/OyB7NMiHll
         sFxUtGF3wgyADnAxMewITwKmun/NaQyjtozPUR4ArlGp6/5edBNLBkLj5x1AmvBO948u
         sX181srWM2KH8HfQGd7a5biEshUGiQzKd+g6ZDlZ+JqpbtKBcP0DB/LZaGgxTLqRP4OM
         oQUpophVgi3JqOjYTJ5nMuNG6kC7sA7/icV7RzHSCQlsIhzs9lvCiBx2DhpEXLKswQUT
         AANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqE1ZVG1b8bryM0cZNxbwIGFwr67seBndN946MlU8vk=;
        b=duY0DJapWv3XFzgKReyJhsVh/U+YpbMHc+SDP0jhYxsGdiJYV+H3EqkA1Hv9mqHKPx
         1/WlUHVwYW0oOK1zSBB+muwlw3he+hNY+APSleOIPHrNC1GOxa7d0+kU9pbTpwUzfm2n
         p3JPzvvKDRPoE4W43xChMGXm7OU/rhD03ULmdPjYm6wLXqYJPw11duq+nl1tne45tAtV
         yX/NNSUsnXqlbwDaLa3H/AFzuKFbmmhd2SWDZn6/mUrG4vTXKEw2TzR5JV57Bnz9L7To
         TB3JmN5Ah3zID2DwZJmf0tQxv82HZv95mm4lqHDpWwsnx0eUIwAQcfy4HKVv7jGU6cZD
         sseA==
X-Gm-Message-State: AOAM530d34oikmjXVpVBUoZKkpUaHLIKsn1V/pm457QR7PH+C0P2GM4P
        sY0oZnjOGYiEgj6BBQdM5TM=
X-Google-Smtp-Source: ABdhPJzv0u2xLv8u82IEuMI8CU7/XZFMtZXUJJe9DXv3N5v0mWbPF+/MJLAlAeRQwEORLLPITTZjyw==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr442220pgs.167.1589498341763;
        Thu, 14 May 2020 16:19:01 -0700 (PDT)
Received: from syed ([106.223.1.212])
        by smtp.gmail.com with ESMTPSA id e2sm106864pjt.2.2020.05.14.16.18.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 16:19:01 -0700 (PDT)
Date:   Fri, 15 May 2020 04:48:46 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <f4d924971feb15b0044eeefdd969b36747d2322b.1589497312.git.syednwaris@gmail.com>
References: <cover.1589497311.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589497311.git.syednwaris@gmail.com>
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
Changes in v6:
 - Make 'for loop' inside 'test_for_each_set_clump' more succinct.

Changes in v5:
 - No change.

Changes in v4:
 - Use 'for' loop in test function of 'for_each_set_clump'.

Changes in v3:
 - No Change.

Changes in v2:
 - Unify different tests for 'for_each_set_clump'. Pass test data as
   function parameters.
 - Remove unnecessary bitmap_zero calls.

 lib/test_bitmap.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..673c512a5bbd 100644
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
@@ -577,6 +610,28 @@ static void noinline __init test_mem_optimisations(void)
 	}
 }
 
+static const unsigned long clump_bitmap_data[] __initconst = {
+	0x38000201,
+	0x05ff0f38,
+	0xeffedcba,
+	0xbbbbabcd,
+	0x000000aa,
+	0x000000aa,
+	0x00ff0000,
+	0xaaaaaa00,
+	0xff000000,
+	0x00aa0000,
+	0x00000000,
+	0x00000000,
+	0x00000000,
+	0x0f000000,
+	0x00ff0000,
+	0xaaaaaa00,
+	0xff000000,
+	0x00aa0000,
+	0x00000ac0,
+};
+
 static const unsigned char clump_exp[] __initconst = {
 	0x01,	/* 1 bit set */
 	0x02,	/* non-edge 1 bit set */
@@ -588,6 +643,92 @@ static const unsigned char clump_exp[] __initconst = {
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
+struct clump_test_data {
+	unsigned long data[256];
+	unsigned long count;
+	unsigned long offset;
+	unsigned long limit;
+	unsigned long clump_size;
+	unsigned long const *exp;
+} clump_test_data[] = { {{0}, 2, 0, 64, 8, clump_exp1},
+			{{0}, 8, 2, 240, 24, clump_exp2},
+			{{0}, 8, 10, 240, 30, clump_exp3},
+			{{0}, 1, 18, 18, 6, clump_exp4} };
+
+static void __init prepare_test_data(unsigned int index)
+{
+	int i;
+	unsigned long width = 0;
+
+	for(i = 0; i < clump_test_data[index].count; i++)
+	{
+		bitmap_set_value(clump_test_data[index].data,
+			clump_bitmap_data[(clump_test_data[index].offset)++], width, 32);
+		width += 32;
+	}
+}
+
+static void __init execute_for_each_set_clump_test(unsigned int index)
+{
+	unsigned long start, clump;
+
+	for_each_set_clump(start, clump, clump_test_data[index].data,
+						clump_test_data[index].limit,
+						clump_test_data[index].clump_size)
+	expect_eq_clump(start, clump_test_data[index].limit, clump_test_data[index].exp,
+						&clump, clump_test_data[index].clump_size);
+}
+
+static void __init test_for_each_set_clump(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(clump_test_data); i++) {
+		prepare_test_data(i);
+		execute_for_each_set_clump_test(i);
+	}
+}
+
 static void __init test_for_each_set_clump8(void)
 {
 #define CLUMP_EXP_NUMBITS 64
@@ -623,6 +764,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.26.2

