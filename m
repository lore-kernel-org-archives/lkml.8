Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91BCC4BA26
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F87F20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582743454;
	bh=263+2Qae8Kqap3erMnb9MSbkUoftrhltl7o6zqVh7+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WereRete0Bsfv5/N8QAWXD8aiock28QOfP4ntsfSCDSGXnW/YKrpLXN+e4p2UQnyV
	 tbNktsPSUtZPJjhNpd7bTB36q1YInsjX3Q87BaZFfBcUUoAMrFOONqSDEFuGp5uCrb
	 5OJzkmcFcHLyUay7f0YFpSg3q4NtNPY6MW2rqKos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgBZS5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 13:57:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727277AbgBZS53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 13:57:29 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9B724679
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 18:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582743449;
        bh=263+2Qae8Kqap3erMnb9MSbkUoftrhltl7o6zqVh7+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=srQKMFeiR0dTRIXSHWHYLl2iz8oE7b7GTqfeRPsVY9CZZkDz34mTvmzjw2+1jUOKl
         VJ20xN8oud6ujaR20vlga6FrfFMQkYeLdOWqymuj4ZJLnR6HW7QCShOfduegpuIuCv
         hQrhFlE87LAaEtOXtWRitsGLQSYYHHb98+9D7qoA=
Received: by mail-wr1-f46.google.com with SMTP id y17so44855wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 10:57:28 -0800 (PST)
X-Gm-Message-State: APjAAAXKFX86ArLrrhdiazGp7ekhiHmLIuDt8bFr/E/mAdhJS9f63D66
        m30A0B5gkIOQUDpmdymLav0iGwPly+kE2xaImTtapg==
X-Google-Smtp-Source: APXvYqzQunJDgv35NJK+eWspjHq40Ddi4gqQIQ897xMQZ+g6AVZrRX449QkqAj38vkmCp+RRfwX9IDd+iCE5OB7VH20=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr59328wrm.75.1582743447224;
 Wed, 26 Feb 2020 10:57:27 -0800 (PST)
MIME-Version: 1.0
References: <20200225213636.689276920@linutronix.de> <20200225220216.933457250@linutronix.de>
 <6dd020cd-e20a-be12-aba7-bfa9e1a94795@kernel.org> <87blpli40i.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blpli40i.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 26 Feb 2020 10:57:16 -0800
X-Gmail-Original-Message-ID: <CALCETrXbNQJyvDEkfi0f0P3r+zrz8h7cPMaWB0PM_eTkFEAF0w@mail.gmail.com>
Message-ID: <CALCETrXbNQJyvDEkfi0f0P3r+zrz8h7cPMaWB0PM_eTkFEAF0w@mail.gmail.com>
Subject: Re: [patch 08/10] x86/entry/32: Remove the 0/-1 distinction from
 exception entries
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
>
> > On 2/25/20 1:36 PM, Thomas Gleixner wrote:
> >> Nothing cares about the -1 "mark as interrupt" in the errorcode anymore. Just
> >> use 0 for all excpetions which do not have an errorcode consistently.
> >>
> >
> > I sincerely wish this were the case.  But look at collect_syscall() in
> > lib/syscall.c.
> >
> > It would be really quite nice to address this for real in some
> > low-overhead way.  My suggestion would be to borrow a trick from 32-bit:
> > split regs->cs into ->cs and ->__csh, and stick CS_FROM_SYSCALL into
> > __csh for syscalls.  This will only add any overhead at all to the int80
> > case.  Then we could adjust syscall_get_nr() to look for CS_FROM_SYSCALL.
> >
> > What do you think?  An alternative would be to use the stack walking
> > machinery in collect_syscall(), since the mere existence of that
> > function is abomination and we may not care about performance.
>
> Looking deeper. The code in common_exception does:
>
>         movl    PT_ORIG_EAX(%esp), %edx         # get the error code
>         movl    $-1, PT_ORIG_EAX(%esp)          # no syscall to restart
>
> So whatever the exception pushed on the stack the thing what
> collect_syscall finds is -1.
>
> The pushed value is used as the error_code argument for the exception
> handler and I really can't find a single one which cares (anymore).
>
> But darn and I overlooked that, it's propagated to do_trap() and
> friends, but even if this causes a user visible change, I doubt that
> anything cares about it today simply because for giggles a 64bit kernel
> unconditionally pushes 0 for all exceptions which do not have a hardware
> error code on stack. So any 32bit application which excpects a
> particular error code (0/-1) in the signal would have been broken on the
> first day it ran on a x64 bit kernel.
>
> If someone yells regression, then that's really trivial to fix in
> C-code.

I *think* this is plumbed much more directly to userspace:

$ cat /proc/$$/syscall
61 0xffffffff 0x7ffccf734ed0 0xa 0x0 0x1 0x0 0x7ffccf734eb8 0x7f0667465eda

That entire feature is highly dubious and I suppose we could just
delete it.  But right now, we at least pretend that we can tell,
totally asynchronously, whether another task is in a syscall.  Unless
we do *something*, though, I think you shouldn't make this change.

Sticking 0 in the error_code field in ucontext for a signal with no
error code seems entirely harmless to me in contrast.
