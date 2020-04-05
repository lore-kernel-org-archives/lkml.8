Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6A7C2BA17
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB49520672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="H2JtguxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDEN5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:57:40 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45355 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgDEN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 09:57:40 -0400
Received: by mail-oi1-f193.google.com with SMTP id l22so10673170oii.12
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 06:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KMfAfBpWX7DTO7rUhHMHrMFwdujm3ATZ8kNwC9anIEs=;
        b=H2JtguxC2oY3JuGTZSL6ziiemeZz9VyaK4LEOVwXLA0flSbkyfZY6t+8PaBuJ6m3bZ
         sF6QTTxfJEVflS+voMrryrFFMDss4i2UrSu3RwBdDNT45DxYG5rEAfA/+5Ktvl6MZXPq
         gCJpWwWQUOWprlaLQZSV5/0WtQIsPgmJAqa3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KMfAfBpWX7DTO7rUhHMHrMFwdujm3ATZ8kNwC9anIEs=;
        b=FI/aQnFs7Y1Pl6ZnIuZNUHVDGILesfu00CGZ+CFUT0yIk08Jrzo6JY51DvmXctuXz+
         mLv0QFDmOGn0Kay+RDy7fZtyDOLd/tGcOkVoNxrEvwaMK/e/qPnZoZstO7jkCI58TvAe
         1SFYbRFnWyFgsWbTTQ1Z5zmPqX35yhBC41b0lWinL9I51HX7m7CuMZ04MRSVGnYvyeWl
         UrpILkFdC0yW2dbpz15oh3yXcnSRca+28whHnmnhqNBxJH6iuOTiUFgwXnrbtDfnbcQN
         Ejq3PpvHYUD/8LDuq/ZaxJYa45e84v1GHFMKptYyMcjuuyzqo+ZLUBAIk35PkeloVRdo
         VYYw==
X-Gm-Message-State: AGi0PubsUA0u/EUvjcyW4p/oYFrVMzY+HHRIIN0DwaAxToyakiEUqMwD
        CKbtU0PL5vV8V5gpMXyVPv+47JAQn77yaPM7mX7VJg==
X-Google-Smtp-Source: APiQypIWIMORz9fSLd8g2VoHBAzhQXSpQ9mdOExFYzChDoE34ciZxskTYW29aXjV5X1fFVt73sVPLdiwPcQIoasOPGs=
X-Received: by 2002:a54:4189:: with SMTP id 9mr9815023oiy.128.1586095057678;
 Sun, 05 Apr 2020 06:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190921125017epcas3p2f5661cca04f0959f9707f6111102435d@epcas3p2.samsung.com>
 <20190921124843.6967-1-joonas.kylmala@iki.fi> <d8a8bf25-0c5e-8d94-9406-b1f74e3edfac@samsung.com>
 <53385e44-1847-ace0-cd87-5571f6acd3f2@iki.fi>
In-Reply-To: <53385e44-1847-ace0-cd87-5571f6acd3f2@iki.fi>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Sun, 5 Apr 2020 15:57:26 +0200
Message-ID: <CAKMK7uHbMOqGoki7rWUZvxn5FbnD-F2KoiMts3SVP6fCx31yAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: samsung: s6e8aa0: Add backlight control support
To:     =?UTF-8?B?Sm9vbmFzIEt5bG3DpGzDpA==?= <joonas.kylmala@iki.fi>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        GNUtoo@cyberdimension.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 3:27 PM Joonas Kylm=C3=A4l=C3=A4 <joonas.kylmala@iki=
.fi> wrote:
>
> Hi,
>
> addressing this email to you all since there might be widespread race
> condition issue in the DRM panel drivers that are using MIPI DSI. See
> below for my message.
>
> Andrzej Hajda:
> >> +static int s6e8aa0_set_brightness(struct backlight_device *bd)
> >> +{
> >> +    struct s6e8aa0 *ctx =3D bl_get_data(bd);
> >> +    const u8 *gamma;
> >> +
> >> +    if (ctx->error)
> >> +            return;
> >> +
> >> +    gamma =3D ctx->variant->gamma_tables[bd->props.brightness];
> >> +
> >> +    if (ctx->version >=3D 142)
> >> +            s6e8aa0_elvss_nvm_set(ctx);
> >> +
> >> +    s6e8aa0_dcs_write(ctx, gamma, GAMMA_TABLE_LEN);
> >> +
> >> +    /* update gamma table. */
> >> +    s6e8aa0_dcs_write_seq_static(ctx, 0xf7, 0x03);
> >> +
> >> +    return s6e8aa0_clear_error(ctx);
> >> +}
> >> +
> >> +static const struct backlight_ops s6e8aa0_backlight_ops =3D {
> >> +    .update_status  =3D s6e8aa0_set_brightness,
> >
> >
> > This is racy, update_status can be called in any time between probe and
> > remove, particularly:
> >
> > a) before panel enable,
> >
> > b) during panel enable,
> >
> > c) when panel is enabled,
> >
> > d) during panel disable,
> >
> > e) after panel disable,
> >
> >
> > b and d are racy for sure - backlight and drm callbacks are async.
> >
> > IMO the best solution would be to register backlight after attaching
> > panel to drm, but for this drm_panel_funcs should have attach/detach
> > callbacks (like drm_bridge_funcs),
> >
> > then update_status callback should take some drm_connector lock to
> > synchronize with drm, and write to hw only when pipe is enabled.
>
> I have done now research and if I understand right one issue here might
> be with setting the backlight brightness if the DSI device is not
> attached before calling update_status() since calling it would call
> subsequently s6e8aa0_set_brightness() -> s6e8aa0_dcs_write() ->
> mipi_dsi_dcs_write_buffer(), which then requires DSI to be attached.
>
> But now to the part that affects many of the panel drivers using MIPI
> DSI, like panel-samsung-s6e63j0x03.c, panel-simple.c, etc.:
> mipi_dsi_attach(dsi) seems to be always called only after the DRM panel
> helper drm_panel_add(). Now I think this is problematic since
> drm_panel_add() makes the panel available for use in userspace but if
> the user tries to actually do something with the panel before
> mipi_dsi_attach(dsi) is called it would not work.
>
> So for some reason the mipi_dsi_attach() is called in all those drivers
> after drm_panel_add() and at least to the problem I pointed out above
> moving the call there before drm_panel_add() would fix the issue but
> then I don't know if it causes some other issue.

Nope, drm_panel_add only makes the panel visible to other drm drivers,
not yet to userspace. That only happens once the overall drm driver
calls drm_dev_register. At that point the mipi_dsi_attach should have
happened I think.

That in turn calls a drm_connector_funcs->late_register hook, which is
meant to be use to register stuff like backlight interfaces. If you
set up your backlight before that, yes I expect some good fireworks.
Now as you noticed, we're not wiring that through to panels, so maybe
the best solution would be if drm_panel gets a backlight pointer with
an initialized, but not yet registered backlight. And then we can
drive this in the bridge or connector wrapper for panels.

Or I'm totally not understanding the issue even, which is also possible :-)

Cheers, Daniel

> Also I don't know if Andrzej had some other issues in mind that could be
> caused by this race condition, so if there are multiple instead of just
> that one issue with DSI not being attached then we might want to have
> all these issues fixed by for example the solution Andrzej proposed
> where we have attach/detach callbacks in drm_bridge_funcs.
>
> Please let me know if anything I write above doesn't make sense, I'm
> still trying to understand the DRM subsystem better.
>
> Joonas



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
