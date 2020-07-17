Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91450C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62362206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="isf6Sxzh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgGQRus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgGQRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:50:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63329C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:50:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m9so5769719pfh.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eI8HvUK+CMya1WaG9TiupjG1WqCMo2nAHU2MtUlxSro=;
        b=isf6Sxzh6k+W/K9cUCxxTRIYMWRAG/8IoFTnDOUdOt4/S7iGxlcC2iIn4PqdA6MRnG
         dYYmIHkDNTyTHktuBk0DKHJpGnSZcDvnXwINW4FU2Kz/GXK6c6V87z0dd7QJDy5LyTrJ
         3qBboaZr8fXlxTvmTaIDX2Lglx1QLnppBuCSiVHxytzzt5Ml9ZKXOXHTQTRb3pHCUEBW
         TmgnkEfU/lv0rXwTgCXpOi6hk1a+JUY+0VvVEp6dlzOgZofU1Wxf+MKBQpoOLvZCd208
         R0obSzHLaE0lgOWf0F6Vqr0engzm7cay7FjcZPr3+iDu+RDptAde1pv2i4w1Uggoe8A1
         VG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eI8HvUK+CMya1WaG9TiupjG1WqCMo2nAHU2MtUlxSro=;
        b=h2qkxPv40KNgskPQmKC0BwHhymceMjnOHC/W4IBdTEzpDDi1K4V2dwlwnYnlD1hlnb
         y7KrO1BLCEdQZsDn9CJRP3//9vQtzTMLz11Vt1TEMvz1MSblb2U5eXwQRORRf8Vy7m1H
         EmfiCcp4xIKNs5NOVsHypadrFZwb7fXi47wx+aMJV3p/gTW5ErGePYVet8dEckfK7YT0
         1H86Ff2XW1H8QBplvIBGgbDX0sevigJ9BIidZMG6vKCuiC0x7tc15sAtsrGhtRs/e2cY
         xb6kAWxD7zjQ40zMFFhUeyx78zm/+a9gqoeDgkKIyezditE39+E2XqVlojw/3znSUD/u
         HUSQ==
X-Gm-Message-State: AOAM532RxdPt6MqFYJc4x4FWLwqbLn1Lukr/c8i/5EHWhQIyNZToCay5
        BlZdINbBoQoV9j7sFx5f8HnpDBBdFp1N56knMCPRYA==
X-Google-Smtp-Source: ABdhPJwKS81H6pwFlmHpNU/HExkebBEVDO6VEjW67T824a1ZEENuInJi0MLH4KrsMp0mgSXLeGk6AnS9eOzu1KXXbBo=
X-Received: by 2002:a63:dd09:: with SMTP id t9mr9481183pgg.41.1595008246639;
 Fri, 17 Jul 2020 10:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200717024447.3128361-1-saravanak@google.com> <87k0z2xvp6.wl-maz@kernel.org>
In-Reply-To: <87k0z2xvp6.wl-maz@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Jul 2020 10:50:10 -0700
Message-ID: <CAGETcx9Fz96tnYCsgPyLMsALDAa7EcNKSQh9BOeCO2X_5pBm1w@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and
 IRQCHIP_MATCH helper macros
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 3:49 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Saravana,
>
> Thanks for re-spinning this one.
>
> On Fri, 17 Jul 2020 03:44:47 +0100,
> Saravana Kannan <saravanak@google.com> wrote:
> >
> > Compiling an irqchip driver as a platform driver needs to bunch of
> > things to be done right:
> > - Making sure the parent domain is initialized first
> > - Making sure the device can't be unbound from sysfs
> > - Disallowing module unload if it's built as a module
> > - Finding the parent node
> > - Etc.
> >
> > Instead of trying to make sure all future irqchip platform drivers get
> > this right, provide boilerplate macros that take care of all of this.
> >
> > An example use would look something like this. Where acme_foo_init and
> > acme_bar_init are similar to what would be passed to IRQCHIP_DECLARE.
> >
> > IRQCHIP_PLATFORM_DRIVER_BEGIN
>
> I think there is some value in having the BEGIN statement containing
> the driver name, see below.
>
> > IRQCHIP_MATCH(foo, "acme,foo", acme_foo_init)
> > IRQCHIP_MATCH(bar, "acme,bar", acme_bar_init)
> > IRQCHIP_PLATFORM_DRIVER_END(acme_irq)
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/irqchip/irqchip.c | 22 ++++++++++++++++++++++
> >  include/linux/irqchip.h   | 23 +++++++++++++++++++++++
> >  2 files changed, 45 insertions(+)
> >
> > diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> > index 2b35e68bea82..236ea793f01c 100644
> > --- a/drivers/irqchip/irqchip.c
> > +++ b/drivers/irqchip/irqchip.c
> > @@ -10,8 +10,10 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/init.h>
> > +#include <linux/of_device.h>
> >  #include <linux/of_irq.h>
> >  #include <linux/irqchip.h>
> > +#include <linux/platform_device.h>
> >
> >  /*
> >   * This special of_device_id is the sentinel at the end of the
> > @@ -29,3 +31,23 @@ void __init irqchip_init(void)
> >       of_irq_init(__irqchip_of_table);
> >       acpi_probe_device_table(irqchip);
> >  }
> > +
> > +int platform_irqchip_probe(struct platform_device *pdev)
> > +{
> > +     struct device_node *np = pdev->dev.of_node;
> > +     struct device_node *par_np = of_irq_find_parent(np);
> > +     of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
> > +
> > +     if (!irq_init_cb)
> > +             return -EINVAL;
> > +
> > +     if (par_np == np)
> > +             par_np = NULL;
> > +
> > +     /* If there's a parent irqchip, make sure it has been initialized. */
> > +     if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
>
> There is no guarantee that the calling driver wants BUS_ANY as a token
> for its parent. It may work for now, if you only have dependencies to
> drivers that only expose a single domain, but that's not a general
> purpose check..
>
> At least, please add a comment saying that the new driver may want to
> check that the irqdomain it depends on may not be available.

