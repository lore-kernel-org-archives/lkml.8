Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64512C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB292070B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDeyBdFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgGFKhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgGFKhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:37:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE984C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:37:20 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so38774759iow.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ldq871DYUjfCutFINwf0OWVTOZ4q2KSgzJKbSP2ijjE=;
        b=VDeyBdFrxB55bqEKHah7hduH/Db1c1CdcSU+hwDxZDfAtZbNsD0HXwc3UNwFAOppQw
         e576XtZLlu171qa/A2Un2vwEsMF7PwCCiZiniUvct1Srx8+3aYxt1Emlznk/1Yj2aMOU
         CzLd+rg8PmasNIZb30d1Fs/PTVnsdBK+14OY59LMt8LLyQOcRpoulcGEWJi0jFRC48Cx
         ZWzjGR7zAgLdNkf8qRFlzPupT/22c4wiG3B514nDRLYxaifBbBgxHJ7c51vWI0kc7jTJ
         5chTOq6ZedEcB63ju6OSu5HZJXw2NeXV8sQtuaaoVl+mlO+ZTYsOfjWZxJtzWltBvQcf
         Yr8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ldq871DYUjfCutFINwf0OWVTOZ4q2KSgzJKbSP2ijjE=;
        b=SXJomdidbZgGXMzjzhUY0hsyd1thOqVMZpf4NgeSHPupbEGjNnsl4BwF6da0fipqhK
         moFYcS6xMsLC/SiY9fbQ3D/Hjc8ogzMKpmNlqjzG0c6OUoUwJ4dEVlrvZ+7T4fYg6p3N
         IMDzAFN0OAWRJT9VF8SZSR0Jk2AMcWsX5zzV2TQecNsurq8CVZpLHQHaPgqkywNP9cRD
         KIzGNGzlCPvXMYEyg5EuUGrd9BlgldlOKY+qRc2t2t+qF+SU7+4hFPmyyJUqF9Xw4w3r
         d8/pFfsJzb8i6ft/4ucI8gSfAp0kBG9M/6Rc9qEC/wD87Wifg8w5xiPkDpfmkykI3BJz
         xmWg==
X-Gm-Message-State: AOAM530qlrYXYwvg0H5FgCZnYcKV64ipghgturcExIFwE7meOHE9DYQb
        5mcMYvOOx9PX/NbzDwZBbl3YnU0mj5GzPAtwG3I=
X-Google-Smtp-Source: ABdhPJwOscehIMGDzDU8B+iwYuJcSOoLVl/U9C0zKqAT0qIrPLL3v33r6QjMoxv1UQqwx0bKvodYbeEHY+SGZWQSh0Q=
X-Received: by 2002:a05:6638:1409:: with SMTP id k9mr54068396jad.125.1594031840060;
 Mon, 06 Jul 2020 03:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVgJFXJ3C_iYK8HrsuhAy3R9U1RDB6mPkOS52JcnU4mDQ@mail.gmail.com>
 <20200706083900.GC4800@hirez.programming.kicks-ass.net> <CA+icZUV=VVpy=R5_bq0N4TvPg+SfzyCXuWW9-QCnKk8-WnZLLg@mail.gmail.com>
 <CA+icZUWevq9qidK8K1v0GV-FOyyhn2hp4DTrsUSz-oeXCNp+1A@mail.gmail.com>
