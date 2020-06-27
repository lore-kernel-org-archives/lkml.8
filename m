Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2757DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2192074F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 08:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gD4UxzXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgF0IMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 04:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgF0IMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:12:09 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E7C03E979
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 01:12:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s14so5157333plq.6
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BnCofAP3+h7ld04wt2Blwglrqf4enknAcVXb4asEDMo=;
        b=gD4UxzXK679ErIbol65/63vbxpv+15Z5J871LAgFfmuuJIlWlG8Nqsx5DLZHq6+f2o
         d5Q8ebxMV4K6awHeVJsbWtCvrnAoPfYsDMGWl5K2r3uzx7uZqmVyvwpexctpo+EOIrH3
         s55UQSYyCVfCbpRaDRSAzFq9GFCxEgyxMmcsllZp39LcuhzverVwVCWTTrjwTrfCwQxp
         8KH1CX7hmFkoRX/ueVuc+Gh/54069mnLjOyoIy7tImn0sUJ/sHTcKQgTrk+X8O0IhJ9d
         tEYaRPbI/UfvT6XpYd8QbyeKJnXxqfBEJl69KVe/WFqtN+0B0NpjHCfPUcPnBO4cEMiS
         MUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BnCofAP3+h7ld04wt2Blwglrqf4enknAcVXb4asEDMo=;
        b=WqmVX+5P20L5n8N1TKKZAAcAziQbsMLgqh1mCtaZXlMdhDjA3LKTEqEXFXstxAIjRz
         edlUFXGkPPwaWvHuk6VbKkv0aRiifFpBcdHCeHTlysYRW30iyfMSnUQV3xJyrwKpegaI
         C1TwLV790m2t/L7XcyA8pnnWzQiqXQzmRtU2UuaboEesin39oLtTp5ZmM30HHjvStWH1
         6MD5Y7JN3+DFtJ2a5RxiRsJwFbfpajvZXOPPnodK8n/dwScFGHW6rJRSD1PZfoZ4zCKG
         oZU4FHXz+Dk4mh0vz30PFxo08PMZ+8nWRN3I/sPEhoZPhoN1q0YwXKIyHJHmX2iqPn/g
         Ovxw==
X-Gm-Message-State: AOAM531YkOVQDrZKKvYvfW7k1uwzk3drsanrcCyWTZloVIDf2iD6ZL0S
        8ag+0V9Lq04IXBH1X45One1CR4QC
X-Google-Smtp-Source: ABdhPJz9xjxrAAGFo8pqcxvnho9VJ6YoAxKV9PVqsq7hfhcdvLA8Tq78i1EP1daUxOxAH3Jc/qRpuQ==
X-Received: by 2002:a17:90a:e28c:: with SMTP id d12mr7816289pjz.122.1593245529249;
        Sat, 27 Jun 2020 01:12:09 -0700 (PDT)
Received: from syed ([106.198.224.34])
        by smtp.gmail.com with ESMTPSA id s10sm661633pjf.3.2020.06.27.01.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jun 2020 01:12:08 -0700 (PDT)
Date:   Sat, 27 Jun 2020 13:41:54 +0530
From:   Syed Nayyar Waris <syednwaris@gmail.com>
To:     linus.walleij@linaro.org
Cc:     andriy.shevchenko@linux.intel.com, vilhelm.gray@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
Message-ID: <5de225965389c3d32a64f1a1cfa0daf73c8d8616.1593243081.git.syednwaris@gmail.com>
References: <cover.1593243079.git.syednwaris@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593243079.git.syednwaris@gmail.com>
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

Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
Changes in v9:
 - No change.

Changes in v8:
 - [Patch 2/4]: Minor change: Use '__initdata' for correct section mismatch
   in 'clump_test_data' array.

Changes in v7:
 - Minor changes: Use macro 'DECLARE_BITMAP()' and split 'struct'
   definition and test data.

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

 lib/test_bitmap.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b13150667f5..78c0048870a6 100644
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
@@ -588,6 +643,95 @@ static const unsigned char clump_exp[] __initconst = {
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
+struct clump_test_data_params {
+	DECLARE_BITMAP(data, 256);
+	unsigned long count;
+	unsigned long offset;
+	unsigned long limit;
+	unsigned long clump_size;
+	unsigned long const *exp;
+};
+
+static struct clump_test_data_params clump_test_data[] __initdata =
+				      { {{0}, 2, 0, 64, 8, clump_exp1},
+					{{0}, 8, 2, 240, 24, clump_exp2},
+					{{0}, 8, 10, 240, 30, clump_exp3},
+					{{0}, 1, 18, 18, 6, clump_exp4} };
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
@@ -623,6 +767,7 @@ static void __init selftest(void)
 	test_bitmap_parselist_user();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
+	test_for_each_set_clump();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.26.2

