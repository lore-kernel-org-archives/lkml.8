Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C1CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448932072A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 22:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmkD9OAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389711AbgDMWpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389552AbgDMWnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 18:43:06 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13294C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:44:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d63so8847102oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 15:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZqm2+INSWWxWp4zfwaZu6nRumZ4R0toXyfOoCgQXZI=;
        b=OmkD9OAiGQkEvPcmiZO91ETfiFyPBrrn193BUQapudklcm8qzzY2Nq/+OvwaC8uJ57
         XphI0mc3rCzgiRhm9KKJi4hBzJk995dbjrQLPNcNlp501dtfjexunNAYqXjn6mjPjNKn
         qyqEqra25SQ2vaTJ2LAGSz3lHDRKNP2HsyJLjSOJcIefNw+BvLRcq5T+AW/ROm7zaD/q
         fvfGLMciPOACd+K49Io2gYK6Hy78w2fe5WGpL3R0c4UVk2C1MoQHIKILRqii87ds4Mk1
         uh8M8fyyMYiYJfadUAHA/hoYqCNONL90LawkOIds2Yzb0Vkkszybp00a1OS1nUAsTaab
         Z9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZqm2+INSWWxWp4zfwaZu6nRumZ4R0toXyfOoCgQXZI=;
        b=sYTawoWkgnYvGd8U1O9hxUO6d48JlXfjC2+pVnDFCx+AZ/ub5Z8Ekm2wW/qsRfXDBV
         s353oF0JKUKp6MC5TZyZoFNY+j6+5xweJvTRyvwvv1joAvO1uQuCBy6tNRxVWi6dTWQI
         cSR+AXUyyRsnBXuLTxUxahHILvg19xDnRtxz7eCYrFLePgDuUuWZ4Dbor88nyXiNfNl1
         4ewDgGu9OS9iAFet9YFrw5hjxWgsDIG4xmY1KPIzvkURy9F3eGM5a8GLEbrq786RsmqP
         EM3XFMMANoEvf19Vqkdxc3clqZaP1l3+omugYJIYVGqzS9sMGlcdNZ5eBDywh5wrzlX/
         uMfA==
X-Gm-Message-State: AGi0PubpEzEjF7zf6lhrZtT4RWsc9A/D/L5VD4z5SMcFOlEBK/qsycTC
        uR2bPO++euEUKd2nKfmCXfhJ43wFKUXbvNGXw3X0Bg==
X-Google-Smtp-Source: APiQypKbZWpZOKkMPYOGSA4B6q19m9IA4NcQIfTfyDWPkgIT3ccrj7jYE59zqN8kucA59X6Rv7TRoiWH+iwAycX3BVg=
X-Received: by 2002:aca:abc6:: with SMTP id u189mr2763659oie.30.1586817847048;
 Mon, 13 Apr 2020 15:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200411045918.179455-1-saravanak@google.com> <86sghas7so.wl-maz@kernel.org>
 <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
In-Reply-To: <CALAqxLXkbNh4GVC82SqXNoib+4FQS2Y3XbePyhreJcwWoVEQaw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 13 Apr 2020 15:43:31 -0700
Message-ID: <CAGETcx92fj-VEjYsYx0E4_TCV8fW1fvvxn_DyV=b4BJ7B5zG2Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1] irqchip: Add IRQCHIP_MODULE_BEGIN/END helper macros
To:     John Stultz <john.stultz@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 3:13 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Sat, Apr 11, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:
> > On Sat, 11 Apr 2020 05:59:18 +0100,
> > Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > Add helper macros IRQCHIP_MODULE_BEGIN and IRQCHIP_MODULE_END that add
> > > the boilerplate code to be able to compile an irqchip driver as a
> > > module.
> > >
> > > The driver developer just needs to do add IRQCHIP_MODULE_BEGIN and
> > > IRQCHIP_MODULE_END(driver_name) around the IRQCHIP_DECLARE macros, like
> > > so:
> > >
> > > IRQCHIP_MODULE_BEGIN
> > > IRQCHIP_DECLARE(foo, "acme,foo", acme_foo_init)
> > > IRQCHIP_DECLARE(bar, "acme,bar", acme_bar_init)
> > > IRQCHIP_MODULE_END(acme_irq)
> > >
> > > Cc: John Stultz <john.stultz@linaro.org>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > > I don't expect this patch to be perfect or the final version. But I'd
> > > like to introduce macros like this that don't need the driver developer
> > > to copy/paste or repeat the same thing (compat string, function name,
> > > etc) in multiple places for the driver to work as a module. If the exact
> > > style of my macros aren't appealing, I'm open to other suggestions.
> > >
> > > There are some checkpatch warning about the > 80 columns that my patch
> > > doesn't add. There are also checkpatch warnings about the trailing ; in
> > > a macro, but I need those for IRQCHIP_DECLARE to work when the driver is
> > > builtin.
> >
> > I think you are looking at the problem from the wrong end, and adding
> > syntactic sugar should be the least of your worries. The reason for
> > not allowing irqchip drivers to be modular is that there is no
> > refcounting in place to prevent drivers from being removed whilst the
> > IRQ stack still has irq_desc, irq_data and various other objects
> > indirectly referencing the driver.
> >
> > I'm all for addressing these issues, though it begs the question of
> > *why* you want to do this. We have been perfectly happy with built-in
> > irqchips so far (they are pretty small, and there aren't millions of
> > them), so what changed?
> >
>
> I can't speak for Saravana, but my sense is that moving functionality
> to loadable modules is becoming more important for Android devices due
> to their efforts to utilize a single kernel image across various
> vendor devices[1].  Obviously with mobile device constraints
> minimizing the unused vendor code in the kernel image is important,
> and modules help there. While the unloading issues you raised are
> important, one can still benefit from having a permanent module
> (modules that don't have a .remove handler), as they can be only
> loaded on the devices that use them. You're also right that irqchip
> drivers are fairly small, but one issue is that any code they depend
> on also has to be built in if they are not able to be configured as a
> module, so by allowing the irqchip driver to be a module, you can also
> modularize whatever platform calls are made from that driver.

Thanks John. I was planning on digging up the context for GKI and then
replying. Looks like you are better at finding that than me :)

And I was also going to suggest the same "permanent" module option and
also setting up the driver attributes (bind something?) so that the
driver can't be unbound from the device either.

Marc, does that answer your questions? Sorry for not giving enough
context in my original email.

-Saravana
