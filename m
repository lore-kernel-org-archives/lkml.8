Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC7EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 914CC20709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+SODkFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHJJYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHJJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:24:03 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2929C061756;
        Mon, 10 Aug 2020 02:24:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id t10so4276770ejs.8;
        Mon, 10 Aug 2020 02:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgfhkzNvcbUoGtDL5a7T3jdAEG0URbX7tG2gL6FfuVo=;
        b=T+SODkFq9eaMaz9JXbovfO+wOLg92BEfF2RhAsBWy4s6n6gLfqA9f6Jx2rBwsv991s
         Tgls+Ag75ZZ7bClxnMbvCrPbf0mDJ0ap9YPyY7BLKjA/QgLR07UXM6t6dBuo1ePbaDWi
         FGBpQxNkRaxUB9sEXlaqiXnFalq9Ud1SFeYvSebDdtGErPcnRLcXVbJL3zAh72LbJkOa
         8c18gt2kkdnYqWjtHJ2zCW7XcKDlDhR5obr8PlIUx9aXuIOfkvCWJx1y+zS51gghgSY8
         idytfHLC+/tyX2+FoDcWUxqED6dngJLkT5hF0nyYcm2MaLzB4XUQ54enkWYR/H2/T1Ht
         Jg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgfhkzNvcbUoGtDL5a7T3jdAEG0URbX7tG2gL6FfuVo=;
        b=ioU2M1r9jXXNW84hLooJXM3TNRyTR6Xc9xS5Q/Zw0rX3gBiHSlRhcY7o3rBY/cx5vy
         LKk/nIbQstMAJsPOvJ/Sj3oUEARyhhvIFG5CAPozUrEXK5UTq8x+ISgSgUVPFgBjDO9i
         7dBJtp+W7N8gbuyWtHZpX5stZoNWZMejUvnC+WUWJGWQvS8hE1Ra7eYaVDRYLEOupSXk
         CUwl35zKEVk3GdpKpoJQGWBbD6JA/QzYtSBEb0RkzbPkmRf/1z50d+0e7y625FWnEcbP
         GjQYwCLX3PYU8ztGKJiFDbexnxe8MxEuHkXVaW9tDOhVmI27NmceFDYMefiBKgSsb7Ku
         PsqA==
X-Gm-Message-State: AOAM533jzeWYorHeZlYa9ybt23d2Wm7UQ4bJXoK+9kPhhp/CbpyHlpJd
        j96QRAZejfgath0U3FhVkdxgLAJKy13EgOww5eI=
X-Google-Smtp-Source: ABdhPJzaQYb49W/ibMoRp27dmgljl5qqtFjKpIEBKMs7dRXbowzXS3Wla2HgwX26vaOH9FXUF6c/P4Vq7YBlPEzVIeU=
X-Received: by 2002:a17:906:528d:: with SMTP id c13mr21349334ejm.61.1597051441470;
 Mon, 10 Aug 2020 02:24:01 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqybxFr5reVmYM2_h+KUzqL3PU5Qo9nrZSieQPYq+gWWCg@mail.gmail.com>
 <20200804133438.GK2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200804133438.GK2674@hirez.programming.kicks-ass.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 10 Aug 2020 12:23:48 +0300
