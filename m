Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69656C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F02A20775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Uhw94F6O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQMMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgGQMMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:12:41 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEF5C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:12:41 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id a9so1800620oof.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgpqIN79nCOfCVhNvxr/rGM/YK4i7u/VPV1BFAAPJaw=;
        b=Uhw94F6OVAquHONB+Evcb0benKNMjZ/MuPp98SVYNLV2GJt53ooUMfBAgndPGC/Qm/
         DGszdD1dYLOu+W8JqPU+WicbVUR7AVolKq+qDk6I1756ULeegD1oTd8rDhgdkhshGo4+
         I41Om38utJXWyZIpzRceOjNvGEbRcD0t3Ux0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mgpqIN79nCOfCVhNvxr/rGM/YK4i7u/VPV1BFAAPJaw=;
        b=sr1x8EGx9Q0M0JEVJgi4RlRQojVrD0QTtJ2FYzVDvE4NYsLZ55AURBUpUGIshIjmWW
         YoNvfPw8enAN8DDgo6ouQrcEV/Ez5q/hDzuTBRwY7E75+DdPNzs5kcZ5ZiWbPyOH0+DF
         h8fgQ+FZiMEdKIGJ5qpif1uJffFGmHu5LoR/U2kPZ8sxWlKVBbsRapn1hH75ssh7OKQy
         ZLXYVW3wSKXFRHGlUfJOf9GUVCv9amEcxl2f4Ghwm+q6/dgrvOPlS++dRfCQrbgFLiAr
         e0B7AzY3eRUnfZ3UpdBiO5pio0vDj2IPWxHtQQhsVkOwJMybuMvnnYfOI6s/fZweO2L3
         SQuQ==
X-Gm-Message-State: AOAM531j7YtjmPCEtHOnGocxAaQM3UZSMWh4Y0SQPdI/DRp3s7bvhKtB
        SEz22PHbU3FKm6biXKjwfNa3ziBKq9dpzxw8fmNAFQ==
X-Google-Smtp-Source: ABdhPJxPDHhBpPwBRT60SUcGdNpykcqlU/t2dXosfVIoY0zbR9Y3+4Q/RU03XCNfEWTJvup70SmMtilH0FFLnJBsJTs=
X-Received: by 2002:a4a:b6c5:: with SMTP id w5mr8159004ooo.89.1594987960413;
 Fri, 17 Jul 2020 05:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200709164736.18291-1-laurentiu.palcu@oss.nxp.com>
 <3c03afff3256ec36e12b9d9408830fbb4853f982.camel@pengutronix.de>
 <CAKMK7uGsveS+cwxiTq7BGrB1OcE_ff9bAxgSFDMUSmS7gRLJ7g@mail.gmail.com>
 <febb665904a9c3c680363be8ea83f243ccd09cb7.camel@pengutronix.de>
 <20200717092758.GR3278063@phenom.ffwll.local> <20200717094517.layssf75bxe3ijs4@fsr-ub1864-141>
 <c325bee7980feb3564de05a0a6d15c1708e2c7c0.camel@pengutronix.de>
