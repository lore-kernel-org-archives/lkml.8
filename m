Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBFEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254582078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHioGyt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHMQJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgHMQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:09:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E0DC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:09:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id j23so3178236vsq.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhPxzDEAbDsTxP9pTuuqSCleYcAolz9FzuIO2cC9vEg=;
        b=EHioGyt8X0ovb69iv+wO2bgemHmETeXUEonigieujzAlN5C5JEl0BMPidKeDNq42ed
         6PcPmOxaZLF2j8ecZByS+j3Da3iCxyOutRymE3GK8jmRXn4IegZIUBRJuMFx2x1hAKTj
         1mf6FTRCGV941eVk3vLyCAKGo3xD1YCjBRnZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhPxzDEAbDsTxP9pTuuqSCleYcAolz9FzuIO2cC9vEg=;
        b=QeZR6ORS2B1O4qN/ZrtFxUEr351QM92KtKrLiOjkvD1s4qfxnn2FVyhuAFXwfemCgE
         oTS2ET1C9cdKv9LmKUm6y2O9YHeZ9Kf0TFzduw1NSWVsCSs0JHo2xwPbhS2Pkwq+87Y3
         1AH39tg8n69Wlfei8E6jCJTQJ4CH8oaRM+yPCe8uwIcTi9aJPB54eJPz7c1aZxo4B6Lx
         f1JNAjXZoNRVKU/K7/s7YZsTF2VjN4NAtVciyQh/GdzROLbDXquzd9+iOOZ2DCVZMqfS
         RDf17fOEaLHn44c5d7zsh3azSsexgCq5d62x62ZL7Uf9NYN7BlrSvorbkipX1yZuz0AJ
         g4UA==
X-Gm-Message-State: AOAM53215jXaUPpZXxOy0X3sfhwwKS4syG12ssepfNU0++N/cy2u4W3P
        rfe4WSEhUac9mUwsBfb+Iw4I5yNTOHA=
X-Google-Smtp-Source: ABdhPJxojPrRUqMuqzplpxq9HzSfinfChhgXgpiA1DPy3b1DNjqdDlhWAg5U1PVeQcEasP0aFj9I8w==
X-Received: by 2002:a67:30c5:: with SMTP id w188mr3935672vsw.115.1597334963347;
        Thu, 13 Aug 2020 09:09:23 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 81sm873292vky.52.2020.08.13.09.09.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 09:09:21 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id i129so3187644vsi.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:09:21 -0700 (PDT)
X-Received: by 2002:a67:d714:: with SMTP id p20mr4179240vsj.119.1597334961095;
 Thu, 13 Aug 2020 09:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org>
 <1597058460-16211-4-git-send-email-mkshah@codeaurora.org> <87pn7ulwr5.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87pn7ulwr5.fsf@nanos.tec.linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 13 Aug 2020 09:09:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WN4R1tS47ZzdZa_hsbvLifwnv6rgETVaiea0+QSZmiOw@mail.gmail.com>
Message-ID: <CAD=FV=WN4R1tS47ZzdZa_hsbvLifwnv6rgETVaiea0+QSZmiOw@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] genirq: Introduce irq_suspend_one() and
 irq_resume_one() callbacks
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Srinivas Rao L <lsrao@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 13, 2020 at 2:29 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Maulik Shah <mkshah@codeaurora.org> writes:
> > From: Douglas Anderson <dianders@chromium.org>
> >
> > The "struct irq_chip" has two callbacks in it: irq_suspend() and
> > irq_resume().  These two callbacks are interesting because sometimes
> > an irq chip needs to know about suspend/resume, but they are a bit
> > awkward because:
> > 1. They are called once for the whole irq_chip, not once per IRQ.
> >    It's passed data for one of the IRQs enabled on that chip.  That
> >    means it's up to the irq_chip driver to aggregate.
> > 2. They are only called if you're using "generic-chip", which not
> >    everyone is.
> > 3. The implementation uses syscore ops, which apparently have problems
> >    with s2idle.
>
> The main point is that these callbacks are specific to generic chip and
> not used anywhere else.

I'm not sure I understand.  This callback is used by drivers that use
generic-chip but I don't think there's anything specific about
generic-chip in these callbacks.  Sure many of them use the
generic-chip's "wake_active" tracking but a different IRQ chip could
track "wake_active" itself without bringing in all of generic-chip and
still might want to accomplish the same thing, right?


> > Probably the old irq_suspend() and irq_resume() callbacks should be
> > deprecated.
>
> You need to analyze first what these callbacks actually do. :)

See below.  I intended my callbacks to be for the same type of thing
as the existing ones, though perhaps either my naming or description
was confusing.


> > Let's introcuce a nicer API that works for all irq_chip devices.
>
> s/Let's intro/Intro/
>
> Let's is pretty useless in a changelog especially if you read it some
> time after the patch got applied.

Sounds fine.  Hopefully Maulik can adjust when he posts the next version.


