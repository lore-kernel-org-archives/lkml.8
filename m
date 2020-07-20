Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC14C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B685122B4E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYYPB8p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgGTUts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgGTUts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:49:48 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ACBC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:49:47 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id b69so13489947pfb.14
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ac83xydEfYdvLnMrJP/6mCcgSl/ZzWMIDDapcG1OTQM=;
        b=JYYPB8p5iFY3MWf4GNM8ckYki4GjyRtkNH0mEHHR6DuTXDz7v7vhNYqSLMKWEpIxpk
         67SB7uVG5diSpuJU9VIA+1E7xEiXuw4VQd/KY2svSaTM2z9wPWEkKmWmCJyXmRqdXmF7
         trgYDOyoqDppd4svcJADvNjOmp6UbmHw2OPek+BF0bAro4xX5Z4j4CgUg0LFFEKPQeGt
         Yl1oAy6z985PPupmzxMiHAzp98NNo3TH8DRKPJZ07XY7n0W2TVbpLo5WQoGoby8h9Lqd
         Tl+mXCah0XlpzwdBdghBPcpk0QCgZqmp+6UVpFb3ikPBSRDHA7l03Vv3hgoQbiWPaZmo
         cEEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ac83xydEfYdvLnMrJP/6mCcgSl/ZzWMIDDapcG1OTQM=;
        b=cyQ29MKF3F5f/IoIH3Uuv77OQZilScilRzNmBjMDebQOI3Mg0qNiJJBIDeDCZtThkI
         X+16+PKu4tPzba8J4/kQ89pCWXPY3JYt8Lso+eGROdtfrwyzI+04NE40GP++8Gi3FEeD
         U0uHNE6mkehczmdj9kaPz4jxIc+OabVG6M3msMqswA8fLFAoW4iRWLQ1imsznQyaWwCt
         E8AVFOewuy/jNZK8VmOOPJIfqfJHrYQ1RuWbndLtUHvfww7S0FDIHmmh/Vy0Q9NMbDxr
         TmIL8OlGxM4gZt+oxF1c3f9eiPRFSVeZ6FXYhtzLm+jxR8P5Oc7NfzwWYhJuYa8ycxRd
         rxoQ==
X-Gm-Message-State: AOAM533EtoqfTzBXhRGcx/Rx4OExYEc1KdzKbPGcE9DcopzL8DOhypWU
        TWISlU1pHo8Kb8/EfAtqZ0s+QLtlEUDDxdn87ek=
X-Google-Smtp-Source: ABdhPJw98Zd0E/0WiYRTH3b0fYqoMSHEZvRfmY7LV+yC1lJ+AOF/FHu3Mz/4q19YkYVCqUSDGi0fX2CJAgS2AsOD1VM=
X-Received: by 2002:a17:90a:d48a:: with SMTP id s10mr1102818pju.116.1595278187193;
 Mon, 20 Jul 2020 13:49:47 -0700 (PDT)
Date:   Mon, 20 Jul 2020 13:49:15 -0700
In-Reply-To: <20200720204925.3654302-1-ndesaulniers@google.com>
Message-Id: <20200720204925.3654302-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 01/11] x86/percpu: Introduce size abstraction macros
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <brgerst@gmail.com>

In preparation for cleaning up the percpu operations, define macros for
abstraction based on the width of the operation.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797c769d..19838e4f7a8f 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -87,6 +87,36 @@
  * don't give an lvalue though). */
 extern void __bad_percpu_size(void);
 
+#define __pcpu_type_1 u8
+#define __pcpu_type_2 u16
+#define __pcpu_type_4 u32
+#define __pcpu_type_8 u64
+
+#define __pcpu_cast_1(val) ((u8)(((unsigned long) val) & 0xff))
+#define __pcpu_cast_2(val) ((u16)(((unsigned long) val) & 0xffff))
+#define __pcpu_cast_4(val) ((u32)(((unsigned long) val) & 0xffffffff))
+#define __pcpu_cast_8(val) ((u64)(val))
+
+#define __pcpu_op1_1(op, dst) op "b " dst
+#define __pcpu_op1_2(op, dst) op "w " dst
+#define __pcpu_op1_4(op, dst) op "l " dst
+#define __pcpu_op1_8(op, dst) op "q " dst
+
+#define __pcpu_op2_1(op, src, dst) op "b " src ", " dst
+#define __pcpu_op2_2(op, src, dst) op "w " src ", " dst
+#define __pcpu_op2_4(op, src, dst) op "l " src ", " dst
+#define __pcpu_op2_8(op, src, dst) op "q " src ", " dst
+
+#define __pcpu_reg_1(mod, x) mod "q" (x)
+#define __pcpu_reg_2(mod, x) mod "r" (x)
+#define __pcpu_reg_4(mod, x) mod "r" (x)
+#define __pcpu_reg_8(mod, x) mod "r" (x)
+
+#define __pcpu_reg_imm_1(x) "qi" (x)
+#define __pcpu_reg_imm_2(x) "ri" (x)
+#define __pcpu_reg_imm_4(x) "ri" (x)
+#define __pcpu_reg_imm_8(x) "re" (x)
+
 #define percpu_to_op(qual, op, var, val)		\
 do {							\
 	typedef typeof(var) pto_T__;			\
-- 
2.28.0.rc0.105.gf9edc3c819-goog

