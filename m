Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62893C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368BC22453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 15:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XFo/5Ipg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgGNPE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 11:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgGNPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:04:57 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293B5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:04:57 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n4so5785589uae.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/oh9XF5SOXVCKwu2J/u8wXMNjEOkkTG/eA/WhWtoY4=;
        b=XFo/5IpgL6tGSOxOVMQeil253Kbt71ltzbuiCBCO4ujqH54FsSkYGTE6Xm7vHe0y3v
         lgJ88ou5QW7Qw/Qz7CNeB0otzjL3+DyYLuKAsWm/5v0ziT7f/risPK+il/Z7aqq17q3+
         SvGlAHGmm+1iL3MjumSHypyUCOBunNYVd3Buw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/oh9XF5SOXVCKwu2J/u8wXMNjEOkkTG/eA/WhWtoY4=;
        b=LXgRIRoXp3yLpg6s6341aJOrNIBxXhyIVK0n0WPluSAEzkDwqufNRWrdIhCgVD1zC5
         qBMYoz5Ma0gN918aKmVrvPMgSpNax3lrqsrslCDeiUNPJ+WdHJEzYYZK0tchk8G/ksHD
         lkFqfj8wBXuqW96LCmugVC4AMzdQqd2kRltSwIVkFGZcCrXGwold/UF6AQcEMEkAiVgQ
         3yhIRn9lydO/sadP2H+1Zgg4pgpmWsGWunlDddGOeFTvfP/4btycuvQ4qIAn4gY3Rida
         PABsLz3fch+sXENPsbNynKrNVH8k8wYYnW1NBcPdUaxFQmFP+655KlrBylH52LeEtsiP
         8wxQ==
X-Gm-Message-State: AOAM5334qDyDkuNPnTn950pon2y+2PcIRxnkF7+myCFmObiCcdH+6blX
        8VRw9XnMOt4yNMFNwaFDW0jNAAMkPxY=
X-Google-Smtp-Source: ABdhPJzpUkEAypyZF8OsX/cg8KbYmvUidzx3SKWbR41Q/o3rnREFS8YOFj5a3dPd8bziMsXAX5Xvnw==
X-Received: by 2002:ab0:53cc:: with SMTP id l12mr3852122uaa.24.1594739095494;
        Tue, 14 Jul 2020 08:04:55 -0700 (PDT)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id f69sm2553568vkf.4.2020.07.14.08.04.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:04:55 -0700 (PDT)
Received: by mail-ua1-f42.google.com with SMTP id q15so5784314uap.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:04:54 -0700 (PDT)
X-Received: by 2002:ab0:44e5:: with SMTP id n92mr3673388uan.121.1594739094005;
 Tue, 14 Jul 2020 08:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200713082628.v2.1.Ie0d730120b232a86a4eac1e2909bcbec844d1766@changeid>
 <d1d9271595a0cfc6cbfca85b54f545cc@kernel.org>
In-Reply-To: <d1d9271595a0cfc6cbfca85b54f545cc@kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Jul 2020 08:04:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XEXiwNfNL54dq+YV3UjipqAbaCTsyyvoA5ZyxZMKXb3Q@mail.gmail.com>
Message-ID: <CAD=FV=XEXiwNfNL54dq+YV3UjipqAbaCTsyyvoA5ZyxZMKXb3Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: qcom: Handle broken/missing PDC dual edge
 IRQs on sc7180
