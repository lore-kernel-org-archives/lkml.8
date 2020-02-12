Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7F8C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15542073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUxk6Sy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgBLCLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:11:20 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43524 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgBLCLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:11:19 -0500
Received: by mail-ot1-f67.google.com with SMTP id p8so353183oth.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 18:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n6k/Lbub/n1jxmtDamXfDiU39sk3ANWZWTNVfSZ9e5g=;
        b=wUxk6Sy9q6qoyjX1z79P+a13uxDl7LnfZY8mNFGDgLHAlzg+XIha1ypLspjBiq7hGA
         HscwnVJCrLtXWufw1he5v8VfT3HhFn4FyHWnUeTsvsjxPaEAAXBiVH0y2bC/U+NCpyPW
         0BtVAPLHJwtrtf3dif65ZmZBB4BUJJNeT61X2XptZj0kCPVjl86sk8jl0uxD4TNa040Y
         iedDOzlawJRkS23dZ4HPD5Tv83JGGozqICZ559cUnrRv1Za8W1K53jibHXYJ97fH0ckR
         IF7Z9sw+FkJ1KG/xqorkkIHoNWCYYP0GScu1biUAByDXEN7ff8+g+wya90Fu0XzcpdDT
         2g+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n6k/Lbub/n1jxmtDamXfDiU39sk3ANWZWTNVfSZ9e5g=;
        b=rh2wUwWlgQ4P0bwGgHmzH0D88GJkPbXmXAXDnvl0KuJKgKahFyIFqdAaYT8NWLJ7tK
         l4aQ9cCdQHcCZcuTinpLT/CH6YbeIauNZ6Jl52X+LqnPcTOyVUhoA9QUxJSYsEVmSzU5
         5qQ5p6cBrt1lv4FfnQAkAfNGSW4CrdSBA8CYWXkV0kY7k9wg4LVEj/it4i8dm6+D6z8W
         3UA9GMW4lpSri4B0Z+g0Eqd35XvR9q8Oq74aiIWuDRIAgdq2IPkW3XU6W7eWwOqePmm6
         zksI61GQh+5WEpf26PSNK8G8I0bITWz3q8vEZ8zxenD5B2SwhwOOMKfyLVLxTxMlvR4e
         aZgQ==
X-Gm-Message-State: APjAAAVADhYNOjIVrINd6yuHVPXD28SSfAlQJxmSJRRhEnOGQFqrX+RD
        bmLDTiFF/i1zg4RfGGSRhUDiPPavY8/pCh+tqYP2cg==
X-Google-Smtp-Source: APXvYqx9WyDPh84T/dWz0V7MAkV6Fu38Ls7r23WUTJHuOaZMt9M7Cqkp1o3QjcNUD57URwJnbkv4nhKPOxGIjSTARy8=
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr7441403otc.236.1581473478420;
 Tue, 11 Feb 2020 18:11:18 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-6-drinkcat@chromium.org> <CAL_JsqLshgzmhGGa+XibosSgk6R_9DQkDf12s793UZcvbQbxKw@mail.gmail.com>
 <CAGETcx_3-ZoVAf+Uf0Yo86pUU1nL4S4-jrS0eZi50yvhCO985g@mail.gmail.com> <CAL_JsqLw1fyj949KtG6wNRG_Ky6cq2wS3VH2Ku+ZykU3bSap=g@mail.gmail.com>
