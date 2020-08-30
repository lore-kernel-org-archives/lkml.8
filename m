Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B5FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9454F2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598802776;
	bh=OS6SXiqY+lshjjjCn0KjODoLYajvf991ognvS2HPuKs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CNFoSBai3dj38jCx9MNoV9ZAm9txyVabKlu1A1yJzWcAZhBBNGaeqvdWT2Xk4ainX
	 /n+9g4jcbIpSzheABFxRVRbWFn3UDX2NmYq+t/bz9D4hmrzYIqZY35YYLkhBy65Nm0
	 lMjfLLcoqMF0Gfq3TCpXHIXNsGNdRVGZ/tTeZoK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgH3Pww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgH3Pwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:52:47 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E23D220EDD
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 15:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598802766;
        bh=OS6SXiqY+lshjjjCn0KjODoLYajvf991ognvS2HPuKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NdzyBPliWINf0MX6JY+vAWcuFhZ24x7rCOZuGvhkw/NRRrQwv1fKvEf8LsNV0EpCN
         jzYoFt5T8CAo/RDgIKSC7RZoaIJ5Z/VPNiH5FqMahOxm2I85y2vpEVELc3hw0R1oYg
         2CzJSFHAy66HEqL5iHS/tTolWHetNUqGT8agDlaw=
Received: by mail-wm1-f45.google.com with SMTP id z9so3210297wmk.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 08:52:45 -0700 (PDT)
X-Gm-Message-State: AOAM533P9pf8bVkLs4+5jrlEYcNygjwDkcCny0MI7CeX5HsqEbKrzcj7
        qYV+M2tBKskhxCC7RGS27IVizcyy/knpUmg5TgJ0Mw==
X-Google-Smtp-Source: ABdhPJztsRRiZUaHkgWepEkB/Pn9/0WW0xMy61f55qTGBnf2A1p6r3o9jA8KDreDbwx5okjYm0jVUfFo4sMGnre0bQc=
X-Received: by 2002:a05:600c:2183:: with SMTP id e3mr7795286wme.49.1598802764333;
 Sun, 30 Aug 2020 08:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWXvAMA7tQ3XZdAk2FixKfzQ_0fBmyNVyyPHVAomLvrWQ@mail.gmail.com>
 <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
In-Reply-To: <CAMzpN2hmR+0-Yse1csbiVOiqgZ0e+VRkCBBXUKoPSTSMOOOFAQ@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 30 Aug 2020 08:52:33 -0700
X-Gmail-Original-Message-ID: <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com>
Message-ID: <CALCETrXY1x0MReMoTOG2awcZvr4c7gp99JVNthK37vUUk-kyew@mail.gmail.com>
Subject: Re: ptrace_syscall_32 is failing
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 9:40 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Sat, Aug 29, 2020 at 12:52 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > Seems to be a recent regression, maybe related to entry/exit work changes.
> >
> > # ./tools/testing/selftests/x86/ptrace_syscall_32
> > [RUN]    Check int80 return regs
> > [OK]    getpid() preserves regs
> > [OK]    kill(getpid(), SIGUSR1) preserves regs
> > [RUN]    Check AT_SYSINFO return regs
> > [OK]    getpid() preserves regs
> > [OK]    kill(getpid(), SIGUSR1) preserves regs
> > [RUN]    ptrace-induced syscall restart
> >     Child will make one syscall
> > [RUN]    SYSEMU
> > [FAIL]    Initial args are wrong (nr=224, args=10 11 12 13 14 4289172732)
> > [RUN]    Restart the syscall (ip = 0xf7f3b549)
> > [OK]    Restarted nr and args are correct
> > [RUN]    Change nr and args and restart the syscall (ip = 0xf7f3b549)
> > [OK]    Replacement nr and args are correct
> > [OK]    Child exited cleanly
> > [RUN]    kernel syscall restart under ptrace
> >     Child will take a nap until signaled
> > [RUN]    SYSCALL
> > [FAIL]    Initial args are wrong (nr=29, args=0 0 0 0 0 4289172732)
> > [RUN]    SYSCALL
> > [OK]    Args after SIGUSR1 are correct (ax = -514)
> > [OK]    Child got SIGUSR1
> > [RUN]    Step again
> > [OK]    pause(2) restarted correctly
>
> Bisected to commit 0b085e68f407 ("x86/entry: Consolidate 32/64 bit
> syscall entry").
> It looks like it is because syscall_enter_from_user_mode() is called
> before reading the 6th argument from the user stack.

Ugh.  I caught, in review, a potential related issue with exit (not a
problem in current kernels), but I missed the entry version.

Thomas, can we revert the syscall_enter() and syscall_exit() part of
the series?  I think that they almost work for x86, but not quite as
indicated by this bug.  Even if we imagine we can somehow hack around
this bug, I imagine we're going to find other problems with this
model, e.g. the potential upcoming exit problem I noted in my review.

I really think the model should be:

void do_syscall_whatever(...)
{
  irqentry_enter(...);
  instrumentation_begin();

  /* Do whatever arch ABI oddities are needed on entry. */

  Then either:
  syscall_begin(arch, nr, regs);
  dispatch the syscall;
  syscall_end(arch, nr, regs);

  Or just:
  generic_do_syscall(arch, nr, regs);

  /* Do whatever arch ABI oddities are needed on exit from the syscall. */

  instrumentation_end();
  irqentry_exit(...);
}

x86 has an ABI oddity needed on entry: this fast syscall argument
fixup.  We also might end up with ABI oddities on exit if we ever try
to make single-stepping of syscalls work fully correctly.  x86 sort of
gets away without specifying arch because the arch helpers that get
called for audit, etc can deduce the arch, but this is kind of gross.
I suppose we could omit arch as an explicit parameter.

Or I suppose we could try to rejigger the API in time for 5.9.
Fortunately only x86 uses the new APIs so far.  I cc'd a bunch of
other arch maintainers to see if other architectures fit well in the
new syscall_enter() model, but I feel like the fact that x86 is
already broken indicates that we messed it up a bit.

--Andy
