Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D076C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A392087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLNaFiA5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgDXM0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgDXM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:26:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294F2C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:26:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e6so3830268pjt.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XzNM/kV1dZuUtHsKgoCs5qViwOgcS6UvB+zpnSAB/Jw=;
        b=CLNaFiA5K0iSkrpFHn6116vKgzHQzUF2312BCY7gW5pDHBXjOMY2yBaJWXkvLAUIAc
         PceHqBzrIKPKE95RDUNixa5suZi8lNy18eI3qzv+QYI1Zf3+fejVNdDufHRjqkq2pObb
         CTv3Lay7EK/5xTZAxY1zkcaHIw20cLtV5aaFqdf3EJjes32z9WhvMgK0IYbHwBnc6UVq
         7EasqGkuDU7+8E4qeM9wR3m+3CO7hpZsqah1RZzYc/J61eASQp0ndJlc/lRaZrpncpFd
         a8GHBEfO9OeZnlRiWCgW2jeldLoq8j93k3d5h3XoJRQeMhwURyjiwbBhbDRO9GSvcsWg
         cEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XzNM/kV1dZuUtHsKgoCs5qViwOgcS6UvB+zpnSAB/Jw=;
        b=bZ9eH5b4bhT6TKU31eDUHgZ+FeETd2jOyc1/PP+xVdA48h/gmo1fIwVe1ALDUkcA7N
         8F2qjRATe1xQiliEYoN7xS6zQP6J5qv7socFMkWQhbNaQ/7xjWP8dLgdOy+hIM0vK5QG
         pbqflawuTPTo3+qGY3hDPBEEdi/cukxGKo9l7kuBl44FqO4Ppvjs/9FBjUAyCOaUQItR
         KAEf+7mE2/7Eppe9KJUSRcN3AdN44tZsNawjBIfo9OfaKGD4b1UCwTnwE15Y9I6E8BsU
         fI1pFUuc+xP/0Buy/tWwXGneLLkjAetzhlM94qWo82yfWG+fbcVGADJC703jKZfsDBC8
         7CCw==
X-Gm-Message-State: AGi0PuapmtJ47/zmvq9hF5Rao4y5W2zf/6SbYkgoLMCNqujo0PswQpt2
        HtxFuSt8Ab3dxANXY7q4o2bsMhnw
X-Google-Smtp-Source: APiQypIJX/5LWo2tBfq/mDSRVssqe2WZzs/Kp+YjoLV7zmwOCjU0+VxePpo8TIBejtzkHLvkoXWw2g==
X-Received: by 2002:a17:902:9044:: with SMTP id w4mr9171692plz.83.1587731185726;
        Fri, 24 Apr 2020 05:26:25 -0700 (PDT)
Received: from syed ([106.223.101.26])
        by smtp.gmail.com with ESMTPSA id mn1sm4587271pjb.24.2020.04.24.05.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 05:26:25 -0700 (PDT)
Date:   Fri, 24 Apr 2020 17:56:19 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <20200424122619.GA5573@syed>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 lib/test_bitmap.c | 159 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150..5c1f98f 100644
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
@@ -610,6 +683,88 @@ static void __init test_for_each_set_clump8(void)
 		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
+static void __init test_for_each_set_clump_8(void)  /* 8 bit clumps test using
+						  new for_each_set_clump */
+{
+#define CLUMP_EXP_NUMBITS 64
+	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS);
+	unsigned long start, clump, clump_size = 8;
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_EXP_NUMBITS);
+	bitmap_set_value(bits, 0x38000201, 0, 32);
+	bitmap_set_value(bits, 0x05ff0f38, 32, 32);
+
+	for_each_set_clump(start, clump, bits, CLUMP_EXP_NUMBITS, clump_size)
+		expect_eq_clump(start, CLUMP_EXP_NUMBITS, clump_exp1, &clump, clump_size);
+}
+
+static void __init test_for_each_set_clump_24(void)  /* 24 bit clumps */
+{
+#define CLUMP_EXP_NUMBITS_2 256
+	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
+	unsigned long start, clump, clump_size = 24;
+	unsigned long size = clump_size * 10;
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
+	bitmap_set_value(bits, 0xeffedcba, 0, 32);
+	bitmap_set_value(bits, 0xbbbbabcd, 32, 32);
+	bitmap_set_value(bits, 0x000000aa, 64, 32);
+	bitmap_set_value(bits, 0x000000aa, 96, 32);
+	bitmap_set_value(bits, 0x00ff0000, 128, 32);
+	bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
+	bitmap_set_value(bits, 0xff000000, 192, 32);
+	bitmap_set_value(bits, 0x00aa0000, 224, 32);
+
+	for_each_set_clump(start, clump, bits, size, clump_size)
+		expect_eq_clump(start, size, clump_exp2, &clump, clump_size);
+}
+
+static void __init test_for_each_set_clump_30(void)   /* 30 bit clumps */
+{
+#define CLUMP_EXP_NUMBITS_2 256
+	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
+	unsigned long start, clump, clump_size = 30;
+	unsigned long size = clump_size * 8;
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
+	bitmap_set_value(bits, 0x00000000, 0, 32);
+	bitmap_set_value(bits, 0x00000000, 32, 32);
+	bitmap_set_value(bits, 0x00000000, 64, 32);
+	bitmap_set_value(bits, 0x0f000000, 96, 32);
+	bitmap_set_value(bits, 0x00ff0000, 128, 32);
+	bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
+	bitmap_set_value(bits, 0xff000000, 192, 32);
+	bitmap_set_value(bits, 0x00aa0000, 224, 32);
+
+	for_each_set_clump(start, clump, bits, size, clump_size)
+		expect_eq_clump(start, size, clump_exp3, &clump, clump_size);
+}
+
+static void __init test_for_each_set_clump_6(void)   /* 6 bit clumps */
+{
+#define CLUMP_EXP_NUMBITS_2 256
+	DECLARE_BITMAP(bits, CLUMP_EXP_NUMBITS_2);
+	unsigned long start, clump, clump_size = 6;
+	unsigned long size = clump_size * 3;
+
+	/* set bitmap to test case */
+	bitmap_zero(bits, CLUMP_EXP_NUMBITS_2);
+	bitmap_set_value(bits, 0x00000ac0, 0, 32);
+	bitmap_set_value(bits, 0x00000000, 32, 32);
+	bitmap_set_value(bits, 0x00000000, 64, 32);
+	bitmap_set_value(bits, 0x0f000000, 96, 32);
+	bitmap_set_value(bits, 0x00ff0000, 128, 32);
+	bitmap_set_value(bits, 0xaaaaaa00, 160, 32);
+	bitmap_set_value(bits, 0xff000000, 192, 32);
+	bitmap_set_value(bits, 0x00aa0000, 224, 32);
+
+	for_each_set_clump(start, clump, bits, size, clump_size)
+		expect_eq_clump(start, size, clump_exp4, &clump, clump_size);
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -623,6 +778,10 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump_8();
+	test_for_each_set_clump_24();
+	test_for_each_set_clump_30();
+	test_for_each_set_clump_6();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.7.4

