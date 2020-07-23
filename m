Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52990C433ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F55C20737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qXoZM4Cl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x70bXklA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgGWKn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57136 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgGWKnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:47 -0400
Date:   Thu, 23 Jul 2020 10:43:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMyfr3U78lbbM7ujA5CuzC2VlJEsKtAQ4GQXVttpFvE=;
        b=qXoZM4ClhxUBBoMSkmKI/6fKeCXOzx4HsyKP8UPwiU0ZCftcVcdM8mzk0J0uYgWecuW+As
        bf0TpBGO3hJP2m3gykjJygDcU/iXMZWimGmo/PE3bFyabqPxl7FuKQBdZqftZxhqSq/i3W
        fWJ8FzAFSPTFER1W6dqRHNY5ZIIpzoRY0PguyQJD2lXTM2ffm6XwQ6bRsjMlb3BGKLE3kf
        TVdgzHZDulPfJ0h3k8/A/JKhkOx9AYY38sirdAMurbNDecDs5wgexIUBnU7EvIOZpDK/Yq
        XUT8b4uXeQKfLyTQfVa9bzaD2+VC5aLGUX+bdXRIyB+mQhX60ikp60tOsZyVAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HMyfr3U78lbbM7ujA5CuzC2VlJEsKtAQ4GQXVttpFvE=;
        b=x70bXklA7N5FXcDYJp9ideoLoKe1FXmZ5tZOqwaWCgyy0GeF5vok+H0XiEwca673PNzIS4
        9IBljRU+0CQajVCA==
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/percpu: Introduce size abstraction macros
Cc:     Brian Gerst <brgerst@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-2-ndesaulniers@google.com>
References: <20200720204925.3654302-2-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550102479.4006.239690933685862718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     6865dc3ae93b9acb336ca48bd7b2db3446d89370
Gitweb:        https://git.kernel.org/tip/6865dc3ae93b9acb336ca48bd7b2db3446d89370
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:15 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 11:46:39 +02:00

x86/percpu: Introduce size abstraction macros

In preparation for cleaning up the percpu operations, define macros for
abstraction based on the width of the operation.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://lkml.kernel.org/r/20200720204925.3654302-2-ndesaulniers@google.com

---
 arch/x86/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index 2278797..19838e4 100644
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
