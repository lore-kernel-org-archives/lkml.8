Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F088C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7ECA20720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iD3Vj09R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgGJQLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbgGJQLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:11:43 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9C8C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:11:43 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q15so3251704vso.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuuyGMPPXvJbhukGctpaGeXqFcZXftTaBLVOd6hvTaY=;
        b=iD3Vj09RYSQk0VOmmHlNPXoLq3wYCqOqY5sTrl+2QE2Sz43ZGFHENAkHrCLJXz34nT
         jIYryH1kh0zZkT9DfOyBCF0h3c+PefBclciTW3O3hg5y5EaTuj1KhgMICW50zkaFzzKU
         hcux+sujAaDsBPqnjfkyKyrIUyWddynsL/iq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuuyGMPPXvJbhukGctpaGeXqFcZXftTaBLVOd6hvTaY=;
        b=TKZZlxk3wu4FM4bmMUG1N9TmIt0PYXtQzeZm1Z9qb+yJZzONEy10NBgMxBhmasLGgd
         FEbgc/QLhjizQO+dTVphhD7XGPmStSZ86b6yZOe8e7zFLWTvkZZRzSGNYE+IxiT8YRWs
         +2m8aFr5XRP76NkpCtmjivS8JYNBhrZzH1hlW5H82EkMKJsC2RwvTU/A1sV4GFMn4HIL
         oMakaTVROmARmd+M+3Eik0DLekQNsXAqO/hB1d2M6uHcUNwHaATKzmRY45V6GaGhytzz
         L7Nwsrvjn4hu/6i4tNXvcwn+NmFX9JXN5riXh3KNQ+Ba0pCnNzEu1bDrVF97oYlOE+wT
         ax7g==
X-Gm-Message-State: AOAM533ovc3rA+PWTMGKemoHwDTkjBIhpHS4FWMkxNTmEcmeiyuafKnQ
        WZg7gJ0c5JHQMv1oNhwNAgSM/2EIxfU=
X-Google-Smtp-Source: ABdhPJyD7NWnEuRj+oKoulAed5SIyjAAqy1JeUbIhjK6BAlc/MTnwiKcSMI9CbawGRkwiX4faVUaag==
X-Received: by 2002:a67:7f41:: with SMTP id a62mr21900305vsd.234.1594397502582;
        Fri, 10 Jul 2020 09:11:42 -0700 (PDT)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id m83sm883573vke.11.2020.07.10.09.11.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 09:11:41 -0700 (PDT)
Received: by mail-vs1-f53.google.com with SMTP id p25so3259134vsg.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:11:41 -0700 (PDT)
X-Received: by 2002:a05:6102:30b5:: with SMTP id y21mr29286187vsd.42.1594397501165;
 Fri, 10 Jul 2020 09:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200708141610.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
 <11dcb47c-60e3-3566-fc64-3a047354dff1@codeaurora.org>
