Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93B5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCD3720782
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 20:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="dOKbvIV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgGCU2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCU2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 16:28:13 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35E9C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 13:28:13 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i18so28211468ilk.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 13:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSdPZ0Xf9SbZ/j4zpvEuUBegtTwETFs5kl/CaJVO1U8=;
        b=dOKbvIV1ymLD4mO7CkHz26yQtEJjvk6LrZj3KT60xk7dXZEZ+M+Oaf9MNL3hgRNJfV
         PuFLSZ9Ztgxu4TZRhqyfaBZLKi9axi08nM0CJE/mPmLEPqwbDgItORPyYhgE28pcSrTD
         gjn+VygMELzdNg6m87TVZujBHZVdliCGJT81xC74M39sysVBiOBxA0NBJ8UBwKqO4c00
         TMPKW8XzDY947f9pbQWyU3fDi3R+TJN7AdCT2nfrp5AxII+HftDd3XVy5FD+znHkZQvt
         jjqfnBa1OeHSBQ2uaOPFXHKX51fT/fgLaEmJ/Xsv5udFfqmkm22yGk77UweFKiFShrio
         DqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSdPZ0Xf9SbZ/j4zpvEuUBegtTwETFs5kl/CaJVO1U8=;
        b=pxqmkzfK2CG5RqdIWJQuWekpUviveS4tBS4CDZ3Cn8BL0UJjiHLoY0B/ANxMRmVYcJ
         GBJARJUkLpdUMr1DwzTdoLHqufh4XB84VF8G+Vg8UrU6LeiYT5b6shph8GVANK/6CJof
         c8c9B7G0NZ5Yeoo7Jl4zeMZ66lMgDgR+Z9AXXjzmqk0+6uqwvg7mG5havYqDMm4s2JrX
         a1GzTn3+RrpYXIV9raS3ko6NuSbCKi+GiwTPonGF0OKKX+ygDBvCmTNXRhjcRX3SR0Sn
         C6Q992b740vl3EV0Kwlzfqr56wvv7P/q9abBSnNTa6yeXSvQr/FFRQstr9lZVTCyKCz5
         NA6Q==
X-Gm-Message-State: AOAM5332B8k7omywoqol1I2QpYui8Z+5teJzkUrooHBAZaeDy+fv064c
        jdG8uB0cJh660UzUrsT6OPoskAe7Pzd04qFI+QQrYg==
X-Google-Smtp-Source: ABdhPJw3/7XShKtON0RVn8qu9ZJNiKz0IrSIIua2WTfbikiHO6P6cmioB417VcK+loMpRGW1Rb3P1p/C2OslQZUc8Eo=
X-Received: by 2002:a05:6e02:1253:: with SMTP id j19mr19674895ilq.145.1593808093006;
 Fri, 03 Jul 2020 13:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
In-Reply-To: <20200703083914.GA18516@willie-the-truck>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Fri, 3 Jul 2020 16:27:37 -0400
Message-ID: <CABV8kRwYp9cvu1b4-fhHktyX_r2QiObhadJ4pqscvuLt1BtRvg@mail.gmail.com>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
To:     Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Now, if we have a seccomp filter that simply does
> > SECCOMP_RET_TRACE, and a ptracer that simply
> > does PTRACE_CONT
>
> Ok, so this means that we're _skipping_ the system call, right?

If the system call were positive this would result in the system call
being executed. The notion of "skipping" the syscall is a bit odd in
this situation. Having the ptracer set the syscallno to -1 is generally
accepted as the way to do it, but what happens if the syscallno is
already -1 or negative is underspecified.

> > then the assert will fire/fail on arm64, but not on x86_64.
>
> It feels weird to me that skipping the system call has any effect on the
> tracee registers...

I think the correct way to frame it is to ask whether the behavior
matches that of the tracee in absence of the ptracer. I would argue
that if the ptracer doesn't explicitly modify register contents, then
the tracee shouldn't observe any behavior difference.

> > Interestingly, arm64 does do something different
> > if the syscall is -1 rather than -10, where early
> > in the ptrace stop it does.
> > ```
> > /* set default errno for user-issued syscall(-1) */
> > if (scno == NO_SYSCALL)
> >     regs->regs[0] = -ENOSYS;
>
> ... so I think this should be fixed too. How about the diff below?

I think the patch behavior is better overall, but I'm not sure it's ideal.
I think the biggest question is what the behavior should be here and
if we want a behavioral difference between *the syscall was -1 at entry*
and *the syscall was -1 because the ptracer wanted to skip the syscall*.
I think there is a bit of a semantic disconnect because "skipping" the
syscall is not really an operation that the ptracer has at its disposal
(unless it's using SYSEMU of course). The only thing it can do is set
the syscall to -1. However, arguably that already has semantics
(of returning -ENOSYS), so it's not at all clear to me that we should
deviate from that. Unfortunately, none of this is currently consistent
across architectures, so I think before we go changing arm64, we
should decide what we'd like to happen in theory and then see
what we can do to improve the situation without being too breaking.

Keno
