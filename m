Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C648C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0571B206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591902666;
	bh=oCuaCcJcNwL+Kgm47//LjwIWmVDvEilE+aEhhdbEjzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zBsam9GmCdWCKi2k8OVJuaParCbGXlljU/MS9OytpzI3/oTOcqlSOcYwEafTHedAJ
	 tVZpONYHKIO5JIchGiejGnm24EIAzi6tRvEkeuZbwFwEsyLAWaYBVIm9jnj5IkTn3b
	 TmxYeNfqCk4HuAIRNt2DPzqr5yAnNQZU8SyRG9Ko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgFKTLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgFKTLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:11:04 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559262073E
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591902663;
        bh=oCuaCcJcNwL+Kgm47//LjwIWmVDvEilE+aEhhdbEjzE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TLDdSHo6/NkPPsh9H7qy3Sfbes8dvePZ8zDWtPhNtpjmwUOh3hrYehtn4hF73sBD8
         sI4xuz69EyihQAiCpepJv/fPgvFjr9c1IbyBrKpy+zZlhif+aPvCTU2JHxHyatyLq+
         fEXhRUos3y/LVy4RS0idohYf2lb3IPlF03royts4=
Received: by mail-wm1-f41.google.com with SMTP id f185so6091459wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:11:03 -0700 (PDT)
X-Gm-Message-State: AOAM5318INrFSE02NwUJq6UpYUyJ1bI8yDx8WOKpHMWmgejVVKcocJdJ
        1+T+zRMosh7JW9Lql3/ek3Rj/MRb7r54fDN8q0j5Rg==
X-Google-Smtp-Source: ABdhPJx+6gnkXRA9GM9BkUDtcRhS463HWcWMYDs3aySp5Lk1ivyzfAQAqHmM/zKtC2nLkLgDUl44W8FEpo7Tk6MRT7o=
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr9576464wmd.138.1591902661891;
 Thu, 11 Jun 2020 12:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
In-Reply-To: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jun 2020 12:10:50 -0700
X-Gmail-Original-Message-ID: <CALCETrXqhwJzhsAoM72tskso5aDELgfGLnHdGYHiAFmgCPforQ@mail.gmail.com>
Message-ID: <CALCETrXqhwJzhsAoM72tskso5aDELgfGLnHdGYHiAFmgCPforQ@mail.gmail.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
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

On Thu, Jun 11, 2020 at 11:56 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> While running perf test and selftest x86 single_step_syscall_32 on
> i386 kernel linux
> next 5.7.0-next-20200610 kernel warning noticed.
>
> steps to reproduce:
> --------------------------
> perf test
> and
> cd /opt/kselftests/default-in-kernel/x86
> ./single_step_syscall_32
>
> perf warning log:
> ----------------------
> [   57.260865] ------------[ cut here ]------------
> [   57.266576] IRQs not disabled as expected
> [   57.270583] WARNING: CPU: 1 PID: 500 at
> /usr/src/kernel/arch/x86/entry/common.c:624
> idtentry_exit_cond_rcu+0x92/0xc0
> [   57.281092] Modules linked in: x86_pkg_temp_thermal fuse
> [   57.286406] CPU: 1 PID: 500 Comm: perf Not tainted 5.7.0-next-20200610 #1
> [   57.293190] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [   57.300577] EIP: idtentry_exit_cond_rcu+0x92/0xc0
> [   57.305280] Code: 8b 89 d8 05 00 00 85 c9 74 ae 80 3d b1 64 2c d4
> 00 75 a5 68 94 2d fb d3 89 55 f8 89 45 fc c6 05 b1 64 2c d4 01 e8 8e
> f5 2b ff <0f> 0b 58 8b 55 f8 8b 45 fc eb 83 8d 76 00 e8 5b fd ff ff c9
> c3 89
> [   57.324017] EAX: 0000001d EBX: 0d00022a ECX: 00000027 EDX: f5b9e14c
> [   57.330274] ESI: f2a2ffb4 EDI: ffff0ff4 EBP: f2a2ff8c ESP: f2a2ff80
> [   57.336531] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010096
> [   57.343345] CR0: 80050033 CR2: 08700a58 CR3: 14ad7000 CR4: 003406d0
> [   57.349608] DR0: 080dfb80 DR1: 080dfc00 DR2: 08700a58 DR3: 00000000
> [   57.355866] DR6: fffe0ff0 DR7: 0d00062a
> [   57.359697] Call Trace:
> [   57.362143]  exc_debug+0x84/0x1b0
> [   57.365487]  ? exc_int3+0x1d0/0x1d0
> [   57.368981]  handle_exception+0x145/0x145
> [   57.372991] EIP: 0x80dfbcd
> [   57.375694] Code: Bad RIP value.
> [   57.378918] EAX: 00000000 EBX: 00000005 ECX: 00002400 EDX: 00000000
> [   57.385175] ESI: 00000003 EDI: 00000004 EBP: bfd59798 ESP: bfd59770
> [   57.391431] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
> [   57.398215] irq event stamp: 1896

A regrettable property of the current entry code structure is that we
lose any real indication of the vector.  Presumably this is #DB, hence
exc_debug.  I don't know what perf has to do with it.

I'll bang on this after lunch if no one beats me to it.
