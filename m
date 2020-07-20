Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6385CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4006D20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7Q4k8Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgGTIXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:23:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF66C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:23:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so8355247pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eN4OkOVVh5VOL/LJiI3jJKhYCr8KjA3UCEWR1N7qxR0=;
        b=g7Q4k8Z6VNQx0AQLnT8UFwU7I+0NvZqQbQxv1EqPkMpULMeJUBNIEA40g6JBl3SCnA
         lT9Tz5GjVs8bKVbFVc/alDvibfpMsyyJp6+5CEPIFePHKbrAeTbr1qswZNum4BGAOuMO
         S0MSs0t+coqG3Wh07ELq3ljjKEtzVShjnaFqskOmN27YJs7L06PAskI5dCUyYlB3SCJB
         DIFdyGKy8AQySrFp5KtSV2cKvHcJXI7saKDWjcGyZREeyem91AXPW3cPhAVapmGmSgpR
         rR2CKZNUYbVZ+SDr9zE8+geNANJOj61qVTl0tPyxbmbTW+6Kn08wgWhs+Cppd1PUlQRx
         DLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eN4OkOVVh5VOL/LJiI3jJKhYCr8KjA3UCEWR1N7qxR0=;
        b=W5Dq1Zzfco4/53X1eBwOn4N8sp8bNcuhDBZdFBOP1sovZfFuWCxKBOLcyst5chlXe7
         chgBso1IDhaJaAODY0NPS4EQp822dEuYqZXSPD+IOLlERAmoaSuwOsuV9wTGAcZxRHPQ
         6yVlD/xxyPdlNys7zo3YM2ZsUL6oiIVkHK6SJmxoXcAO+MBozH1aYoC8tyi8phhyIZDY
         +jub34QOkF58gxJnNqlK5OgOpbPXdfFw8iXmvegYKRUfklQ/zJinbWL0T4cxJvRz7V5W
         3IIaYYHO3OKGGQMWbkedflP0Ksh+QXCeHT1s1TMfjntsxiiXfLk4KKSB4lp6Q8AL7FZy
         6asQ==
X-Gm-Message-State: AOAM531AoPRZOOoWQEBB0dVbmmjOkz3Ht83U9TYHlWpvWIT0itLX4zBm
        RxbnYE2LqS3zVGdT938mxzOI3UN5kTyG3mVm/ERU2v1t
X-Google-Smtp-Source: ABdhPJzZwNspZ8QltnkExGcT0Zy2sUrQXtZ04IsToNu1KhH2D5HZ0B5v13zQbCJwWSwcIT+cVWvkOHedNjUsD85GrS0=
X-Received: by 2002:a17:902:8491:: with SMTP id c17mr16834730plo.262.1595233388018;
 Mon, 20 Jul 2020 01:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de> <20200718121053.GA691245@elver.google.com>
 <20200719034312.GA566736@jagdpanzerIV.localdomain> <20200720064303.GA2144711@elver.google.com>
In-Reply-To: <20200720064303.GA2144711@elver.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jul 2020 11:22:51 +0300
Message-ID: <CAHp75Vc-x9jo8_7zcTv9EQ3RaterJDCEXWWbJBbVDAUtXufZxA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
To:     Marco Elver <elver@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 9:45 AM Marco Elver <elver@google.com> wrote:
> On Sun, Jul 19, 2020 at 12:43PM +0900, Sergey Senozhatsky wrote:
> > On (20/07/18 14:10), Marco Elver wrote:
> > >
> > > It seems this causes a regression observed at least with newline-only
> > > printks. I noticed this during -next testing because various debugging
> > > tools (K*SAN, lockdep, etc.) use e.g. pr_{err,warn,info}("\n") to format
> > > reports.
> > >
> > > Without wanting to wait for a report from one of these debugging tools,
> > > a simple reproducer is below. Without this patch, the expected newline
> > > is printed.
> >
> > Empty/blank lines carry no valuable payload, could you please explain
> > why do you consider this to be a regression?
>
> Empty/blank lines are visually valuable.
>
> Did I miss a discussion somewhere that this change is acceptable?
> Unfortunately, I can't find it mentioned in the commit message, and
> therefore assumed it's a regression.
>
> As I said, a number of debugging tools use them to format reports to be
> more readable (visually separate title and report body, and separate
> parts of the report).

While I can find it useful in some cases, though messages can be
interleaved, ...

> Also, such reports are often parsed by CI systems,
> and by changing the reports, these CI systems may break. But those are
> just the usecases I'm acutely aware of -- please see a full list of
> newline-print users below.

...but this is a weak argument. If your CI relies on message rather on
the ABI, you earn the breakage.
Go and fix your CI to do sane things instead.

> Breaking the observable behaviour of a widely used interface such as
> printk doesn't seem right. Where the newline-print is inappropriate,
> wouldn't removing that newline-print be more appropriate (instead of
> forcing this behaviour on everyone)?

-- 
With Best Regards,
Andy Shevchenko
