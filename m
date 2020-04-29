Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76233C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E84E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S150YcIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgD2TFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2TFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:05:33 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4CCC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:05:33 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x10so2846084oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7G3G29UhhG+IEB7Xr/dtB1V+xXtuGT6YoyLL11HBwfw=;
        b=S150YcIZ5NG8xnKggfiT0VQ7LuEfupfSENSSX+7AHkxBgOGrUT3c4t79CtlvM1cT2J
         3JtHKNDRVEw90HyiqVSnrAwJU44GaLWzHrMD1B3i5epDByFqTOMJ86KJGpk9Z5J5Nm60
         W6jTP104mSS8rMYMewO67UjjFotZ/lgNx36gKa6lbF8RuQbkXUk/ct2XSywLorOxhlIZ
         1bZRHstqYRBIOgm+wwWerF6B1Qv30RL2iS6s70vU1VgQ9Kh32SXK4G9+1fH0qe2eDMqC
         iosNnr65FAkAvzPvRtrbhjiPqK3vHE+BiEWuQJT3d0FDqsYCvHVLjoWB0XR6k33n/dlV
         hiGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7G3G29UhhG+IEB7Xr/dtB1V+xXtuGT6YoyLL11HBwfw=;
        b=UUJQU84CYol77oB4+Ql89kJgBOUgaRf3pG7narGs9xHKdxh7I6ELXamDhg47xl/NpF
         PqJHBAqchNLjuyho6o6DZc379j85AEkkKXPbaZFeKqTud3J3fChpiwgdPx1spbWQ7XJ5
         F9Js73fdTYBarMHGDN1Mql7LYVZkJFV5tLs+DJDtosrtcUDe8r58CrqgHu2lhtlHv2xT
         LfCaJMiF2s4RdrdG8No2xG+iewEWTM9ED6KamXhpnzAlCR5ttepSnUntOyHyunyBljT8
         BNK1/tDUcaQIEvtQtmu+EveMwpoHwG3TxYNiIOGao3IHOQsV2Ib3dX187iczCDBgVoKU
         zM1Q==
X-Gm-Message-State: AGi0PuYOp8zJKSp0f3CNbkxZ3fwjONtLZA5/ap33gOYPKPyep6BHBSK1
        1JNIIIqwTHX0XgUuqxIYOCKj9ECI5kmNBZ0LkGUsQQ==
X-Google-Smtp-Source: APiQypJUCXIgJnnOFCHhT20LDdTPbULJ3tzyvyX/wUsSnM/ytwoIUlPd9yZmuj1sNf5cILlhJXhVsnO7ArnfIbqrDoM=
X-Received: by 2002:aca:abc6:: with SMTP id u189mr2801173oie.30.1588187131986;
 Wed, 29 Apr 2020 12:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200411045918.179455-1-saravanak@google.com> <86sghas7so.wl-maz@kernel.org>
 <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
 <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com> <20200429102832.4eee22b4@why>
In-Reply-To: <20200429102832.4eee22b4@why>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 29 Apr 2020 12:04:55 -0700
Message-ID: <CAGETcx_d0aM+MdeOFDaXDnTEs85rVY=H7zvhZf7NNB4w-t_CGg@mail.gmail.com>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 2:28 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Saravana,
>
> Sorry for the delay replying.

No worries.

