Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96916C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E2220792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 00:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+Kr/xh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgHDAJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 20:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgHDAJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 20:09:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ABCC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 17:09:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so1019438pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kNl+hfthpZUs0DMOrCZCaKc5u5G5K72jxV4KQTYuVI=;
        b=h+Kr/xh55EdeFvbqOwH1qCgT1MJDbkdSzzssRi3J4SJdcUBk753LMdTmgqZyGQpsDY
         46RBxRJlBKw1ZJYSvY4LRP47rHRGbfXaav26RKpxEUYSY0F3ERbM9ibuDX7FGBNwIZA1
         0Ei634B0IFroOMhs2tQFcZGngvzXA2Wk87NxtzMXDxLR/dA6Tx87Bbh1F2SrN8gjcs2K
         S1gLr3LftmQhYxYcR4aqaahXB6eLW90v4jbQRD41h7MFz8355d1jtzfur4XFJ0gr2OYf
         pTbMVCnyvk/WoVOBbuFffZJ8Uv0LlHs/X+lCgqcHyjfxDvO95+/if5qi6gsCe7SX1wGm
         01kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6kNl+hfthpZUs0DMOrCZCaKc5u5G5K72jxV4KQTYuVI=;
        b=RELgFj6GGrMrnllrGgtGTY6mfMFjKzzuz325I+CXn//8sSdIG44EBmTtXVfBT62L6x
         FP3TCjVlZo83cnRouKDazG3yCd5OT7HGXk1b1ADNHEc56NYlOKmXbT4Ts3ZaA84ElgPN
         IFrxzjf2JFMnfFZOD4d3s7n3sF6FdtRExJkxG0kellQH2/smCHrPNJtLtiCQbP1M7C5p
         Gdp0xokfkJcakBgW+WqWh8UqWIwAKtunekwQIbMz2fU/Q2d5UZfc9rwvyoUGDgNa5LEM
         UzdzBobkJLHjDpNO03QfEIk05eql1UhWVLekaCcOLYsQaLP+pB5BGLlX/fiPLusOypn8
         4enQ==
X-Gm-Message-State: AOAM532hqrDADzEj2eRwyFXPu0UZxXjRz7g+dnJ8JSLKecDFRv9gYkZ0
        Jl0v+zJV2IfScbY6QEFUUSbSac6d+uA1pq9olNY8Fg==
X-Google-Smtp-Source: ABdhPJxDSR8antHhVh9I3l5jSU6w3VkeDO6x8aJ76Qsk2fqKrtcDE4aVMHZL8zCg5MNTpQ98tUaApHLpCv7ATD+aI+s=
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr16563102ply.223.1596499785878;
 Mon, 03 Aug 2020 17:09:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de>
In-Reply-To: <20200527135329.1172644-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 3 Aug 2020 17:09:34 -0700
Message-ID: <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Arnd Bergmann <arnd@arndb.de>, Peter Collingbourne <pcc@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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

On Wed, May 27, 2020 at 6:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When using the clang integrated assembler, we get a reference
> to __force_order that should normally get ignored in a few
> rare cases:
>
> ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!
>
> Add a 'static' definition so any file in which this happens can
> have a local copy.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,
Looks like
$ ARCH=i386 make CC=clang LLVM_IAS=1 -j71
defconfig+CONFIG_X86_POWERNOW_K6=m
is the simplest reproducer.

If I run
$ llvm-readelf -s drivers/cpufreq/powernow-k6.o | grep __force_order
    39: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __force_order
we can indeed see an undefined reference to __force_order.

If I build the .s file via
$ ARCH=i386 make CC=clang LLVM_IAS=1 -j71 drivers/cpufreq/powernow-k6.s
the only reference I see to __force_order is:
979   .addrsig_sym __force_order

which is created by Clang's implicit -faddr-sig.  If I disable that
for this file via:

```diff
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index f1b7e3dd6e5d..87d655d5af49 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -28,6 +28,9 @@ obj-$(CONFIG_X86_ACPI_CPUFREQ)                +=
acpi-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
 obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
 obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
+ifdef CONFIG_CC_IS_CLANG
+CFLAGS_powernow-k6.o                   += -fno-addrsig
+endif
 obj-$(CONFIG_X86_POWERNOW_K7)          += powernow-k7.o
 obj-$(CONFIG_X86_LONGHAUL)             += longhaul.o
 obj-$(CONFIG_X86_E_POWERSAVER)         += e_powersaver.o
```
then the module links without error, and we get no hits for
__force_order from llvm-readelf -s.  This makes me think there may be
a bug in Clang generating address significance tables for global
variables that are otherwise unused, resulting in such linkage
failures. +pcc@ for that.

I ran a creduce job on drivers/cpufreq/powernow-k6.i where I'd compile
twice, one with the implicit default value of -faddr-sig and look for
the undefined __force_order, and again with -fno-addrsig and ensure
there was no undefined __force_order, which coughed up:
extern int __force_order;
int a(void) { asm("" : "=m"(__force_order)); return 0; }
as the bare minimum for an address significant table.
https://godbolt.org/z/cjfaqM

I'll bet this is coming from the call to read_cr0() in
powernow_k6_set_cpu_multiplier().  If __force_order is defined in
arch/x86/boot/compressed/pgtable_64.c, then I'm not sure it's a good
idea to build drivers/cpufreq/powernow-k6.c as a kernel module
(CONFIG_X86_POWERNOW_K6=m) vs statically compiled in.  Wouldn't
__force_order need to be EXPORT'ed for kernel modules to use it
safely?

> ---
>  arch/x86/boot/compressed/pgtable_64.c | 2 ++
>  arch/x86/include/asm/special_insns.h  | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index c8862696a47b..8595194cea41 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -12,7 +12,9 @@
>   * It is not referenced from the code, but GCC < 5 with -fPIE would fail
>   * due to an undefined symbol. Define it to make these ancient GCCs work.
>   */
> +#ifndef CONFIG_CC_IS_CLANG
>  unsigned long __force_order;
> +#endif
>
>  #define BIOS_START_MIN         0x20000U        /* 128K, less than this is insane */
>  #define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 82436cb04ccf..7081e587c1ea 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -16,8 +16,15 @@
>   * A memory clobber would solve the problem, but would prevent reordering of
>   * all loads stores around it, which can hurt performance. Solution is to
>   * use a variable and mimic reads and writes to it to enforce serialization
> + *
> + * Clang sometimes fails to kill the reference to the dummy variable, so
> + * provide an actual copy.
>   */
> +#ifdef CONFIG_CC_IS_CLANG
> +static unsigned long __force_order;
> +#else
>  extern unsigned long __force_order;
> +#endif
>
>  void native_write_cr0(unsigned long val);
>
> --
> 2.26.2
>
> --


-- 
Thanks,
~Nick Desaulniers
