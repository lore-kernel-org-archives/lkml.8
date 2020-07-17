Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B7FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B26207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Oewzlb2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgGQI7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQI73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:59:29 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8A3C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:59:29 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g37so6349180otb.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5PNUfhkPOzCtGqX/oONwFu71YklmBXd7t8O0WuvMto=;
        b=Oewzlb2sA/hPQSB8gtfajBsMvwNqTXyfDC/wKFjjF0Pe91PrhezKi39jdRtf6W+4vA
         ANuqVdL6FyNvrYMkmAq7+0NzecMz8JrclHuQ+C3eLNVz5YkUrG8ihNk8BpZ2DBaTbOGn
         vghS+8FrqB3Vri65uCWCFLqGjmwaPcGItdqug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5PNUfhkPOzCtGqX/oONwFu71YklmBXd7t8O0WuvMto=;
        b=bZuInw7lgQEncyPbp4InVXEV49PqjjmssFiphAdEtkxJKjJqTX4rnYeVH16H9yESE1
         NHuEAzTvFionDnjrjbuqsTUBxRk6efJjjrkgVUXc/QL1Y7/7pB/2U2f8psPNrnp2OmuL
         /dHwQOA+6ceAE15MqhfrwwIqeREmdhVGlD1bof7W2ozRpIu2kteu0Arnu3DAt2QfVe8e
         eI0xjO7X4TPfP/khg72XztrHbxoa7uM+Xlc4Txm9oQF698jTuYrnn5K+dbnlGscmaMKp
         pfapNzfxjLeEKdYQK3YEViLAuVTtl30+4cOviSr34lZUsX0LVc0v8V4YUk/3eVgJZUvC
         cWqg==
X-Gm-Message-State: AOAM5304igwUUDY6O1bGor1tJYmJmK3fJyT10+68WVHL32zWOuuVNbTo
        HahSh8h/LYy39dhENH9S5epQfnRY/SJB+HUXBcVMeJIz
X-Google-Smtp-Source: ABdhPJx8PfObS5k+rQ+XWK2T2u51RwD4F85OqwBcYoWXvllFm+rLrDkuI6R9PbkuRgKJm0z8tGtPMewsgLGzbsopjM8=
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr8383247ota.188.1594976368886;
 Fri, 17 Jul 2020 01:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200709164736.18291-1-laurentiu.palcu@oss.nxp.com> <3c03afff3256ec36e12b9d9408830fbb4853f982.camel@pengutronix.de>
In-Reply-To: <3c03afff3256ec36e12b9d9408830fbb4853f982.camel@pengutronix.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 17 Jul 2020 10:59:17 +0200
Message-ID: <CAKMK7uGsveS+cwxiTq7BGrB1OcE_ff9bAxgSFDMUSmS7gRLJ7g@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add support for iMX8MQ Display Controller Subsystem
To:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
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

On Fri, Jul 17, 2020 at 10:18 AM Lucas Stach <l.stach@pengutronix.de> wrote:
>
> Hi Laurentiu,
>
> Am Donnerstag, den 09.07.2020, 19:47 +0300 schrieb Laurentiu Palcu:
> > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> >
> > Hi,
> >
> > This patchset adds initial DCSS support for iMX8MQ chip. Initial support
> > includes only graphics plane support (no video planes), no HDR10 capabilities,
> > no graphics decompression (only linear, tiled and super-tiled buffers allowed).
> >
> > Support for the rest of the features will be added incrementally, in subsequent
> > patches.
> >
> > The patchset was tested with both HDP driver (in the downstream tree) and the upstream
> > MIPI-DSI driver (with a couple of patches on top, to make it work correctly with DCSS).
>
> I think the series (minus 3/5 and minor correction to the DT binding)
> is fine to go in now. So just some formal questions: are you going to
> maintain this driver in upstream? If so we should add a MAINTAINERS
> entry to that effect. I can offer to act as a reviewer in this case.
>
> How do you intend to merge this? IMO pushing this through drm-misc
> seems like the right thing to do. If you agree I can help you get this
> applied. If you are going to maintain the driver on your own, I think
> you should then apply for commit rights to drm-misc.

drm/imx isn't listed yet as under the drm-misc umbrella, maybe we
should put the entire collective of imx drivers under drm-misc? Or
maybe it's just an oversight that the git repo isn't specified in the
MAINTAINERS entry. Also maybe we should add the pengutronix kernel
team alias there too?
-Daniel