In-Reply-To: <c325bee7980feb3564de05a0a6d15c1708e2c7c0.camel@pengutronix.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 17 Jul 2020 14:12:29 +0200
Message-ID: <CAKMK7uGQbgB_w3-j1GzZdS0ZcqgQc+LZZxSUbBWeEz_vYf4nJQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support for iMX8MQ Display Controller Subsystem
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        lukas@mntmn.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 12:51 PM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Am Freitag, den 17.07.2020, 12:45 +0300 schrieb Laurentiu Palcu:
> > Hi Lukas and Daniel,
> >
> > On Fri, Jul 17, 2020 at 11:27:58AM +0200, Daniel Vetter wrote:
> > > On Fri, Jul 17, 2020 at 11:12:39AM +0200, Lucas Stach wrote:
> > > > Am Freitag, den 17.07.2020, 10:59 +0200 schrieb Daniel Vetter:
> > > > > On Fri, Jul 17, 2020 at 10:18 AM Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > > > Hi Laurentiu,
> > > > > >
> > > > > > Am Donnerstag, den 09.07.2020, 19:47 +0300 schrieb Laurentiu Palcu:
> > > > > > > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > This patchset adds initial DCSS support for iMX8MQ chip. Initial support
> > > > > > > includes only graphics plane support (no video planes), no HDR10 capabilities,
> > > > > > > no graphics decompression (only linear, tiled and super-tiled buffers allowed).
> > > > > > >
> > > > > > > Support for the rest of the features will be added incrementally, in subsequent
> > > > > > > patches.
> > > > > > >
> > > > > > > The patchset was tested with both HDP driver (in the downstream tree) and the upstream
> > > > > > > MIPI-DSI driver (with a couple of patches on top, to make it work correctly with DCSS).
> > > > > >
> > > > > > I think the series (minus 3/5 and minor correction to the DT binding)
> > > > > > is fine to go in now. So just some formal questions: are you going to
> > > > > > maintain this driver in upstream? If so we should add a MAINTAINERS
> > > > > > entry to that effect. I can offer to act as a reviewer in this case.
> >
> > I can maintain the DCSS driver, sure, and the more reviewers the better.
> > Thanks for helping out with this. Should I send a v6 then with a patch
> > for MAINTAINERS?
> >
> > > > > > How do you intend to merge this? IMO pushing this through drm-misc
> > > > > > seems like the right thing to do. If you agree I can help you get this
> > > > > > applied. If you are going to maintain the driver on your own, I think
> > > > > > you should then apply for commit rights to drm-misc.
> > > > >
> > > > > drm/imx isn't listed yet as under the drm-misc umbrella, maybe we
> > > > > should put the entire collective of imx drivers under drm-misc? Or
> > > > > maybe it's just an oversight that the git repo isn't specified in the
> > > > > MAINTAINERS entry. Also maybe we should add the pengutronix kernel
> > > > > team alias there too?
> > > >
> > > > drm/imx was exclusively the IPUv3 up until now, which is in fact
> > > > maintained outside of drm-misc in its own git tree. This has worked
> > > > quite well in the past so even though IPUv3 doesn't see a lot of churn
> > > > these days the motivation to change anything to this workflow is quite
> > > > low. And yes, the git tree is missing from the MAINTAINERS entry.
> > > >
> > > > For the DCSS driver, if it's going to be maintained by NXP, I figured
> > > > it might be easier for Laurentiu to push things into drm-misc than set
> > > > up a separate public git tree. But IMHO that's fully up to him to
> > > > decide.
> > >
> > > /me puts on maintainer hat
> > >
> > > Much prefer drm-misc over random people playing maintainer and fumbling
> > > it. I think the reasonable options are either in the current imx tree, or
> > > drm-misc. Standalone tree for these small drivers just doesn't make much
> > > sense.
> >
> > I don't have anything against either method, though I have to agree I
> > like things to be simple. Going through drm-misc sounds simple enough to me. :)
> > However, since there is going to be more activity in the DRM IMX area in
> > the future, reviving the drm/imx tree, and push all IMX related stuff
> > through drm/imx, could make sense as well.
>
> I think drm-misc is the right place then.
>
> Please send a v6 with the following changes:
> - drop the component framework patch
> - drop the i.MX8MQ DT patch, this should go through Shawn's imx tree
> after the driver and binding has landed in drm-misc
> - you can add my Reviewed-by to the whole series or I can add it when
> applying
> - add a MAINTAINERS entry, please add me as a reviewer if you don't
> mind
>
> I can push this initial series into drm-misc until you've got your own
> commit rights.

For drm-misc howto get started:

https://drm.pages.freedesktop.org/maintainer-tools/getting-started.html

And howto get commit rights:

https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html

Once you have the fd.o bug report to request commit rights pls paste
it here so we can get the ack from drm-misc maintainers.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
