Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F8EF207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNDcuQBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgEQP3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbgEQP3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:30 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F02C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:29 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id a4so3547101qvj.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpuRSos/Dd79+yBu/pA6uPLxXxzGdDvrOTy9JmROkHM=;
        b=GNDcuQBDv9VaHlWYS1IHwa/G+xMSrjl+4lByquKvpmip7qNdAVAb3PthPZKXkmlu9j
         KgX/1uUhpYMN28uKH4fcgiCw9mFuV2jtIXjTXjMb3lpN7IasSxCrBlfxd+e4nynNhHUe
         pcvWbmcH4G98xD2uvi+yIdHZelJ4RJ+nNKWUjgvqT/ybv5IE9X5I84tyAHB0whdkjZkC
         jrFWrVRlauhogCvBe0OMkqAT3bmsQy/YRNAhrKf3PPIQKTfJyA/tv+tnbWXjkvG+0sYI
         nrU6aLR30/hWd1C2sT6ZY7g187ZGGBpj5aucNqCKdlPKLxYLkjlJEEsOdG0ZpfxbR2Oc
         BqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpuRSos/Dd79+yBu/pA6uPLxXxzGdDvrOTy9JmROkHM=;
        b=HAeo6MHOzNjqrqkxkUwJ/o79V45JwPeKhzKeHfaGu1PwM20NzCHDJF7uhr+aKSZoB8
         E5dm3txJfPlXWeSvSIWOo0Ge0iZDMZyKfwIH4L6TvI4MEJkC1/zvil/SWhTQJ/B97u5U
         IiUNwe//INi9kWnCmwTfgIMxdju8T99p+spF/Fx3jzv+9iv2w2mR+65kWfnANL5Dpsyw
         N/YMjlGbsnOlocQ+3Zjc+GZQ0W+JJEOXpfMtIKqs/MdgvF+y/QvjGTS83pIo58diMZEo
         G1u+6nUhXxsAe9eI6p40UnI4gxu2pljRxIAd91DT0O0siRC32gwYyJNNncdnYPIh1gND
         h8Kw==
X-Gm-Message-State: AOAM531pFMjGh10+qPw8mTFz5fqlp3N85NRzLNXNva2mcveiIjkbrJvO
        u+04XKfJQfuveHHRs2WOgmh9vnC39w==
X-Google-Smtp-Source: ABdhPJx5VCjqQ6yFPyCCfHJPb4xsgodggDsmUptOsP4NwMB9JTEQnWBMCB/kXjz0ciWxmMyarLNRFA==
X-Received: by 2002:a0c:c506:: with SMTP id x6mr12112064qvi.188.1589729368463;
        Sun, 17 May 2020 08:29:28 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:28 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 3/7] x86/percpu: Clean up percpu_from_op()
Date:   Sun, 17 May 2020 11:29:12 -0400
Message-Id: <20200517152916.3146539-4-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200517152916.3146539-1-brgerst@gmail.com>
References: <20200517152916.3146539-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core percpu macros already have a switch on the data size, so the switch
in the x86 code is redundant and produces more dead code.

Also use appropriate types for the width of the instructions.  This avoids
errors when compiling with Clang.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/x86/include/asm/percpu.h | 50 +++++++++++------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 233c7a78d1a6..93f33202492d 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -190,33 +190,13 @@ do {									\
 	}								\
 } while (0)
 
-#define percpu_from_op(qual, op, var)			\
-({							\
-	typeof(var) pfo_ret__;				\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b "__percpu_arg(1)",%0"	\
-		    : "=q" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 2:						\
-		asm qual (op "w "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 4:						\
-		asm qual (op "l "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	case 8:						\
-		asm qual (op "q "__percpu_arg(1)",%0"	\
-		    : "=r" (pfo_ret__)			\
-		    : "m" (var));			\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
-	pfo_ret__;					\
+#define percpu_from_op(size, qual, op, _var)				\
+({									\
+	__pcpu_type_##size pfo_val__;					\
+	asm qual (__pcpu_op2_##size(op, __percpu_arg([var]), "%[val]")	\
+	    : [val] __pcpu_reg_##size("=", pfo_val__)			\
+	    : [var] "m" (_var));					\
+	(typeof(_var))(unsigned long) pfo_val__;			\
 })
 
 #define percpu_stable_op(op, var)			\
@@ -401,9 +381,9 @@ do {									\
  */
 #define this_cpu_read_stable(var)	percpu_stable_op("mov", var)
 
-#define raw_cpu_read_1(pcp)		percpu_from_op(, "mov", pcp)
-#define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
-#define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_1(pcp)		percpu_from_op(1, , "mov", pcp)
+#define raw_cpu_read_2(pcp)		percpu_from_op(2, , "mov", pcp)
+#define raw_cpu_read_4(pcp)		percpu_from_op(4, , "mov", pcp)
 
 #define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
 #define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
@@ -433,9 +413,9 @@ do {									\
 #define raw_cpu_xchg_2(pcp, val)	raw_percpu_xchg_op(pcp, val)
 #define raw_cpu_xchg_4(pcp, val)	raw_percpu_xchg_op(pcp, val)
 
-#define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_1(pcp)		percpu_from_op(1, volatile, "mov", pcp)
+#define this_cpu_read_2(pcp)		percpu_from_op(2, volatile, "mov", pcp)
+#define this_cpu_read_4(pcp)		percpu_from_op(4, volatile, "mov", pcp)
 #define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
 #define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
 #define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
@@ -488,7 +468,7 @@ do {									\
  * 32 bit must fall back to generic operations.
  */
 #ifdef CONFIG_X86_64
-#define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
+#define raw_cpu_read_8(pcp)			percpu_from_op(8, , "mov", pcp)
 #define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
@@ -497,7 +477,7 @@ do {									\
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
-#define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
+#define this_cpu_read_8(pcp)			percpu_from_op(8, volatile, "mov", pcp)
 #define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
-- 
2.25.4

