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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11783204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soaveJwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgEQP3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgEQP33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:29:29 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AC1C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:29 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u12so4106489vsq.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4B8J5esrFUm5kQo9wy0QxWh6m7I0euVc7kaRaYNQU0=;
        b=soaveJwPzVQ3bcHdVORgKmYGRrhPT+yeAI9cuonziViQ9KSQoOo3Wvs51/2qjub0lR
         bl1j7lH8oL49jn4jrmd2Wgi7CFbmiTmE3rwTCCaSlBwV+1Wsn2xRo/fkhN2ty5WYX3W3
         uFzE0+BMd3yIgdqJ6VE0olwiE68QHADgW/EBi0OJbyMZENIGgY1tlu99RMYujYHwQiNo
         oGa4QfgVIj5hUWq822Sq0daug/ASWPrY0CsyA+lKo+PAT4cIb3aymxPkRH1O4Mw9lVyW
         eWGTIkDZ70fTowkTNMzb06psPP2tNeyg13FYd8SC60bmDTL60ylamzeejHcONsxK6lYY
         T3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4B8J5esrFUm5kQo9wy0QxWh6m7I0euVc7kaRaYNQU0=;
        b=olCVLLATjCmNZWL/D+wX4SZvWbErSpZq9ZjSZz0oq22ce3PGJDHehlIaROlGNnRl0T
         6nwot3rzPrD3AanxwaW7AwQtuant6wmuZf53luk9r0Cx1MQbpzV25cVb/moSMjgUbXXj
         rLcvLpmoN9/+cDM9bmtoK3KoU7VfFuOfJk8uJstIQWY7NqfHHvPZ98juecMiq6/Ohm26
         OrVIUyhqoIpaZiE8pOKD7mAgfLZwdSEbpE7EcreNR75nbLT9DAQ5q7pbFv5U53QJ0m6n
         7VN+tE9eB74djlwoSymNlBJ5ypjlU+8Zt8Dd0F+cjyYRD7cxGq/u/r1fLzbMPFlvQPFI
         0mVw==
X-Gm-Message-State: AOAM532C5vGKYk8XLhuOor3I5TZKgp+fbkqXg0bbCUn+I6fIaU1omm5b
        GemN0ej9wFD9kz4LMx3dv9uKP3gGxg==
X-Google-Smtp-Source: ABdhPJywjQ/B9Dtl8+yLCl2smLq5/Ep0yPdjhDWOZ4YhnhsfkeGclp6U7aPdIWiKu7n83vnuOK+wcQ==
X-Received: by 2002:ad4:408b:: with SMTP id l11mr11332578qvp.156.1589729367173;
        Sun, 17 May 2020 08:29:27 -0700 (PDT)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id 63sm6234335qkh.120.2020.05.17.08.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 08:29:26 -0700 (PDT)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Brian Gerst <brgerst@gmail.com>
Subject: [PATCH 2/7] x86/percpu: Clean up percpu_to_op()
Date:   Sun, 17 May 2020 11:29:11 -0400
Message-Id: <20200517152916.3146539-3-brgerst@gmail.com>
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
 arch/x86/include/asm/percpu.h | 90 ++++++++++++++---------------------
 1 file changed, 35 insertions(+), 55 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 89f918a3e99b..233c7a78d1a6 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
 #define __pcpu_reg_imm_4(x) "ri" (x)
 #define __pcpu_reg_imm_8(x) "re" (x)
 
