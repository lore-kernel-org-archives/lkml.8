Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAC6207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 12:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACEvjKbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgHLMiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 08:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHLMiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:38:07 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:38:06 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id z3so1456034ilh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 05:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQtXByRbpsoZgIhMvMt2U6G++emg9r8kEFPKd8B0DRk=;
        b=ACEvjKbbna5E9MeCPPx0HYG5qBhsGSEYw+6jRsL5al3m/G2U74HqE4aQ3opk7q+5pG
         CcSJYvwpubYIrt2hnXsjJ4iQG1B0yUdNiYwBhNK7X61GCxW/iRcMxbgnVmt+I2ezDZgs
         rsf47c5KZ50TqkOHJLyR06EKKaFrF3XZfVc3TIQJx6I2WwPC8D9bQF0FvO7cqaEeFhxk
         i6igMx8HbHiERgCSPCb+k8NPtiu6hRTQChESlhGXU/YoRLMhRhb/ypCdLv7AQxDNJ2sq
         IrRJkWrwxEW4aQDWxEAeqklEzEnTXycRaOLdyzSb+lUGXVoeijvVVUVyG4FqxS7lMajo
         gqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQtXByRbpsoZgIhMvMt2U6G++emg9r8kEFPKd8B0DRk=;
        b=kJxrBNeQp2FkFXrlQzNZFJk7n2xl68hW6aCr2EKI/F5pQrDHW0wtuZw0cq6lWTv1Qo
         7ZMn2DjfmpljA5/JgikSCFXLVa8nE6t48mNoI0SGehkG3Tc9vBKdJZqCfuS99MyClJkA
         y5ycbDDF8HdbLVMmRvKd+Aj34N8CIK/ELO4uuiwEieK75IIW3Jyxsmi++IIo1pjSW2qA
         U29KOjTZ+ay1YPfHylxZl/5mQqxXqN4eUM+bIgntgsVOt3GI9rWVFGxrunKnhNc0gOJ/
         zROmP/yGho2LmeoBN65b9hhY2lGkYmR2kaHq8GVJE0NtQz30tZ+gggkQPT+mhpftCRUI
         FQEw==
X-Gm-Message-State: AOAM530P3Q2+gA7+UEgZclTo9Jg1h01JZQEdY/WDixjbDbUdgQKpqSP8
        cFTl2Oa2CNVKBFJ3goWAlMO/XoRUmtnlEZ3f2bA=
X-Google-Smtp-Source: ABdhPJzoyB8+qQand7vIwbLrsWHwa1yvxRPLisll1sMpOfD9oHZIHP716uouyz1UWVZXL2XrddDSDBo+ftC2Zdux69E=
X-Received: by 2002:a05:6e02:1343:: with SMTP id k3mr8651765ilr.217.1597235884383;
 Wed, 12 Aug 2020 05:38:04 -0700 (PDT)
MIME-Version: 1.0
References: <1597217150-22911-1-git-send-email-simhavcs@gmail.com> <20200812095418.GG6057@pendragon.ideasonboard.com>
In-Reply-To: <20200812095418.GG6057@pendragon.ideasonboard.com>
From:   Vinay Simha B N <simhavcs@gmail.com>
Date:   Wed, 12 Aug 2020 18:07:52 +0530
Message-ID: <CAGWqDJ4i=t4Noi7wjGDDhUYkB_uuQ6A-WiMrh1ErKRi2HU9t9w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/tc358775: Fixes bus formats read
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

laurent,

please see the reply inline below.

