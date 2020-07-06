Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B00C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142F120739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593996953;
	bh=RHq2frbr5C2baeMa24wuxuxZcDCDS1+l6jz9s81NhXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gciFCKIuvVeIWMyKSn7lz1yAxavYyjv5SOM4wNK8NJ//VA3iqApPx95uVxKzMPuZe
	 17bWaoVn9u0HAB+KOJWo4Zcqy88uYRAI0ibJ1HLxIp09t8ofgEsrJvqYM4NA2fGHw7
	 7/VXTtRnQvDPNmQu193c++vVXAPuytgQbpuO+quk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgGFAzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:55:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgGFAzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:55:49 -0400
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F4DF20786;
        Mon,  6 Jul 2020 00:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593996948;
        bh=RHq2frbr5C2baeMa24wuxuxZcDCDS1+l6jz9s81NhXo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DbxuE8Ja5OroOh1pVX2wqFvRGK1khawlOaVNo+AECDr0akQUHQWP9vJGAXE2EQOPh
         VJOTas95HHPDyo65YRvvDv8SQszatJW6Y9wUYSXK5QyNRpV6KlIhg43qh+9kMHY3Xf
         p5N838jjl7Z+aNhZ5g3yWN54RIpBtqop8uHbrJqs=
Received: by mail-lj1-f181.google.com with SMTP id n23so43420151ljh.7;
        Sun, 05 Jul 2020 17:55:48 -0700 (PDT)
X-Gm-Message-State: AOAM532QxEJhpA2iHCm2HlZF0jH7ZvFOySkJFCBtkj3uWesOaGupDZK4
        7RZI+ChkycDdWt12PCuXco4qk74kRvy0bsC4Fqc=
X-Google-Smtp-Source: ABdhPJyqg4cj0aC4F94U/7Fo1d/pfDDfpEAE94q72fMqGwsQBE7GhkSUNlvcT9PsuxV5GVDiB93U5qFrLHBSMAj0AvA=
X-Received: by 2002:a05:651c:111:: with SMTP id a17mr3380595ljb.265.1593996946540;
 Sun, 05 Jul 2020 17:55:46 -0700 (PDT)
MIME-Version: 1.0
References: <1593930255-12378-1-git-send-email-guoren@kernel.org>
 <202007042350.4C153C4F8@keescook> <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
 <202007051328.FE9EF99@keescook>
In-Reply-To: <202007051328.FE9EF99@keescook>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 6 Jul 2020 08:55:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTCEEoP3a9i_REXPwkJZ4Si_hYfjk_hwqHxkyfgw_xBLw@mail.gmail.com>
Message-ID: <CAJF2gTTCEEoP3a9i_REXPwkJZ4Si_hYfjk_hwqHxkyfgw_xBLw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add STACKPROTECTOR supported
To:     Kees Cook <keescook@chromium.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Atish Patra <atish.patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 4:31 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jul 05, 2020 at 10:16:14PM +0800, Guo Ren wrote:
> > On Sun, Jul 5, 2020 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
> > > On Sun, Jul 05, 2020 at 06:24:15AM +0000, guoren@kernel.org wrote:
> > > > +static __always_inline void boot_init_stack_canary(void)
> > > > +{
> > > > +     unsigned long canary;
> > > > +
> > > > +     /* Try to get a semi random initial value. */
> > > > +     get_random_bytes(&canary, sizeof(canary));
> > > > +     canary ^= LINUX_VERSION_CODE;
> > > > +     canary &= CANARY_MASK;
> > >
> > > Does riscv have any kind of instruction counters or other trivial timers
> > > that could be mixed in here? (e.g. x86's TSC)
> > Do you mean:
> >   get_random_bytes(&canary, sizeof(canary));
> > + canary += get_cycles64() + (get_cycles64() << 32UL);
> >   canary ^= LINUX_VERSION_CODE;
> >   canary &= CANARY_MASK;
> >
> > Ok ?
>
> Sure -- I assume get_cycles64() is architecturally "simple"? (i.e. it
> doesn't require that the entire time-keeping subsystem has started?)
Yes, it's just a csr read. But it's necessary? get_random_bytes should enough.

>
> > >
> > > > +
> > > > +     current->stack_canary = canary;
> > > > +     __stack_chk_guard = current->stack_canary;
> > >
> > > What's needed for riscv to support a per-task canary? (e.g. x86's TLS or
> > > arm64's register-specific methods)
> > Some archs change __stack_chk_guard in _switch_to of entry.S, but it
> > depends on !CONFIG_SMP.
>
> Oh, funny. I hadn't actually noticed that logic for the !CONFIG_SMP
> cases. I see to problem with that, but the more important case, I think
> is the per-task canaries.
Maybe some race condition problems. When canary changed the in the
switch to, but other CPUs still get that value concurrently.

>
> > #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
> >         get  value  from next_task->stack_canary
> >         store  value to __stack_chk_guard
> > #endif
> >
> > It's a so limitation solution for per-task canary, so I didn't copy it
> > into riscv?
>
> Right -- it's a limited solution. On the other had, is !CONFIG_SMP
> expected to be a common config for riscv? If so, it's worth adding. If
> not, I'd say skip it. (Though it looks very simple to do...)
CONFIG_SMP is mostly default for me and let's talk about arm64/x86
per-task solution. That is the right way.


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