This is just checking if the parent interrupt controller has been
initialized. It's just saying that if NONE of the parent irq domains
have been registered, it's not time for this interrupt controller to
initialize. And yes, as you said, the actual init code can do more
checks and defer probe too. Maybe I'll just put the 2nd sentence as
the comment.

>
> > +             return -EPROBE_DEFER;
> > +
> > +     return irq_init_cb(np, par_np);
> > +}
> > +EXPORT_SYMBOL_GPL(platform_irqchip_probe);
> > diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
> > index 950e4b2458f0..6d5eba7cbbb7 100644
> > --- a/include/linux/irqchip.h
> > +++ b/include/linux/irqchip.h
> > @@ -13,6 +13,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> > +#include <linux/platform_device.h>
> >
> >  /*
> >   * This macro must be used by the different irqchip drivers to declare
> > @@ -26,6 +27,28 @@
> >   */
> >  #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
> >
> > +extern int platform_irqchip_probe(struct platform_device *pdev);
> > +
> > +#define IRQCHIP_PLATFORM_DRIVER_BEGIN \
> > +static const struct of_device_id __irqchip_match_table[] = {
>
> How about:
>
> #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
> static const struct of_device_id __irqchip_match_table_##drv_name = {
>
> which makes it easier to debug when you want to identify specific
> structures in an object (otherwise, they all have the same
> name...). it is also much more pleasing aesthetically ;-).

I totally agree. I wanted BEGIN to have the name and END to not have
to specify the name. But I couldn't figure out a way to do it. I
assumed you wouldn't want the names repeated in both BEGIN and END. If
you are okay with that, I prefer your suggestion too.

> > +
> > +#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
> > +
> > +#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)                \
> > +     {},                                             \
> > +};                                                   \
> > +MODULE_DEVICE_TABLE(of, __irqchip_match_table);              \
> > +static struct platform_driver drv_name##_driver = {  \
>
> const?

Sure.

> > +     .probe  = platform_irqchip_probe,               \
> > +     .driver = {                                     \
> > +             .name = #drv_name,                      \
> > +             .owner = THIS_MODULE,                   \
> > +             .of_match_table = __irqchip_match_table,\
> > +             .suppress_bind_attrs = true,            \
> > +     },                                              \
> > +};                                                   \
> > +builtin_platform_driver(drv_name##_driver)
> > +
> >  /*
> >   * This macro must be used by the different irqchip drivers to declare
> >   * the association between their version and their initialization function.
> > --
> > 2.28.0.rc0.105.gf9edc3c819-goog
> >
> >
>
> Otherwise looks good. When you respin it, it would be good to also
> submit one user of this API by converting an existing driver, as I'd
> hate to merge something that has no user.

The only one I know will work is the qcom pdc one from John. So I was
hoping John would respin his patch if you accept this one or I was
going to redo it after it shows up on linux-next. Maybe MTK can use
this too for their other series?

-Saravana
