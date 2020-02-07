Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7234AC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454D4214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="n54HafII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGCES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:04:18 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43384 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgBGCES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:04:18 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so269213qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 18:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f/k2mGN9MY7NNfoOb4gMqNsjIZIFXh28kOhlDVSQmA0=;
        b=n54HafII/Lex3YLQXDbmveG7TRPxgfQUwWoNXykBlSczgnFnbEiABU6Nlwne2EnVqZ
         BLZNg9eH05yf+6HnfQFJWO3Ox35KsJoJtLmFEwLlc7LmqfuMonfkWKrE2MVp0ijf+rlC
         pgFHFzmYKEZYMyZMpnzqCt5JXY3Du2ndL/p2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f/k2mGN9MY7NNfoOb4gMqNsjIZIFXh28kOhlDVSQmA0=;
        b=kq2566EJw+5PXrf7qc2K0C4MQxCruoiRZhmoX142KMu+jxkYYOKhwgIZnC1qlpe5bF
         D5UsIZTSOdrvyhM1LDPBkIpX4ydzz1EvgXkjiFQC8aguJo+QvAGeApmQxN70713urFaj
         f5V79n1OwaRDBebSCbp31bfJkOfWHeiObHGYpLbhVSRi27DJTz4xw4C5y5EXcI09eOYv
         jRNm8KLydi9awig25aERCfaXmc+6odMd2qk7KYr9l9oleboZpvsy7d0kjfODAOguP2KR
         ZJhyNoaXNSXoSnfy75U0DwZAZGzvTpE9n35m626r2WIJHnWDPVDdu618iMKmaUfkElyb
         z/BA==
X-Gm-Message-State: APjAAAUNEosIruZKIwa2IRLWlFOuGVSVkK2im5tquACvPUKNCd8iafGC
        oQ8YND7ARBOpJdfN1anV/0YP615MDmkxZlNfN/xepA==
X-Google-Smtp-Source: APXvYqy6BPTxmJROJmd8xpRbLnJsPInZlt9zqkAt5bAH9XGkXglHOonteC+kQPoH8wbuH3FDnIt6xkHqcmjd+EAPUBo=
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr4977078qvb.187.1581041055375;
 Thu, 06 Feb 2020 18:04:15 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-6-drinkcat@chromium.org>
 <b58a8cf9-3275-cf89-6dff-596aceeb8000@arm.com> <CANMq1KBcNr=1_poBHrA_SDo_h-5i3e5TMqASEVaDj5LevsRcOQ@mail.gmail.com>
 <CAPDyKFr4Vz1ihuFQNnhDLEnOs=BZ1n2wzw3CATgPcDXs9g54uA@mail.gmail.com>
In-Reply-To: <CAPDyKFr4Vz1ihuFQNnhDLEnOs=BZ1n2wzw3CATgPcDXs9g54uA@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Feb 2020 10:04:04 +0800
Message-ID: <CANMq1KBCd0wNgVAxAzxBwafHoafPExz07wKFhEWQFViAc0LL1Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drm/panfrost: Add support for multiple power
 domain support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Steven Price <steven.price@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        lkml <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, Jan 27, 2020 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 10 Jan 2020 at 02:53, Nicolas Boichat <drinkcat@chromium.org> wro=
te:
> >
> > +Ulf to keep me honest on the power domains
> >
> > On Thu, Jan 9, 2020 at 10:08 PM Steven Price <steven.price@arm.com> wro=
te:
> > >
> > > On 08/01/2020 05:23, Nicolas Boichat wrote:
> > > > When there is a single power domain per device, the core will
> > > > ensure the power domains are all switched on.
> > > >
> > > > However, when there are multiple ones, as in MT8183 Bifrost GPU,
> > > > we need to handle them in driver code.
> > > >
> > > >
> > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > ---
> > > >
> > > > The downstream driver we use on chromeos-4.19 currently uses 2
> > > > additional devices in device tree to accomodate for this [1], but
> > > > I believe this solution is cleaner.
> > >
> > > I'm not sure what is best, but it seems odd to encode this into the P=
anfrost driver itself - it doesn't have any knowledge of what to do with th=
ese power domains. The naming of the domains looks suspiciously like someon=
e thought that e.g. only half of the cores could be powered, but it doesn't=
 look like that was implemented in the chromeos driver linked and anyway th=
at is *meant* to be automatic in the hardware! (I.e. if you only power up o=
ne cores in one core stack then the PDC should only enable the power domain=
 for that set of cores).
> >
> > This is actually implemented in the Chrome OS driver [1]. IMHO power
> > domains are a bit confusing [2]:
> >  i. If there's only 1 power domain in the device, then the core takes
> > care of power on the domain (based on pm_runtime)
> >  ii. If there's more than 1 power domain, then the device needs to
> > link the domains manually.
> >
> > So the Chrome OS [1] driver takes approach (i), by creating 3 devices,
> > each with 1 power domain that is switched on/off automatically using
> > pm_runtime.
> >
> > This patch takes approach (ii) with device links to handle the extra do=
mains.
> >
> > I believe the latter is more upstream-friendly, but, as always,
> > suggestions welcome.
>
> Apologies for the late reply. A few comments below.

No worries, than for the helpful reply!

> If the device is partitioned across multiple PM domains (it may need
> several power rails), then that should be described with the "multi PM
> domain" approach in the DTS. As in (ii).
>
> Using "device links" is however optional, as it may depend on the use
> case. If all multiple PM domains needs to be powered on/off together,
> then it's certainly recommended to use device links.

That's the case here, there's no support for turning on/off the
domains individually.

> However, if the PM domains can be powered on/off independently (one
> can be on while another is off), then it's probably easier to operate
> directly with runtime PM, on the returned struct *device from
> dev_pm_domain_attach_by_id().
>
> Also note, there is dev_pm_domain_attach_by_name(), which allows us to
> specify a name for the PM domain in the DTS, rather than using an
> index. This may be more future proof to use.

Agree, probably better to have actual names than just "counting" the
number of domains like I do, especially as we have a compatible struct
anyway. I'll update the patch.

> [...]
>
> Hope this helps.
>
> Kind regards
> Uffe