Message-ID: <CADxRZqy+PcHrMu1a6VZp_SNEybVUax88eqO09Sbq7v3yjivVKw@mail.gmail.com>
Subject: Re: [sparc64] enabling CONFIG_PROVE_LOCKING makes kernel unable to build
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 4:34 PM <peterz@infradead.org> wrote:
>
> On Tue, Aug 04, 2020 at 04:17:16PM +0300, Anatoly Pugachev wrote:
> > Hello!
> >
> > Linus git master sources:
> >
> > $ git desc
> > v5.8-2483-gc0842fbc1b18
> >
>
> Ooh, it looks like that series wasn't cut back far enough :/
>
> 859247d39fb0 ("seqlock: lockdep assert non-preemptibility on seqcount_t
> write") does indeed also introduce problems.
>
> I've been working on untangling the header mess for the full series and
> the below patch is what I currently have.
>
> ---
> Subject: seqlock,headers: Untangle the spaghetti monster
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jul 30 13:20:47 CEST 2020
>
> By using lockdep_assert_*() from seqlock.h, the spaghetti monster
> attacked.

Thanks Peter!

It doesn't apply cleanly over master git, but it least makes kernel
compilable / bootable on sparc64:

linux-2.6$ git desc
v5.8-11991-gfc80c51fd4b2

linux-2.6$ patch -p1 < ~/headers.patch
patching file arch/ia64/include/asm/smp.h
patching file arch/ia64/include/asm/xtp.h
patching file arch/ia64/kernel/iosapic.c
patching file arch/ia64/kernel/irq.c
patching file arch/ia64/kernel/process.c
Hunk #1 succeeded at 47 (offset -1 lines).
patching file arch/ia64/kernel/sal.c
patching file arch/ia64/kernel/setup.c
patching file arch/ia64/kernel/smp.c
Hunk #1 succeeded at 45 (offset -1 lines).
patching file arch/parisc/include/asm/timex.h
patching file arch/sh/include/asm/io.h
patching file arch/sh/kernel/machvec.c
patching file arch/sparc/include/asm/timer_64.h
patching file arch/sparc/include/asm/vvar.h
patching file arch/sparc/kernel/vdso.c
patching file arch/x86/include/asm/fixmap.h
patching file arch/x86/kernel/apic/apic_noop.c
patching file arch/x86/kernel/apic/hw_nmi.c
patching file arch/x86/kernel/apic/probe_64.c
patching file arch/x86/kernel/cpu/amd.c
patching file arch/x86/kernel/cpu/common.c
patching file arch/x86/kernel/cpu/hygon.c
patching file arch/x86/kernel/cpu/intel.c
patching file arch/x86/kernel/jailhouse.c
patching file arch/x86/kernel/tsc_msr.c
patching file arch/x86/mm/init_32.c
patching file arch/x86/xen/apic.c
patching file arch/x86/xen/smp_hvm.c
patching file arch/x86/xen/suspend_pv.c
patching file include/linux/dynamic_queue_limits.h
patching file include/linux/hrtimer.h
patching file include/linux/ktime.h
patching file include/linux/lockdep.h
patching file include/linux/mutex.h
patching file include/linux/sched.h
patching file include/linux/seqlock.h
Hunk #1 FAILED at 19.
1 out of 1 hunk FAILED -- saving rejects to file include/linux/seqlock.h.rej
patching file include/linux/time.h
patching file include/linux/videodev2.h
patching file include/linux/ww_mutex.h
mator@ttip:~/linux-2.6$ make -j arch/sparc
  UPD     include/config/kernel.release
  UPD     include/generated/utsrelease.h
  CALL    scripts/atomic/check-atomics.sh
  CC      arch/sparc/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
<stdin>:1511:2: warning: #warning syscall clone3 not implemented [-Wcpp]
  CC      arch/sparc/math-emu/math_64.o
  CC      arch/sparc/net/bpf_jit_comp_64.o
  CC      arch/sparc/mm/tlb.o
  CC      arch/sparc/mm/tsb.o
  CC      arch/sparc/vdso/vclock_gettime.o
  CC      arch/sparc/mm/fault_64.o
  CC      arch/sparc/mm/init_64.o
  CC      arch/sparc/mm/hugetlbpage.o
  CC      arch/sparc/vdso/vma.o
  CC      arch/sparc/vdso/vdso32/vclock_gettime.o
  CC      arch/sparc/crypto/aes_glue.o
  CC      arch/sparc/crypto/des_glue.o
  CC      arch/sparc/crypto/camellia_glue.o
  CC [M]  arch/sparc/crypto/sha1_glue.o
  CC [M]  arch/sparc/crypto/sha256_glue.o
  CC [M]  arch/sparc/crypto/sha512_glue.o
  CC [M]  arch/sparc/crypto/md5_glue.o
  CC [M]  arch/sparc/crypto/crc32c_glue.o
  VDSO    arch/sparc/vdso/vdso64.so.dbg
  CC      arch/sparc/kernel/traps_64.o
  CC      arch/sparc/kernel/irq_64.o
  CC      arch/sparc/kernel/process_64.o
  CC      arch/sparc/kernel/process.o
  CC      arch/sparc/kernel/signal_64.o
  CC      arch/sparc/kernel/sigutil_64.o
  OBJCOPY arch/sparc/vdso/vdso64.so
  CC      arch/sparc/kernel/setup_64.o
  CC      arch/sparc/kernel/idprom.o
  CC      arch/sparc/kernel/sys_sparc_64.o
  VDSO2C  arch/sparc/vdso/vdso-image-64.c
  CC      arch/sparc/kernel/time_64.o
  CC      arch/sparc/kernel/cpu.o
  CC      arch/sparc/kernel/vdso.o
  CC      arch/sparc/vdso/vdso-image-64.o
  CC      arch/sparc/kernel/ptrace_64.o
  CC      arch/sparc/kernel/unaligned_64.o
  CC      arch/sparc/kernel/prom_common.o
  CC      arch/sparc/kernel/prom_64.o
  CC      arch/sparc/kernel/of_device_common.o
  CC      arch/sparc/kernel/of_device_64.o
  CC      arch/sparc/kernel/prom_irqtrans.o
  CC      arch/sparc/kernel/reboot.o
  CC      arch/sparc/kernel/sysfs.o
  CC      arch/sparc/kernel/iommu.o
  CC      arch/sparc/kernel/iommu-common.o
  CC      arch/sparc/kernel/central.o
  CC      arch/sparc/kernel/starfire.o
  CC      arch/sparc/kernel/power.o
  CC      arch/sparc/kernel/sbus.o
  CC      arch/sparc/kernel/ebus.o
  CC      arch/sparc/kernel/visemul.o
  CC      arch/sparc/kernel/hvapi.o
  CC      arch/sparc/kernel/sstate.o
  CC      arch/sparc/kernel/mdesc.o
  CC      arch/sparc/kernel/adi_64.o
  CC      arch/sparc/kernel/pcr.o
  VDSO    arch/sparc/vdso/vdso32.so.dbg
  CC      arch/sparc/kernel/nmi.o
  CC      arch/sparc/kernel/cpumap.o
  CC      arch/sparc/kernel/smp_64.o
  CC      arch/sparc/kernel/auxio_64.o
  CC      arch/sparc/kernel/module.o
  OBJCOPY arch/sparc/vdso/vdso32.so
  CC      arch/sparc/kernel/kgdb_64.o
  CC      arch/sparc/kernel/ftrace.o
  VDSO2C  arch/sparc/vdso/vdso-image-32.c
  CC      arch/sparc/kernel/btext.o
  CC      arch/sparc/kernel/stacktrace.o
  CC      arch/sparc/vdso/vdso-image-32.o
  CC      arch/sparc/kernel/sys_sparc32.o
  CC      arch/sparc/kernel/signal32.o
  CC      arch/sparc/kernel/kprobes.o
  CC      arch/sparc/kernel/ldc.o
  CC      arch/sparc/kernel/vio.o
  CC      arch/sparc/kernel/viohs.o
  CC      arch/sparc/kernel/ds.o
  CC      arch/sparc/kernel/audit.o
  CC      arch/sparc/kernel/compat_audit.o
  CC      arch/sparc/kernel/perf_event.o
  CC      arch/sparc/kernel/jump_label.o
  CC [M]  arch/sparc/kernel/chmc.o
  AR      arch/sparc/vdso/built-in.a
  LD [M]  arch/sparc/crypto/sha1-sparc64.o
  LD [M]  arch/sparc/crypto/md5-sparc64.o
  LD [M]  arch/sparc/crypto/sha256-sparc64.o
  LD [M]  arch/sparc/crypto/crc32c-sparc64.o
  LD [M]  arch/sparc/crypto/sha512-sparc64.o
  AR      arch/sparc/crypto/built-in.a
  AR      arch/sparc/net/built-in.a
  AR      arch/sparc/kernel/built-in.a
  AR      arch/sparc/mm/built-in.a
  AR      arch/sparc/math-emu/built-in.a
  AR      arch/sparc/built-in.a

...
$ reboot
...
$ uname -a
Linux ttip 5.8.0-11991-gfc80c51fd4b2-dirty #23 SMP Mon Aug 10 12:17:12
MSK 2020 sparc64 GNU/Linux
