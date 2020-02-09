Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B30C35254
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033AB20726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k1JVxZ8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbgBIMuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:50:24 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42044 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBIMuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:50:24 -0500
Received: by mail-qt1-f195.google.com with SMTP id r5so1748643qtt.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 04:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UUxkIo4yxkeRP+bZrwjD/FNTFLHW7fMlloVtMLr4fIw=;
        b=k1JVxZ8GdaxEZGeieGrpnm15pZ4+JPC8+bYPE/sod5qDCs/0UmRUfHu0wy4MINXpOW
         DihXo/5r07fOxQ6dMJP4lLbq78/jS89B0S3UYF9bGi0QnnLCHvKmJAgk8IwGJsOr0H26
         FaQH3KFacAlpODxXd2voo6Yh1qvW4pzy/NNYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UUxkIo4yxkeRP+bZrwjD/FNTFLHW7fMlloVtMLr4fIw=;
        b=JDOuxXR4zoAHt2DwVPQebXyQG3FVrlsRLqB5nHDLGlIQaaaz6KpaPT+NIsVjaRcqd3
         S6u+NyN6RmY+u7x+6aw2hgTpRy3Xtdt5tsc/L56U2k+a6M2Svp6rMGLo7yhXxiPckZoA
         +FvKQYbNRHAhSCZSpTbZKN0O6EcZjoTt532/0M7AwDcKYguHoS28eAC3iuPPDrMGDKtJ
         YT1A/H5mYMSi/3HioGwFrnWyVdmUjbCFUz6W0Oa82V6WoFKUsMSDypA2wZev2QszR1/8
         rE2IUPTb7S+fy/864iPxNwjXnxD2fKx/hrjuyz4S2/4ByK6/xyp14VQTkucZCww+RCnm
         yCEQ==
X-Gm-Message-State: APjAAAVa7qYkP01A1AqX5+vMQVPnTxDgps1wCL6fcB5wfAADLW3SMIQi
        2zQbg2duZU5eG6BDbZQfLKwWEBKe7gUlFH2d0ylO7w==
X-Google-Smtp-Source: APXvYqwL0HPYs/DVRlaJsVp3prBvI/t5NO1gP07ODLr8nGv9P4GfIkkmBVpz1yzFJ54MiCuGem5H75+HZritEl9gP4M=
X-Received: by 2002:ac8:3946:: with SMTP id t6mr6142797qtb.278.1581252621106;
 Sun, 09 Feb 2020 04:50:21 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-6-drinkcat@chromium.org> <CAPDyKFoz0gUkoofWkd6dFuOkRWqeeCDrv84UHyYYowAAgTiitw@mail.gmail.com>
In-Reply-To: <CAPDyKFoz0gUkoofWkd6dFuOkRWqeeCDrv84UHyYYowAAgTiitw@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sun, 9 Feb 2020 20:50:23 +0800
Message-ID: <CANMq1KA+3O+G+_r=xY98eK-in5i3HWg+4B4-ONk-6qWS3a9=0g@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/panfrost: Add support for multiple power domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 10:26 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 7 Feb 2020 at 06:27, Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > When there is a single power domain per device, the core will
> > ensure the power domain is switched on (so it is technically
> > equivalent to having not power domain specified at all).
> >
> > However, when there are multiple domains, as in MT8183 Bifrost
> > GPU, we need to handle them in driver code.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Besides a minor nitpick, feel free to add:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Kind regards
> Uffe
>
> [snip]
> > +static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
> > +{
> > +       int err;
> > +       int i, num_domains;
> > +
> > +       num_domains = of_count_phandle_with_args(pfdev->dev->of_node,
> > +                                                "power-domains",
> > +                                                "#power-domain-cells");
> > +
> > +       /*
> > +        * Single domain is handled by the core, and, if only a single power
> > +        * the power domain is requested, the property is optional.
> > +        */
> > +       if (num_domains < 2 && pfdev->comp->num_pm_domains < 2)
> > +               return 0;
> > +
> > +       if (num_domains != pfdev->comp->num_pm_domains) {
> > +               dev_err(pfdev->dev,
> > +                       "Incorrect number of power domains: %d provided, %d needed\n",
> > +                       num_domains, pfdev->comp->num_pm_domains);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (WARN(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs),
> > +                       "Too many supplies in compatible structure.\n"))
>
> Nitpick:
> Not sure this deserves a WARN. Perhaps a regular dev_err() is sufficient.

Ah well I had a BUG_ON before so presumably this is already a little better ,-)

You can only reach there if you set pfdev->comp->num_pm_domains >
MAX_PM_DOMAINS in the currently matched struct panfrost_compatible
(pfdev->comp->num_pm_domains == num_domains, and see below too), so
the kernel code would actually be actually broken (not the device
tree, nor anything that could be probed). So I'm wondering if the
loudness of a WARN is better in this case? Arguable ,-)

> > +               return -EINVAL;
> [snip]
> > --- a/drivers/gpu/drm/panfrost/panfrost_device.h
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
> > @@ -21,6 +21,7 @@ struct panfrost_perfcnt;
> >
> >  #define NUM_JOB_SLOTS 3
> >  #define MAX_REGULATORS 2
> > +#define MAX_PM_DOMAINS 3
> >
> >  struct panfrost_features {
> >         u16 id;
> > @@ -61,6 +62,13 @@ struct panfrost_compatible {
> >         /* Supplies count and names. */
> >         int num_supplies;
> >         const char * const *supply_names;
> > +       /*
> > +        * Number of power domains required, note that values 0 and 1 are
> > +        * handled identically, as only values > 1 need special handling.
> > +        */
> > +       int num_pm_domains;
> > +       /* Only required if num_pm_domains > 1. */
> > +       const char * const *pm_domain_names;
> >  };
> >
> >  struct panfrost_device {
> > @@ -73,6 +81,9 @@ struct panfrost_device {
> >         struct clk *bus_clock;
> >         struct regulator_bulk_data regulators[MAX_REGULATORS];
> >         struct reset_control *rstc;
> > +       /* pm_domains for devices with more than one. */
> > +       struct device *pm_domain_devs[MAX_PM_DOMAINS];
> > +       struct device_link *pm_domain_links[MAX_PM_DOMAINS];
> >
> >         struct panfrost_features features;
> >         const struct panfrost_compatible *comp;
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > index 4d08507526239f2..a6e162236d67fdf 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> > @@ -663,6 +663,8 @@ const char * const default_supplies[] = { "mali" };
> >  static const struct panfrost_compatible default_data = {
> >         .num_supplies = ARRAY_SIZE(default_supplies),
> >         .supply_names = default_supplies,
> > +       .num_pm_domains = 1, /* optional */
> > +       .pm_domain_names = NULL,
> >  };
> >
> >  static const struct of_device_id dt_match[] = {
> > --
> > 2.25.0.341.g760bfbb309-goog
> >
