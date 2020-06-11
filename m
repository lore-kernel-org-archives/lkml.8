Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A26DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D001120835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591917765;
	bh=gCJ5zqC/HJ85uZUZkc1Pp30uL4zAwCk0QHm5dlfJCxQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KheQXkarhFAXbvk+lVsNRa+Du3TsCyyCADb04ISqZQW92AFUA8kri+MwkgpfXXJA/
	 sWMOspTJbkTVqqpDLVFMpmtJJikOzuMEGSrf0o68GykUJwYH+7AmqnybY2/PCmP2ne
	 +YzUNkwUOyqciN+pg3vN9Dcauc0OwcElZlR5Es9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgFKXWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgFKXWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:22:44 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1DD320842
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591917763;
        bh=gCJ5zqC/HJ85uZUZkc1Pp30uL4zAwCk0QHm5dlfJCxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=duE0lHeBUBaxcv06IPvKMJ8xFFdI+oD+spB9ul0CbL5RuNwio4yW2AtAB/ZKjXsS+
         mQ5PyjSFj/lB/RovzUDb9YTWSevheRmAfjcvvaSXgYJdL1lIXU1YCbeBQzKTuRgPkQ
         2c+YxORIB1li5jlGlHUFObcTqu/vJhu3W1pIlrEY=
Received: by mail-wm1-f44.google.com with SMTP id y20so6625545wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:22:42 -0700 (PDT)
X-Gm-Message-State: AOAM5338MVVSvh2yQjqjsaddQd9fL4MkphXt/AAJUwPJ1jrnzCmo0Puu
        klqIQ+4YPjUio3GXBmPKV2UTGDrT+CuQZiL0oGLHzQ==
X-Google-Smtp-Source: ABdhPJxURP1nrp3/OilZVFaQiKiyETgVyPosYam3mqppbEU3sz3tDgAMb8c8PgLGfV1JlEGV5kp5GFoXr6ffzhW3lr8=
X-Received: by 2002:a1c:2d54:: with SMTP id t81mr10962586wmt.154.1591917761460;
 Thu, 11 Jun 2020 16:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
 <CALCETrXqhwJzhsAoM72tskso5aDELgfGLnHdGYHiAFmgCPforQ@mail.gmail.com> <20200611192518.GA2483@worktop.programming.kicks-ass.net>
