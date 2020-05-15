Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90630C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 707FD20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qt025oqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgEOSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgEOSGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:06:32 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF37C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:06:31 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id l4so3124984qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=L/+EYSk36TST2rIE8NznK9E9+/xuLx5a1Z0fVdYAEAY=;
        b=qt025oqxlccbdZIKGGePBSeQj+NCxNAypwS2fm5s7SgZ9lqy37Pi84+SlnfTpTPOsS
         mxf/QQ6AGrrgLzSDCrVT4/cEDTlfMi9DB5vYjzvQc1T5BITZyPJ3ngCJVIxbe0dW6EWt
         Zgevf/JvOHpzF+Lju6skjTrB35btnsBv7iPqTWYOabX0KXaTtScs0pH9A/MKWDCFRsS0
         MBDhM5W5wPiIAZMb3lDPa7wANlc8OoW52cAsqIthcJEalPRg3FQ+nDjhS9JFXnAcFp23
         Pb6tahUikecLS3UQTpHQK1WfVZCpnocrhUdU6RaRIHm1StsLfZazMj25CINrYUIoemZO
         FlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=L/+EYSk36TST2rIE8NznK9E9+/xuLx5a1Z0fVdYAEAY=;
        b=ZpMNnEEyHxXB7euj8qwCKY5oLXIdzh2pq4Fi1C/f0RV2tlWqIr7E8Hwek4guiAiScd
         DUYUKvlTwCJFysfdBL/GD9rNq8jt8WQjgEEBQ+2gt4t3DskIvt7tTG99/fs7GcxVvsQ7
         ekdk5elndFwgCKZBoMtCNP0lyeCAIQzkI7vxdKOX/dcBzCMvoTLCrq1RVb0am1ZQy5A6
         cuW8LZlhyaQLvCy4gQmAY5n8TDvBJkcVdUkyXTigrGIBL9pfM1XWURXHAIdp4DrtTZ38
         yhm9zdgRYX2aVMoakvaeke1eEdln+SiPzode87sCTQwPmqSnlLb4OB9DSbx14uhv0SGO
         3wDg==
X-Gm-Message-State: AOAM533l4HghpJWdRYj9LXjzr2WDyr1hgiuCuVZx+BHdJP1ijpnQmq8r
        Q76s2u2lRW2+t4PjHHCEGKpYuK8ZoiGics8=
X-Google-Smtp-Source: ABdhPJxFCN+Odlk5Gn6l7v7mBMxOuNoAeU0ranBO58vemtSSApbHPxzmBLZpaewrmv5lJAR3lpJ4ZAm+4ElEfMU=
X-Received: by 2002:a0c:9c4f:: with SMTP id w15mr4602062qve.245.1589565990696;
 Fri, 15 May 2020 11:06:30 -0700 (PDT)
Date:   Fri, 15 May 2020 11:05:40 -0700
Message-Id: <20200515180544.59824-1-inglorion@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH] x86_64: fix jiffies ODR violation
From:   Bob Haarman <inglorion@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Fangrui Song <maskray@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Bob Haarman <inglorion@google.com>, stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alistair Delva <adelva@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Baoquan He <bhe@redhat.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Ross Zwisler <zwisler@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`jiffies` and `jiffies_64` are meant to alias (two different symbols
that share the same address).  Most architectures make the symbols alias
to the same address via linker script assignment in their
arch/<arch>/kernel/vmlinux.lds.S:

jiffies = jiffies_64;

which is effectively a definition of jiffies.

jiffies and jiffies_64 are both forward declared for all arch's in:
include/linux/jiffies.h.

jiffies_64 is defined in kernel/time/timer.c for all arch's.

x86_64 was peculiar in that it wasn't doing the above linker script
assignment, but rather was:
1. defining jiffies in arch/x86/kernel/time.c instead via linker script.
2. overriding the symbol jiffies_64 from kernel/time/timer.c in
arch/x86/kernel/vmlinux.lds.s via `jiffies_64 = jiffies;`.

As Fangrui notes:
```
In LLD, symbol assignments in linker scripts override definitions in
object files. GNU ld appears to have the same behavior. It would
probably make sense for LLD to error "duplicate symbol" but GNU ld is
unlikely to adopt for compatibility reasons.
```

So we have an ODR violation (UB), which we seem to have gotten away
with thus far. Where it becomes harmful is when we:

1. Use -fno-semantic-interposition.

As Fangrui notes:
```
Clang after LLVM
commit 5b22bcc2b70d ("[X86][ELF] Prefer to lower MC_GlobalAddress
operands to .Lfoo$local")
defaults to -fno-semantic-interposition similar semantics which help
-fpic/-fPIC code avoid GOT/PLT when the referenced symbol is defined
within the same translation unit. Unlike GCC
-fno-semantic-interposition, Clang emits such relocations referencing
local symbols for non-pic code as well.
```

This causes references to jiffies to refer to `.Ljiffies$local` when
jiffies is defined in the same translation unit. Likewise, references
to jiffies_64 become references to `.Ljiffies_64$local` in translation
units that define jiffies_64.  Because these differ from the names
used in the linker script, they will not be rewritten to alias one
another.

Combined with ...

2. Full LTO effectively treats all source files as one translation
unit, causing these local references to be produced everywhere.  When
the linker processes the linker script, there are no longer any
references to `jiffies_64` anywhere to replace with `jiffies`.  And
thus `.Ljiffies$local` and `.Ljiffies_64$local` no longer alias
at all.

In the process of porting patches enabling Full LTO from arm64 to
x86_64, we observe spooky bugs where the kernel appeared to boot, but
init doesn't get scheduled.

Instead, we can avoid the ODR violation by matching other arch's by
defining jiffies only by linker script.  For -fno-semantic-interposition
+ Full LTO, there is no longer a global definition of jiffies for the
compiler to produce a local symbol which the linker script won't ensure
aliases to jiffies_64.

Link: https://github.com/ClangBuiltLinux/linux/issues/852
Fixes: 40747ffa5aa8 ("asmlinkage: Make jiffies visible")
Cc: stable@vger.kernel.org
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: Alistair Delva <adelva@google.com>
Suggested-by: Fangrui Song <maskray@google.com>
Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
Debugged-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Bob Haarman <inglorion@google.com>
---
 arch/x86/kernel/time.c        | 4 ----
 arch/x86/kernel/vmlinux.lds.S | 4 ++--
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 371a6b348e44..e42faa792c07 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -25,10 +25,6 @@
 #include <asm/hpet.h>
 #include <asm/time.h>
 
-#ifdef CONFIG_X86_64
-__visible volatile unsigned long jiffies __cacheline_aligned_in_smp = INITIAL_JIFFIES;
-#endif
-
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 1bf7e312361f..7c35556c7827 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -40,13 +40,13 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 #ifdef CONFIG_X86_32
 OUTPUT_ARCH(i386)
 ENTRY(phys_startup_32)
-jiffies = jiffies_64;
 #else
 OUTPUT_ARCH(i386:x86-64)
 ENTRY(phys_startup_64)
-jiffies_64 = jiffies;
 #endif
 
+jiffies = jiffies_64;
+
 #if defined(CONFIG_X86_64)
 /*
  * On 64-bit, align RODATA to 2MB so we retain large page mappings for
-- 
2.26.2.761.g0e0b3e54be-goog

