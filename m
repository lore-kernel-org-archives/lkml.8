Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BB9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2754B206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SeNAh2Su"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgFDJwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFDJwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:52:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77430C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 02:52:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u6so7288693ybo.18
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 02:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r692uYxf+UU+Krdksb9nzub5hLmbN/XbgAudqBHpBo4=;
        b=SeNAh2SuOORcxIaGUfrf3S6izrA39+/EFQRxpQL6/A8joHQj7/8TPa63fT4+uthn/D
         pmkJlXu1mzSnbgjJvSCGj87IA5/hs8mtuQXlX0gXIwDR2jYjDQd2cmhMjehTTeCn5aPc
         1feh52ZU6ZZ4z6Ot+LYHcrVKbrXMV+0aWxNzdXpBr7UqFJthuP93LYW+AgBNmHN8+RDz
         ULcP2SMgdcz0aCzkdQ/GApw/9zbFLc4hHtZT4vXdGsIwF9a2iXt8tZPWBX5uMMjdPeVV
         2F/0+L7VIcdPVnWPemEq4QZVpKRpQgRoe8737QiUCFWCS3ZGnlvFLeyMEavKj+gulUFW
         dP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r692uYxf+UU+Krdksb9nzub5hLmbN/XbgAudqBHpBo4=;
        b=pXvmVX7Ah/61gqekdHeSQCmHzfz+At2kohapmoNW+D7IWpc8X9RZe+rDavhHEzoA0T
         s9k44SWoUxUdqTmEHLy6cyXZ7rNc28UO9ADmCwMj6TlwUIOW6vhXvsO1eFrgTmbRMTm4
         ve1ZlEKhLbXcIp+p+fAyYyD4bOyLSmaZhoI+I3v7Cgx88kKRPV9Un1RSgCr4jEdIIMQe
         rl/l+UPbXS8C4et2v/mxXi7XWvupSjuQ9F2Rp7v8qqebJfKWRvqQCIw/1q/3sva/TQbO
         rIuQS9xqRbyhZ/tXdChpxKshG+euIWFAdOS+LrQK4HUOAYcTp3Gh1AZLJuif/KZYVVtQ
         oNLg==
X-Gm-Message-State: AOAM530Qv99QBSMqaRP5e1Or0KQgWqAEv4X6uPFsCTErruXzljbRMM0+
        EFOtmEnS3bzQcaRoLQr8UUBFky2FPw==
X-Google-Smtp-Source: ABdhPJwna0ZgzdrKmVmkDY03kUR4ZmkBUBWCh132Y09C64+HiXWxW6QjpcDOJZbZ7xXsYK2z1U5M3AzflA==
X-Received: by 2002:a25:2f4f:: with SMTP id v76mr6129459ybv.7.1591264320706;
 Thu, 04 Jun 2020 02:52:00 -0700 (PDT)
Date:   Thu,  4 Jun 2020 11:50:57 +0200
Message-Id: <20200604095057.259452-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     peterz@infradead.org, bp@alien8.de, tglx@linutronix.de,
        mingo@kernel.org, clang-built-linux@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KCOV runtime is very minimal, only updating a field in 'current',
and none of __sanitizer_cov-functions generates reports nor calls any
other external functions.

Therefore we can make the KCOV runtime noinstr-compatible by:

  1. always-inlining internal functions and marking
     __sanitizer_cov-functions noinstr. The function write_comp_data() is
     now guaranteed to be inlined into __sanitize_cov_trace_*cmp()
     functions, which saves a call in the fast-path and reduces stack
     pressure due to the first argument being a constant.

  2. For Clang, correctly pass -fno-stack-protector via a separate
     cc-option, as -fno-conserve-stack does not exist on Clang.

The major benefit compared to adding another attribute to 'noinstr' to
not collect coverage information, is that we retain coverage visibility
in noinstr functions. We also currently lack such an attribute in both
GCC and Clang.

Signed-off-by: Marco Elver <elver@google.com>
---
Note: There are a set of KCOV patches from Andrey in -next:
https://lkml.kernel.org/r/cover.1585233617.git.andreyknvl@google.com --
Git cleanly merges this patch with those patches, and no merge conflict
is expected.
---
 kernel/Makefile |  2 +-
 kernel/kcov.c   | 26 +++++++++++++-------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/Makefile b/kernel/Makefile
index 5d935b63f812..8e282c611a72 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -35,7 +35,7 @@ KCOV_INSTRUMENT_stacktrace.o := n
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
 KCSAN_SANITIZE_kcov.o := n
-CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack) $(call cc-option, -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
 CFLAGS_sys_ni.o = $(DISABLE_LTO)
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 8accc9722a81..d6e3be2d0570 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -142,7 +142,7 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
 	list_add(&area->list, &kcov_remote_areas);
 }
 
-static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
+static __always_inline bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 {
 	unsigned int mode;
 
@@ -164,7 +164,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
 	return mode == needed_mode;
 }
 
-static notrace unsigned long canonicalize_ip(unsigned long ip)
+static __always_inline unsigned long canonicalize_ip(unsigned long ip)
 {
 #ifdef CONFIG_RANDOMIZE_BASE
 	ip -= kaslr_offset();
@@ -176,7 +176,7 @@ static notrace unsigned long canonicalize_ip(unsigned long ip)
  * Entry point from instrumented code.
  * This is called once per basic-block/edge.
  */
-void notrace __sanitizer_cov_trace_pc(void)
+void noinstr __sanitizer_cov_trace_pc(void)
 {
 	struct task_struct *t;
 	unsigned long *area;
@@ -198,7 +198,7 @@ void notrace __sanitizer_cov_trace_pc(void)
 EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
 
 #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
-static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
+static __always_inline void write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 {
 	struct task_struct *t;
 	u64 *area;
@@ -231,59 +231,59 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 	}
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
2.27.0.rc2.251.g90737beb825-goog

