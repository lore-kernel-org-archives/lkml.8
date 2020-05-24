Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89AEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 06:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982852076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 06:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="sKmEqVf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgEXG5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 02:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgEXG5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 02:57:12 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9F1C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 23:57:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f3so15857791ioj.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 23:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noxFunX2uI/FVRTYdrIrdHqbpc9T4lCMyDInJvvG8rs=;
        b=sKmEqVf0g2OLue9Rp1A/WkSXf70RjVaTuI3MbjU8wS/C7acN/fmBvNE67EieNmqvMf
         jRe1vfe9CkK76yclpUEWyB5YXYSqHDFJ772rO2kUs4rM8fmV6bBR7xZPMoIXLwN4m3hq
         81SmFj/W6fm/8MOEpkzOpx48SdpvSfHm/VTOXCmuHsaFKpvKF9qbFyprxsq8P8Gd2i8i
         3MT3a3JnCibxEtC7K1Gjrw0WVb8WJpIPXqWIPvI9qnsqInY1p0gQ7hSWbyLLxNTNn1ta
         ezpvkeuMoxqR9Um0oPBP4N58/efb+RFrBlPbDxXOdHsAe7izw0VhQD7R3e4ueAIVhQX9
         VlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noxFunX2uI/FVRTYdrIrdHqbpc9T4lCMyDInJvvG8rs=;
        b=Nv/tSBMUqpREV+XQ0PWzJJ2m/KAB6LdNVm6bg9HU3WtSw9coFub2JfXvAluKpO82/V
         0AMA52pQaLKRPvAZbOI5EVZ/2rrOnbNH4B49UnR0qGPEAqzo4kDgNpT7pk6L1nx8IJv1
         m5aNiBDdKcThDkXufZnj2UkFQVH9K24DrpYSOFpBK2KVKNigMMACnCtKhtyjmYE3FLwR
         cMb3bvWzy8x3OZvECeQySLnqSFPOql3ARmF6asic8gqt1gd/f8i7eykZYeAW2IxdFr0w
         35uBSkNt/50vd/QPx3VgRbJEV/7JhuMsr2GBo5jFG6iYd0pO0YBZwdxbM/DlfQfXLES2
         XwzA==
X-Gm-Message-State: AOAM5309SUiih/il20ICY2k9av6g/vbW1ZvF1tTXe88kJ8ZIiaBEtVnx
        DcoXuBH8bo4VcfbNLUw1xL8Xj5opavARcPdVDwwV0w==
X-Google-Smtp-Source: ABdhPJxsTmfAXqCTWeb8LCoLtGraNutbh1nU/LqHMh/NN3fmkihgGKjA1xwD+BPQlycsQL4PiIDH6n1Yr02j9d+i0Mo=
X-Received: by 2002:a6b:6b04:: with SMTP id g4mr9182371ioc.75.1590303430943;
 Sat, 23 May 2020 23:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck> <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck> <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
In-Reply-To: <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Sun, 24 May 2020 02:56:35 -0400
Message-ID: <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
Subject: Re: arm64: Register modification during syscall entry/exit stop
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <khuey@pernos.co>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just ran into this issue again, with what I think may be most compelling
example yet why this is problematic:

The tracee incurred a signal, we PTRACE_SYSEMU'd to the rt_sigreturn,
which the tracer tried to emulate by applying the state from the signal frame.
However, the PTRACE_SYSEMU stop is a syscall-stop, so the tracer's write
to x7 was ignored and x7 retained the value it had in the signal handler,
which broke the tracee.

Keno

On Sat, May 23, 2020 at 1:35 AM Keno Fischer <keno@juliacomputing.com> wrote:
>
> I got bitten by this again, so I decided to write up a simple example
> that shows the problem:
>
> https://gist.github.com/Keno/cde691b26e32373307fb7449ad305739
>
> This runs the same child twice. First vanilla where it prints "Hello world".
> The second time, using a textbook ptrace example, to only print "world".
> The problem here is that by the time the ptracer gets around to restoring
> the registers, it's no longer in a syscall stop, so the write to x7 does not
> get ignored and the correct value of x7 gets clobbered.
> I copied the syscall definition from musl, so the compiler thinks x7 is
> live, and we can see an assertion.
>
> Output on my machine (will depend on compiler version, etc.):
> ```
> $ gcc -g3 -O3 ptrace_lies.c
> $ ./a.out
> Hello World
> World
> a.out: ptrace_lies.c:49: do_child: Assertion `v3 == values[2]' failed.
> a.out: ptrace_lies.c:134: main: Assertion `WIFEXITED(status) &&
> WEXITSTATUS(status) == 0' failed.
> Aborted (core dumped)
> ```
>
> However, I don't think that whether or not the compiler thinks that x7 is
> live is the problem here. The problem is entirely that this mechanism
> prevents the ptracer from precisely controlling the register state. While
> basic ptracers don't need this feature (strace),
> more advanced ptracers (think criu, etc.) absolutely do want to precisely
> control what the register state is.
> The ptracer I'm working on (https://rr-project.org/)
> happens to be an extreme case of this, where it wants *bitwise* equivalent
> register states such that it can run the same code many times and get
> the exact same results.
>
> Also, if the issue was just that the kernel clobbered x7, that would be fine
> we could deal with that no problem. However, it's much worse than that,
> because the behavior of the kernel with respect to x7 depends on what
> kind of ptrace stop we're in and even worse, in some kinds of stop,
> there's absolutely no way to get at the actual value of x7.
>
> > Hmm, does that actually result in the SVC instruction getting inlined? I
> > think that's quite dangerous, since we document that we can trash the SVE
> > register state on a system call, for example. I'm also surprised that
> > the register variables are honoured by compilers if that inlining can occur.
>
> I haven't gotten to trying SVE yet, so I appreciate the warning :). That said,
> deterministic clobbering of registers is fine. Even changing the registers to
> random junk is fine. We're happy to read those registers through ptrace.
> The problem here is that the kernel lies about what the contents of the x7
> register is and discards any writes to it.
>
> I really hope we can come up with a solution here, I'm already dreading
> the next time I unexpectedly run into this and have to add yet
> another special case :(.
>
> Keno
