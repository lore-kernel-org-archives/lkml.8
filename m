Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE591C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 923B2206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r2fzHkSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgBTVhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:37:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45312 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgBTVhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:37:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so5020180qko.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mtH2MLidwl9++wyo68VivOeVZ1eKeqRlT2z3fduTibk=;
        b=r2fzHkSmmhSOpPfv60LemDTCouA+wqlfydNS58a7/9b6oAvY7dvlVy0m1X9qfp6GFO
         f8E4BulhWJ1JfqyMWvEnqCzi+E+mm+IjnNRN8kwLQaQiT9H+EvvnG/RhhzXYfJm7/1vG
         xXgnpVsIPdwy1iPX/czKlk6DJtKpuMkcby6F3bYuSSj67Xe3d2tJM+maIgbKPxiF8Rxe
         0qmU0XioEhfpkCjkSMaWNsAzW7rbkRERdPsFzUYmcbsAnXMnJZiF75GLubTl1qR6RRn0
         Rc5Bky5Lyws72PzUbnl8udHa/xLeqLCTmPnIJbo3yEXex3g6FU/60garybwdad8FNYGg
         f5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mtH2MLidwl9++wyo68VivOeVZ1eKeqRlT2z3fduTibk=;
        b=fWcgNaUlmw1Y4colUgDu4ObBLRGWVCol9lyjiv+4RUbGAO7HqYZBSHf35zzn8p2ZSK
         dJccnDf+F0EbXGzcp6apXgh84gbGy9NHDryXaa26aWOiQG1RQd5gv7KBVxp4z+vnJIeT
         po3bZG2c7DfNgHxjV7wAFMIobP9RxNJuVEcOR1tDoze8W3XTguHJYQISWcwMUgBKHilP
         f/27llvpkNYZeOuL7g3Ilr9cZZ5HZeQclvLXd2KrobZMM0vMAFTgx8DIcwX07cuw8VA8
         xLJandVGh3vUHENlNoaeGuNOt1I7It9x+s/Hch2X/FdxQUi8cCkMdAzfOBC44Q7vUOGy
         CiyA==
X-Gm-Message-State: APjAAAX2zBBAELPLjzPtbSr0nWTSP14mQ48YIC7PaI6Ia6bhQAKFrbdo
        JZ4olIogdadw6y4MYH1fGjmrcQNaUNrpBvF5RFQ=
X-Google-Smtp-Source: APXvYqzC17jJf8WSEQarDVhinql9TAMsf5KB/vSzhkgDO/I0O9wFO00fmXTLO3jktl0H/mpFHoh4KIlD6179zJYx+90=
X-Received: by 2002:a37:b285:: with SMTP id b127mr3343845qkf.413.1582234673672;
 Thu, 20 Feb 2020 13:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20200220083508.792071-1-anarsoul@gmail.com> <20200220083508.792071-6-anarsoul@gmail.com>
 <20200220135929.GF4998@pendragon.ideasonboard.com>
In-Reply-To: <20200220135929.GF4998@pendragon.ideasonboard.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Thu, 20 Feb 2020 13:37:40 -0800
Message-ID: <CA+E=qVcNuYDHaz1WEbDqosEdwqtpte7hzL405LOw0rmraWCzWw@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/panel: simple: Add NewEast Optoelectronics CO.,
 LTD WJFH116008A panel support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        arm-linux <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 5:59 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Vasily,

Hi Laurent,

>
> Thank you for the patch.
>
> On Thu, Feb 20, 2020 at 12:35:07AM -0800, Vasily Khoruzhick wrote:
> > This commit adds support for the NewEast Optoelectronics CO., LTD
> > WJFH116008A 11.6" 1920x1080 TFT LCD panel.
> >
> > Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 47 ++++++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index e14c14ac62b5..aa04afaf3d26 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -2224,6 +2224,50 @@ static const struct panel_desc netron_dy_e231732 = {
> >       .bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> >  };
> >
> > +static const struct drm_display_mode neweast_wjfh116008a_modes[] = {
> > +{
> > +     .clock = 138500,
> > +     .hdisplay = 1920,
> > +     .hsync_start = 1920 + 48,
> > +     .hsync_end = 1920 + 48 + 32,
> > +     .htotal = 1920 + 48 + 32 + 80,
> > +     .vdisplay = 1080,
> > +     .vsync_start = 1080 + 3,
> > +     .vsync_end = 1080 + 3 + 5,
> > +     .vtotal = 1080 + 3 + 5 + 23,
> > +     .vrefresh = 60,
> > +     .flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> > +}, {
> > +     .clock = 110920,
> > +     .hdisplay = 1920,
> > +     .hsync_start = 1920 + 48,
> > +     .hsync_end = 1920 + 48 + 32,
> > +     .htotal = 1920 + 48 + 32 + 80,
> > +     .vdisplay = 1080,
> > +     .vsync_start = 1080 + 3,
> > +     .vsync_end = 1080 + 3 + 5,
> > +     .vtotal = 1080 + 3 + 5 + 23,
> > +     .vrefresh = 48,
> > +     .flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
> > +} };
>
> This should be indented one step to the right, see boe_nv101wxmn51_modes
> for instance.

Will do.

> The only different between the two modes is the clock, leading to
> different refresh rates. Are only those two clock frequencies supported,
> or does the panel support anything in-between as well ? In the latter
> case, would it make sense to use display_timing instead of
> drm_display_mode ? See dlc_dlc0700yzg_1_timing for an example.

These are coming from EDID. The datasheet [1] says typical frequency
is 138.5MHz and min/max are not specified, so I'm not sure whether it
supports anything in between. I did check that both modes work though.

[1] http://files.pine64.org/doc/datasheet/pinebook/11.6inches-1080P-IPS-LCD-Panel-spec-WJFH116008A.pdf



> > +
> > +static const struct panel_desc neweast_wjfh116008a = {
> > +     .modes = neweast_wjfh116008a_modes,
> > +     .num_modes = 2,
> > +     .bpc = 6,
> > +     .size = {
> > +             .width = 260,
> > +             .height = 150,
> > +     },
> > +     .delay = {
> > +             .prepare = 110,
> > +             .enable = 20,
> > +             .unprepare = 500,
> > +     },
> > +     .bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > +     .connector_type = DRM_MODE_CONNECTOR_eDP,
> > +};
> > +
> >  static const struct drm_display_mode newhaven_nhd_43_480272ef_atxl_mode = {
> >       .clock = 9000,
> >       .hdisplay = 480,
> > @@ -3399,6 +3443,9 @@ static const struct of_device_id platform_of_match[] = {
> >       }, {
> >               .compatible = "netron-dy,e231732",
> >               .data = &netron_dy_e231732,
> > +     }, {
> > +             .compatible = "neweast,wjfh116008a",
> > +             .data = &neweast_wjfh116008a,
> >       }, {
> >               .compatible = "newhaven,nhd-4.3-480272ef-atxl",
> >               .data = &newhaven_nhd_43_480272ef_atxl,
>
> --
> Regards,
>
> Laurent Pinchart
