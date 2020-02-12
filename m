Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF20C35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BDA2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ra4CJUVR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLCIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:08:40 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38565 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgBLCIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:08:40 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so601771qkj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aO1UKgSaz5CktVcc4Y8RcygWfgexx86iGtyjlHVU3kc=;
        b=Ra4CJUVRnDxwoRk1QHlRr35m77IrmNP+H+pxr+bZOB0DUqvHsCjOXSRfGg8rh5YTc/
         bgIS4sXVXPWDN0WSvdb5FMIFOhtL88yKaI01xKq0D1/4ULI+kJq4x8UcjsWQePCqsrs8
         6+XGOuD6jIhd4dxdCqcpHLWlftWwwtVIkMYXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aO1UKgSaz5CktVcc4Y8RcygWfgexx86iGtyjlHVU3kc=;
        b=b3qJ5q3gMuEiKMhTFYld9dv4GUrZg8EV6V5I54qilhxar3RGstbpVbg5DKT3rP74CX
         ju2wzZojP2TPLHpXmISc8PXqJLUi45iDHm/spo92Gf2M2PcA6tQWGSTQT/URsoODGZui
         QM5if3uptl5/luHdtI4qY79OGw8dNQ5FIzQ8nPZVeY0Ijzs9D5dR66vJweTn9836d1xx
         BaR3514DS2Zm6TJwDWYarufju4SLhE2MIFaC1OxVzJInBkbP38w03FC1XD4ypSMQo854
         mC/YZKF/TNf8hfjlmTRCpL2wHPgorPnkG5ApOKXI2KBd5H2QtJxJSS1SlJjJ7uq/a8PP
         MEkQ==
X-Gm-Message-State: APjAAAXF/O0ADbebGnhnTd4w51f/D82Obr4LSXLrkWHSMsFPiXwS1dVu
        SMzXQqPb9mSr+4sep2mJRnon8ffTOsNHpurG0qlEaA==
X-Google-Smtp-Source: APXvYqwbzvTmz/rK3xPb+7Zh0OWCEANWSI8B0x6aGBv3LzyJNw2pam02x3/hzeuy9xsPHf377lq3HNhZe8a4gYL9G7M=
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr8405839qky.299.1581473317421;
 Tue, 11 Feb 2020 18:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <20200207052627.130118-6-drinkcat@chromium.org> <CAL_JsqLshgzmhGGa+XibosSgk6R_9DQkDf12s793UZcvbQbxKw@mail.gmail.com>
 <CAGETcx_3-ZoVAf+Uf0Yo86pUU1nL4S4-jrS0eZi50yvhCO985g@mail.gmail.com>
In-Reply-To: <CAGETcx_3-ZoVAf+Uf0Yo86pUU1nL4S4-jrS0eZi50yvhCO985g@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 12 Feb 2020 10:08:26 +0800
Message-ID: <CANMq1KC2LEQ2iQzGDVAi+-x4Uy1LLB8JU-grTBVTL-iRej-t4A@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] drm/panfrost: Add support for multiple power domains
To:     Saravana Kannan <saravanak@google.com>
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

On Wed, Feb 12, 2020 at 4:09 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Tue, Feb 11, 2020 at 11:44 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > +Saravana
> >
> > On Thu, Feb 6, 2020 at 11:27 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > When there is a single power domain per device, the core will
> > > ensure the power domain is switched on (so it is technically
> > > equivalent to having not power domain specified at all).
> > >
> > > However, when there are multiple domains, as in MT8183 Bifrost
> > > GPU, we need to handle them in driver code.
> > >
> > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > >
> > > ---
> > > [snip]
> > > +               pfdev->pm_domain_links[i] = device_link_add(pfdev->dev,
> > > +                               pfdev->pm_domain_devs[i], DL_FLAG_PM_RUNTIME |
> > > +                               DL_FLAG_STATELESS | DL_FLAG_RPM_ACTIVE);
> >
> > We're in the process of adding device links based on DT properties.
> > Shouldn't we add power domains to that? See drivers/of/property.c for
> > what's handled.
>
> Rob,
>
> drivers/of/property.c doesn't enable the RPM_ACTIVE AND PM_RUNTIME
> flags. Wanted to start off conservative. But adding command line ops
> to change the default flags shouldn't be difficult. But before I do
> that, I want to change of_devlink to
> fw_devlink=<disabled|permissive|enabled>. May be I can extend that to
> "disabled, permissive, suspend, runtime".
>
> Nicholas,
>
> And the adding and removing of device links for power domains will be
> a 2 line change. I've been meaning to add a few more bindings like
> hwspinlocks and pinctrl. I can roll power domains support into that if
> you want.

Adding power domains makes sense to me, as there are a bunch of other
users (git grep dev_pm_domain_attach_by_name).

This seems to be a bit orthogonal to this patch though. If your
solution lands before this (and not something that is behind a command
line option), then I'm happy to make use of it. Either way, happy to
test things.