> Regards,
> Lucas
>
> > Thanks,
> > Laurentiu
> >
> > Changes in v5:
> >  * Rebased to latest;
> >  * Took out component framework support and made it a separate patch so
> >    that people can still test with HDP driver, which makes use of it.
> >    But the idea is to get rid of it once HDP driver's next versions
> >    will remove component framework as well;
> >  * Slight improvement to modesetting: avoid cutting off the pixel clock
> >    if the new mode and the old one are equal. Also, in this case, is
> >    not necessary to wait for DTG to shut off. This would allow to switch
> >    from 8b RGB to 12b YUV422, for example, with no interruptions (at least
> >    from DCSS point of view);
> >  * Do not fire off CTXLD when going to suspend, unless it still has
> >    entries that need to be committed to DCSS;
> >  * Addressed Rob's comments on bindings;
> >
> > Changes in v4:
> >  * Addressed Lucas and Philipp's comments:
> >    * Added DRM_KMS_CMA_HELPER dependency in Kconfig;
> >    * Removed usage of devm_ functions since I'm already doing all the
> >      clean-up in the submodules_deinit();
> >    * Moved the drm_crtc_arm_vblank_event() in dcss_crtc_atomic_flush();
> >    * Removed en_completion variable from dcss_crtc since this was
> >      introduced mainly to avoid vblank timeout warnings which were fixed
> >      by arming the vblank event in flush() instead of begin();
> >    * Removed clks_on and irq_enabled flags since all the calls to
> >      enabling/disabling clocks and interrupts were balanced;
> >    * Removed the custom atomic_commit callback and used the DRM core
> >      helper and, in the process, got rid of a workqueue that wasn't
> >      necessary anymore;
> >    * Fixed some minor DT binding issues flagged by Philipp;
> >    * Some other minor changes suggested by Lucas;
> >  * Removed YUV formats from the supported formats as these cannot work
> >    without the HDR10 module CSCs and LUTs. Will add them back when I
> >    will add support for video planes;
> >
> > Changes in v3:
> >  * rebased to latest linux-next and made it compile as drmP.h was
> >    removed;
> >  * removed the patch adding the VIDEO2_PLL clock. It's already applied;
> >  * removed an unnecessary 50ms sleep in the dcss_dtg_sync_set();
> >  * fixed a a spurious hang reported by Lukas Hartmann and encountered
> >    by me several times;
> >  * mask DPR and DTG interrupts by default, as they may come enabled from
> >    U-boot;
> >
> > Changes in v2:
> >  * Removed '0x' in node's unit-address both in DT and yaml;
> >  * Made the address region size lowercase, to be consistent;
> >  * Removed some left-over references to P010;
> >  * Added a Kconfig dependency of DRM && ARCH_MXC. This will also silence compilation
> >    issues reported by kbuild for other architectures;
> >
> > Laurentiu Palcu (5):
> >   drm/imx: compile imx directory by default
> >   drm/imx: Add initial support for DCSS on iMX8MQ
> >   drm/imx/dcss: add component framework functionality
> >   dt-bindings: display: imx: add bindings for DCSS
> >   arm64: dts: imx8mq: add DCSS node
> >
> >  .../bindings/display/imx/nxp,imx8mq-dcss.yaml |  84 ++
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi     |  23 +
> >  drivers/gpu/drm/Makefile                      |   2 +-
> >  drivers/gpu/drm/imx/Kconfig                   |   2 +
> >  drivers/gpu/drm/imx/Makefile                  |   1 +
> >  drivers/gpu/drm/imx/dcss/Kconfig              |   9 +
> >  drivers/gpu/drm/imx/dcss/Makefile             |   6 +
> >  drivers/gpu/drm/imx/dcss/dcss-blkctl.c        |  70 ++
> >  drivers/gpu/drm/imx/dcss/dcss-crtc.c          | 219 +++++
> >  drivers/gpu/drm/imx/dcss/dcss-ctxld.c         | 424 +++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dev.c           | 314 +++++++
> >  drivers/gpu/drm/imx/dcss/dcss-dev.h           | 177 ++++
> >  drivers/gpu/drm/imx/dcss/dcss-dpr.c           | 562 ++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-drv.c           | 183 ++++
> >  drivers/gpu/drm/imx/dcss/dcss-dtg.c           | 409 +++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-kms.c           | 185 ++++
> >  drivers/gpu/drm/imx/dcss/dcss-kms.h           |  43 +
> >  drivers/gpu/drm/imx/dcss/dcss-plane.c         | 405 +++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-scaler.c        | 826 ++++++++++++++++++
> >  drivers/gpu/drm/imx/dcss/dcss-ss.c            | 180 ++++
> >  20 files changed, 4123 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> >  create mode 100644 drivers/gpu/drm/imx/dcss/Kconfig
> >  create mode 100644 drivers/gpu/drm/imx/dcss/Makefile
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-blkctl.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-crtc.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ctxld.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dev.h
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dpr.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-drv.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-dtg.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-kms.h
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-plane.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-scaler.c
> >  create mode 100644 drivers/gpu/drm/imx/dcss/dcss-ss.c
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
