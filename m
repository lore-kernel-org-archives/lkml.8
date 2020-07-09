Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B64C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5162070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 23:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594336547;
	bh=WKp2RVFe68SGsfy7Hqg46eACLbZJztj8u5UjJnydzJw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=I2Yj81D1oUxo9LHEsseeJeydIiai9RPQOmqPw8ekkM/WUkWT8KFaIWyuTKs7S78bU
	 bFFz9UsHF38+QCpMKkBUBUXhrUsgXb/k0wfFyGAGYvRW9qXDI7vE1IlKrGJVG1GzYG
	 wBHtkf+6XerMWRX64X6hCjWmNNIm1E/Lg7Buzeqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgGIXPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 19:15:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgGIXPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 19:15:45 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9373420786;
        Thu,  9 Jul 2020 23:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594336544;
        bh=WKp2RVFe68SGsfy7Hqg46eACLbZJztj8u5UjJnydzJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sTKNHyrGxjZHVmElPsUrMB0oPbGEmh5sIBbuCWoItrDYOtZOQtKBzRCD1UOwRW0ps
         xYuzzensHJN29VXkbSU6m244+1lhHoeEjAUc8IQj6dY7k1sZULyLeqTvV0ZhOND5I2
         qIvmbbAXmhQevnKbX//nYKBoVOqX97awD/JvDNdA=
Received: by mail-lj1-f180.google.com with SMTP id h19so4255625ljg.13;
        Thu, 09 Jul 2020 16:15:44 -0700 (PDT)
X-Gm-Message-State: AOAM532uWMyOy5m3fbk7zDok68KOihMBZRyldLWzAHuloYpDFEvb4KkP
        U8SjEndGk57z1Lt/5BO+kC3sQNO0yZBP2V3UvjM=
X-Google-Smtp-Source: ABdhPJwP3mup+JqlbZ3i4TpJbfsI0x3PxwcNYP4Z+8OXIGKrTQvFVgXB2+LnS3GVk56FcdbCumxmhbXp3nvJtI9dPx4=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr16456695ljb.265.1594336542920;
 Thu, 09 Jul 2020 16:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org> <mhng-af022fcc-7dce-4d1b-9204-d31241538412@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-af022fcc-7dce-4d1b-9204-d31241538412@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 10 Jul 2020 07:15:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRQkEM7zR06GYOGhT_Aerhc9vRNaxsDZ-jVCHyEodnXcg@mail.gmail.com>
Message-ID: <CAJF2gTRQkEM7zR06GYOGhT_Aerhc9vRNaxsDZ-jVCHyEodnXcg@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] riscv: Enable LOCKDEP
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Palmer

On Fri, Jul 10, 2020 at 6:06 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Sat, 27 Jun 2020 06:57:05 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Lockdep is needed by proving the spinlocks and rwlocks. To support it,
> > we need to add TRACE_IRQFLAGS codes in kernel/entry.S. These patches
> > follow Documentation/irqflags-tracing.txt.
> >
> > Fixup 2 bugs that block the lockdep implementation.
> >
> > ---
> > Changes in v2
> >  - Remove sX regs recovery codes which are unnecessary, because
> >    callee will handle them. Thx Greentime :)
> >
> >  - Move "restore a0 - a7" to handle_syscall, but if _TIF_SYSCALL_WORK
> >    is set, "restore a1 - a7" is still duplicated. I prefer a C wrapper
> >    for syscall.
> >
> > Guo Ren (2):
> >   riscv: Fixup static_obj() fail
> >   riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT
> >
> > Zong Li (1):
> >   riscv: Fixup lockdep_assert_held with wrong param cpu_running
> >
> >  arch/riscv/Kconfig              |  3 +++
> >  arch/riscv/kernel/entry.S       | 33 ++++++++++++++++++++++++++++++++-
> >  arch/riscv/kernel/smpboot.c     |  1 -
> >  arch/riscv/kernel/vmlinux.lds.S |  2 +-
> >  4 files changed, 36 insertions(+), 3 deletions(-)
>
> These are on for-next.  As far as I can tell lockdep is working, but I'm just
> doing some simple boot tests.
>
> Thanks!



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
