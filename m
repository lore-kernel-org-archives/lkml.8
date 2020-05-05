Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16AFC47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8BC9206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VVReM2U7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgEESpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 14:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgEESpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 14:45:21 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A85C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 11:45:20 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id j127so778115vke.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wHhztHLFnBrWe2DrhJMe0XhNIi9ECLuQiryle+9hws=;
        b=VVReM2U7DiVBj8k3pkKVcLc66Z4fh4wsIzJxpwUZJi4Wg9YN8qZE6ZEMRt/Ks21ny+
         hY5Q0l3WH6MFzmN5zcVRy81kbiTuz+IMdvhEpenLk2S5TREd1eYQXvn710iYgdIvXwKX
         H7sDIyshHoNBsg+sneB1TQOPqNn1kvJLiuu4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wHhztHLFnBrWe2DrhJMe0XhNIi9ECLuQiryle+9hws=;
        b=YLgahBWTYsYVWBYLw9TxiYGdh8DX9C4MTwjw0pNfbVplUbVZ5rY7L6g5o7Mu//P4UP
         CT1lpx/VmJmaSoOfGvi2fgkvsLGdCh45wee6Y8o+fk+2t5hL/9m6eq1zJ3glA7h3M5oa
         vkS/Dj2MepZ4Ka8K5hEcXH7RpX3SCcW1qp/2ctvWm0zDRZ99NPrIyCPg2PyNT3Edk/9/
         FfOqBk7yrmVAgkjqE9wEy98FymJehnhuDJHFLBjhk8SIPf96RWcp4qdRplnWjGx9Wx5/
         1+CN2HxNJGPTif2Bs+xtWCQzAMW53fugKlKCS2HM+0lIH22lZvN8zW9NK/qHSL145mdn
         fT/w==
X-Gm-Message-State: AGi0PubUk/VqJ118BnqEJK6EZpAkqIRybHxujD7nIfTxm0dRJIcozD0t
        rITo/+svSQaveCpMZ1L0TKr7n5A771M=
X-Google-Smtp-Source: APiQypLGDblP1FUwgsDhnxCBFGjRIjxzkH+xvwWckzZCtcrDq8d7gQgoimSqT1VNoSexSSj2QzJawQ==
X-Received: by 2002:a1f:a844:: with SMTP id r65mr3898945vke.56.1588704318755;
        Tue, 05 May 2020 11:45:18 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id t23sm1427141vsm.31.2020.05.05.11.45.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 11:45:17 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id y10so814101uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 11:45:17 -0700 (PDT)
X-Received: by 2002:ab0:45c7:: with SMTP id u65mr3285723uau.8.1588704316968;
 Tue, 05 May 2020 11:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200504213624.1.Ibc8eeddcee94984a608d6900b46f9ffde4045da4@changeid>
 <158865745768.11125.12003632060774071567@swboyd.mtv.corp.google.com>
In-Reply-To: <158865745768.11125.12003632060774071567@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 5 May 2020 11:45:05 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uq6K95FBkKYn=M6+7cfyam11n_f-9AMxosmDBZQYfmsQ@mail.gmail.com>
Message-ID: <CAD=FV=Uq6K95FBkKYn=M6+7cfyam11n_f-9AMxosmDBZQYfmsQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ti-sn65dsi86: Implement lane reordering + polarity
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, May 4, 2020 at 10:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-05-04 21:36:31)
> > The ti-sn65dsi86 MIPI DSI to eDP bridge chip supports arbitrary
> > remapping of eDP lanes and also polarity inversion.  Both of these
> > features have been described in the device tree bindings for the
> > device since the beginning but were never implemented in the driver.
> > Implement both of them.
> >
> > Part of this change also allows you to (via the same device tree
> > bindings) specify to use fewer than the max number of DP lanes that
> > the panel reports.  This could be useful if your display supports more
> > lanes but only a few are hooked up on your board.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Except for one thing below:
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > index 1a125423eb07..52cca54b525f 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -707,26 +716,20 @@ static void ti_sn_bridge_enable(struct drm_bridge *bridge)
> >         int dp_rate_idx;
> >         unsigned int val;
> >         int ret = -EINVAL;
> > +       int max_dp_lanes;
> >
> > -       /*
> > -        * Run with the maximum number of lanes that the DP sink supports.
> > -        *
> > -        * Depending use cases, we might want to revisit this later because:
> > -        * - It's plausible that someone may have run fewer lines to the
> > -        *   sink than the sink actually supports, assuming that the lines
> > -        *   will just be driven at a higher rate.
> > -        * - The DP spec seems to indicate that it's more important to minimize
> > -        *   the number of lanes than the link rate.
> > -        *
> > -        * If we do revisit, it would be important to measure the power impact.
> > -        */
> > -       pdata->dp_lanes = ti_sn_get_max_lanes(pdata);
> > +       max_dp_lanes = ti_sn_get_max_lanes(pdata);
> > +       pdata->dp_lanes = min(pdata->dp_lanes, max_dp_lanes);
> >
> >         /* DSI_A lane config */
> >         val = CHA_DSI_LANES(4 - pdata->dsi->lanes);
>
> Not a problem in this patch, but maybe this can be SN_MAX_DP_LANES -
> pdata->dsi->lanes now.