> > This will be called by the core and is called once per IRQ.  The core
> > will call the suspend callback after doing its normal suspend
> > operations and the resume before its normal resume operations.
>
> Will be? You are adding the code which calls that unconditionally even.
>
> > +void suspend_one_irq(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = desc->irq_data.chip;
> > +
> > +     if (chip->irq_suspend_one)
> > +             chip->irq_suspend_one(&desc->irq_data);
> > +}
> > +
> > +void resume_one_irq(struct irq_desc *desc)
> > +{
> > +     struct irq_chip *chip = desc->irq_data.chip;
> > +
> > +     if (chip->irq_resume_one)
> > +             chip->irq_resume_one(&desc->irq_data);
> > +}
>
> There not much of a point to have these in chip.c. The functionality is
> clearly pm.c only.

No objections to it moving.  Since Maulik is posting the patches,
hopefully he can move it?


> >  static bool suspend_device_irq(struct irq_desc *desc)
> >  {
> > +     bool sync = false;
> > +
> >       if (!desc->action || irq_desc_is_chained(desc) ||
> >           desc->no_suspend_depth)
> > -             return false;
> > +             goto exit;
>
> What?
>
> If no_suspend_depth is > 0 why would you try to tell the irq chip
> that this line needs to be suspended?
>
> If there is no action, then the interrupt line is in shut down
> state. What's the point of suspending it?
>
> Chained interrupts are special and you really have to think hard whether
> calling suspend for them unconditionally is a good idea. What if a
> wakeup irq is connected to this chained thing?

I think there is a confusion about what this callback is intended to
do and that probably needs to be made clearer, either by renaming or
by comments (or both).  Let's think about these two things that we
might be telling the IRQ:

a) Please disable yourself in preparation for suspending.

b) The system is suspending, please take any action you need to.

I believe you are reading this as a).  I intended it to be b).  Can
you think of a name for these callbacks that would make it clearer?
suspend_notify() / resume_notify() maybe?


Specifically the problem we're trying to address is when an IRQ is
marked as "disabled" (driver called disable_irq()) but also marked as
"wakeup" (driver called enable_irq_wake()).  As per my understanding,
this means:

* Don't call the interrupt handler for this interrupt until I call
enable_irq() but keep tracking it (either in hardware or in software).
Specifically it's a requirement that if the interrupt fires one or
more times while masked the interrupt handler should be called as soon
as enable_irq() is called.

* If this interrupt fires while the system is suspended then please
wake the system up.


On some (many?) interrupt controllers a masked interrupt won't wake
the system up.  Thus we need some point in time where the interrupt
controller can unmask interrupts in hardware so that they can act as
wakeups.  Also: if an interrupt was masked lazily this could be a good
time to ensure that these interrupts _won't_ wake the system up.  Thus
the point of these callbacks is to provide a hook for IRQ chips to do
this.  Now that you understand the motivation perhaps you can suggest
a better way to accomplish this if the approach in this patch is not
OK.


I will note that a quick audit of existing users of the gernic-chip's
irq_suspend() show that they are doing exactly this.  So the point of
my patch is to actually allow other IRQ chips (ones that aren't using
generic-chip) to do this type of thing.  At the same time my patch
provides a way for current users of generic-chip to adapt their
routines so they work without syscore (which, I guess, isn't
compatible with s2idle).


> >       if (irqd_is_wakeup_set(&desc->irq_data)) {
> >               irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
> > +
> >               /*
> >                * We return true here to force the caller to issue
> >                * synchronize_irq(). We need to make sure that the
> >                * IRQD_WAKEUP_ARMED is visible before we return from
> >                * suspend_device_irqs().
> >                */
> > -             return true;
> > +             sync = true;
> > +             goto exit;
>
> So again. This interrupt is a wakeup source. What's the point of
> suspending it unconditionally.

Again this is a confusion about whether I'm saying "please suspend
yourself" or "the system is suspending, please take needed action".


> >       }
> >
> >       desc->istate |= IRQS_SUSPENDED;
> > @@ -95,7 +99,10 @@ static bool suspend_device_irq(struct irq_desc *desc)
> >        */
> >       if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
> >               mask_irq(desc);
> > -     return true;
> > +
> > +exit:
> > +     suspend_one_irq(desc);
> > +     return sync;
>
> So what happens in this case:
>
>    CPU0                         CPU1
>    interrupt                    suspend_device_irq()
>      handle()                     chip->suspend_one()
>        action()                 ...
>        chip->fiddle();
>
> ????

Ah, so I guess we need to move the call to suspend_one_irq() till
after the (potential) call to synchronize_irq() in in
suspend_device_irqs()?


> What is the logic here and how is this going to work under all
> circumstances without having magic hacks in the irq chip to handle all
> the corner cases?
>
> This needs way more thoughts vs. the various states and sync
> requirements. Just adding callbacks, invoking them unconditionally, not
> giving any rationale how the whole thing is supposed to work and then
> let everyone figure out how to deal with the state and corner case
> handling at the irq chip driver level does not cut it, really.
>
> State handling is core functionality and if irq chip drivers have
> special requirements then they want to be communicated with flags and/or
> specialized callbacks.

Hopefully with the above explanation this makes more sense?  If not,
hopefully you can suggest how to adapt it to accomplish what we need
(allow wakeup from masked IRQs that have wakeup enabled).

Thanks!

-Doug
