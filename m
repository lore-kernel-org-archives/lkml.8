Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA1DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417022074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRNhyOkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFEI2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:28:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCB7C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 01:28:43 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y7so11163622ybj.15
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q4xtHULh8K3VSLAHr6h+7DTr9q0n8BVN7sADFLbNyog=;
        b=NRNhyOkZW2AHP6pjt01FNdyqIoohsNLcNf6YvMUTcMA63i6H3CSfkhOPKKziRZWP81
         ijFHHm+IHydhxdQQOkmrgl9SYC6W9tBejccem+OO5IWr0vGbm0Z4QeFP2MyFoEYAn1b4
         EppDtMY64DGA0vz1picXrZhcG2dTlLTh/Gb70X2/q+S5m2TI/Ybfp4drphvE9ElkUl0z
         VkA8tdUZLo7ESn2xZFOaVmY6fhn/IOKARHpk7zMqdWWSSUHUF9j83n2y0OCsTupWaRkp
         140gvtVTTHlGSoIoRxLpKM4bTJ0VNoQf/KesCdGRzVe0FOQT0gavKVGNWUU6I+bQCop6
         i0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q4xtHULh8K3VSLAHr6h+7DTr9q0n8BVN7sADFLbNyog=;
        b=JNOWGBZYavEHAkRCBfBGBKT/yqKYzn9TZH0XhZyodcInbqNM3+JHSLK9FUadd1uLlA
         Fn0qSjFYWutwciqgggdvdM0k6yxJ3jC61hf6LZAZ6+JNlotDoCZ2pQEHJKV9Ma0HvYtb
         atPgLnsJ6lPvWwSe9d/Hon3RcqokpbUZpdpBj+MyBrMKnOyvz23OrB4NZbgzGp9Q9HgC
         yeKOtIFtiSAAHveFobVeeHWqsj25f9zNU47TEGDmtrYEDNAPAIW9vevyfpcmWHz44RPs
         E8jyHLcFAwbPsAkNxdF4/ia4XcDFCdcNSwlTK1kAM6yH5xyhMyYBvAZPWbCF80/j6ZxY
         KmPQ==
X-Gm-Message-State: AOAM532wBXXBpiNr28dpeSS+WlYoZG0Eo/x8NL4YhR/j5cWm7l3uT2ZQ
        Gc6uBiaP1YS7RN9iHv0BazXxmDV2kQ==
X-Google-Smtp-Source: ABdhPJzIAplfiGvvUAXfws2Vg4mMgLkpukHSy8NK0gsF4gPzeFXpJ99PYxD9sjpRwcytsiX/05iyw/k3Jw==
X-Received: by 2002:a25:b882:: with SMTP id w2mr14553588ybj.160.1591345722977;
 Fri, 05 Jun 2020 01:28:42 -0700 (PDT)
Date:   Fri,  5 Jun 2020 10:28:38 +0200
Message-Id: <20200605082839.226418-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        mingo@kernel.org, clang-built-linux@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        akpm@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While we lack a compiler attribute to add to noinstr that would disable
KCOV, make the KCOV runtime functions return if the caller is in a
noinstr section, and mark them noinstr.

Declare write_comp_data() as __always_inline to ensure it is inlined,
which also reduces stack usage and removes one extra call from the
fast-path.

In future, our compilers may provide an attribute to implement
__no_sanitize_coverage, which can then be added to noinstr, and the
checks added in this patch can be guarded by an #ifdef checking if the
compiler has such an attribute or not.

Signed-off-by: Marco Elver <elver@google.com>
---
Applies to -tip only currently, because of the use of instrumentation.h
markers.

v3:
* Remove objtool hack, and instead properly mark __sanitizer_cov
  functions as noinstr.
* Add comment about .entry.text.

v2: https://lkml.kernel.org/r/20200604145635.21565-1-elver@google.com
* Rewrite based on Peter's and Andrey's feedback -- v1 worked because we
  got lucky. Let's not rely on luck, as it will be difficult to ensure the
  same conditions remain true in future.

v1: https://lkml.kernel.org/r/20200604095057.259452-1-elver@google.com

Note: There are a set of KCOV patches from Andrey in -next:
https://lkml.kernel.org/r/cover.1585233617.git.andreyknvl@google.com --
Git cleanly merges this patch with those patches, and no merge conflict
is expected.
---
 kernel/kcov.c | 59 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 14 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 8accc9722a81..84cdc30d478e 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -6,6 +6,7 @@
 #include <linux/compiler.h>
 #include <linux/errno.h>
 #include <linux/export.h>