In-Reply-To: <20200611192518.GA2483@worktop.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jun 2020 16:22:29 -0700
X-Gmail-Original-Message-ID: <CALCETrXq2sVuT39+oB2CskQBP3nNk4ogx+cwv-Jc3vE-uZazYg@mail.gmail.com>
Message-ID: <CALCETrXq2sVuT39+oB2CskQBP3nNk4ogx+cwv-Jc3vE-uZazYg@mail.gmail.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jun 11, 2020 at 12:10:50PM -0700, Andy Lutomirski wrote:
> > On Thu, Jun 11, 2020 at 11:56 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> > >
> > > While running perf test and selftest x86 single_step_syscall_32 on
> > > i386 kernel linux
> > > next 5.7.0-next-20200610 kernel warning noticed.
> > >
> > > steps to reproduce:
> > > --------------------------
> > > perf test
> > > and
> > > cd /opt/kselftests/default-in-kernel/x86
> > > ./single_step_syscall_32
> > >
> > > perf warning log:
> > > ----------------------
> > > [   57.260865] ------------[ cut here ]------------
> > > [   57.266576] IRQs not disabled as expected
> > > [   57.270583] WARNING: CPU: 1 PID: 500 at
> > > /usr/src/kernel/arch/x86/entry/common.c:624
> > > idtentry_exit_cond_rcu+0x92/0xc0
> > > [   57.281092] Modules linked in: x86_pkg_temp_thermal fuse
> > > [   57.286406] CPU: 1 PID: 500 Comm: perf Not tainted 5.7.0-next-20200610 #1
> > > [   57.293190] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> > > 2.2 05/23/2018
> > > [   57.300577] EIP: idtentry_exit_cond_rcu+0x92/0xc0
> > > [   57.305280] Code: 8b 89 d8 05 00 00 85 c9 74 ae 80 3d b1 64 2c d4
> > > 00 75 a5 68 94 2d fb d3 89 55 f8 89 45 fc c6 05 b1 64 2c d4 01 e8 8e
> > > f5 2b ff <0f> 0b 58 8b 55 f8 8b 45 fc eb 83 8d 76 00 e8 5b fd ff ff c9
> > > c3 89
> > > [   57.324017] EAX: 0000001d EBX: 0d00022a ECX: 00000027 EDX: f5b9e14c
> > > [   57.330274] ESI: f2a2ffb4 EDI: ffff0ff4 EBP: f2a2ff8c ESP: f2a2ff80
> > > [   57.336531] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010096
> > > [   57.343345] CR0: 80050033 CR2: 08700a58 CR3: 14ad7000 CR4: 003406d0
> > > [   57.349608] DR0: 080dfb80 DR1: 080dfc00 DR2: 08700a58 DR3: 00000000
> > > [   57.355866] DR6: fffe0ff0 DR7: 0d00062a
> > > [   57.359697] Call Trace:
> > > [   57.362143]  exc_debug+0x84/0x1b0
> > > [   57.365487]  ? exc_int3+0x1d0/0x1d0
> > > [   57.368981]  handle_exception+0x145/0x145
> > > [   57.372991] EIP: 0x80dfbcd
> > > [   57.375694] Code: Bad RIP value.
> > > [   57.378918] EAX: 00000000 EBX: 00000005 ECX: 00002400 EDX: 00000000
> > > [   57.385175] ESI: 00000003 EDI: 00000004 EBP: bfd59798 ESP: bfd59770
> > > [   57.391431] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> > > [   57.398215] irq event stamp: 1896
> >
> > A regrettable property of the current entry code structure is that we
> > lose any real indication of the vector.  Presumably this is #DB, hence
> > exc_debug.  I don't know what perf has to do with it.
> >
> > I'll bang on this after lunch if no one beats me to it.
>
> Puzzling, CR3 seems to suggest this is !user_mode(), but either way #DB
> has either idtentry_enter_user() or nmi_enter().
>

I just got this splat on 32-bit while running my perf abuser here:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/misc-tests.git/tree/perf_lots_of_nmi.c