-#define percpu_to_op(qual, op, var, val)		\
-do {							\
-	typedef typeof(var) pto_T__;			\
-	if (0) {					\
-		pto_T__ pto_tmp__;			\
-		pto_tmp__ = (val);			\
-		(void)pto_tmp__;			\
-	}						\
-	switch (sizeof(var)) {				\
-	case 1:						\
-		asm qual (op "b %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "qi" ((pto_T__)(val)));		\
-		break;					\
-	case 2:						\
-		asm qual (op "w %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "ri" ((pto_T__)(val)));		\
-		break;					\
-	case 4:						\
-		asm qual (op "l %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "ri" ((pto_T__)(val)));		\
-		break;					\
-	case 8:						\
-		asm qual (op "q %1,"__percpu_arg(0)	\
-		    : "+m" (var)			\
-		    : "re" ((pto_T__)(val)));		\
-		break;					\
-	default: __bad_percpu_size();			\
-	}						\
+#define percpu_to_op(size, qual, op, _var, _val)			\
+do {									\
+	__pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);	\
+	if (0) {		                                        \
+		typeof(_var) pto_tmp__;					\
+		pto_tmp__ = (_val);					\
+		(void)pto_tmp__;					\
+	}								\
+	asm qual(__pcpu_op2_##size(op, "%[val]", __percpu_arg([var]))	\
+	    : [var] "+m" (_var)						\
+	    : [val] __pcpu_reg_imm_##size(pto_val__));			\
 } while (0)
 
 /*
@@ -425,18 +405,18 @@ do {									\
 #define raw_cpu_read_2(pcp)		percpu_from_op(, "mov", pcp)
 #define raw_cpu_read_4(pcp)		percpu_from_op(, "mov", pcp)
 
-#define raw_cpu_write_1(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_2(pcp, val)	percpu_to_op(, "mov", (pcp), val)
-#define raw_cpu_write_4(pcp, val)	percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_1(pcp, val)	percpu_to_op(1, , "mov", (pcp), val)
+#define raw_cpu_write_2(pcp, val)	percpu_to_op(2, , "mov", (pcp), val)
+#define raw_cpu_write_4(pcp, val)	percpu_to_op(4, , "mov", (pcp), val)
 #define raw_cpu_add_1(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_2(pcp, val)		percpu_add_op(, (pcp), val)
 #define raw_cpu_add_4(pcp, val)		percpu_add_op(, (pcp), val)
-#define raw_cpu_and_1(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_and_2(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_and_4(pcp, val)		percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_or_1(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_or_2(pcp, val)		percpu_to_op(, "or", (pcp), val)
-#define raw_cpu_or_4(pcp, val)		percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_and_1(pcp, val)		percpu_to_op(1, , "and", (pcp), val)
+#define raw_cpu_and_2(pcp, val)		percpu_to_op(2, , "and", (pcp), val)
+#define raw_cpu_and_4(pcp, val)		percpu_to_op(4, , "and", (pcp), val)
+#define raw_cpu_or_1(pcp, val)		percpu_to_op(1, , "or", (pcp), val)
+#define raw_cpu_or_2(pcp, val)		percpu_to_op(2, , "or", (pcp), val)
+#define raw_cpu_or_4(pcp, val)		percpu_to_op(4, , "or", (pcp), val)
 
 /*
  * raw_cpu_xchg() can use a load-store since it is not required to be
@@ -456,18 +436,18 @@ do {									\
 #define this_cpu_read_1(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_2(pcp)		percpu_from_op(volatile, "mov", pcp)
 #define this_cpu_read_4(pcp)		percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_write_1(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
-#define this_cpu_write_2(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
-#define this_cpu_write_4(pcp, val)	percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_1(pcp, val)	percpu_to_op(1, volatile, "mov", (pcp), val)
+#define this_cpu_write_2(pcp, val)	percpu_to_op(2, volatile, "mov", (pcp), val)
+#define this_cpu_write_4(pcp, val)	percpu_to_op(4, volatile, "mov", (pcp), val)
 #define this_cpu_add_1(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_2(pcp, val)	percpu_add_op(volatile, (pcp), val)
 #define this_cpu_add_4(pcp, val)	percpu_add_op(volatile, (pcp), val)
-#define this_cpu_and_1(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_and_2(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_and_4(pcp, val)	percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_or_1(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
-#define this_cpu_or_2(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
-#define this_cpu_or_4(pcp, val)		percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_and_1(pcp, val)	percpu_to_op(1, volatile, "and", (pcp), val)
+#define this_cpu_and_2(pcp, val)	percpu_to_op(2, volatile, "and", (pcp), val)
+#define this_cpu_and_4(pcp, val)	percpu_to_op(4, volatile, "and", (pcp), val)
+#define this_cpu_or_1(pcp, val)		percpu_to_op(1, volatile, "or", (pcp), val)
+#define this_cpu_or_2(pcp, val)		percpu_to_op(2, volatile, "or", (pcp), val)
+#define this_cpu_or_4(pcp, val)		percpu_to_op(4, volatile, "or", (pcp), val)
 #define this_cpu_xchg_1(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_2(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_xchg_4(pcp, nval)	percpu_xchg_op(volatile, pcp, nval)
@@ -509,19 +489,19 @@ do {									\
  */
 #ifdef CONFIG_X86_64
 #define raw_cpu_read_8(pcp)			percpu_from_op(, "mov", pcp)
-#define raw_cpu_write_8(pcp, val)		percpu_to_op(, "mov", (pcp), val)
+#define raw_cpu_write_8(pcp, val)		percpu_to_op(8, , "mov", (pcp), val)
 #define raw_cpu_add_8(pcp, val)			percpu_add_op(, (pcp), val)
-#define raw_cpu_and_8(pcp, val)			percpu_to_op(, "and", (pcp), val)
-#define raw_cpu_or_8(pcp, val)			percpu_to_op(, "or", (pcp), val)
+#define raw_cpu_and_8(pcp, val)			percpu_to_op(8, , "and", (pcp), val)
+#define raw_cpu_or_8(pcp, val)			percpu_to_op(8, , "or", (pcp), val)
 #define raw_cpu_add_return_8(pcp, val)		percpu_add_return_op(, pcp, val)
 #define raw_cpu_xchg_8(pcp, nval)		raw_percpu_xchg_op(pcp, nval)
 #define raw_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(, pcp, oval, nval)
 
 #define this_cpu_read_8(pcp)			percpu_from_op(volatile, "mov", pcp)
-#define this_cpu_write_8(pcp, val)		percpu_to_op(volatile, "mov", (pcp), val)
+#define this_cpu_write_8(pcp, val)		percpu_to_op(8, volatile, "mov", (pcp), val)
 #define this_cpu_add_8(pcp, val)		percpu_add_op(volatile, (pcp), val)
-#define this_cpu_and_8(pcp, val)		percpu_to_op(volatile, "and", (pcp), val)
-#define this_cpu_or_8(pcp, val)			percpu_to_op(volatile, "or", (pcp), val)
+#define this_cpu_and_8(pcp, val)		percpu_to_op(8, volatile, "and", (pcp), val)
+#define this_cpu_or_8(pcp, val)			percpu_to_op(8, volatile, "or", (pcp), val)
 #define this_cpu_add_return_8(pcp, val)		percpu_add_return_op(volatile, pcp, val)
 #define this_cpu_xchg_8(pcp, nval)		percpu_xchg_op(volatile, pcp, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval)	percpu_cmpxchg_op(volatile, pcp, oval, nval)
-- 
2.25.4

