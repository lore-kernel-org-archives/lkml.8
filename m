Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C9EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E548206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391738AbgE0RuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:50:17 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:58018 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388206AbgE0RuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:50:17 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D0C6980567;
        Wed, 27 May 2020 19:50:13 +0200 (CEST)
Date:   Wed, 27 May 2020 19:50:12 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm: pl111: add CONFIG_VEXPRESS_CONFIG dependency
Message-ID: <20200527175012.GB98921@ravnborg.org>
References: <20200527133158.462057-1-arnd@arndb.de>
 <20200527145226.GA91560@ravnborg.org>
 <CAK8P3a2k2qPOdREo-+AwOL8JVcO2VFoouAFyx6-fr1UnpavwLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2k2qPOdREo-+AwOL8JVcO2VFoouAFyx6-fr1UnpavwLA@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=MOBOZvRl c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=XtOjGa42SBT2tKonbKAA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd.

On Wed, May 27, 2020 at 05:47:21PM +0200, Arnd Bergmann wrote:
> On Wed, May 27, 2020 at 4:52 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Arnd.
> >
> > On Wed, May 27, 2020 at 03:31:42PM +0200, Arnd Bergmann wrote:
> > > The vexpress_config code fails to link in some configurations:
> > >
> > > drivers/gpu/drm/pl111/pl111_versatile.o: in function `pl111_versatile_init':
> > > (.text+0x1f0): undefined reference to `devm_regmap_init_vexpress_config'
> > >
> > > Add a dependency that links to this only if the dependency is there,
> > > and prevent the configuration where the drm driver is built-in but
> > > the config is a loadable module.
> > >
> > > Fixes: 826fc86b5903 ("drm: pl111: Move VExpress setup into versatile init")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Could this be another way to fix it:
> >
> > diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
> > index 64f01a4e6767..1c38d3bd2e84 100644
> > --- a/drivers/gpu/drm/pl111/pl111_versatile.c
> > +++ b/drivers/gpu/drm/pl111/pl111_versatile.c
> > @@ -379,7 +379,7 @@ static int pl111_vexpress_clcd_init(struct device *dev, struct device_node *np,
> >         u32 val;
> >         int ret;
> >
> > -       if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
> > +       if (!IS_REACHABLE(CONFIG_VEXPRESS_CONFIG))
> >                 return -ENODEV;
> >
> >         /*
> >
> >
> > Then we no longer have the whole driver depending on
> > the value of VEXPRESS_CONFIG.
> > Not that I like IS_REACHABLE() but we already had
> > IS_ENABLED() to cover up here, and that was not enough.
> >
> > With your patch would we then need the IS_ENABLED()
> > check?
> 
> The IS_ENABLED() check is what I'm adding, not removing. I'd still
> the Kconfig dependency combined with that check over
> IS_REACHABLE(), which is more likely to silently not work.

Then the now redundant IS_ENABLED() check should go.
With you patch it looks like this:

	...
	if (IS_ENABLED(CONFIG_VEXPRESS_CONFIG) && ...)
		pl111_vexpress_clcd_init()


And in pl111_vexpress_clcd_init() we have:

{
	if (!IS_ENABLED(CONFIG_VEXPRESS_CONFIG))
		return -ENODEV;

The IS_ENABLED() in pl111_vexpress_clcd_init() is redundant
and the patch should drop it.

	Sam
