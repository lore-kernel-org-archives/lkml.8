Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80632C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4757020829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 17:30:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPG9z3sh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgHNRaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbgHNR3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 13:29:55 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47232C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:29:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u63so8783592oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=LQUYCPF81nUKijFcByZIq3gr+jwx6Zv8RO3AtGf1z18=;
        b=UPG9z3shXbCSUjJLg9XiedDE0K2C54iqnIM2lmbVod8kxblCir+EGuncjwGh5h+ugD
         4ij4LCVs3ljDHWZu3IxGGssSjK8eN1/ks+AkHkK693fJBBZGMYVPAnKdt5lataHXpAZz
         0s93E8ZEggI64zmM1h22D3xAqq9mSJIOYyWbTJxRDxtiIVjcWNSeQo5JBQUKSysJsPfH
         aKGmzcRRztIZACI3p3neTQ9WEbEo5LI2vx+yzzyiW1+Ao14I6UcJIi1IwKE4W4GLz+am
         te28fT/1NxYqceNNLeTw7xNerjIk0qEQg1dB7zM5PLVif5MZ716fKUHVngMg2aDs3pi0
         /+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=LQUYCPF81nUKijFcByZIq3gr+jwx6Zv8RO3AtGf1z18=;
        b=gHmJeY0ei47edvas6Rw18bXWEj9H2MT25bpJltMbPpoUqqXZNqPdf6A+tV3vXoPsX8
         8HqHW2Huvvx2NaIDe5Na/xoCWQpaNoj7/4AIRhslBIihefdPmCqBSnWTImg2qp3A52zK
         EYnmcyYIFtolePDH698Wb0o4y3ukSxzcmY0EGJi8Jt/U47j4/3gPzbrKzcQVbnpYHwn/
         80wtEyJkzSTBQ9KnE15fyNrsVAWCi3JU+no1zhQq5OV4YanAOWNC/3LdzSjFwwQu+Jl0
         PXWg1nloVAoiqIU/a4LE/hHgJiJH7+xSraIa8MwtZfsKcwoXS1CKJIjBhMpYasf4RfTj
         9XiQ==
X-Gm-Message-State: AOAM530aqVo2lENxRWndnbs9FMfUvDiOnb8YnIDcjfEmhIvWEF2t8yBs
        2kjAv3MIPfVbsfNd8eIo9uaR8/ajSh2hRSFXwtE=
X-Google-Smtp-Source: ABdhPJzE44EFyND9u3s7avmfTt4fbSLJLmD/e6CtB2I0vt5jojEdwoVUUkuhOsOwGI+VRBMlXjryI50pVeTdMm215RM=
X-Received: by 2002:a05:6808:311:: with SMTP id i17mr2289529oie.72.1597426194312;
 Fri, 14 Aug 2020 10:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527135329.1172644-1-arnd@arndb.de> <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
