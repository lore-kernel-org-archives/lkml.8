Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99E3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E72206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1peec51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgG1Bf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgG1Bf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:35:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B4C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:35:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id c25so13760111otf.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fI6YwDGtg+joeqOCzuXAQEYG2xJxfhrjUye2AxD2ZBA=;
        b=G1peec51s0+H5DoRmqJiB4s90sR/1pLFDcucc8EtN3ZN5lp784VVe2JWxcmlZHvHeA
         t+6FshXP+oBm9pGxuyz2z3ZGU7TbpTNpSYJ06+KisBg/8fCyAzTwmqqytNDY0MZesb5z
         MScbAshkQ8GQTyRDVjk+JbP8vJDEuIYoKfwVg8kXYFePD7Xn62CkzQPNth8qjDz9W1xA
         VllCUh/oZrSDLmKLJZ4147as/cyjF6cueAVDE6lT++5iBlmpiZmWpnAU4UFB7glnPV14
         DgAtrhgzW6KOPZibdoySiGkbiRpUgykvaQfglZ0rF94Zpfsv2hE7WHh3rwcoNSVU7d/x
         WAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fI6YwDGtg+joeqOCzuXAQEYG2xJxfhrjUye2AxD2ZBA=;
        b=DnZkC7f5OK+VLJ16xUCYYhbv016+zO5v0S4nj4w7E82kgZBSrBmU+NsRaDqwg4nneR
         FJlJ1DvSgCSnymkf+XzBmascSO5DFb4Cxf26ITUWCEGYMnnaNETx5PhV3vRR6mmTXkMH
         7qaeHL5R9Q0hx4bPGV6jlw8ZrwwR7BTz3R3G0D6e0eJ1ExEdGRN/Cvv6Oxdkv2vvGb1o
         nZtdDeUeUHNfELve0qkhArMWKatlllqmaiPq0AjipYLfksEdXMfQq2VXM7gWHoYraSP5
         FXjImpeC8Pq1Tq1EAzg+H5l5+QBtt5vWbdE1F7jOrJVD4B3aj1jnNWiocZN3TnJuvjld
         /ETQ==
X-Gm-Message-State: AOAM530RhBqK3TLs7He2ygA196F6VbadDKlUOqp9S6LmujUBkTeXeKwN
        lUqu0/zlrgeCKxnBFmiZYNE3OXhubNvAb6kILbs=
X-Google-Smtp-Source: ABdhPJzOl2kW9LkTqkutjFqeNIU+eJcjuTfsALHmq71or7tSEVJSjXmDcDOfsga4ocMNs+qyrcX3ZIQibx6B9Jow8vI=
X-Received: by 2002:a05:6830:1e37:: with SMTP id t23mr7621300otr.215.1595900126816;
 Mon, 27 Jul 2020 18:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com> <87sgddaru7.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sgddaru7.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Tue, 28 Jul 2020 09:35:16 +0800
Message-ID: <CAKc596+cs7SMT493HjfiX_1E+aGdL9aaPgP_KqT5+gXrgsZVCA@mail.gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Qian,
>
> qianjun.kernel@gmail.com writes:
> >  /*
> >   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
> >   * but break the loop if need_resched() is set or after 2 ms.
> > - * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
> > - * certain cases, such as stop_machine(), jiffies may cease to
> > - * increment and so we need the MAX_SOFTIRQ_RESTART limit as
> > - * well to make sure we eventually return from this method.
> > + * In the loop, if the processing time of the softirq has exceeded 2
> > + * milliseconds, we also need to break the loop to wakeup the
> > ksofirqd.
>
> You are removing the MAX_SOFTIRQ_RESTART limit explanation and I rather
> have MAX_SOFTIRQ_TIME_NS there than '2 milliseconds' in case the value
> gets adjusted later on. Also while sched_clock() is granular on many
> systems it still can be jiffies based and then the above problem
> persists.
>
> > @@ -299,6 +298,19 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >               }
> >               h++;
> >               pending >>= softirq_bit;
> > +
> > +             /*
> > +              * the softirq's action has been running for too much time
> > +              * so it may need to wakeup the ksoftirqd
> > +              */
> > +             if (need_resched() && sched_clock() > end) {
> > +                     /*
> > +                      * Ensure that the remaining pending bits are
> > +                      * handled.
> > +                      */
> > +                     or_softirq_pending(pending << (vec_nr + 1));
>
> To or the value interrupts need to be disabled because otherwise you can
> lose a bit when an interrupt happens in the middle of the RMW operation
> and raises a softirq which is not in @pending and not in the per CPU
> local softirq pending storage.
>
> There is another problem. Assume bit 0 and 1 are pending when the
> processing starts. Now it breaks out after bit 0 has been handled and
> stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
> again. ksoftirqd runs and handles bit 0, which takes more than the
> timeout. As a result the bit 0 processing can starve all other softirqs.
>
I got it. I will try to slove this problem. Thanks.

> So this needs more thought.
>
> Thanks,
>
>         tglx