In-Reply-To: <11dcb47c-60e3-3566-fc64-3a047354dff1@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 10 Jul 2020 09:11:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDj285gcUY83fK0OM_WzHDTHsTxgy9n04UgK6z88qMKw@mail.gmail.com>
Message-ID: <CAD=FV=VDj285gcUY83fK0OM_WzHDTHsTxgy9n04UgK6z88qMKw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: Handle broken PDC dual edge case on sc7180
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     LinusW <linus.walleij@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 9, 2020 at 10:09 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi Doug,
>
> On 7/9/2020 2:46 AM, Douglas Anderson wrote:
> > As per Qualcomm, there is a PDC hardware issue (with the specific IP
> > rev that exists on sc7180) that causes the PDC not to work properly
> > when configured to handle dual edges.
> >
> > Let's work around this by emulating only ever letting our parent see
> > requests for single edge interrupts on affected hardware.
> >
> > Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > As far as I can tell everything here should work and the limited
> > testing I'm able to give it shows that, in fact, I can detect both
> > edges.
> >
> > Please give this an extra thorough review since it's trying to find
> > the exact right place to insert this code and I'm not massively
> > familiar with all the frameworks.
> >
> > If someone has hardware where it's easy to stress test this that'd be
> > wonderful too.  The board I happen to have in front of me doesn't have
> > any easy-to-toggle GPIOs where I can just poke a button or a switch to
> > generate edges.  My testing was done by hacking the "write protect"
> > GPIO on my board into gpio-keys as a dual-edge interrupt and then
> > sending commands to our security chip to toggle it--not exactly great
> > for testing to make sure there are no race conditions if the interrupt
> > bounces a lot.
> >
> >   drivers/pinctrl/qcom/pinctrl-msm.c    | 80 +++++++++++++++++++++++++++
> >   drivers/pinctrl/qcom/pinctrl-msm.h    |  4 ++
> >   drivers/pinctrl/qcom/pinctrl-sc7180.c |  1 +
> >   3 files changed, 85 insertions(+)
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 83b7d64bc4c1..45ca09ebb7b3 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -860,6 +860,79 @@ static void msm_gpio_irq_ack(struct irq_data *d)
> >       raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> >   }
> >
> > +/**
> > + * msm_gpio_update_dual_edge_parent() - Prime next edge for IRQs handled by parent.
> > + * @d: The irq dta.
> > + *
> > + * This is much like msm_gpio_update_dual_edge_pos() but for IRQs that are
> > + * normally handled by the parent irqchip.  The logic here is slightly
> > + * different due to what's easy to do with our parent, but in principle it's
> > + * the same.
> > + */
> > +static void msm_gpio_update_dual_edge_parent(struct irq_data *d)
> > +{
> > +     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +     struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> > +     const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
> > +     unsigned long flags;
> > +     int loop_limit = 100;
> > +     unsigned int val;
> > +     unsigned int type;
> > +
> > +     /* Read the value and make a guess about what edge we need to catch */
> > +     val = msm_readl_io(pctrl, g) & BIT(g->in_bit);
> > +     type = val ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
> > +
> > +     raw_spin_lock_irqsave(&pctrl->lock, flags);
> can you please move this spinlock covering above two lines as well?

I could, but it wouldn't accomplish anything would it?  We're reading
the status of the pin straight from memory mapped registers.  Grabbing
a spinlock won't stop the pin from toggling.

...but from Mark's review I'll likely change the locking a bit anyway.


> > +     do {
> > +             /* Set the parent to catch the next edge */
> > +             irq_chip_set_type_parent(d, type);
> > +
> > +             /*
> > +              * Possibly the line changed between when we last read "val"
> > +              * (and decided what edge we needed) and when set the edge.
> > +              * If the value didn't change (or changed and then changed
> > +              * back) then we're done.
> > +              */
> > +             val = msm_readl_io(pctrl, g) & BIT(g->in_bit);
> > +             if (type == IRQ_TYPE_EDGE_RISING) {
> > +                     if (!val)
> > +                             break;
> > +                     type = IRQ_TYPE_EDGE_FALLING;
> > +             } else if (type == IRQ_TYPE_EDGE_FALLING) {
> > +                     if (val)
> > +                             break;
> > +                     type = IRQ_TYPE_EDGE_RISING;
> > +             }
> > +     } while (loop_limit-- > 0);
> > +     raw_spin_unlock_irqrestore(&pctrl->lock, flags);
> > +
> > +     if (!loop_limit)
> > +             dev_err(pctrl->dev, "dual-edge irq failed to stabilize\n");
>
> you will never enter this if condtion since loop_limit will become
> negative value in above do..while loop.
>
> need to update this check to if (loop_limit <= 0)
>
> other than above comment this change looks good to me.

Good catch, thanks!



> Reviewed-by: Maulik Shah <mkshah@codeaurora.org>
>
> Tested-by: Maulik Shah <mkshah@codeaurora.org>
>
> Thanks,
> Maulik
>
> > +}
> > +
> > +void msm_gpio_handle_dual_edge_parent_irq(struct irq_desc *desc)
> > +{
> > +     struct irq_data *d = &desc->irq_data;
> > +
> > +     /* Make sure we're primed for the next edge */
> > +     msm_gpio_update_dual_edge_parent(d);
> > +
> > +     /* Pass on to the normal interrupt handler */
> > +     handle_fasteoi_irq(desc);
> > +}
> > +
> > +static bool msm_gpio_needs_dual_edge_parent_workaround(struct irq_data *d,
> > +                                                    unsigned int type)
> > +{
> > +     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +     struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> > +
> > +     return type == IRQ_TYPE_EDGE_BOTH &&
> > +            pctrl->soc->wakeirq_dual_edge_errata && d->parent_data &&
> > +            test_bit(d->hwirq, pctrl->skip_wake_irqs);
> > +}
> > +
> >   static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> >   {
> >       struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > @@ -868,6 +941,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> >       unsigned long flags;
> >       u32 val;
> >
> > +     if (msm_gpio_needs_dual_edge_parent_workaround(d, type)) {
> > +             irq_set_handler_locked(d, msm_gpio_handle_dual_edge_parent_irq);
> > +             msm_gpio_update_dual_edge_parent(d);
> > +
> > +             return 0;
> > +     }
> > +
> >       if (d->parent_data)
> >               irq_chip_set_type_parent(d, type);
> >
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
> > index 9452da18a78b..7486fe08eb9b 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.h
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.h
> > @@ -113,6 +113,9 @@ struct msm_gpio_wakeirq_map {
> >    * @pull_no_keeper: The SoC does not support keeper bias.
> >    * @wakeirq_map:    The map of wakeup capable GPIOs and the pin at PDC/MPM
> >    * @nwakeirq_map:   The number of entries in @wakeirq_map
> > + * @wakeirq_dual_edge_errata: If true then GPIOs using the wakeirq_map need
> > + *                            to be aware that their parent can't handle dual
> > + *                            edge interrupts.
> >    */
> >   struct msm_pinctrl_soc_data {
> >       const struct pinctrl_pin_desc *pins;
> > @@ -128,6 +131,7 @@ struct msm_pinctrl_soc_data {
> >       const int *reserved_gpios;
> >       const struct msm_gpio_wakeirq_map *wakeirq_map;
> >       unsigned int nwakeirq_map;
> > +     bool wakeirq_dual_edge_errata;
> >   };
> >
> >   extern const struct dev_pm_ops msm_pinctrl_dev_pm_ops;
> > diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
> > index 1b6465a882f2..1d9acad3c1ce 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-sc7180.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
> > @@ -1147,6 +1147,7 @@ static const struct msm_pinctrl_soc_data sc7180_pinctrl = {
> >       .ntiles = ARRAY_SIZE(sc7180_tiles),
> >       .wakeirq_map = sc7180_pdc_map,
> >       .nwakeirq_map = ARRAY_SIZE(sc7180_pdc_map),
> > +     .wakeirq_dual_edge_errata = true,
> >   };
> >
> >   static int sc7180_pinctrl_probe(struct platform_device *pdev)
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
