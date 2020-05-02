Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8130C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B26A92072E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 23:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meDlXdPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgEBXMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726427AbgEBXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 19:12:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F2AC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 16:12:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so3546125pfw.13
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 16:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5EZ9kyNkZoFZYcmMll8JFKJ2xEN7le+M8oIKunN4Pv4=;
        b=meDlXdPm4H/WMUwrSneNcpxbS+qZRqJ3j6uWfu7Dzv01K7vGF7nOOPUdMEE5QigCob
         WIqUAbqtyxKx7JrImjaz8x2eR1jvx2uFC3z5YrYrn61/5G/iRQAd3qDWeazh7Kz6gyBA
         9t9xBRMyeTZ9sDmXeIV+Lv+W/+ur2thcmkRZrj0Ca0k5YFoNNkk2t7v3Mfr2F139kNSs
         yRK/U3UI33Y41q8T0P+x6Sm9hSmyAGmHBD2xRrzluspSOLwKcHzHiW0eRFx05r9sDbHg
         rfWBdKLysLz3Bu+GE8Klr6caj3SJ8JwPgLffCwx3qPv6gpysLp/dOIUx5tR5QG5OVMzI
         SQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5EZ9kyNkZoFZYcmMll8JFKJ2xEN7le+M8oIKunN4Pv4=;
        b=epj/usDA2Y7Sn0zOftzeSKlnDBq1Cbcp3GDyWm1DIsgW3v6nfP/vnbJbAV6VnAKcol
         ydPxWwneQ4z7tymTWybPbEpt+bOAiDIc+DIPvc3sBSeoKCbVsKSFSWepYLpKMhZxAD0v
         iOhKpp1tYG53qvDyowCzVeBh+GJYNWuswNhS3M9IbYE5YUTrgA2wpQfg5n6uPTtGR4H9
         drDPERYstn52SlMgf2iri+tM14FgJ75bMIxU70JeCRarvy+VvKZ0hDUp4sod2cvzkH/v
         p3H41p70ASRWa/TZjnNtAQKcgok6QvDEaYFzn5Nuflsu5UuHI0RofvHGwTQis6Vc8uhb
         eklQ==
X-Gm-Message-State: AGi0PuZT1OOAnyWRHIld8hal6SdlLNIsmgeTXCjDskKrUVFk4r94ZC3U
        Q5ZL0XJerCtZjEwrjW1zu80=
X-Google-Smtp-Source: APiQypJ+YqBUTTgV/VPc3M1GyACSe1e5R33ryzP/1wnBQoZtDIn1+kSXi6wz5DU5/XqpOIlbU5kjHw==
X-Received: by 2002:a63:6285:: with SMTP id w127mr10177918pgb.449.1588461121468;
        Sat, 02 May 2020 16:12:01 -0700 (PDT)
Received: from syed ([106.210.101.167])
        by smtp.gmail.com with ESMTPSA id b16sm5303351pfp.89.2020.05.02.16.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2020 16:12:01 -0700 (PDT)
Date:   Sun, 3 May 2020 04:41:42 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     akpm@linux-foundation.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <3eeb13d101db69be8eca739522bbf303527339bd.1588460322.git.syednwaris@gmail.com>
References: <cover.1588460322.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588460322.git.syednwaris@gmail.com>
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

 lib/test_bitmap.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..a2a1c411dd62 100644
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
@@ -588,6 +621,71 @@ static const unsigned char clump_exp[] __initconst = {
 	0x05,	/* non-adjacent 2 bits set */
 };
 
+static const unsigned long bitmap_test_data[] __initconst = {
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
+	0x00000ac0,
+};
+
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
+static const unsigned long * const clump_data[] __initconst = {
+	clump_exp1,
+	clump_exp2,
+	clump_exp3,
+	clump_exp4,
+};
+
 static void __init test_for_each_set_clump8(void)
 {
 #define CLUMP_EXP_NUMBITS 64
@@ -610,6 +708,48 @@ static void __init test_for_each_set_clump8(void)
 		expect_eq_clump8(start, CLUMP_EXP_NUMBITS, clump_exp, &clump);
 }
 
+static void __init execute_for_each_set_clump_test(unsigned long *bits,
+				unsigned long size,
+				unsigned long clump_size,
+				const unsigned long *clump_exp)
+{
+	unsigned long start, clump;
+
+	for_each_set_clump(start, clump, bits, size, clump_size)
+		expect_eq_clump(start, size, clump_exp, &clump, clump_size);
+}
+
+static void __init prepare_test_data(unsigned long * bits,
+				const unsigned long * test_data,
+				int start, int count)
+{
+	int i;
+	unsigned long position = 0;
+
+	for(i = 0; i < count; i++)
+	{
+		bitmap_set_value(bits, test_data[start++], position, 32);
+		position += 32;
+	}
+}
+
+static void __init test_for_each_set_clump(void)
+{
+	int i;
+	int count[] = {2, 8, 4, 1};
+	int offset[] = {0, 2, 10, 14};
+	unsigned long limit[] = {64, 240, 240, 18};
+	unsigned long clump_size[] = {8, 24, 30, 6};
+	DECLARE_BITMAP(bits, 256);
+
+	for(i = 0; i < 4; i++)
+	{
+		prepare_test_data(bits, bitmap_test_data, offset[i], count[i]);
+		execute_for_each_set_clump_test(bits, limit[i],
+					clump_size[i], clump_data[i]);
+	}
+}
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -623,6 +763,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.26.2

