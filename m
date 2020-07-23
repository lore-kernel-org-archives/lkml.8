Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC65C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 977E120737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zzt73+wd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yLPlHr3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgGWKnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:43:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57048 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgGWKnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:43:42 -0400
Date:   Thu, 23 Jul 2020 10:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xgn/PBeBQmOoAg0U/oX6YBE51LNtdNydLKBKAukUbM0=;
        b=Zzt73+wd+EJDZW4+wiA0hJh4wGCe5ZYqSyU/8/7bUrGLbGRHe3KRwgf4FaSnJsRLvW93eG
        T3WJJs2sRxxj9SKAwFk5+3Oali7W1a9Jlls9odgyZMN9nOkkuLKNE4Dx1wToRfXm9EINSr
        Sxu90+hkX4MZeRPVY8gHwyEqhfSSCC1o6kBD1+5YvSc9Q+CFD8waDnbyJmoyF87Ioc6nb/
        ElGdbffXC/8/MVKhUA3qe6Xwx7P5CrMtmCpaevyGUsYCrEdzJbza/0zgqp9Qh1kFPMc+eq
        hvQclSv+n00bTA+avlZ9as/eUqevFt86SAhgB5ptyI6VzNoQNK1WUoBMpxxxsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501019;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xgn/PBeBQmOoAg0U/oX6YBE51LNtdNydLKBKAukUbM0=;
        b=yLPlHr3n3vDGga4rqAOJ9iGTexXhKx+izX7A5enA7oweoszCsJ41w3V1x5SbJaSyJDt0CT
        f7tKpwt6eluDSbAg==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/uaccess: Make __get_user_size() Clang compliant on 32-bit
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720204925.3654302-12-ndesaulniers@google.com>
References: <20200720204925.3654302-12-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <159550101883.4006.16106494273357713858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     158807de5822d1079e162a3762956fd743dd483e
Gitweb:        https://git.kernel.org/tip/158807de5822d1079e162a3762956fd743dd483e
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Mon, 20 Jul 2020 13:49:25 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jul 2020 12:38:31 +02:00

x86/uaccess: Make __get_user_size() Clang compliant on 32-bit

Clang fails to compile __get_user_size() on 32-bit for the following code:

      long long val;

      __get_user(val, usrptr);

with: error: invalid output size for constraint '=q'

GCC compiles the same code without complaints.

The reason is that GCC and Clang are architecturally different, which leads
to subtle issues for code that's invalid but clearly dead, i.e. with code
that emulates polymorphism with the preprocessor and sizeof.

GCC will perform semantic analysis after early inlining and dead code
elimination, so it will not warn on invalid code that's dead. Clang
strictly performs optimizations after semantic analysis, so it will warn
for dead code.

Neither Clang nor GCC like this very much with -m32:

long long ret;
asm ("movb $5, %0" : "=q" (ret));

However, GCC can tolerate this variant:

long long ret;
switch (sizeof(ret)) {
case 1:
        asm ("movb $5, %0" : "=q" (ret));
        break;
case 8:;
}

Clang, on the other hand, won't accept that because it validates the inline
asm for the '1' case before the optimisation phase where it realises that
it wouldn't have to emit it anyway.

If LLVM (Clang's "back end") fails such as during instruction selection or
register allocation, it cannot provide accurate diagnostics (warnings /
errors) that contain line information, as the AST has been discarded from
memory at that point.

While there have been early discussions about having C/C++ specific
language optimizations in Clang via the use of MLIR, which would enable
such earlier optimizations, such work is not scoped and likely a multi-year
endeavor.

It was discussed to change the asm output constraint for the one byte case
from "=q" to "=r". While it works for 64-bit, it fails on 32-bit. With '=r'
the compiler could fail to chose a register accessible as high/low which is
required for the byte operation. If that happens the assembly will fail.

Use a local temporary variable of type 'unsigned char' as output for the
byte copy inline asm and then assign it to the real output variable. This
prevents Clang from failing the semantic analysis in the above case.

The resulting code for the actual one byte copy is not affected as the
temporary variable is optimized out.

[ tglx: Amended changelog ]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reported-by: David Woodhouse <dwmw2@infradead.org>
Reported-by: Dmitry Golovin <dima@golovin.in>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Acked-by: Dennis Zhou <dennis@kernel.org>
Link: https://bugs.llvm.org/show_bug.cgi?id=33587
Link: https://github.com/ClangBuiltLinux/linux/issues/3
Link: https://github.com/ClangBuiltLinux/linux/issues/194
Link: https://github.com/ClangBuiltLinux/linux/issues/781
Link: https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
Link: https://lore.kernel.org/lkml/CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com/
Link: https://lkml.kernel.org/r/20200720204925.3654302-12-ndesaulniers@google.com
---
 arch/x86/include/asm/uaccess.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 18dfa07..2f3e8f2 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -314,11 +314,14 @@ do {									\
 
 #define __get_user_size(x, ptr, size, retval)				\
 do {									\
+	unsigned char x_u8__;						\
+									\
 	retval = 0;							\
 	__chk_user_ptr(ptr);						\
 	switch (size) {							\
 	case 1:								\
-		__get_user_asm(x, ptr, retval, "b", "=q");		\
+		__get_user_asm(x_u8__, ptr, retval, "b", "=q");		\
+		(x) = x_u8__;						\
 		break;							\
 	case 2:								\
 		__get_user_asm(x, ptr, retval, "w", "=r");		\