In-Reply-To: <CA+icZUWevq9qidK8K1v0GV-FOyyhn2hp4DTrsUSz-oeXCNp+1A@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 6 Jul 2020 12:37:08 +0200
Message-ID: <CA+icZUU+HO7BuSdCtFu=4pH-sTq2Qi7aJNM5Fvsqi+Cdza58bQ@mail.gmail.com>
Subject: Re: [Linux v5.8-rc4] objtool warnings with gcc-10
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 11:02 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jul 6, 2020 at 10:43 AM Sedat Dilek <sedat.dilek@gmail.com> wrote=
:
> >
> > On Mon, Jul 6, 2020 at 10:39 AM Peter Zijlstra <peterz@infradead.org> w=
rote:
> > >
> > > On Mon, Jul 06, 2020 at 09:09:55AM +0200, Sedat Dilek wrote:
> > > > [ Please CC me I am not subscribed to this mailing-list ]
> > > >
> > > > Hi Josh and Peter,
> > > >
> > > > today I switched over from Linux v5.7.y to Linux v5.8-rc4 and built
> > > > the first time with GCC version 10 on Debian/testing AMD64.
> > > >
> > > > $ cat /proc/version
> > > > Linux version 5.8.0-rc4-1-amd64-gcc10 (sedat.dilek@gmail.com@iniza)
> > > > (gcc-10 (Debian 10.1.0-4) 10.1.0, GNU ld (GNU Binutils for Debian)
> > > > 2.34) #1~bullseye+dileks1 SMP 2020-07-06
> > > >
> > > > I see these objtool warnings (which are new to me):
> > > >
> > > > $ grep warning: build-log_5.8.0-rc4-1-amd64-gcc10.txt | sort
> > > > arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x118=
: unreachable instruction
> > > > drivers/atm/horizon.o: warning: objtool: interrupt_handler()+0x19f:=
 unreachable instruction
> > > > drivers/message/fusion/mptbase.o: warning: objtool: mpt_Soft_Hard_R=
esetHandler()+0x33a: unreachable instruction
> > > > drivers/scsi/aic7xxx/aic79xx_core.o: warning: objtool: ahd_intr.par=
t.0()+0x10f: unreachable instruction
> > > > drivers/scsi/pcmcia/aha152x_core.o: warning: objtool: run()+0x4c0: =
unreachable instruction
> > > > fs/btrfs/backref.o: warning: objtool: btrfs_backref_finish_upper_li=
nks()+0x309: unreachable instruction
> > > > fs/btrfs/extent_io.o: warning: objtool: __set_extent_bit.cold()+0xc=
: unreachable instruction
> > > > fs/btrfs/relocation.o: warning: objtool: update_backref_cache.part.=
0()+0x1de: unreachable instruction
> > > > kernel/exit.o: warning: objtool: __x64_sys_exit_group()+0x14: unrea=
chable instruction
> > > > net/core/skbuff.o: warning: objtool: skb_push.cold()+0x15: unreacha=
ble instruction
> > >
> > > That's more CONFIG_LIVEPATCH=3Dy wreckage I expect. The problem is th=
at
> > > GCC -flive-patching=3D thing wreck the propagation of the noreturn.
> > >
> > > This really is a compiler issue and we've not managed a sensible
> > > work-around in objtool.
> >
> > Thanks for the quick response.
> >
> > I have...
> >
> > CONFIG_LIVEPATCH=3Dy
> >
> > ...and see in my build-log:
> >
> > -flive-patching=3Dinline-clone
> >
> > - Sedat -
>
> OK, I found some discussions in "Re: linux-next: Tree for May 21
> (objtool warnings)" [1].
>
> GCC docs say [2]:
> - BOQ (Begin Of Quote) -
> [ -flive-patching=3Dlevel ]
>
> The level argument should be one of the following:
>
> [ =E2=80=98inline-clone=E2=80=99 ]
>
> Only enable inlining and cloning optimizations, which includes
> inlining, cloning, interprocedural scalar replacement of aggregates
> and partial inlining. As a result, when patching a function, all its
> callers and its clones=E2=80=99 callers are impacted, therefore need to b=
e
> patched as well.
>
> -flive-patching=3Dinline-clone disables the following optimization flags:
>
> -fwhole-program  -fipa-pta  -fipa-reference  -fipa-ra
> -fipa-icf  -fipa-icf-functions  -fipa-icf-variables
> -fipa-bit-cp  -fipa-vrp  -fipa-pure-const  -fipa-reference-addressable
> -fipa-stack-alignment
>
> [ =E2=80=98inline-only-static=E2=80=99 ]
>
> Only enable inlining of static functions. As a result, when patching a
> static function, all its callers are impacted and so need to be
> patched as well.
>
> In addition to all the flags that -flive-patching=3Dinline-clone
> disables, -flive-patching=3Dinline-only-static disables the following
> additional optimization flags:
>
> -fipa-cp-clone  -fipa-sra  -fpartial-inlining  -fipa-cp
>
> When -flive-patching is specified without any value, the default value
> is inline-clone.
>
> This flag is disabled by default.
>
> Note that -flive-patching is not supported with link-time optimization (-=
flto).
>  - EOQ (End of Quote) -
>
> Josh says in [3]:
>
> > The issue here is that with -fno-ipa-pure-const, GCC no longer
> > automatically detects that the static inline function is noreturn, so i=
t
> > emits unreachable instructions after a call to it.
>
> - Sedat -
>
> [1] https://marc.info/?t=3D159011496400002&r=3D1&w=3D2
> [2] https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html
> [3] https://marc.info/?l=3Dlinux-next&m=3D159059217601108&w=3D2

