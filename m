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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025CEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B3A20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 22:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiDMRc7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgE3WLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 18:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgE3WLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 18:11:44 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D502C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:44 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id g3so284654ilq.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 15:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zfm9kHjFnQFdUAVBLjMI6TIQzJXR3Gk74c6bjpdsb8g=;
        b=QiDMRc7DQ2hf2K47s62fau1XIFINWgxyDIC0+dp+3keJgz040D3ReyW7Gz7rkH04bF
         i/0wpKmJuCMfs0RScze33QWnlr/3ytxHMzPqAppv15RnF+MIOknIT4PnjsQrrGaq6JYr
         MMRaUIxjLIFmFAzT+jRfgYFMFHRbxoxtTumH42QhA2AtUliW+7cPxTuEtapwQkXYCb28
         GPGpMKQQeUgF9/wY7uscg7PErSElF4ujUZ+n28EmSpSsA02rCT7FAF/7nC8uGQtixqxd
         VAzfhbE69dQzyRrHHmI0w/8QrYQeoveVOBNqn+cLVYxqqafIx+ZqJ/4LdDJQVEyvnqf2
         dyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zfm9kHjFnQFdUAVBLjMI6TIQzJXR3Gk74c6bjpdsb8g=;
        b=LgjD7TkuioxaAAhjevTqJq637sjhUmrYYXezte4AnsLYFMDvEu+I6DdV4Bn/yneVeY
         Iwj9lfgSDgDRvK4j7AW+T1eRsQvdcb3JyoHGFpUVENmGMGQWClHgkQNK6vDDRcMmZBhD
         yx9aPthnEGsO0Z7hMLgu46nMdD4JtQAZ4DSs9ttoNj/JSl3CU7ywrUR01MLUlYTSe+OY
         3zT9ytPpWB78nwXqqQuZE6ttISMdSNNp22QZ5F15laPIiXhFGd8zpUtYM088IE9EiszE
         WHuDE+WMB7wQvPqtGBIBKi2k2fCMm0lCRRytpOphvwpR4e8qNeje3MI+uY8EVKKaos84
         DFIQ==
X-Gm-Message-State: AOAM531XkSzwq9yJ1jxtpthTL7F+fpYO/7ZIaVFI3IG1Tt0uMTBH+ZwA
        q2r7Veu8U39DbYtfoMqgD1EZ4QqP7w==
X-Google-Smtp-Source: ABdhPJygS4BQ7sZKPT/hOEtTDUw4cjexuPghBz/KxV4adEFleNvMjRcqlsmKj1YhPmqijwTx3leZpg==
X-Received: by 2002:a92:894e:: with SMTP id n75mr14220540ild.271.1590876702496;
        Sat, 30 May 2020 15:11:42 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id w78sm2735698ilk.14.2020.05.30.15.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 15:11:42 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2 03/10] x86/percpu: Clean up percpu_from_op()
Date:   Sat, 30 May 2020 18:11:20 -0400
Message-Id: <20200530221127.459704-4-brgerst@gmail.com>
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 50 +++++++++++------------------------
 1 file changed, 15 insertions(+), 35 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index fb280fba94c5..a40d2e055f58 100644
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

