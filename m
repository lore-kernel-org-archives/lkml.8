Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C529C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 062EE208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 18:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595269860;
	bh=S4GpBaPUjODc7Idkx2SKjzguaLApomdk5LaY2gmQEGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=x06ivQaZxycaOSxA4RsNc5UYYzdZBPi5e/2gqhJOhDmast9AmuxcEBf55C3/QqmP4
	 qm99ENN6pcvr9+4Krqdsu28kAq9MB9u7nN6URC5xouJzuSNr/HT6hM6IWUa/OOZsKw
	 ters2B0VN7iEVJZuu3K8Z9uHMKDhERL1VItoBbYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgGTSa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 14:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTSa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 14:30:58 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9F6C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:30:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e8so21349166ljb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eLm1g6wX0u+kbO+T7uZR40kC/xNw/fbY+lFjsSbRCrQ=;
        b=enk9UNDqqpkyBymHXAemQoho8R9poOstpys1T9uwejv/TFZtzA3OTJugXLxVqhD4hf
         Fj4xwWCee33f4enVhWDp+U4q7tOBzpVQbTMWcNuNmIPWtgEm7vt3yMvKi/REWrB5NffW
         duOV7APLqbXXCHTYmoSFjgK0N1Q5TvBcRImmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eLm1g6wX0u+kbO+T7uZR40kC/xNw/fbY+lFjsSbRCrQ=;
        b=OJljmEdIFd1/Cbt1mS1CK/oHvRxMIf8spNn+tR2+GK3zukI9+GRpnvHuMokQ/hn0c/
         g/SK46Cpn3WjfcAiK9MeJhWhm2WZjonfxCpO96mUSeczmX8OfYH1Ha1c14cfoWhWy5GM
         5JE4rns0+ltlFv0WgZZzAhHll2UlTpCKypgGzHNjz2hEQAyjy1WfC5AtGeh101cH7zZE
         tNv0b9sIVfCnUNR2PZR+02DiUiUsUHOCTIG+1Mi9A+eXrU/i4lmyYObGGMU6zPGFMn99
         IvbM9M8ENH/Ui2dHkjpqDAW/7IL+0IUvGohOKRDmyckH9s5Q9QpkK9wbuWJ90boaNLkH
         c73w==
X-Gm-Message-State: AOAM532VcQ2eTWZ8jxZhHZi/LHW7TSvCCy6QqrF6bRl8DEJysPk0gbVc
        UrCOTcjftqS3pIjMdTDc4ngdDF0dSUs=
X-Google-Smtp-Source: ABdhPJwM8zY4hnAn+USxvxdMr88zvK7NZn/z7yIK4ddAARw7rwGy0tgvVHHAu3DnUjUyuT964OcP5w==
X-Received: by 2002:a2e:5d8:: with SMTP id 207mr10594937ljf.257.1595269855796;
        Mon, 20 Jul 2020 11:30:55 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 193sm4630980lfa.90.2020.07.20.11.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 11:30:53 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id r19so21237199ljn.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 11:30:53 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr9625723ljn.421.1595269852673;
 Mon, 20 Jul 2020 11:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de> <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com> <20200720015057.GA463@jagdpanzerIV.localdomain>
In-Reply-To: <20200720015057.GA463@jagdpanzerIV.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jul 2020 11:30:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
Message-ID: <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 6:51 PM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> Do I get it right, what you are saying is - when we process a PR_CONT
> message the cont buffer should already contain previous non-LOG_NEWLINE
> and non-PR_CONT message, otherwise it's a bug?

No.

I'm saying that the code that does PR_CONT should have done *some*
printing before, otherwise it's at the very least questionable.

IOW, you can't just randomly start printing with PR_CONT, without
having established _some_ context for it.

But that context could be a previous newline you created (the PR_CONT
will be a no-op). That's certainly useful for printing a header and
then after that printing possible other complex data that may or may
not have line breaks in it.

So your example looks fine. The context starts out with

    pr_warn("which would create a new lock dependency:\n");

and after that you can use KERN_CONT / pr_cont() as much as you want,
since you've established a context for what you're printing.

And then it ends with 'pr_cont("\n")'.

So anything that was interrupted by this, and uses KERN_CONT /
pr_cont() will have no ambiguous issues. The code you pointed at both
started and ended a line.

That said, we have traditionally used not just "current process", but
also "last irq-level" as the context information, so I do think it
would be good to continue to do that.

At that point, "an interrupt printed something in the middle" isn't
even an issue any more, because it's clear that the context has
changed.

                     Linus