+#include <linux/instrumentation.h>
 #include <linux/types.h>
 #include <linux/file.h>
 #include <linux/fs.h>
@@ -24,6 +25,7 @@
 #include <linux/refcount.h>
 #include <linux/log2.h>
 #include <asm/setup.h>
+#include <asm/sections.h>
 
 #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
 
@@ -172,20 +174,38 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
 	return ip;
 }
 
+/* Return true if @ip is within a noinstr section. */
+static __always_inline bool within_noinstr_section(unsigned long ip)
+{
+	/*
+	 * Note: .entry.text is also considered noinstr, but for now, since all
+	 * .entry.text code lives in .S files, these are never instrumented.
+	 */
+	return (unsigned long)__noinstr_text_start <= ip &&
+	       ip < (unsigned long)__noinstr_text_end;
+}
+
 /*
  * Entry point from instrumented code.
  * This is called once per basic-block/edge.
  */
-void notrace __sanitizer_cov_trace_pc(void)
+void noinstr __sanitizer_cov_trace_pc(void)
 {
 	struct task_struct *t;
 	unsigned long *area;
-	unsigned long ip = canonicalize_ip(_RET_IP_);
+	unsigned long ip;
 	unsigned long pos;
 
+	if (unlikely(within_noinstr_section(_RET_IP_)))
+		return;
+
+	instrumentation_begin();
+
 	t = current;
 	if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
-		return;
+		goto out;
+
+	ip = canonicalize_ip(_RET_IP_);
 
 	area = t->kcov_area;
 	/* The first 64-bit word is the number of subsequent PCs. */
@@ -194,19 +214,27 @@ void notrace __sanitizer_cov_trace_pc(void)
 		area[pos] = ip;
 		WRITE_ONCE(area[0], pos);
 	}
+
+out:
+	instrumentation_end();
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
-static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
+static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 {
 	struct task_struct *t;
 	u64 *area;
 	u64 count, start_index, end_pos, max_pos;
 
+	if (unlikely(within_noinstr_section(ip)))
+		return;
+
+	instrumentation_begin();
+
 	t = current;
 	if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
-		return;
+		goto out;
 
 	ip = canonicalize_ip(ip);
 
@@ -229,61 +257,64 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 		area[start_index + 3] = ip;
 		WRITE_ONCE(area[0], count + 1);
 	}
+
+out:
+	instrumentation_end();
 }
 
-void notrace __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
+void noinstr __sanitizer_cov_trace_cmp1(u8 arg1, u8 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(0), arg1, arg2, _RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_cmp1);
 
-void notrace __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2)
+void noinstr __sanitizer_cov_trace_cmp2(u16 arg1, u16 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(1), arg1, arg2, _RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_cmp2);
 
-void notrace __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2)
+void noinstr __sanitizer_cov_trace_cmp4(u32 arg1, u32 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(2), arg1, arg2, _RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_cmp4);
 
-void notrace __sanitizer_cov_trace_cmp8(u64 arg1, u64 arg2)
+void noinstr __sanitizer_cov_trace_cmp8(u64 arg1, u64 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(3), arg1, arg2, _RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_cmp8);
 
-void notrace __sanitizer_cov_trace_const_cmp1(u8 arg1, u8 arg2)
+void noinstr __sanitizer_cov_trace_const_cmp1(u8 arg1, u8 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(0) | KCOV_CMP_CONST, arg1, arg2,
 			_RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp1);
 
-void notrace __sanitizer_cov_trace_const_cmp2(u16 arg1, u16 arg2)
+void noinstr __sanitizer_cov_trace_const_cmp2(u16 arg1, u16 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(1) | KCOV_CMP_CONST, arg1, arg2,
 			_RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp2);
 
-void notrace __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2)
+void noinstr __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(2) | KCOV_CMP_CONST, arg1, arg2,
 			_RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp4);
 
-void notrace __sanitizer_cov_trace_const_cmp8(u64 arg1, u64 arg2)
+void noinstr __sanitizer_cov_trace_const_cmp8(u64 arg1, u64 arg2)
 {
 	write_comp_data(KCOV_CMP_SIZE(3) | KCOV_CMP_CONST, arg1, arg2,
 			_RET_IP_);
 }
 EXPORT_SYMBOL(__sanitizer_cov_trace_const_cmp8);
 
-void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
+void noinstr __sanitizer_cov_trace_switch(u64 val, u64 *cases)
 {
 	u64 i;
 	u64 count = cases[0];
-- 
2.27.0.278.ge193c7cf3a9-goog

