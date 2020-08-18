Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 984922076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPUCTqXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHRNTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHRNSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:18:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBDEC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:18:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i10so21395508ljn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDDil0AUbZ0wmokmM/QHNHE+fyW15U6tmDP5zuUGqO4=;
        b=hPUCTqXSRTJbtoSpUcqVa72Pi616CqOCXEesCSvBgHZnk6f8IumMxFDDzZfuIblroK
         ejDxDGB38/9/NmxAtDbFkRlfCKiXMzjfqVUAFDoc7emGmzJgQrizkrwRxDgmfXzb/fcD
         /XY5L0L1PlPbTdt52PGQBV7bp+JNs+Dy/fwr25FIyEq0xbwV06R34HZCVX4HN4/BjWE9
         It80EGd8AgS/6a+Cs4TztyLGpRjmQK0mLeyLikA6hlAbroVZpCZmM7X/IAeVHlt+O4Hr
         BCEzg06q6o/JDgAQsmVEybV8jWEkrV14oasnDTEeXktQAIrOC+TP1XnhFNBeRdQ/f9EI
         AmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDDil0AUbZ0wmokmM/QHNHE+fyW15U6tmDP5zuUGqO4=;
        b=VM8p7reWwcoeBfvKGZsoomCov5FmaEuTvct3OXetBpYoakVJzcN98+ROYp8ORfsogz
         SLDUUH93HqrqJDYBcOOjLtTx9Mxhcn1R31Y/vjZ0VC4xE7T69+Y+QohVhwxczFYH8qdZ
         M1ynFZhsPta7tpddJ8ZSplddimNcHWXaKCNJLZicu3xDtBA6ZbgLvPuujpC5pJcCEMvI
         iiL39/oJ3cOqMUdU0xIF07+VV+7yk4ROs/5KGu2CumqHRkIviopp0SyKdwndDnIBe+es
         5IiszLl9y4ldMuzZxKFsvZ2mNq42kXkknhKHFo2Gd5tJi1V2Ei6k+xkMyGmw4M2z1EVO
         lskw==
X-Gm-Message-State: AOAM532tdCPzrtP/S/zwnOP7ieH3nXXAEavZL15ORx1FdHBspRl0Ym/Q
        EokAvvJHbCrkPAiAhE3fOdd1Qf5rlsHWfWpuQ2SBmA==
X-Google-Smtp-Source: ABdhPJwSmkycWJtZ2n0vto4Q7YpdHzTXmjky1pIKMelRyq/iUrhxnCPuEg+PkYeruBbJ1j1MGwbDkxYZ63gkD3Fr8HA=
X-Received: by 2002:a05:651c:294:: with SMTP id b20mr9143135ljo.4.1597756722365;
 Tue, 18 Aug 2020 06:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <1595333413-30052-3-git-send-email-sumit.garg@linaro.org> <CAD=FV=XUNqun3d+C_7GpgntGWRXwLSLnXKStLUz8iqZoGKu8zg@mail.gmail.com>
 <CAFA6WYNq-Z5WD=AqJn2_DEg0F6G1CYte2y5Snc964vsgCnr0Bw@mail.gmail.com>
 <CAD=FV=Vu3PGSUzargD-6e2XOw=Eh7CZaQ_+a09dr8SR1T8eE2g@mail.gmail.com>
 <CAFA6WYPJ_w+R15NRKK5BzZtTxKq8Gh_mGswuYbW0cYZoBYLhxw@mail.gmail.com>
 <20200814141322.lffebtamfjt2qrym@holly.lan> <CAFA6WYNAdELYCoOVQokgLNKhOYF9QK85UidgvyFfo4wsSNwKXw@mail.gmail.com>
 <CAD=FV=WiZi18zBwx9J0sKLdCqMCvxuQ=U0m21yNqhtaBfZEqzA@mail.gmail.com>
 <CAFA6WYOww8T7fmP-LtzS-EXG0iBbKEUOS5KrUU_7i+yqd_rFfQ@mail.gmail.com> <20200817143222.x524v6xqw5hvzvjs@holly.lan>
