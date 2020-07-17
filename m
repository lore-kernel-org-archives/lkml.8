Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C87C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C0E2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595009062;
	bh=1u6Gzdq1LfVvVuz7++DGNuxGmE1RVYr0vhPj47AzA4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=loz4PHnry0wGEWmcZrfGENZUa0yRsbSHiPw6bsF0d2D7TzJPdYFs8TDLuFp5gJS3f
	 Q4v0pgcZiQtG5JST+bldLhhNTV9biFkaXGXPeHJS2hPjug5nAqRA6cgVmltysQMu8z
	 DPaa96Iem/O+mEofY9JOjPHhro6TfmCeAiCexbf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGQSEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:37660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgGQSES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:04:18 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D432067D;
        Fri, 17 Jul 2020 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595009057;
        bh=1u6Gzdq1LfVvVuz7++DGNuxGmE1RVYr0vhPj47AzA4w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lLmpldaT3Krwi/B69k0Wax4FoSZyUt4kR8FqjyeGbWfiHGJlszM974aXsMC60TbWS
         4daQ+nwFQt0x6/CvzOb0KNYDHQepW6jZ4WtDhOY1LPXAJLwx3XookA9BL8vFpqxYFK
         mPsx1ecPmCGKoYiQ4N4Ii+xhSD0pt7fdfVhreLtg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jwUiV-00Chus-Aj; Fri, 17 Jul 2020 19:04:16 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Jul 2020 19:04:15 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
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
Subject: Re: [PATCH v2] irqchip: Add IRQCHIP_PLATFORM_DRIVER_BEGIN/END and
 IRQCHIP_MATCH helper macros
In-Reply-To: <CAGETcx9Fz96tnYCsgPyLMsALDAa7EcNKSQh9BOeCO2X_5pBm1w@mail.gmail.com>
References: <20200717024447.3128361-1-saravanak@google.com>
 <87k0z2xvp6.wl-maz@kernel.org>
 <CAGETcx9Fz96tnYCsgPyLMsALDAa7EcNKSQh9BOeCO2X_5pBm1w@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <90d5a870c46643f6b4654f9c8cbd7740@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: saravanak@google.com, tglx@linutronix.de, jason@lakedaemon.net, matthias.bgg@gmail.com, john.stultz@linaro.org, cc.hwang@mediatek.com, loda.chou@mediatek.com, hanks.chen@mediatek.com, kernel-team@android.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-17 18:50, Saravana Kannan wrote:
> On Fri, Jul 17, 2020 at 3:49 AM Marc Zyngier <maz@kernel.org> wrote:
>> 
>> Hi Saravana,
>> 
>> Thanks for re-spinning this one.
>> 
>> On Fri, 17 Jul 2020 03:44:47 +0100,
>> Saravana Kannan <saravanak@google.com> wrote:
>> >
>> > Compiling an irqchip driver as a platform driver needs to bunch of
>> > things to be done right:
>> > - Making sure the parent domain is initialized first
>> > - Making sure the device can't be unbound from sysfs
>> > - Disallowing module unload if it's built as a module
>> > - Finding the parent node
>> > - Etc.
>> >
>> > Instead of trying to make sure all future irqchip platform drivers get
>> > this right, provide boilerplate macros that take care of all of this.
>> >
>> > An example use would look something like this. Where acme_foo_init and
>> > acme_bar_init are similar to what would be passed to IRQCHIP_DECLARE.
>> >
>> > IRQCHIP_PLATFORM_DRIVER_BEGIN
>> 
>> I think there is some value in having the BEGIN statement containing
>> the driver name, see below.
>> 
>> > IRQCHIP_MATCH(foo, "acme,foo", acme_foo_init)
>> > IRQCHIP_MATCH(bar, "acme,bar", acme_bar_init)
>> > IRQCHIP_PLATFORM_DRIVER_END(acme_irq)
>> >
>> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>> > ---
>> >  drivers/irqchip/irqchip.c | 22 ++++++++++++++++++++++
>> >  include/linux/irqchip.h   | 23 +++++++++++++++++++++++
>> >  2 files changed, 45 insertions(+)
>> >
>> > diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
>> > index 2b35e68bea82..236ea793f01c 100644
>> > --- a/drivers/irqchip/irqchip.c
>> > +++ b/drivers/irqchip/irqchip.c
>> > @@ -10,8 +10,10 @@
>> >
>> >  #include <linux/acpi.h>
>> >  #include <linux/init.h>
>> > +#include <linux/of_device.h>
>> >  #include <linux/of_irq.h>
>> >  #include <linux/irqchip.h>
>> > +#include <linux/platform_device.h>
>> >
>> >  /*
>> >   * This special of_device_id is the sentinel at the end of the
>> > @@ -29,3 +31,23 @@ void __init irqchip_init(void)
>> >       of_irq_init(__irqchip_of_table);
>> >       acpi_probe_device_table(irqchip);
>> >  }
>> > +
>> > +int platform_irqchip_probe(struct platform_device *pdev)
>> > +{
>> > +     struct device_node *np = pdev->dev.of_node;
>> > +     struct device_node *par_np = of_irq_find_parent(np);
>> > +     of_irq_init_cb_t irq_init_cb = of_device_get_match_data(&pdev->dev);
>> > +
>> > +     if (!irq_init_cb)
>> > +             return -EINVAL;
>> > +
>> > +     if (par_np == np)
>> > +             par_np = NULL;
>> > +
>> > +     /* If there's a parent irqchip, make sure it has been initialized. */
>> > +     if (par_np && !irq_find_matching_host(np, DOMAIN_BUS_ANY))
>> 
>> There is no guarantee that the calling driver wants BUS_ANY as a token
>> for its parent. It may work for now, if you only have dependencies to
>> drivers that only expose a single domain, but that's not a general
>> purpose check..
>> 
>> At least, please add a comment saying that the new driver may want to
>> check that the irqdomain it depends on may not be available.
> 
> This is just checking if the parent interrupt controller has been
> initialized. It's just saying that if NONE of the parent irq domains
> have been registered, it's not time for this interrupt controller to
> initialize. And yes, as you said, the actual init code can do more
> checks and defer probe too. Maybe I'll just put the 2nd sentence as
> the comment.