[ arch/x86/kernel/cpu/mce/core.o ]

After "-flive-patching=3Dinline-clone" I manually added in the make line:

#1: -fno-ipa-pure-const

$ ./tools/objtool/objtool orc generate  --no-fp --retpoline --uaccess
arch/x86/kernel/cpu/mce/core.o
arch/x86/kernel/cpu/mce/core.o: warning: objtool: mce_panic()+0x118:
unreachable instruction

#2: -fipa-pure-const

$ gcc-10 -Wp,-MMD,arch/x86/kernel/cpu/mce/.core.o.d -nostdinc -isystem
/usr/lib/gcc/x86_64-linux-gnu/10/include -I./arch/x86/include
-I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi
-I./arch/x86/include/generated/uapi -I./include/uapi
-I./include/generated/uapi -include ./include/linux/kconfig.h -include
./include/linux/compiler_types.h -D__KERNEL__ -Wall -Wundef
-Werror=3Dstrict-prototypes -Wno-trigraphs -fno-strict-aliasing
-fno-common -fshort-wchar -fno-PIE
-Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
-Wno-format-security -std=3Dgnu89 -mno-sse -mno-mmx -mno-sse2 -mno-3dnow
-mno-avx -m64 -falign-jumps=3D1 -falign-loops=3D1 -mno-80387
-mno-fp-ret-in-387 -mpreferred-stack-boundary=3D3 -mskip-rax-setup
-mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -Wno-sign-compare
-fno-asynchronous-unwind-tables -mindirect-branch=3Dthunk-extern
-mindirect-branch-register -fno-jump-tables
-fno-delete-null-pointer-checks -Wno-frame-address
-Wno-format-truncation -Wno-format-overflow
-Wno-address-of-packed-member -O2 -fno-allow-store-data-races
-Wframe-larger-than=3D2048 -fstack-protector-strong
-Wno-unused-but-set-variable -Wimplicit-fallthrough
-Wno-unused-const-variable -fno-var-tracking-assignments -g -gdwarf-4
-gz=3Dzlib -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY
-flive-patching=3Dinline-clone -fipa-pure-const
-Wdeclaration-after-statement -Wvla -Wno-pointer-sign
-Wno-stringop-truncation -Wno-zero-length-bounds -Wno-array-bounds
-Wno-stringop-overflow -Wno-restrict -Wno-maybe-uninitialized
-fno-strict-overflow -fno-merge-all-constants -fmerge-constants
-fno-stack-check -fconserve-stack -Werror=3Ddate-time
-Werror=3Dincompatible-pointer-types -Werror=3Ddesignated-init
-fmacro-prefix-map=3D./=3D -fcf-protection=3Dnone -Wno-packed-not-aligned
-DKBUILD_MODFILE=3D'"arch/x86/kernel/cpu/mce/core"'
-DKBUILD_BASENAME=3D'"core"' -DKBUILD_MODNAME=3D'"core"' -c -o
arch/x86/kernel/cpu/mce/core.o arch/x86/kernel/cpu/mce/core.c

cc1: error: =E2=80=98-fipa-pure-const=E2=80=99 is incompatible with
=E2=80=98-flive-patching=3Dinline-only-static|inline-clone=E2=80=99

- Sedat -
