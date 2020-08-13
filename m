Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9236AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541AA207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cE9ovcxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHMAMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHMAMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 20:12:46 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC45C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:12:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so1842257plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rQ8RM01rFuZ8r/9BI4QTmJ2mrQfdhz3BxI3jO3ju76Q=;
        b=cE9ovcxBiRGz0uXy2XKVJmWc7XIlmD45kR5rrmAxADG7T4zw7CkmABVyuazB0+QHRd
         t9xqJoxRoO5wSiQE9v06cB4f2zMx3PUz2tZ/idxeuwk46j78tailuIybnOIJM8NenufU
         1p6haO7msyzgULG05Ko2R6OSMVorHq5A+ntwDm6dBwr69H7Q4vv/GsALei+dt7k7mkKh
         0B7mZgBhsQfTHtg4+t6bhnL7fqaYhFYwh5O2LasArHY4yurENVwCHknsmbe5Ni4nSWoU
         5sygthBh4LfS+K7RmfSjftviv2dceJZllWrliH99Fi9JFhLM7H70ZP0vCQM4eu6614yx
         3eMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rQ8RM01rFuZ8r/9BI4QTmJ2mrQfdhz3BxI3jO3ju76Q=;
        b=ZdbSwJH0genVfDGwA95GxjRKN5Nsjpkci38Y8AjLBFB2OWp3Bpih2Fr/9V03xxIV/Q
         8GULm0F+HgiDy7+ruNPrOLnxHNra5/p/WbsW1B0uDvt75Ur1cPjYJ7A3wcXzp4FNO+ql
         +arCStBc8tk7Xbsi5JJvwQRQaBEz3Ir1ItGbNdcD0WdcD07O4C0B0Q3GHLYjrRFJ2fCc
         E6oifm7tFAXsFzpZmbqsDkH4/s3us57fnhVqvAfK1yAAkkduXEXfXDNwpVyTB38uWjje
         FKPailwJG0mxdGYjrFOgjejsJnHCiWhcjgSRpWgs2dLNCnE0JSEiqV4DX7lYkiYscqPs
         ynFg==
X-Gm-Message-State: AOAM530O41RwCnMSA0JHHYdNaukmTBt1IsU8JxAF9bpnrUtETIIBt+VG
        FpSD4j0rphCECKnit6/8TbV3QdUW4LqOzJ0R0RXc5g==
X-Google-Smtp-Source: ABdhPJwRZ0UP26/3ePd4nNlPoGIzSsfqNzNfqQ2ZOAr7dDUNAwmhf0ZlexWKbxA24bkpPFoA1CKn6IKF/RlfOyKUVdI=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr2316606pjc.25.1597277565702;
 Wed, 12 Aug 2020 17:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <878serh1b9.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878serh1b9.fsf@nanos.tec.linutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 12 Aug 2020 17:12:34 -0700
Message-ID: <CAKwvOdnOh3H3ga2qpTktywvcgfXW5QJaB7r4XMhigmDzLhDNeA@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:11 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Arnd Bergmann <arnd@arndb.de> writes:
> > When using the clang integrated assembler, we get a reference
> > to __force_order that should normally get ignored in a few
> > rare cases:
> >
> > ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!
> >
> > Add a 'static' definition so any file in which this happens can
> > have a local copy.
>
> That's a horrible hack.

Agreed.  And static means everyone gets their own copy, rather than
sharing one memory address.  I guess no one actually writes to it, so
it doesn't really matter, but __force_order just seems so strange to
me.

> And the only reason why it does not trigger -Wunused-variable warnings
> all over the place is because it's "referenced" in unused inline
> functions and then optimized out along with the unused inlines.
>
> >   * It is not referenced from the code, but GCC < 5 with -fPIE would fail
> >   * due to an undefined symbol. Define it to make these ancient GCCs
> >   work.
>
> Bah, we really should have moved straight to GCC5 instead of upping it
> just to 4.9
>
> > + *
> > + * Clang sometimes fails to kill the reference to the dummy variable, so
> > + * provide an actual copy.
>
> Can that compiler be fixed instead?

I don't think so. The logic in the compiler whether to emit an
"address is significant" assembler directive is based on whether the
variable is "used."  The "use" of `__force_order` is as output of all
of these control register read/write functions' inline asm, even
though the inline asm doesn't actually write to them.  We'd have to
peek inside of the inline asm and build "use/def chains" for the
inline asm, to see that you don't actually use the output variable.
Best we can do is see it listed as an output to the inline asm
statement.  And if you reference an `extern` variable, it should be no
wonder that you can get undefined symbol linkage failures.

I'd much rather remove all of __force_order.

>
> Aside of that is there a reason to make this 'static' thing wrapped in
> #ifdeffery? A quick check with GCC8.3 just works. But maybe 4.9 gets
> unhappy. Can't say due to: -ENOANCIENTCOMPILER :)