In-Reply-To: <20200817143222.x524v6xqw5hvzvjs@holly.lan>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Aug 2020 18:48:30 +0530
Message-ID: <CAFA6WYO_tBUSNnuDU4yvphUb3-f7oc2GHFTTjbX3=963p=iePQ@mail.gmail.com>
Subject: Re: [RFC 2/5] serial: core: Add framework to allow NMI aware serial drivers
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 at 20:02, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Mon, Aug 17, 2020 at 07:53:55PM +0530, Sumit Garg wrote:
> > On Mon, 17 Aug 2020 at 19:27, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Aug 17, 2020 at 5:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> > > >
> > > > Thanks for your suggestion, irq_work_schedule() looked even better
> > > > without any overhead, see below:
> > > >
> > > > diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
> > > > index 3082378..1eade89 100644
> > > > --- a/include/linux/irq_work.h
> > > > +++ b/include/linux/irq_work.h
> > > > @@ -3,6 +3,7 @@
> > > >  #define _LINUX_IRQ_WORK_H
> > > >
> > > >  #include <linux/smp_types.h>
> > > > +#include <linux/workqueue.h>
> > > >
> > > >  /*
> > > >   * An entry can be in one of four states:
> > > > @@ -24,6 +25,11 @@ struct irq_work {
> > > >         void (*func)(struct irq_work *);
> > > >  };
> > > >
> > > > +struct irq_work_schedule {
> > > > +       struct irq_work work;
> > > > +       struct work_struct *sched_work;
> > > > +};
> > > > +
> > > >  static inline
> > > >  void init_irq_work(struct irq_work *work, void (*func)(struct irq_work *))
> > > >  {
> > > >  {
> > > > @@ -39,6 +45,7 @@ void init_irq_work(struct irq_work *work, void
> > > > (*func)(struct irq_work *))
> > > >
> > > >  bool irq_work_queue(struct irq_work *work);
> > > >  bool irq_work_queue_on(struct irq_work *work, int cpu);
> > > > +bool irq_work_schedule(struct work_struct *sched_work);
> > > >
> > > >  void irq_work_tick(void);
> > > >  void irq_work_sync(struct irq_work *work);
> > > > diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> > > > index eca8396..3880316 100644
> > > > --- a/kernel/irq_work.c
> > > > +++ b/kernel/irq_work.c
> > > > @@ -24,6 +24,8 @@
> > > >  static DEFINE_PER_CPU(struct llist_head, raised_list);
> > > >  static DEFINE_PER_CPU(struct llist_head, lazy_list);
> > > >
> > > > +static struct irq_work_schedule irq_work_sched;
> > > > +
> > > >  /*
> > > >   * Claim the entry so that no one else will poke at it.
> > > >   */
> > > > @@ -79,6 +81,25 @@ bool irq_work_queue(struct irq_work *work)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(irq_work_queue);
> > > >
> > > > +static void irq_work_schedule_fn(struct irq_work *work)
> > > > +{
> > > > +       struct irq_work_schedule *irq_work_sched =
> > > > +               container_of(work, struct irq_work_schedule, work);
> > > > +
> > > > +       if (irq_work_sched->sched_work)
> > > > +               schedule_work(irq_work_sched->sched_work);
> > > > +}
> > > > +
> > > > +/* Schedule work via irq work queue */
> > > > +bool irq_work_schedule(struct work_struct *sched_work)
> > > > +{
> > > > +       init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> > > > +       irq_work_sched.sched_work = sched_work;
> > > > +
> > > > +       return irq_work_queue(&irq_work_sched.work);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(irq_work_schedule);
> > >
> > > Wait, howzat work?  There's a single global variable that you stash
> > > the "sched_work" into with no locking?  What if two people schedule
> > > work at the same time?
> >
> > This API is intended to be invoked from NMI context only, so I think
> > there will be a single user at a time.
>
> How can you possibly know that?

I guess here you are referring to NMI nesting, correct?

Anyway, I am going to shift to another implementation as mentioned in
the other thread.

-Sumit

>
> This is library code, not a helper in a driver.
>
>
> Daniel.
>
>
> > And we can make that explicit
> > as well:
> >
> > +/* Schedule work via irq work queue */
> > +bool irq_work_schedule(struct work_struct *sched_work)
> > +{
> > +       if (in_nmi()) {
> > +               init_irq_work(&irq_work_sched.work, irq_work_schedule_fn);
> > +               irq_work_sched.sched_work = sched_work;
> > +
> > +               return irq_work_queue(&irq_work_sched.work);
> > +       }
> > +
> > +       return false;
> > +}
> > +EXPORT_SYMBOL_GPL(irq_work_schedule);
> >
> > -Sumit
> >
> > >
> > > -Doug