Sure, go ahead.

> 
>> 
>> > +             return -EPROBE_DEFER;
>> > +
>> > +     return irq_init_cb(np, par_np);
>> > +}
>> > +EXPORT_SYMBOL_GPL(platform_irqchip_probe);
>> > diff --git a/include/linux/irqchip.h b/include/linux/irqchip.h
>> > index 950e4b2458f0..6d5eba7cbbb7 100644
>> > --- a/include/linux/irqchip.h
>> > +++ b/include/linux/irqchip.h
>> > @@ -13,6 +13,7 @@
>> >
>> >  #include <linux/acpi.h>
>> >  #include <linux/of.h>
>> > +#include <linux/platform_device.h>
>> >
>> >  /*
>> >   * This macro must be used by the different irqchip drivers to declare
>> > @@ -26,6 +27,28 @@
>> >   */
>> >  #define IRQCHIP_DECLARE(name, compat, fn) OF_DECLARE_2(irqchip, name, compat, fn)
>> >
>> > +extern int platform_irqchip_probe(struct platform_device *pdev);
>> > +
>> > +#define IRQCHIP_PLATFORM_DRIVER_BEGIN \
>> > +static const struct of_device_id __irqchip_match_table[] = {
>> 
>> How about:
>> 
>> #define IRQCHIP_PLATFORM_DRIVER_BEGIN(drv_name) \
>> static const struct of_device_id __irqchip_match_table_##drv_name = {
>> 
>> which makes it easier to debug when you want to identify specific
>> structures in an object (otherwise, they all have the same
>> name...). it is also much more pleasing aesthetically ;-).
> 
> I totally agree. I wanted BEGIN to have the name and END to not have
> to specify the name. But I couldn't figure out a way to do it. I
> assumed you wouldn't want the names repeated in both BEGIN and END. If
> you are okay with that, I prefer your suggestion too.

I'm perfectly fine having the name in both the BEGIN and END tags.
It has a nice LaTeX twist to it ;-).

> 
>> > +
>> > +#define IRQCHIP_MATCH(compat, fn) { .compatible = compat, .data = fn },
>> > +
>> > +#define IRQCHIP_PLATFORM_DRIVER_END(drv_name)                \
>> > +     {},                                             \
>> > +};                                                   \
>> > +MODULE_DEVICE_TABLE(of, __irqchip_match_table);              \
>> > +static struct platform_driver drv_name##_driver = {  \
>> 
>> const?
> 
> Sure.
> 
>> > +     .probe  = platform_irqchip_probe,               \
>> > +     .driver = {                                     \
>> > +             .name = #drv_name,                      \
>> > +             .owner = THIS_MODULE,                   \
>> > +             .of_match_table = __irqchip_match_table,\
>> > +             .suppress_bind_attrs = true,            \
>> > +     },                                              \
>> > +};                                                   \
>> > +builtin_platform_driver(drv_name##_driver)
>> > +
>> >  /*
>> >   * This macro must be used by the different irqchip drivers to declare
>> >   * the association between their version and their initialization function.
>> > --
>> > 2.28.0.rc0.105.gf9edc3c819-goog
>> >
>> >
>> 
>> Otherwise looks good. When you respin it, it would be good to also
>> submit one user of this API by converting an existing driver, as I'd
>> hate to merge something that has no user.
> 
> The only one I know will work is the qcom pdc one from John. So I was
> hoping John would respin his patch if you accept this one or I was
> going to redo it after it shows up on linux-next. Maybe MTK can use
> this too for their other series?

I have queued John's PDC work in irq/irqchip-5.9, which I will get
into -next over the weekend. Feel free to post a patch reworking
his last patch, which will give a very nice overview of what we gain.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
