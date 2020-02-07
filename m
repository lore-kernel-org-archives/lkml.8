Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4427CC352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B19E217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DRN9eI/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBGCEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:04:50 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37287 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBGCEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:04:50 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so765641qky.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 18:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xQNdH8HSEiIzxaho14u/BEs8wUQb+GjAw81SGUP7GdU=;
        b=DRN9eI/n8c0Gcre3b5rd94tWww0SnkeFdjPCVRH56fDZ+ZMERq0Hh3FJ+fV3s0LvHW
         h4PA2j0WNkLvGAVkenJcVRH867RrT/K+yBxCm/rKUFacSo/t5jTnaJrDpwqeRb/l3vVi
         oX2RtZTG+BPEjvKnpzEhYgSreKrlzX82vQ8i0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xQNdH8HSEiIzxaho14u/BEs8wUQb+GjAw81SGUP7GdU=;
        b=p5JuJHnGIJfcjO75j+L+x2osnTZm+EjOGr0BwhLIQM+ZWE57PC71ahAE2I56Mu/vTp
         LRW/+IWR55G0YO9O7NCCw+eQz+q2Wsq7ScUzzMWL8LNYsvalHy8PKZpN+dv2h27e39sF
         c+tfylOQTCvG+eeHxaSnOMuLHpJ+y7c1ONxT954nTUU6/+SaOFTv4WYoBPAilkC1UmsJ
         Sg7pE7kKQ6o1vsZ6Io15nS6HjBtMeB1NN7afWWfFCCYCaimYLjNFiz36pyMavo0jhSwP
         CjOUuRncwVkCdDqdN899jGgVhV+vkVq109co5ikDjtL9GLRNVlEsFJUI1k6ESh01dDqk
         0eag==
X-Gm-Message-State: APjAAAWPHcOIwoZgYrkpohv8fc5THM/0CP+YD1bxI8nhUJai8xnuG0EC
        NxgHPRatpRcDj1orfl5rYw4753MbTBi5WDd8f8Rtrg==
X-Google-Smtp-Source: APXvYqxcjzJPaNQ7j6RLDf2aEpB3XRG9jMZeN0SjoJdxuKlWm+e9t5RltA8xoLZ41gghj4Zu8N4HnqZrFuiNRVisbZ4=
X-Received: by 2002:ae9:ebd8:: with SMTP id b207mr5472135qkg.353.1581041088699;
 Thu, 06 Feb 2020 18:04:48 -0800 (PST)
MIME-Version: 1.0
References: <20200108052337.65916-1-drinkcat@chromium.org> <20200108052337.65916-6-drinkcat@chromium.org>
 <b58a8cf9-3275-cf89-6dff-596aceeb8000@arm.com> <CANMq1KBcNr=1_poBHrA_SDo_h-5i3e5TMqASEVaDj5LevsRcOQ@mail.gmail.com>
 <CAPDyKFr4Vz1ihuFQNnhDLEnOs=BZ1n2wzw3CATgPcDXs9g54uA@mail.gmail.com> <CANMq1KBCd0wNgVAxAzxBwafHoafPExz07wKFhEWQFViAc0LL1Q@mail.gmail.com>
In-Reply-To: <CANMq1KBCd0wNgVAxAzxBwafHoafPExz07wKFhEWQFViAc0LL1Q@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Feb 2020 10:04:37 +0800
Message-ID: <CANMq1KCTxcfePJVMc72byn+Z-rrxsAC_BNwiqiTxxMY20sbeqw@mail.gmail.com>
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

On Fri, Feb 7, 2020 at 10:04 AM Nicolas Boichat <drinkcat@chromium.org> wro=
te:
>
> Hi Ulf,
>
> On Mon, Jan 27, 2020 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrot=
e:
> >
> > On Fri, 10 Jan 2020 at 02:53, Nicolas Boichat <drinkcat@chromium.org> w=
rote:
> > >
> > > +Ulf to keep me honest on the power domains
> > >
> > > On Thu, Jan 9, 2020 at 10:08 PM Steven Price <steven.price@arm.com> w=
rote:
> > > >
> > > > On 08/01/2020 05:23, Nicolas Boichat wrote:
> > > > > When there is a single power domain per device, the core will
> > > > > ensure the power domains are all switched on.
> > > > >
> > > > > However, when there are multiple ones, as in MT8183 Bifrost GPU,
> > > > > we need to handle them in driver code.
> > > > >
> > > > >
> > > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > ---
> > > > >
> > > > > The downstream driver we use on chromeos-4.19 currently uses 2
> > > > > additional devices in device tree to accomodate for this [1], but
> > > > > I believe this solution is cleaner.
> > > >
> > > > I'm not sure what is best, but it seems odd to encode this into the=
 Panfrost driver itself - it doesn't have any knowledge of what to do with =
these power domains. The naming of the domains looks suspiciously like some=
one thought that e.g. only half of the cores could be powered, but it doesn=
't look like that was implemented in the chromeos driver linked and anyway =
that is *meant* to be automatic in the hardware! (I.e. if you only power up=
 one cores in one core stack then the PDC should only enable the power doma=
in for that set of cores).
> > >
> > > This is actually implemented in the Chrome OS driver [1]. IMHO power
> > > domains are a bit confusing [2]:
> > >  i. If there's only 1 power domain in the device, then the core takes
> > > care of power on the domain (based on pm_runtime)
> > >  ii. If there's more than 1 power domain, then the device needs to
> > > link the domains manually.
> > >
> > > So the Chrome OS [1] driver takes approach (i), by creating 3 devices=
,
> > > each with 1 power domain that is switched on/off automatically using
> > > pm_runtime.
> > >
> > > This patch takes approach (ii) with device links to handle the extra =
domains.
> > >
> > > I believe the latter is more upstream-friendly, but, as always,
> > > suggestions welcome.
> >
> > Apologies for the late reply. A few comments below.
>
> No worries, than for the helpful reply!

(s/than/thanks/... ,-P)

>
> > If the device is partitioned across multiple PM domains (it may need
> > several power rails), then that should be described with the "multi PM
> > domain" approach in the DTS. As in (ii).
> >
> > Using "device links" is however optional, as it may depend on the use
> > case. If all multiple PM domains needs to be powered on/off together,
> > then it's certainly recommended to use device links.
>
> That's the case here, there's no support for turning on/off the
> domains individually.
>
> > However, if the PM domains can be powered on/off independently (one
> > can be on while another is off), then it's probably easier to operate
> > directly with runtime PM, on the returned struct *device from
> > dev_pm_domain_attach_by_id().
> >
> > Also note, there is dev_pm_domain_attach_by_name(), which allows us to
> > specify a name for the PM domain in the DTS, rather than using an
> > index. This may be more future proof to use.
>
> Agree, probably better to have actual names than just "counting" the
> number of domains like I do, especially as we have a compatible struct
> anyway. I'll update the patch.
>
> > [...]
> >
> > Hope this helps.
> >
> > Kind regards
> > Uffe