In-Reply-To: <CAL_JsqLw1fyj949KtG6wNRG_Ky6cq2wS3VH2Ku+ZykU3bSap=g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 11 Feb 2020 18:10:42 -0800
Message-ID: <CAGETcx9H09LZ7v+SrPLmtyLQBVzoVg9yRFMwYnQOLCtndWgHTw@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/panfrost: Add support for multiple power domains
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:58 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Feb 11, 2020 at 2:09 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Tue, Feb 11, 2020 at 11:44 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > +Saravana
> > >
> > > On Thu, Feb 6, 2020 at 11:27 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > > >
> > > > When there is a single power domain per device, the core will
> > > > ensure the power domain is switched on (so it is technically
> > > > equivalent to having not power domain specified at all).
> > > >
> > > > However, when there are multiple domains, as in MT8183 Bifrost
> > > > GPU, we need to handle them in driver code.
> > > >
> > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > >
> > > > ---
> > > >
> > > > The downstream driver we use on chromeos-4.19 currently uses 2
> > > > additional devices in device tree to accomodate for this [1], but
> > > > I believe this solution is cleaner.
> > > >
> > > > [1] https://chromium.googlesource.com/chromiumos/third_party/kernel/+/refs/heads/chromeos-4.19/drivers/gpu/arm/midgard/platform/mediatek/mali_kbase_runtime_pm.c#31
> > > >
> > > > v4:
> > > >  - Match the exact power domain names as specified in the compatible
> > > >    struct, instead of just matching the number of power domains.
> > > >    [Review: Ulf Hansson]
> > > >  - Dropped print and reordered function [Review: Steven Price]
> > > >  - nits: Run through latest version of checkpatch:
> > > >    - Use WARN instead of BUG_ON.
> > > >    - Drop braces for single expression if block.
> > > > v3:
> > > >  - Use the compatible matching data to specify the number of power
> > > >    domains. Note that setting 0 or 1 in num_pm_domains is equivalent
> > > >    as the core will handle these 2 cases in the exact same way
> > > >    (automatically, without driver intervention), and there should
> > > >    be no adverse consequence in this case (the concern is about
> > > >    switching on only some power domains and not others).
> > > >
> > > >  drivers/gpu/drm/panfrost/panfrost_device.c | 97 ++++++++++++++++++++--
> > > >  drivers/gpu/drm/panfrost/panfrost_device.h | 11 +++
> > > >  drivers/gpu/drm/panfrost/panfrost_drv.c    |  2 +
> > > >  3 files changed, 102 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > index 3720d50f6d9f965..8136babd3ba9935 100644
> > > > --- a/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > > > @@ -5,6 +5,7 @@
> > > >  #include <linux/clk.h>
> > > >  #include <linux/reset.h>
> > > >  #include <linux/platform_device.h>
> > > > +#include <linux/pm_domain.h>
> > > >  #include <linux/regulator/consumer.h>
> > > >
> > > >  #include "panfrost_device.h"
> > > > @@ -120,6 +121,79 @@ static void panfrost_regulator_fini(struct panfrost_device *pfdev)
> > > >                         pfdev->regulators);
> > > >  }
> > > >
> > > > +static void panfrost_pm_domain_fini(struct panfrost_device *pfdev)
> > > > +{
> > > > +       int i;
> > > > +
> > > > +       for (i = 0; i < ARRAY_SIZE(pfdev->pm_domain_devs); i++) {
> > > > +               if (!pfdev->pm_domain_devs[i])
> > > > +                       break;
> > > > +
> > > > +               if (pfdev->pm_domain_links[i])
> > > > +                       device_link_del(pfdev->pm_domain_links[i]);
> > > > +
> > > > +               dev_pm_domain_detach(pfdev->pm_domain_devs[i], true);
> > > > +       }
> > > > +}
> > > > +
> > > > +static int panfrost_pm_domain_init(struct panfrost_device *pfdev)
> > > > +{
> > > > +       int err;
> > > > +       int i, num_domains;
> > > > +
> > > > +       num_domains = of_count_phandle_with_args(pfdev->dev->of_node,
> > > > +                                                "power-domains",
> > > > +                                                "#power-domain-cells");
> > > > +
> > > > +       /*
> > > > +        * Single domain is handled by the core, and, if only a single power
> > > > +        * the power domain is requested, the property is optional.
> > > > +        */
> > > > +       if (num_domains < 2 && pfdev->comp->num_pm_domains < 2)
> > > > +               return 0;
> > > > +
> > > > +       if (num_domains != pfdev->comp->num_pm_domains) {
> > > > +               dev_err(pfdev->dev,
> > > > +                       "Incorrect number of power domains: %d provided, %d needed\n",
> > > > +                       num_domains, pfdev->comp->num_pm_domains);
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       if (WARN(num_domains > ARRAY_SIZE(pfdev->pm_domain_devs),
> > > > +                       "Too many supplies in compatible structure.\n"))
> > > > +               return -EINVAL;
> > > > +
> > > > +       for (i = 0; i < num_domains; i++) {
> > > > +               pfdev->pm_domain_devs[i] =
> > > > +                       dev_pm_domain_attach_by_name(pfdev->dev,
> > > > +                                       pfdev->comp->pm_domain_names[i]);
> > > > +               if (IS_ERR_OR_NULL(pfdev->pm_domain_devs[i])) {
> > > > +                       err = PTR_ERR(pfdev->pm_domain_devs[i]) ? : -ENODATA;
> > > > +                       pfdev->pm_domain_devs[i] = NULL;
> > > > +                       dev_err(pfdev->dev,
> > > > +                               "failed to get pm-domain %s(%d): %d\n",
> > > > +                               pfdev->comp->pm_domain_names[i], i, err);
> > > > +                       goto err;
> > > > +               }
> > > > +
> > > > +               pfdev->pm_domain_links[i] = device_link_add(pfdev->dev,
> > > > +                               pfdev->pm_domain_devs[i], DL_FLAG_PM_RUNTIME |
> > > > +                               DL_FLAG_STATELESS | DL_FLAG_RPM_ACTIVE);
> > >
> > > We're in the process of adding device links based on DT properties.
> > > Shouldn't we add power domains to that? See drivers/of/property.c for
> > > what's handled.
> >
> > Rob,
> >
> > drivers/of/property.c doesn't enable the RPM_ACTIVE AND PM_RUNTIME
> > flags. Wanted to start off conservative.
>
> I worry that you can't add it later without potentially breaking platforms.
>
> I haven't checked, but I assume these flags make runtime PM honor
> device links? That seems like the more conservative option (more
> reasons why a device can't suspend).

Conservative as in, if of_devlink adds the RPM_ACTIVE flag, the
drivers can't remove it.

> > But adding command line ops
> > to change the default flags shouldn't be difficult. But before I do
> > that, I want to change of_devlink to
> > fw_devlink=<disabled|permissive|enabled>. May be I can extend that to
> > "disabled, permissive, suspend, runtime".
>
> I think any command line option should be debug primarily. It's kind
> of a big hammer.

It is a big hammer. But it's better than disabling of_devlink
altogether. There is always going to be weird hardware that won't work
with of_devlink if all the device link flags are set. They'll need
some fix up of drivers and/or clean up of DT. And having different
of_devlink command line options would at least let those hardware to
run with as much of_devlink enabled as possible while working to get
more fixes into the kernel. That way, we can make sure we don't
regress further while trying to improve the support.

> Can drivers adjust the flags themselves? Just modify the flags rather
> than trying to create new links?

They can, but only in an additive manner. And the way to do it would
be to add a device link like usual and the framework takes care of
combining the flags. That's why I don't set most of the flags by
default.


-Saravana
