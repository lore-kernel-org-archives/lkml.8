Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A73C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB5420731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588152518;
	bh=OmeUQgLG2b0au2ewYYU7E5eHExIkjcjT5fVcBESuGrs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wmKX7pwGMT1q+5yBnLYQRpW98dsLEzuZ1qgaQzxA2Rpp8r3lebS9nIxd65TJeQ+op
	 t8R4e601Qe7u7hoOdEYVOVwlnYG45OYstAYkus/f3e4ks35eHht7gqf6r0iF1/InYT
	 hw1/iEeuWUfQ+Io8nhxfxpXnm/PnusmfCVpRzjI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgD2J2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:45502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2J2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:28:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F133120787;
        Wed, 29 Apr 2020 09:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588152516;
        bh=OmeUQgLG2b0au2ewYYU7E5eHExIkjcjT5fVcBESuGrs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UX8f/mKyFnCUy0jOhlIXQOHw4jZeTAao7i/3RAzmKcvocb1yOZphm+wojDHM3EMXE
         Mi8320H/VvSjn3bjRkyCv8scBqP7ZBrBOKXNUQu0DQumOkUbUnFjrj4ISB3LJLN5xv
         uHUBGXm8IkJoz4lBgZhrF7R86q93C+JB+Zc89gOU=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jTj18-007f7C-B1; Wed, 29 Apr 2020 10:28:34 +0100
Date:   Wed, 29 Apr 2020 10:28:32 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper
 macros
Message-ID: <20200429102832.4eee22b4@why>
In-Reply-To: <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
References: <20200411045918.179455-1-saravanak@google.com>
        <86sghas7so.wl-maz@kernel.org>
        <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
        <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: saravanak@google.com, john.stultz@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, kernel-team@android.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravana,

Sorry for the delay replying.

On Mon, 13 Apr 2020 15:43:31 -0700
Saravana Kannan <saravanak@google.com> wrote:

> On Mon, Apr 13, 2020 at 3:13 PM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Sat, Apr 11, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:  
> > > On Sat, 11 Apr 2020 05:59:18 +0100,
> > > Saravana Kannan <saravanak@google.com> wrote:  
> > > >
> > > > Add helper macros IRQCHIP_MODULE_BEGIN and IRQCHIP_MODULE_END that add
> > > > the boilerplate code to be able to compile an irqchip driver as a
> > > > module.
> > > >
> > > > The driver developer just needs to do add IRQCHIP_MODULE_BEGIN and
> > > > IRQCHIP_MODULE_END(driver_name) around the IRQCHIP_DECLARE macros, like
> > > > so:
> > > >
> > > > IRQCHIP_MODULE_BEGIN
> > > > IRQCHIP_DECLARE(foo, "acme,foo", acme_foo_init)
> > > > IRQCHIP_DECLARE(bar, "acme,bar", acme_bar_init)
> > > > IRQCHIP_MODULE_END(acme_irq)
> > > >
> > > > Cc: John Stultz <john.stultz@linaro.org>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > > I don't expect this patch to be perfect or the final version. But I'd
> > > > like to introduce macros like this that don't need the driver developer
> > > > to copy/paste or repeat the same thing (compat string, function name,
> > > > etc) in multiple places for the driver to work as a module. If the exact
> > > > style of my macros aren't appealing, I'm open to other suggestions.
> > > >
> > > > There are some checkpatch warning about the > 80 columns that my patch
> > > > doesn't add. There are also checkpatch warnings about the trailing ; in
> > > > a macro, but I need those for IRQCHIP_DECLARE to work when the driver is
> > > > builtin.  
> > >
> > > I think you are looking at the problem from the wrong end, and adding
> > > syntactic sugar should be the least of your worries. The reason for
> > > not allowing irqchip drivers to be modular is that there is no
> > > refcounting in place to prevent drivers from being removed whilst the
> > > IRQ stack still has irq_desc, irq_data and various other objects
> > > indirectly referencing the driver.
> > >
> > > I'm all for addressing these issues, though it begs the question of
> > > *why* you want to do this. We have been perfectly happy with built-in
> > > irqchips so far (they are pretty small, and there aren't millions of
> > > them), so what changed?
> > >  
> >
> > I can't speak for Saravana, but my sense is that moving functionality
> > to loadable modules is becoming more important for Android devices due
> > to their efforts to utilize a single kernel image across various
> > vendor devices[1].  Obviously with mobile device constraints
> > minimizing the unused vendor code in the kernel image is important,
> > and modules help there. While the unloading issues you raised are
> > important, one can still benefit from having a permanent module
> > (modules that don't have a .remove handler), as they can be only
> > loaded on the devices that use them. You're also right that irqchip
> > drivers are fairly small, but one issue is that any code they depend
> > on also has to be built in if they are not able to be configured as a
> > module, so by allowing the irqchip driver to be a module, you can also
> > modularize whatever platform calls are made from that driver.  
> 
> Thanks John. I was planning on digging up the context for GKI and then
> replying. Looks like you are better at finding that than me :)
> 
> And I was also going to suggest the same "permanent" module option and
> also setting up the driver attributes (bind something?) so that the
> driver can't be unbound from the device either.
> 
> Marc, does that answer your questions? Sorry for not giving enough
> context in my original email.

This makes more sense, thanks.

One thing though: this seems to be exclusively DT driven. Have you
looked into how that would look like for other firmware types such as
ACPI?

Another thing is the handling of dependencies. Statically built
irqchips are initialized in the right order based on the topology
described in DT, and are initialized early enough that client devices
will find their irqchip This doesn't work here, obviously. How do you
propose we handle these dependencies, both between irqchip drivers and
client drivers?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