From the comment in arch/x86/boot/compressed/pgtable_64.c, there's a
hint that maybe gcc < 5 and -pie (CONFIG_RANDOMIZE_BASE?) would fail
due to undefined symbol, though I'm not sure which symbol the comment
is referring to.  If it's __force_order, then removing outright likely
fixes that issue.

Not sure about the comment in arch/x86/include/asm/special_insns.h
either; smells fishy like a bug with a compiler from a long time ago.
It looks like it was introduced in:
commit d3ca901f94b32 ("x86: unify paravirt parts of system.h")
Lore has this thread:
https://lore.kernel.org/lkml/4755A809.4050305@qumranet.com/
Patch 4: https://lore.kernel.org/lkml/11967844071346-git-send-email-gcosta@redhat.com/
It seems like there was a discussion about %cr8, but no one asked
"what's going on here with __force_order, is that right?"
Latest GCC release on December 4 2007 would have been GCC 4.2.2 according to:
https://gcc.gnu.org/releases.html

Quick boot test of the below works for me, though I should probably
test hosting a virtualized guest since d3ca901f94b32 refers to
paravirt.  Thoughts?
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -5,15 +5,6 @@
 #include "pgtable.h"
 #include "../string.h"

-/*
- * __force_order is used by special_insns.h asm code to force instruction
- * serialization.
- *
- * It is not referenced from the code, but GCC < 5 with -fPIE would fail
- * due to an undefined symbol. Define it to make these ancient GCCs work.
- */
-unsigned long __force_order;
-
 #define BIOS_START_MIN         0x20000U        /* 128K, less than
this is insane */
 #define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */

diff --git a/arch/x86/include/asm/special_insns.h
b/arch/x86/include/asm/special_insns.h
index 59a3e13204c3..d2e0d53b0f69 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -10,46 +10,37 @@
 #include <linux/irqflags.h>
 #include <linux/jump_label.h>

-/*
- * Volatile isn't enough to prevent the compiler from reordering the
- * read/write functions for the control registers and messing everything up.
- * A memory clobber would solve the problem, but would prevent reordering of
- * all loads stores around it, which can hurt performance. Solution is to
- * use a variable and mimic reads and writes to it to enforce serialization
- */
-extern unsigned long __force_order;
-
 void native_write_cr0(unsigned long val);

 static inline unsigned long native_read_cr0(void)
 {
        unsigned long val;
-       asm volatile("mov %%cr0,%0\n\t" : "=r" (val), "=m" (__force_order));
+       asm volatile("mov %%cr0,%0\n\t" : "=r" (val));
        return val;
 }

 static __always_inline unsigned long native_read_cr2(void)
 {
        unsigned long val;
-       asm volatile("mov %%cr2,%0\n\t" : "=r" (val), "=m" (__force_order));
+       asm volatile("mov %%cr2,%0\n\t" : "=r" (val));
        return val;
 }

 static __always_inline void native_write_cr2(unsigned long val)
 {
-       asm volatile("mov %0,%%cr2": : "r" (val), "m" (__force_order));
+       asm volatile("mov %0,%%cr2": : "r" (val));
 }

 static inline unsigned long __native_read_cr3(void)
 {
        unsigned long val;
-       asm volatile("mov %%cr3,%0\n\t" : "=r" (val), "=m" (__force_order));
+       asm volatile("mov %%cr3,%0\n\t" : "=r" (val));
        return val;
 }

 static inline void native_write_cr3(unsigned long val)
 {
-       asm volatile("mov %0,%%cr3": : "r" (val), "m" (__force_order));
+       asm volatile("mov %0,%%cr3": : "r" (val));
 }

 static inline unsigned long native_read_cr4(void)
@@ -64,10 +55,10 @@ static inline unsigned long native_read_cr4(void)
        asm volatile("1: mov %%cr4, %0\n"
                     "2:\n"
                     _ASM_EXTABLE(1b, 2b)
-                    : "=r" (val), "=m" (__force_order) : "0" (0));
+                    : "=r" (val) : "0" (0));
 #else
        /* CR4 always exists on x86_64. */
-       asm volatile("mov %%cr4,%0\n\t" : "=r" (val), "=m" (__force_order));
+       asm volatile("mov %%cr4,%0\n\t" : "=r" (val));
 #endif
        return val;
 }
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 965474d78cef..ba9b5234cf44 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -358,7 +358,7 @@ void native_write_cr0(unsigned long val)
        unsigned long bits_missing = 0;

 set_register:
-       asm volatile("mov %0,%%cr0": "+r" (val), "+m" (__force_order));
+       asm volatile("mov %0,%%cr0": "+r" (val));

        if (static_branch_likely(&cr_pinning)) {
                if (unlikely((val & X86_CR0_WP) != X86_CR0_WP)) {
-- 
Thanks,
~Nick Desaulniers