Since I introduce the define in this patch, I'll update it in v2.


> >         regmap_update_bits(pdata->regmap, SN_DSI_LANES_REG,
> >                            CHA_DSI_LANES_MASK, val);
> >
> > +       regmap_write(pdata->regmap, SN_LN_ASSIGN_REG, pdata->ln_assign);
> > +       regmap_update_bits(pdata->regmap, SN_ENH_FRAME_REG, LN_POLRS_MASK,
> > +                          pdata->ln_polrs << LN_POLRS_OFFSET);
> > +
> >         /* set dsi clk frequency value */
> >         ti_sn_bridge_set_dsi_rate(pdata);
> >
> > @@ -1063,6 +1066,50 @@ static int ti_sn_setup_gpio_controller(struct ti_sn_bridge *pdata)
> >         return ret;
> >  }
> >
> > +static void ti_sn_bridge_parse_lanes(struct ti_sn_bridge *pdata,
> > +                                    struct device_node *np)
> > +{
> > +       u32 lane_assignments[SN_MAX_DP_LANES] = { 0, 1, 2, 3 };
> > +       u32 lane_polarities[SN_MAX_DP_LANES] = { };
> > +       struct device_node *endpoint;
> > +       u8 ln_assign = 0;
> > +       u8 ln_polrs = 0;
>
> Do we need to assign to 0 to start? Seems like no?

Yes.  See usage:

  ln_assign = ln_assign << LN_ASSIGN_WIDTH | lane_assignments[i];
  ln_polrs = ln_polrs << 1 | lane_polarities[i];

Notably each time we shift a new bit in we base on the old value.  If
you think it'll make it clearer, I can put this initialization at the
beginning of the loop.  It's 2 extra lines of code but if it adds
clarity I'll do it.


> > +       int dp_lanes;
> > +       int i;
> > +
> > +       /*
> > +        * Read config from the device tree about lane remapping and lane
> > +        * polarities.  These are optional and we assume identity map and
> > +        * normal polarity if nothing is specified.  It's OK to specify just
> > +        * data-lanes but not lane-polarities but not vice versa.
> > +        */
> > +       endpoint = of_graph_get_endpoint_by_regs(np, 1, -1);
> > +       dp_lanes = of_property_count_u32_elems(endpoint, "data-lanes");
> > +       if (dp_lanes > 0) {
> > +               of_property_read_u32_array(endpoint, "data-lanes",
> > +                                          lane_assignments, dp_lanes);
> > +               of_property_read_u32_array(endpoint, "lane-polarities",
> > +                                          lane_polarities, dp_lanes);
> > +       } else {
> > +               dp_lanes = SN_MAX_DP_LANES;
> > +       }
>
> Needs an of_node_put(endpoint) here for the
> of_graph_get_endpoint_by_regs() above.

Thanks!  I'll fix in v2, which I'll send out either after a delay of a
few days or whenever I get resolution on my email to Laurent,
whichever comes first.  ;-)


-Doug