[   21.874114] traps: PANIC: double fault, error_code: 0x0
[   21.874127] double fault: 0000 [#1] SMP PTI
[   21.874127] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0+ #117
[   21.874128] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31
04/01/2014
[   21.874128] EIP: asm_exc_invalid_op+0x6/0x10
[   21.874129] Code: a1 07 00 00 0f 01 ca fc 6a 00 68 f0 4c d7 cf e9
91 07 00 00 0f 01 ca fc 6a 00 68 90 4f d7 cf e9 81 07 00 00 0f 01 ca
fc 6a 00 <68> 30 4d d7 cf e9 71 07 00 00 0f 01 ca fc 6a 00 68 60 55 d7
cf e9
[   21.874129] EAX: 00000000 EBX: cff9902c ECX: 000000e0 EDX: 00000000
[   21.874129] ESI: cff9be9c EDI: cfd74d30 EBP: cff99014 ESP: cff99000
[   21.874130] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210046
[   21.874130] CR0: 80050033 CR2: cff98ffc CR3: 10108000 CR4: 00340ef0
[   21.874130] Call Trace:
[   21.874131] Modules linked in:
[   21.889116] ---[ end trace aa191c9e5c534faf ]---
[   21.889116] EIP: asm_exc_invalid_op+0x6/0x10
[   21.889117] Code: a1 07 00 00 0f 01 ca fc 6a 00 68 f0 4c d7 cf e9
91 07 00 00 0f 01 ca fc 6a 00 68 90 4f d7 cf e9 81 07 00 00 0f 01 ca
fc 6a 00 <68> 30 4d d7 cf e9 71 07 00 00 0f 01 ca fc 6a 00 68 60 55 d7
cf e9
[   21.889117] EAX: 00000000 EBX: cff9902c ECX: 000000e0 EDX: 00000000
[   21.889117] ESI: cff9be9c EDI: cfd74d30 EBP: cff99014 ESP: cff99000
[   21.889127] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210046
[   21.889128] CR0: 80050033 CR2: cff98ffc CR3: 10108000 CR4: 00340ef0
[   21.889128] Kernel panic - not syncing: Fatal exception in interrupt
[   21.889338] Kernel Offset: 0xe600000 from 0xc1000000 (relocation
range: 0xc0000000-0xf7dfdfff)

All code
========
   0:    a1 07 00 00 0f           mov    0xf000007,%eax
   5:    01 ca                    add    %ecx,%edx
   7:    fc                       cld
   8:    6a 00                    push   $0x0
   a:    68 f0 4c d7 cf           push   $0xcfd74cf0
   f:    e9 91 07 00 00           jmp    0x7a5
  14:    0f 01 ca                 clac
  17:    fc                       cld
  18:    6a 00                    push   $0x0
  1a:    68 90 4f d7 cf           push   $0xcfd74f90
  1f:    e9 81 07 00 00           jmp    0x7a5
  24:    0f 01 ca                 clac
  27:    fc                       cld
  28:    6a 00                    push   $0x0
  2a:*    68 30 4d d7 cf           push   $0xcfd74d30        <--
trapping instruction
  2f:    e9 71 07 00 00           jmp    0x7a5
  34:    0f 01 ca                 clac
  37:    fc                       cld
  38:    6a 00                    push   $0x0
  3a:    68 60 55 d7 cf           push   $0xcfd75560

This is on my private branch, which has some extra changes, but I
don't think they're relevant.  I think we broke NMI :(  I did a nopti
run and got a different explosion:

[   14.618581] BUG: unable to handle page fault for address: 0021004a
[   14.620149] #PF: supervisor write access in kernel mode
[   14.621134] #PF: error_code(0x0002) - not-present page
[   14.622028] *pdpt = 0000000035b2f001 *pde = 0000000000000000
[   14.623047] Oops: 0002 [#1] SMP NOPTI
[   14.623684] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0+ #117
[   14.624733] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31
04/01/2014
[   14.627013] EIP: run_timer_softirq+0x14a/0x470
[   14.627793] Code: 3b 63 00 8b 45 b8 8b 00 89 45 bc 8b 45 bc 85 c0
74 5c 8b 45 b8 8b 18 89 5f 04 3e 8d 74 26 00 8b 03 8b 53 04 89 02 85
c0 74 03 <89> 50 04 c7 43 04 00 00 00 00 8b 53 0c c7 03 22 01 00 00 f6
43 12
[   14.630874] EAX: 00210046 EBX: f60f3ee4 ECX: fffba48e EDX: f602bf88
[   14.631913] ESI: f602bf88 EDI: f65c8080 EBP: f602bfbc ESP: f602bf68
[   14.632970] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00210002
[   14.634248] CR0: 80050033 CR2: 0021004a CR3: 3583b120 CR4: 00340ef0
[   14.635300] Call Trace:
[   14.635710]  <SOFTIRQ>
[   14.636232]  __do_softirq+0xac/0x25b
[   14.636885]  ? __entry_text_end+0x8/0x8
[   14.637786]  call_on_stack+0x40/0x50
[   14.638397]  </SOFTIRQ>
[   14.638813]  ? irq_exit_rcu+0x95/0xa0
[   14.639513]  ? sysvec_apic_timer_interrupt+0x27/0x40
[   14.640424]  ? handle_exception+0x15d/0x15d
[   14.641272]  ? __cpuidle_text_start+0x8/0x8
[   14.642167]  ? default_idle+0x23/0x160

I have to run, so I'll keep digging later.