To:     Marc Zyngier <maz@kernel.org>
Cc:     LinusW <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 14, 2020 at 3:54 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Doug,
>
> On 2020-07-13 16:26, Douglas Anderson wrote:
> > Depending on how you look at it, you can either say that:
> > a) There is a PDC hardware issue (with the specific IP rev that exists
> >    on sc7180) that causes the PDC not to work properly when configured
> >    to handle dual edges.
> > b) The dual edge feature of the PDC hardware was only added in later
> >    HW revisions and thus isn't in all hardware.
> >
> > Regardless of how you look at it, let's work around the lack of dual
> > edge support by only ever letting our parent see requests for single
> > edge interrupts on affected hardware.
> >
> > NOTE: it's possible that a driver requesting a dual edge interrupt
> > might get several edges coalesced into a single IRQ.  For instance if
> > a line starts low and then goes high and low again, the driver that
> > requested the IRQ is not guaranteed to be called twice.  However, it
> > is guaranteed that once the driver's interrupt handler starts running
> > its first instruction that any new edges coming in will cause the
> > interrupt to fire again.  This is relatively commonplace for dual-edge
> > gpio interrupts (many gpio controllers require software to emulate
> > dual edge with single edge) so client drivers should be setup to
> > handle it.
> >
> > Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > As far as I can tell everything here should work and the limited
> > testing I'm able to give it shows that, in fact, I can detect both
> > edges.
> >
> > I specifically left off Reviewed-by and Tested-by tags from v2 becuase
> > I felt that the implementation had changed just enough to invalidate
> > previous reviews / testing.  Hopefully it's not too much of a hassle
> > for folks to re-review and re-test.
> >
> > Changes in v2:
> > - Use handle_fasteoi_ack_irq() and switch edges in the Ack now.
> > - If we change types, switch back to the normal handle_fasteoi_irq().
> > - No extra locking.
> > - Properly print an error if we hit 100 loops w/ no stability.
> > - Beefed up the commit message.
> >
> >  drivers/pinctrl/qcom/Kconfig          |  2 +
> >  drivers/pinctrl/qcom/pinctrl-msm.c    | 74 ++++++++++++++++++++++++++-
> >  drivers/pinctrl/qcom/pinctrl-msm.h    |  4 ++
> >  drivers/pinctrl/qcom/pinctrl-sc7180.c |  1 +
> >  4 files changed, 79 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pinctrl/qcom/Kconfig
> > b/drivers/pinctrl/qcom/Kconfig
> > index ff1ee159dca2..f8ff30cdafa6 100644
> > --- a/drivers/pinctrl/qcom/Kconfig
> > +++ b/drivers/pinctrl/qcom/Kconfig
> > @@ -7,6 +7,8 @@ config PINCTRL_MSM
> >       select PINCONF
> >       select GENERIC_PINCONF
> >       select GPIOLIB_IRQCHIP
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     select IRQ_FASTEOI_HIERARCHY_HANDLERS
> >
> >  config PINCTRL_APQ8064
> >       tristate "Qualcomm APQ8064 pin controller driver"
> > diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c
> > b/drivers/pinctrl/qcom/pinctrl-msm.c
> > index 83b7d64bc4c1..eae8f421ff63 100644
> > --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> > +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> > @@ -832,6 +832,52 @@ static void msm_gpio_irq_unmask(struct irq_data
> > *d)
> >       msm_gpio_irq_clear_unmask(d, false);
> >  }
> >
> > +/**
> > + * msm_gpio_update_dual_edge_parent() - Prime next edge for IRQs
> > handled by parent.
> > + * @d: The irq dta.
> > + *
> > + * This is much like msm_gpio_update_dual_edge_pos() but for IRQs that
> > are
> > + * normally handled by the parent irqchip.  The logic here is slightly
> > + * different due to what's easy to do with our parent, but in
> > principle it's
> > + * the same.
> > + */
> > +static void msm_gpio_update_dual_edge_parent(struct irq_data *d)
> > +{
> > +     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +     struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> > +     const struct msm_pingroup *g = &pctrl->soc->groups[d->hwirq];
> > +     int loop_limit = 100;
> > +     unsigned int val;
> > +     unsigned int type;
> > +
> > +     /* Read the value and make a guess about what edge we need to catch
> > */
> > +     val = msm_readl_io(pctrl, g) & BIT(g->in_bit);
> > +     type = val ? IRQ_TYPE_EDGE_FALLING : IRQ_TYPE_EDGE_RISING;
> > +
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
> > +                             return;
> > +                     type = IRQ_TYPE_EDGE_FALLING;
> > +             } else if (type == IRQ_TYPE_EDGE_FALLING) {
> > +                     if (val)
> > +                             return;
> > +                     type = IRQ_TYPE_EDGE_RISING;
> > +             }
> > +     } while (loop_limit-- > 0);
> > +     dev_err(pctrl->dev, "dual-edge irq failed to stabilize\n");
>
> I'd tone this down to a dev_warn_once(), if at all possible, or
> some other rate-limited variant.
>
> Otherwise, looks OK to me.

Thanks for your review.  I'm sending out v3 without any delay just to
get this fixed up since it's not controversial.  Hope that's OK.

-Doug
