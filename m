Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE19EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F332068E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 22:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597445212;
	bh=7fy7fQeR8PGLlOHjUBLU1dsocvP+uvBOTWDBnYeIw6I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=py58Am/T7fUYadhIxncjuSt/NaHzoPkS93KxSsGUWUaTmG5bSFk2huL7esreMQjAh
	 S7rDBrd/Ke38QJW2DliEnEdOyJ0EcXrIJP55MDsR1Gw9cx9E8y87cb/rdfrzMwfzjI
	 aM1wEOkR0TBNqK/N2YXrhSai788YyWGZLkuW34lQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgHNWqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 18:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNWqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 18:46:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CAC061385
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:46:49 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so11577754ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMHHqpZMExPkpnHmo+3MalBUzwDo2HDU1pz0k0B1TSA=;
        b=LaBf2dos0BNfgB3XUtaoz2HGT0OLNq8Lk4PIiDYm1cpXuZyNz+PXpSYJmwrhdlIKbF
         tQNOSSlt+RU+9+8q2Cxnhuz0BasWnQvQkbEcRhxQS8cG7B+DQ/XzlKpbWIRS9BSNc7Hb
         kMp1oPDks0J7OofepXaPrrJILRWwqyQ6NNZyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMHHqpZMExPkpnHmo+3MalBUzwDo2HDU1pz0k0B1TSA=;
        b=PhYKWKfiw3d+mYHOrRN7t/e7KSgGl6kae2vpFalUMJUBxYFy3APf6xPCFs4Hg7Mu+5
         KLfuaRaJ6dVxVmAyBNWnxMrby80KCi7VhIlbdPy2V35dn78wo6n3K+E+N+mhjNrI3dKG
         QWCp1oD4iKVEd0bBQnr2oz0rVAQ83ohaXG4VIHFF+CmQXxHQztZPJ+tnF+WlIYfZ9Sbj
         LOJhWO+vO95i5HiwHMH4qh5EjHEhHqXD+qLbAg+6DosnFJhSLal0b5ISejucge3fzYYn
         pqpjpGhKElOmXvWrdPHsKlSqFSlaK/016YB3jV5w5qvBplBlRZeG+8xZcS/rCotGB6V7
         S0tA==
X-Gm-Message-State: AOAM533S+i8Z9peexxLLjOhy5W0ncgHdXUjNAdj1JdGHdKUk0mKf6N/1
        NtYXfQvUBxCxZbDSKbBTB6KeIcZjIW4EvQ==
X-Google-Smtp-Source: ABdhPJyXrThroWD2zjZSJfhkKUxePsGHmVZ5w4yiKlqzZuIcOKXVOQHqSvpXu8cATu93yfRKi+pZfQ==
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr1922602ljo.431.1597445208069;
        Fri, 14 Aug 2020 15:46:48 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s4sm2156322lfc.56.2020.08.14.15.46.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 15:46:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 185so11517757ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 15:46:46 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr2087781ljc.371.1597445206132;
 Fri, 14 Aug 2020 15:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain> <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley> <20200813115435.GB483@jagdpanzerIV.localdomain>
In-Reply-To: <20200813115435.GB483@jagdpanzerIV.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 14 Aug 2020 15:46:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
Message-ID: <CAHk-=wjoRWDAGkeevWtxR73vMimYfzJt13yFqTqv=7BGb0cuAQ@mail.gmail.com>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
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

On Thu, Aug 13, 2020 at 4:54 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> I think what Linus said a long time ago was that the initial purpose of
> pr_cont was
>
>         pr_info("Initialize feature foo...");
>         if (init_feature_foo() == 0)
>                 pr_cont("ok\n");
>         else
>                 pr_cont("not ok\n");
>
>         And if init_feature_foo() crashes the kernel then the first printk()
>         form panic() will flush the cont buffer.

Right.

This is why I think any discussion that says "people should buffer
their lines themselves and we should get rid if pr_cont()" is
fundamentally broken.

Don't go down that hole. I won't take it. It's wrong.

The fact is, pr_cont() goes back to the original kernel. No, it wasn't
pr_cont() back then, and no, there were no actual explicit markers for
"this is a continuation" at all, it was all just "the last printk
didn't have a newline, so we continue where we left off".

We've added pr_cont (and KERN_CONT) since then, and I realize that a
lot of people hate the complexity it introduces, but it's a
fundamental complexity that you have to live with.

If you can't live with pr_cont(), you shouldn't be working on
printk(), and find some other area of the kernel that you _can_ live
with.

It really is that simple.

            Linus
