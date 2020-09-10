Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF788C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A38742078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730916AbgIJKZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730779AbgIJKZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:25:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0594DC061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:25:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kGJl0-0007HR-Ia; Thu, 10 Sep 2020 12:24:46 +0200
Message-ID: <a325e1594dff339ddd6858f0ac93698582a6000a.camel@pengutronix.de>
Subject: Re: [PATCH] drm/imx/dcss: fix compilation issue on 32bit
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Sep 2020 12:24:44 +0200
In-Reply-To: <20200910102128.5agk4vxf2jeonw3q@fsr-ub1864-141>
References: <20200910095250.7663-1-laurentiu.palcu@oss.nxp.com>
         <CAKMK7uGsJcg81a_cGebBgk3pwxj4VPrFfmV5AF+5fRyK3_Pigw@mail.gmail.com>
         <20200910102128.5agk4vxf2jeonw3q@fsr-ub1864-141>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 2020-09-10 at 13:21 +0300, Laurentiu Palcu wrote:
> On Thu, Sep 10, 2020 at 11:57:10AM +0200, Daniel Vetter wrote:
> > On Thu, Sep 10, 2020 at 11:53 AM Laurentiu Palcu
> > <laurentiu.palcu@oss.nxp.com> wrote:
> > > When compiling for 32bit platforms, the compilation fails with:
> > > 
> > > ERROR: modpost: "__aeabi_ldivmod"
> > > [drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
> > > ERROR: modpost: "__aeabi_uldivmod"
> > > [drivers/gpu/drm/imx/dcss/imx-dcss.ko] undefined!
> > > 
> > > This patch adds a dependency on ARM64 since no 32bit SoCs have DCSS, so far.
> > 
> > Usual way to fix this correctly is using the right division macros,
> > not limiting the driver to 64bit. But this works for now, would be
> > good to fix this properly for compile-testing and all that.
> 
> I didn't see the point in using the macros since this is running only on
> 64bit. Though I will probably revisit it and fix it properly in a
> subsequent patch.
> 
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > Reported-by: Daniel Vetter <daniel@ffwll.ch>
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > Please push to drm-misc-next.
> 
> About that, I may need some help pushing it.

I've already pushed a few minutes ago, so we don't disturb the build
tests any longer.

Regards,
Lucas

> Apparently, my request for
> a legacy SSH account for contributing to drm-misc got stalled:
> 
> https://gitlab.freedesktop.org/freedesktop/freedesktop/-/issues/289
> 
> Thanks,
> laurentiu
> 
> > -Daniel
> > 
> > 
> > 
> > ---
> > >  drivers/gpu/drm/imx/dcss/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/imx/dcss/Kconfig b/drivers/gpu/drm/imx/dcss/Kconfig
> > > index 69860de8861f..2b17a964ff05 100644
> > > --- a/drivers/gpu/drm/imx/dcss/Kconfig
> > > +++ b/drivers/gpu/drm/imx/dcss/Kconfig
> > > @@ -3,7 +3,7 @@ config DRM_IMX_DCSS
> > >         select IMX_IRQSTEER
> > >         select DRM_KMS_CMA_HELPER
> > >         select VIDEOMODE_HELPERS
> > > -       depends on DRM && ARCH_MXC
> > > +       depends on DRM && ARCH_MXC && ARM64
> > >         help
> > >           Choose this if you have a NXP i.MX8MQ based system and want to use the
> > >           Display Controller Subsystem. This option enables DCSS support.
> > > --
> > > 2.17.1
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