On Wed, Aug 12, 2020 at 3:24 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Vinay,
>
> Thank you for the patch.
>
> On Wed, Aug 12, 2020 at 12:55:50PM +0530, Vinay Simha BN wrote:
> > - bus formats read from drm_bridge_state.output_bus_cfg.format
> >   and .atomic_get_input_bus_fmts() instead of connector
> >
> > Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>
> >
> > ---
> >  v1:
> >  * Laurent Pinchart review comments incorporated
> >    drm_bridge_state.output_bus_cfg.format
> >    instead of connector
> > ---
> >  drivers/gpu/drm/bridge/tc358775.c | 76 ++++++++++++++++++++++++++++++---------
> >  1 file changed, 59 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> > index 7da15cd..5d8714a 100644
> > --- a/drivers/gpu/drm/bridge/tc358775.c
> > +++ b/drivers/gpu/drm/bridge/tc358775.c
> > @@ -271,6 +271,13 @@ struct tc_data {
> >       struct gpio_desc        *stby_gpio;
> >       u8                      lvds_link; /* single-link or dual-link */
> >       u8                      bpc;
> > +     u32                     output_bus_fmt;
> > +};
> > +
> > +static const u32 tc_lvds_out_bus_fmts[] = {
> > +     MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
> > +     MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> > +     MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> >  };
> >
> >  static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
> > @@ -359,19 +366,6 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
> >                       ret, addr);
> >  }
> >
> > -/* helper function to access bus_formats */
> > -static struct drm_connector *get_connector(struct drm_encoder *encoder)
> > -{
> > -     struct drm_device *dev = encoder->dev;
> > -     struct drm_connector *connector;
> > -
> > -     list_for_each_entry(connector, &dev->mode_config.connector_list, head)
> > -             if (connector->encoder == encoder)
> > -                     return connector;
> > -
> > -     return NULL;
> > -}
> > -
> >  static void tc_bridge_enable(struct drm_bridge *bridge)
> >  {
> >       struct tc_data *tc = bridge_to_tc(bridge);
> > @@ -380,7 +374,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
> >       u32 val = 0;
> >       u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
> >       struct drm_display_mode *mode;
> > -     struct drm_connector *connector = get_connector(bridge->encoder);
> >
> >       mode = &bridge->encoder->crtc->state->adjusted_mode;
> >
> > @@ -451,14 +444,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
> >       d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
> >
> >       dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
> > -             connector->display_info.bus_formats[0],
> > +             tc->output_bus_fmt,
> >               tc->bpc);
> >       /*
> >        * Default hardware register settings of tc358775 configured
> >        * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
> >        */
> > -     if (connector->display_info.bus_formats[0] ==
> > -             MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
> > +     if (tc->output_bus_fmt == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
> >               /* VESA-24 */
> >               d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
> >               d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_R7, LVI_R5, LVI_G0));
> > @@ -590,6 +582,51 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
> >       return 0;
> >  }
> >
> > +static int tc_bridge_atomic_check(struct drm_bridge *bridge,
> > +                               struct drm_bridge_state *bridge_state,
> > +                               struct drm_crtc_state *crtc_state,
> > +                               struct drm_connector_state *conn_state)
> > +{
> > +     struct tc_data *tc = bridge_to_tc(bridge);
> > +
> > +     tc->output_bus_fmt = bridge_state->output_bus_cfg.format;
>
> .atomic_check() isn't allowed to modify the device state, neither the
> hardware state nor the software state in drm_bridge or tc_data. You can
> instead access the bridge state directly in tc_bridge_enable(), with
>
>         struct drm_bridge_state *state =
>                 drm_priv_to_bridge_state(bridge->base.state);
>
Currently the driver is picking up from the dts panel
(data-mapping = "vesa-24";) or jeida-24 or jeida-18.

Does state->output_bus_cfg.format  get set from the data-mapping?

> > +
> > +     dev_dbg(tc->dev, "output_bus_fmt %04x\n", tc->output_bus_fmt);
> > +
> > +     return 0;
> > +}
> > +
> > +static u32 *
> > +tc_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
> > +                          struct drm_bridge_state *bridge_state,
> > +                          struct drm_crtc_state *crtc_state,
> > +                          struct drm_connector_state *conn_state,
> > +                          u32 output_fmt,
> > +                          unsigned int *num_input_fmts)
> > +{
> > +     u32 *input_fmts = NULL;
> > +     int i;
>
> i only takes positive values, so it can be an unsigned int.
>
> > +
> > +     *num_input_fmts = 0;
> > +
> > +     for (i = 0 ; i < ARRAY_SIZE(tc_lvds_out_bus_fmts) ; ++i) {
> > +             if (output_fmt == tc_lvds_out_bus_fmts[i]) {
> > +                     *num_input_fmts = 1;
> > +                     input_fmts = kcalloc(*num_input_fmts,
> > +                                          sizeof(*input_fmts),
> > +                                          GFP_KERNEL);
> > +                     if (!input_fmts)
> > +                             return NULL;
> > +
> > +                     input_fmts[0] = output_fmt;
>
> I don't think this is right, the input of the bridge isn't LVDS, is it ?

Input to the bridge is DSI, format is already set

dsi->format = MIPI_DSI_FMT_RGB888;

enum mipi_dsi_pixel_format {
        MIPI_DSI_FMT_RGB888,
        MIPI_DSI_FMT_RGB666,
        MIPI_DSI_FMT_RGB666_PACKED,
        MIPI_DSI_FMT_RGB565,
};
include/drm/drm_mipi_dsi.h

Why do we require this atomic_get_input_bus_fmts?

Do i need to implement both atomic_get_input_bus_fmts and
atomic_get_output_bus_fmts?

> As far as I can tell, the hardware support transcoding any of the
> supported input formats (RGB565, RGB666 or RGB888) to any of the
> supported output formats. How about the following ?
>
> static const u32 tc_lvds_in_bus_fmts[] = {
>         MEDIA_BUS_FMT_RGB565_1X16,
>         MEDIA_BUS_FMT_RGB666_1X18,
>         MEDIA_BUS_FMT_RBG888_1X24,
> };
>
> ...
>
>         u32 *input_fmts;
>         unsigned int i;
>
>         *num_input_fmts = 0;
>
>         for (i = 0 ; i < ARRAY_SIZE(tc_lvds_out_bus_fmts) ; ++i) {
>                 if (output_fmt == tc_lvds_out_bus_fmts[i])
>                         break;
>         }
>
>         if (i == ARRAY_SIZE(tc_lvds_out_bus_fmts))
>                 return NULL;
>
>         input_fmts = kcalloc(*num_input_fmts, ARRAY_SIZE(tc_lvds_in_bus_fmts),
>                              GFP_KERNEL);
>         if (!input_fmts)
>                 return NULL;
>
>         for (i = 0; i < ARRAY_SIZE(tc_lvds_in_bus_fmts); ++i)
>                 input_fmts[i] = tc_lvds_in_bus_fmts[i];
>
>         *num_inputs_fmts = ARRAY_SIZE(tc_lvds_in_bus_fmts);
>         return input_fmts;
>
> > +
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return input_fmts;
> > +}
> > +
> >  static int tc_bridge_attach(struct drm_bridge *bridge,
> >                           enum drm_bridge_attach_flags flags)
> >  {
> > @@ -639,6 +676,11 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
> >  }
> >
> >  static const struct drm_bridge_funcs tc_bridge_funcs = {
> > +     .atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> > +     .atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> > +     .atomic_reset = drm_atomic_helper_bridge_reset,
> > +     .atomic_get_input_bus_fmts = tc_bridge_get_input_bus_fmts,
> > +     .atomic_check = tc_bridge_atomic_check,
> >       .attach = tc_bridge_attach,
> >       .pre_enable = tc_bridge_pre_enable,
> >       .enable = tc_bridge_enable,
>
> --
> Regards,
>
> Laurent Pinchart



-- 
regards,
vinaysimha
