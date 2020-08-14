Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7ECC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788F4207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597423349;
	bh=d9BdbP4v4mPSDocV/X8+coEoeF/GEtkKDXHdvTvLuJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KW5utV1c1GrQ6ieBJOCHjkLNEeOdkjh3rd+XTBiQrBnSh7sLWjDSnHCK9ns3BODgI
	 MRwFhfkkjujLgpAs3TgYkX4s1QLL7fq/romvcBMc4PpsiHVEc9Q7JlgXjWAllMp5Mz
	 lggh4H0KrAZ+OyRG9tywWOoIasHeH8dkHIOVj1Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgHNQm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgHNQmZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:42:25 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4CD20855
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 16:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597423344;
        bh=d9BdbP4v4mPSDocV/X8+coEoeF/GEtkKDXHdvTvLuJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1xJwF7/Z5fXekgvEA4/s8tnI3lcrFDZ98TP7EG6yuS8XsxBej+56+3k6/PMJkPC58
         y3qZKfLadclxFXM4dqw4Rwm1JMXDpFOx8VVUY5jg5ea8IX+IbDD9/2DjKVbfP9fcib
         inC92fPJcUFr6vRgYO5d8mZLHIljXZj+HQgN9m60=
Received: by mail-wr1-f51.google.com with SMTP id l2so8891941wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:42:24 -0700 (PDT)
X-Gm-Message-State: AOAM5337+yUzRFpIaGcZQEsKHYFM9l17H7pHMPmDoipRfxzXtMBg7eYy
        8jstQhwBfOh07SnHRtoxWVc2HvdpWGCWHTYw2fE6AQ==
X-Google-Smtp-Source: ABdhPJx0QaAUcNfSeXLu/stSOna5JR3L8S7t74nSnFtCX82+18VMezwOCF6D8vKUwpCcNllN0B49x2PvIki11hNqfN0=
X-Received: by 2002:adf:e90f:: with SMTP id f15mr3538919wrm.18.1597423342736;
 Fri, 14 Aug 2020 09:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <87y2onbdtb.fsf@nanos.tec.linutronix.de> <8E41B15F-D567-4C52-94E9-367015480345@amacapital.net>
 <20200616132705.GW2531@hirez.programming.kicks-ass.net> <20200617131742.GD8389@yuki.lan>
 <CALCETrVX=wxRrv0qw-Enbyg5CEQsy5TigbNt7sSs=MDO6uAnMw@mail.gmail.com>
 <20200812093114.GA13676@yuki.lan> <20200814145823.GA13646@yuki.lan>
In-Reply-To: <20200814145823.GA13646@yuki.lan>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 14 Aug 2020 09:42:11 -0700
X-Gmail-Original-Message-ID: <CALCETrUZO7ifrQPKks=LuUoTcPcM7nE_TjaCXWpwMm8TOZLzDg@mail.gmail.com>
Message-ID: <CALCETrUZO7ifrQPKks=LuUoTcPcM7nE_TjaCXWpwMm8TOZLzDg@mail.gmail.com>
Subject: Re: [LTP] [x86/entry] 2bbc68f837: ltp.ptrace08.fail
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 7:58 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > do_debug is a bit of a red herring here.  ptrace should not be able to
> > > put a breakpoint on a kernel address, period.  I would just pick a
> > > fixed address that's in the kernel text range or even just in the
> > > pre-KASLR text range and make sure it gets rejected.  Maybe try a few
> > > different addresses for good measure.
> >
> > I've looked at the code and it seems like this would be a bit more
> > complicated since the breakpoint is set by an accident in a race and the
> > call still fails. Which is why the test triggers the breakpoint and
> > causes infinite loop in the kernel...
> >
> > I guess that we could instead read back the address with
> > PTRACE_PEEKUSER, so something as:
> >
> >
> > break_addr = ptrace(PTRACE_PEEKUSER, child_pid,
> >                     (void *)offsetof(struct user, u_debugreg[0]),
> >                     NULL);
> >
> > if (break_addr == kernel_addr)
> >       tst_res(TFAIL, "ptrace() set break on a kernel address");
>
> So this works actually nicely, even better than the original code.
>
> Any hints on how to select a fixed address in the kernel range as you
> pointed out in one of the previous emails? I guess that this would end
> up as a per-architecture mess of ifdefs if we wanted to hardcode it.
>

It's fundamentally architecture dependent.  Sane architectures like
s390x don't even have this concept.

--Andy
