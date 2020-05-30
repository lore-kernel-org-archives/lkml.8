Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29007C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00559207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqZBYWdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbgE3WLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgE3WLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB565C08C5CA
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t8so5407897ilm.7
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91CInpU4Cyy1eJiDeE1wnCFd+k0uw8ETJ1vg5EH3afw=;
        b=BqZBYWdn1rw66hGbTh8L4ktSZUDayuf9qbGv9aRyb9lrjUMgJniZNOalOvJuqvUMsj
         cVduf9zneBKwqat7HznI0vQvSkreOrseWL+ktQdm/zpRRW5RKlr1xLGSg1dCWsfBZBfh
         n4JO0fQCHDsX/mmFEm0UIk5yn0lg8NDP6MeCNlRAgSgAc8lqXE0GNSHtA3ZcByluusI9
         MJ1ugg8UyBAaozI4defS1uifiDZA5Z9gDXoPRiGghSux6n9LxzfO/H4/v9/uacCS5eL4
         vev6q50LRKGxNurHeytNKRGdhsxpmkJdsmCWisz6Mo+IrbAJaybG7XP10yPVvTPpKgZC
         ifSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91CInpU4Cyy1eJiDeE1wnCFd+k0uw8ETJ1vg5EH3afw=;
        b=ZsXX4RJTsA0aXr2mDScg7Tde9ASSSY3rvfpnjhRi0JVv48gyp4H+YFn6ssl/bWu4m2
         EN3Dsbt8RZlR8QRSDhxjA+CkSB0z17hcbvLtEZwd2USGl5MV2iiLEFhQ0udQcbwWG1Cu
         BmkLfbeM9THNnvSdyFcQt925B+4QFzHPlDWt4muV+wAcztCjPERGq1xPQjRDp8ExcAfM
         x7V9O1QQhh3O9KXcVHWWncb5utvBZApvj/lzDvibPZXUE/izDcx9REWqIGR4oUATASIG
         43aozLUrMIUSQRSVnLz1XVt14XL59Am9CvjFCSEXa4BLzVv0gRgUTore960Y7fsIWlQo
         yuYg==
X-Gm-Message-State: AOAM532k/sTeKqklZ0Fibj+jp1F2ToqI1Y4PnIZRE2pDUr6B0LFL9kFw
        CWHmmKAz8l7SDuDPzyeeW0ZuCJ6xrg==
X-Google-Smtp-Source: ABdhPJyKBtrr/K6W0DlinkhYnJU0rNxJwethTgrfxuCori7CpKnq91iP2tVh8lFtyjvkDBng/e0OQA==
X-Received: by 2002:a92:ba14:: with SMTP id o20mr14465831ili.23.1590876706027;
        Sat, 30 May 2020 15:11:46 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:45 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 06/10] x86/percpu: Clean up percpu_add_return_op()
Date:   Sat, 30 May 2020 18:11:23 -0400
Message-Id: <20200530221127.459704-7-brgerst@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
References: <20200530221127.459704-1-brgerst@gmail.com>
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
 arch/x86/include/asm/percpu.h | 51 +++++++++++------------------------
 1 file changed, 16 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 9bb5440d98d3..0776a11e7e11 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -199,34 +199,15 @@ do {									\
 /*
  * Add return operation
  */
-#define percpu_add_return_op(qual, var, val)				\
+#define percpu_add_return_op(size, qual, _var, _val)			\
 ({									\
-	typeof(var) paro_ret__ = val;					\
-	switch (sizeof(var)) {						\
-	case 1:								\
-		asm qual ("xaddb %0, "__percpu_arg(1)			\
-			    : "+q" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	case 2:								\
-		asm qual ("xaddw %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	case 4:								\
-		asm qual ("xaddl %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	case 8:								\
-		asm qual ("xaddq %0, "__percpu_arg(1)			\
-			    : "+r" (paro_ret__), "+m" (var)		\
-			    : : "memory");				\
-		break;							\
-	default: __bad_percpu_size();					\
-	}								\
-	paro_ret__ += val;						\
-	paro_ret__;							\
+	__pcpu_type_##size paro_tmp__ = __pcpu_cast_##size(_val);	\
+	asm qual (__pcpu_op2_##size("xadd", "%[tmp]",			\
+				     __percpu_arg([var]))		\
+		  : [tmp] __pcpu_reg_##size("+", paro_tmp__),		\
+		    [var] "+m" (_var)					\
+		  : : "memory");					\
+	(typeof(_var))(unsigned long) (paro_tmp__ + _val);		\
 })
 
 /*
@@ -377,16 +358,16 @@ do {									\
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 
-#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(, pcp, val)
-#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, , pcp, val)
+#define raw_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, , pcp, val)
+#define raw_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, , pcp, val)
 #define raw_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 #define raw_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 #define raw_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
-#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(volatile, pcp, val)
-#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(volatile, pcp, val)
-#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_1(pcp, val)		percpu_add_return_op(1, volatile, pcp, val)
+#define this_cpu_add_return_2(pcp, val)		percpu_add_return_op(2, volatile, pcp, val)
+#define this_cpu_add_return_4(pcp, val)		percpu_add_return_op(4, volatile, pcp, val)
 #define this_cpu_cmpxchg_1(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_2(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
@@ -418,7 +399,7 @@ do {									\
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(8, , (pcp), val)
 #define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
 #define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
-#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
+#define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, , pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
@@ -427,7 +408,7 @@ do {									\
 #define this_cpu_add_8(pcp, val)		percpu_add_op(8, volatile, (pcp), val)
 #define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
 #define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
-#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
+#define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(8, volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
 
-- 
2.25.4