> On Mon, 13 Apr 2020 15:43:31 -0700
> Saravana Kannan <saravanak@google.com> wrote:
>
> > On Mon, Apr 13, 2020 at 3:13 PM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Sat, Apr 11, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > On Sat, 11 Apr 2020 05:59:18 +0100,
> > > > Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > Add helper macros IRQCHIP_MODULE_BEGIN and IRQCHIP_MODULE_END that add
> > > > > the boilerplate code to be able to compile an irqchip driver as a
> > > > > module.
> > > > >
> > > > > The driver developer just needs to do add IRQCHIP_MODULE_BEGIN and
> > > > > IRQCHIP_MODULE_END(driver_name) around the IRQCHIP_DECLARE macros, like
> > > > > so:
> > > > >
> > > > > IRQCHIP_MODULE_BEGIN
> > > > > IRQCHIP_DECLARE(foo, "acme,foo", acme_foo_init)
> > > > > IRQCHIP_DECLARE(bar, "acme,bar", acme_bar_init)
> > > > > IRQCHIP_MODULE_END(acme_irq)
> > > > >
> > > > > Cc: John Stultz <john.stultz@linaro.org>
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > ---
> > > > > I don't expect this patch to be perfect or the final version. But I'd
> > > > > like to introduce macros like this that don't need the driver developer
> > > > > to copy/paste or repeat the same thing (compat string, function name,
> > > > > etc) in multiple places for the driver to work as a module. If the exact
> > > > > style of my macros aren't appealing, I'm open to other suggestions.
> > > > >
> > > > > There are some checkpatch warning about the > 80 columns that my patch
> > > > > doesn't add. There are also checkpatch warnings about the trailing ; in
> > > > > a macro, but I need those for IRQCHIP_DECLARE to work when the driver is
> > > > > builtin.
> > > >
> > > > I think you are looking at the problem from the wrong end, and adding
> > > > syntactic sugar should be the least of your worries. The reason for
> > > > not allowing irqchip drivers to be modular is that there is no
> > > > refcounting in place to prevent drivers from being removed whilst the
> > > > IRQ stack still has irq_desc, irq_data and various other objects
> > > > indirectly referencing the driver.
> > > >
> > > > I'm all for addressing these issues, though it begs the question of
> > > > *why* you want to do this. We have been perfectly happy with built-in
> > > > irqchips so far (they are pretty small, and there aren't millions of
> > > > them), so what changed?
> > > >
> > >
> > > I can't speak for Saravana, but my sense is that moving functionality
> > > to loadable modules is becoming more important for Android devices due
> > > to their efforts to utilize a single kernel image across various
> > > vendor devices[1].  Obviously with mobile device constraints
> > > minimizing the unused vendor code in the kernel image is important,
> > > and modules help there. While the unloading issues you raised are
> > > important, one can still benefit from having a permanent module
> > > (modules that don't have a .remove handler), as they can be only
> > > loaded on the devices that use them. You're also right that irqchip
> > > drivers are fairly small, but one issue is that any code they depend
> > > on also has to be built in if they are not able to be configured as a
> > > module, so by allowing the irqchip driver to be a module, you can also
> > > modularize whatever platform calls are made from that driver.
> >
> > Thanks John. I was planning on digging up the context for GKI and then
> > replying. Looks like you are better at finding that than me :)
> >
> > And I was also going to suggest the same "permanent" module option and
> > also setting up the driver attributes (bind something?) so that the
> > driver can't be unbound from the device either.
> >
> > Marc, does that answer your questions? Sorry for not giving enough
> > context in my original email.
>
> This makes more sense, thanks.
>
> One thing though: this seems to be exclusively DT driven. Have you
> looked into how that would look like for other firmware types such as
> ACPI?

I'm not very familiar with ACPI at all. I've just started to learn
about how it works in the past few months poking at code when I have
some time. So I haven't tried to get this to work with ACPI nor do I
think I'll be able to do that anytime in the near future. I hope that
doesn't block this from being used for DT based platforms.

> Another thing is the handling of dependencies. Statically built
> irqchips are initialized in the right order based on the topology
> described in DT, and are initialized early enough that client devices
> will find their irqchip This doesn't work here, obviously.

Yeah, I read that code thoroughly :)

> How do you
> propose we handle these dependencies, both between irqchip drivers and
> client drivers?

For client drivers, we don't need to do anything. The IRQ apis seem to
already handle -EPROBE_DEFER correctly in this case.

For irqchip drivers, the easy answer can be: Load the IRQ modules
early if you make them modules.

But in my case, I've been testing this with fw_devlink=on. The TL;DR
of "fw_devlink=on" in this context is that the IRQ devices will get
device links created based on "interrupt-parent" property. So, with
the magic of device links, these IRQ devices will probe in the right
topological order without any wasted deferred probe attempts. For
cases without fw_devlink=on, I think I can improve
platform_irqchip_probe() in my patch to check if the parent device has
probed and defer if it hasn't.

-Saravana