In-Reply-To: <CAKwvOdmA29WzTd7APsQCsG_a=NVWuR53Z2h8NTLza5sisnV2PA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 14 Aug 2020 19:29:42 +0200
Message-ID: <CA+icZUUjtu3fCNTngY52h3uRL+eUaimNJb0UNwj5v-QwKggs5A@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Collingbourne <pcc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Tue, Aug 4, 2020 at 2:09 AM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Wed, May 27, 2020 at 6:53 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > When using the clang integrated assembler, we get a reference
> > to __force_order that should normally get ignored in a few
> > rare cases:
> >
> > ERROR: modpost: "__force_order" [drivers/cpufreq/powernow-k6.ko] undefined!
> >
> > Add a 'static' definition so any file in which this happens can
> > have a local copy.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi Arnd,
> Looks like
> $ ARCH=i386 make CC=clang LLVM_IAS=1 -j71
> defconfig+CONFIG_X86_POWERNOW_K6=m
> is the simplest reproducer.
>
> If I run
> $ llvm-readelf -s drivers/cpufreq/powernow-k6.o | grep __force_order
>     39: 00000000     0 NOTYPE  GLOBAL DEFAULT   UND __force_order
> we can indeed see an undefined reference to __force_order.
>
> If I build the .s file via
> $ ARCH=i386 make CC=clang LLVM_IAS=1 -j71 drivers/cpufreq/powernow-k6.s
> the only reference I see to __force_order is:
> 979   .addrsig_sym __force_order
>
> which is created by Clang's implicit -faddr-sig.  If I disable that
> for this file via:
>
> ```diff
> diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> index f1b7e3dd6e5d..87d655d5af49 100644
> --- a/drivers/cpufreq/Makefile
> +++ b/drivers/cpufreq/Makefile
> @@ -28,6 +28,9 @@ obj-$(CONFIG_X86_ACPI_CPUFREQ)                +=
> acpi-cpufreq.o
>  obj-$(CONFIG_X86_POWERNOW_K8)          += powernow-k8.o
>  obj-$(CONFIG_X86_PCC_CPUFREQ)          += pcc-cpufreq.o
>  obj-$(CONFIG_X86_POWERNOW_K6)          += powernow-k6.o
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_powernow-k6.o                   += -fno-addrsig
> +endif
>  obj-$(CONFIG_X86_POWERNOW_K7)          += powernow-k7.o
>  obj-$(CONFIG_X86_LONGHAUL)             += longhaul.o
>  obj-$(CONFIG_X86_E_POWERSAVER)         += e_powersaver.o
> ```
> then the module links without error, and we get no hits for
> __force_order from llvm-readelf -s.  This makes me think there may be
> a bug in Clang generating address significance tables for global
> variables that are otherwise unused, resulting in such linkage
> failures. +pcc@ for that.
>
> I ran a creduce job on drivers/cpufreq/powernow-k6.i where I'd compile
> twice, one with the implicit default value of -faddr-sig and look for
> the undefined __force_order, and again with -fno-addrsig and ensure
> there was no undefined __force_order, which coughed up:
> extern int __force_order;
> int a(void) { asm("" : "=m"(__force_order)); return 0; }
> as the bare minimum for an address significant table.
> https://godbolt.org/z/cjfaqM
>
> I'll bet this is coming from the call to read_cr0() in
> powernow_k6_set_cpu_multiplier().  If __force_order is defined in
> arch/x86/boot/compressed/pgtable_64.c, then I'm not sure it's a good
> idea to build drivers/cpufreq/powernow-k6.c as a kernel module
> (CONFIG_X86_POWERNOW_K6=m) vs statically compiled in.  Wouldn't
> __force_order need to be EXPORT'ed for kernel modules to use it
> safely?
>
> > ---
> >  arch/x86/boot/compressed/pgtable_64.c | 2 ++
> >  arch/x86/include/asm/special_insns.h  | 7 +++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > index c8862696a47b..8595194cea41 100644
> > --- a/arch/x86/boot/compressed/pgtable_64.c
> > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > @@ -12,7 +12,9 @@
> >   * It is not referenced from the code, but GCC < 5 with -fPIE would fail
> >   * due to an undefined symbol. Define it to make these ancient GCCs work.
> >   */
> > +#ifndef CONFIG_CC_IS_CLANG
> >  unsigned long __force_order;
> > +#endif
> >
> >  #define BIOS_START_MIN         0x20000U        /* 128K, less than this is insane */
> >  #define BIOS_START_MAX         0x9f000U        /* 640K, absolute maximum */
> > diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> > index 82436cb04ccf..7081e587c1ea 100644
> > --- a/arch/x86/include/asm/special_insns.h
> > +++ b/arch/x86/include/asm/special_insns.h
> > @@ -16,8 +16,15 @@
> >   * A memory clobber would solve the problem, but would prevent reordering of
> >   * all loads stores around it, which can hurt performance. Solution is to
> >   * use a variable and mimic reads and writes to it to enforce serialization
> > + *
> > + * Clang sometimes fails to kill the reference to the dummy variable, so
> > + * provide an actual copy.
> >   */
> > +#ifdef CONFIG_CC_IS_CLANG
> > +static unsigned long __force_order;
> > +#else
> >  extern unsigned long __force_order;
> > +#endif
> >
> >  void native_write_cr0(unsigned long val);
> >
> > --
> > 2.26.2
> >

Thanks for the proposal.

I have adapted it to fit my patchset against Linux v5.8.

Both Debian's GCC-10 and a snapshot version of LLVM toolchain
v11.0.0-rc1+ seems to be OK.

MAKE_OPTS="V=1 -j3 CC=gcc-10 LD=ld.bfd"
make $MAKE_OPTS arch/x86/kernel/cpu/common.o

MAKE_OPTS="V=1 -j3 HOSTCC=clang-11 HOSTCXX=clang++-11 HOSTLD=ld.lld-11
HOSTAR=llvm-ar-11 CC=clang-11 LD=ld.lld-11 AR=llvm-ar-11 NM=llvm-nm-11
OBJCOPY=llvm-objcopy-11 OBJDUMP=llvm-objdump-11 OBJSIZE=llvm-size-11
READELF=llvm-readelf-11 STRIP=llvm-strip-11 LLVM_IAS=1"
make $MAKE_OPTS arch/x86/kernel/cpu/common.o

I can send both object files if desired.

I will do a full kernel-build to see if I am able to build the
VirtualBox out-of-tree kernel-modules.

- Sedat -
