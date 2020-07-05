Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916EEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E07A2074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JDpzbBFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgGEUbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbgGEUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:31:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CF8C08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 13:31:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j20so437283pfe.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ur7mB1HQd3aacYwlGEFeNIXsEbUuMF415cElS3tVlkQ=;
        b=JDpzbBFHelJ+U3gs0XnqMdc/wE1/wEy2lbGSnkGrl84Cxopx0PV7YffkPDncy+PyuR
         XCG9Sqzhws6JDKzAfs4dnTSCmZ4jbLklFaKH1xvR6cHeQb7xmHJSxB1QSff5g07yw91J
         GmVq69VJBztKqy+z680mZmPxPEkKYR2EhdVyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ur7mB1HQd3aacYwlGEFeNIXsEbUuMF415cElS3tVlkQ=;
        b=GinsfaD5ZseIP8mXpBImcYboWOqAyvzQgaonKx3OYTMrIJzYNT5PTXKpVIlP6tpYpY
         dfCvU0FOdwYCel/YEufAK7Z8pUusJLRipMymV+v3zHup5cWzJYgk1HfdA0DwUxeNaGpy
         v/IPxNdvj7ZZ4vuMyA24NpeDkk7Yfh0uOp168UM5JVot08siCT/oXLU9r03oF8OY/Pwh
         IwFifP40ZkjExpiN3PPQTiM1ibhG2KelV68sUkw3lj1l9vFvKdHBuJenv22yKHyUAnxE
         0i1yoZIC3aND39Jm1Giucf2jepo9BYfBJxekRPMLpktYOW1d9RpHqj/+g9odBisYvY+q
         1m8w==
X-Gm-Message-State: AOAM533N1DG+mQc1n0+unttxWta/Jo3f6KZFl9iUtt84eP4XLiXAIg1N
        o9s0F/nNqTF9iugBf63aMUnxqg==
X-Google-Smtp-Source: ABdhPJxGflcwOaYyfs2gLTjaHiikusvtN11502CcX43vmcvaWqy2v3cL096nKsEZPkw+SWGXAu7ksA==
X-Received: by 2002:a62:164a:: with SMTP id 71mr43090161pfw.266.1593981113896;
        Sun, 05 Jul 2020 13:31:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m9sm1342538pjs.18.2020.07.05.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 13:31:53 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:31:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guo Ren <guoren@kernel.org>
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
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] riscv: Add STACKPROTECTOR supported
Message-ID: <202007051328.FE9EF99@keescook>
References: <1593930255-12378-1-git-send-email-guoren@kernel.org>
 <202007042350.4C153C4F8@keescook>
 <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 10:16:14PM +0800, Guo Ren wrote:
> On Sun, Jul 5, 2020 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
> > On Sun, Jul 05, 2020 at 06:24:15AM +0000, guoren@kernel.org wrote:
> > > +static __always_inline void boot_init_stack_canary(void)
> > > +{
> > > +     unsigned long canary;
> > > +
> > > +     /* Try to get a semi random initial value. */
> > > +     get_random_bytes(&canary, sizeof(canary));
> > > +     canary ^= LINUX_VERSION_CODE;
> > > +     canary &= CANARY_MASK;
> >
> > Does riscv have any kind of instruction counters or other trivial timers
> > that could be mixed in here? (e.g. x86's TSC)
> Do you mean:
>   get_random_bytes(&canary, sizeof(canary));
> + canary += get_cycles64() + (get_cycles64() << 32UL);
>   canary ^= LINUX_VERSION_CODE;
>   canary &= CANARY_MASK;
> 
> Ok ?

Sure -- I assume get_cycles64() is architecturally "simple"? (i.e. it
doesn't require that the entire time-keeping subsystem has started?)

> >
> > > +
> > > +     current->stack_canary = canary;
> > > +     __stack_chk_guard = current->stack_canary;
> >
> > What's needed for riscv to support a per-task canary? (e.g. x86's TLS or
> > arm64's register-specific methods)
> Some archs change __stack_chk_guard in _switch_to of entry.S, but it
> depends on !CONFIG_SMP.

Oh, funny. I hadn't actually noticed that logic for the !CONFIG_SMP
cases. I see to problem with that, but the more important case, I think
is the per-task canaries.

> #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
>         get  value  from next_task->stack_canary
>         store  value to __stack_chk_guard
> #endif
> 
> It's a so limitation solution for per-task canary, so I didn't copy it
> into riscv?

Right -- it's a limited solution. On the other had, is !CONFIG_SMP
expected to be a common config for riscv? If so, it's worth adding. If
not, I'd say skip it. (Though it looks very simple to do...)

-- 
Kees Cook
