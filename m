Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F36CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBCBB207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDnF5Snh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgIBQzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgIBQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:55:53 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011CC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:55:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so2834360pgd.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hdYVEuQJsLS8XipihWRuhbU3xPPXwqeBIMKPtKZRZo4=;
        b=cDnF5SnhZNkKDN5xqO/nwzRTKGXbJtKhz2wo6fMl7N6OYIyZ9DhZmIExeDp7ypJukE
         t9LFfSW0AEXg8Hyro1hyHQgcLQ/9HjPz3vezytz3BlEoMZsICuou0ZO4dxoLyvn3MoCk
         lCcK/gz0Tbo8fWbaFqa84owdYWvTj7NyCroVfddXUr1jKqijmoXYtyrUNllSbs/wVzCj
         95W8X3HL/JDzH4UDTiJj0Sm0AF7d04YyVpugLCXHKaRUq86TzC4BtFETDlOc41tdokJA
         sVfz5l7G820XUE/1DW9U6mfr+BgDbnLX/647gxhvzr0ENHjxMfy8eJl7TZx+ndzz0WZS
         W86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hdYVEuQJsLS8XipihWRuhbU3xPPXwqeBIMKPtKZRZo4=;
        b=fTvih6KlFHU10K7QQiPlFehz+dw0Red3XNH7gqX1CwfM95GjW65SrItv5tgSYtLiET
         kqOW5boKtl2rKcCVlJVrpouOr+W8EEH/0luxHn79qi8CqhmteAeumESO3hjn8eLVZU7J
         SunhFnjZ9yFTlAYNMtw+C5tVoQ6JvYRo2wfpTT0EX1ZRFqzTkyy+L6qbslMNN/2e+KOb
         Eg3HT8/RUAgjBuRPIWxxElMMNM9u1VoHKoVA7Ln/IQTXIv+deMlU6P5P20AdUHxVQZUz
         /KIkrLi+es5+6c8NU8AAgK4uWD07VlO6QlPGmoEnVphE06ME/NteIGXNpFTzLUlCi4v9
         7g5Q==
X-Gm-Message-State: AOAM533ZeMTac61RSRwOux4TDyQl4Ngnqsv7EsdXdMBxhHVNuclS6Zgx
        7OPo2ubAEu0eILgvNcKXV5wAJIS+sQuVdj2xAt5YFUBIOuo=
X-Google-Smtp-Source: ABdhPJwLErBx9enNDGjL8lSgkYJi5XasZCfAETGqZUaa95fqW4paWq8Pxt264+W62PlQimkVKhODvhcxNH02K3PvxoY=
X-Received: by 2002:a63:f14c:: with SMTP id o12mr2596315pgk.150.1599065753099;
 Wed, 02 Sep 2020 09:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200901220305.6809-1-jernej.skrabec@siol.net>
 <CAGphcdnT4U8AztL_B_B2HYskQSAYKRgCQcnO3Q8Qj+UFO082hQ@mail.gmail.com> <10671571.W45mMbEh4O@kista>
In-Reply-To: <10671571.W45mMbEh4O@kista>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Wed, 2 Sep 2020 19:55:42 +0300
Message-ID: <CAGphcdmfb0Ha0h2UX_Ez7049r7sm2Np6amg_paTcqfPB42Ga9w@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: Fix DE2 YVU handling
To:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     mripard@kernel.org, wens@csie.org, irlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 2 =D1=81=D0=B5=D0=BD=D1=82. 2020 =D0=B3. =D0=B2 19:46, Jernej=
 =C5=A0krabec <jernej.skrabec@siol.net>:
>
> Dne sreda, 02. september 2020 ob 09:01:17 CEST je Roman Stratiienko
> napisal(a):
> > =D1=81=D1=80, 2 =D1=81=D0=B5=D0=BD=D1=82. 2020 =D0=B3. =D0=B2 00:58, Je=
rnej Skrabec <jernej.skrabec@siol.net>:
> > > Function sun8i_vi_layer_get_csc_mode() is supposed to return CSC mode
> > > but due to inproper return type (bool instead of u32) it returns just=
 0
> > > or 1. Colors are wrong for YVU formats because of that.
> > >
> > > Fixes: daab3d0e8e2b ("drm/sun4i: de2: csc_mode in de2 format struct i=
s
> > > mostly redundant") Reported-by: Roman Stratiienko
> > > <r.stratiienko@gmail.com>
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > >
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index 22c8c5375d0d..c0147af6=
a840
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > @@ -211,7 +211,7 @@ static int sun8i_vi_layer_update_coord(struct
> > > sun8i_mixer *mixer, int channel,>
> > >         return 0;
> > >
> > >  }
> > >
> > > -static bool sun8i_vi_layer_get_csc_mode(const struct drm_format_info
> > > *format) +static u32 sun8i_vi_layer_get_csc_mode(const struct
> > > drm_format_info *format)>
> > >  {
> > >
> > >         if (!format->is_yuv)
> > >
> > >                 return SUN8I_CSC_MODE_OFF;
> > >
> > > --
> > > 2.28.0
> >
> > Hi Jernej,
> >
> > Thank you for the fix.
> > I can confirm this patch fixes the issue with wrong colors.
>
> Thanks! Can I assume that this means your Tested-by tag can be added?

Sure.

Tested-by: Roman Stratiienko <r.stratiienko@gmail.com>

>
> >
> > Let me share my thoughts:
> > I've looked into csc code, and it seems to me reordering U, V offsets
> > should be a much simpler solution than applying
> > color transformation matrices.It should also simplify adding more
> > color encodings in the future.
>
> Switching offsets assumes that you have separate planes for U and V which=
 may
> not be true in the future. I agree that CSC matrices are needlessly dupli=
cated
> for handling U/V switch. I have a patch which reorganize matrix on the fl=
y when
> coefficients are written in registers but since it's a part of a bigger,
> unfinished series, I didn't sent it out yet. Only difference in YUV and Y=
VU CSC
> matrices are switched 2nd and 3rd column.

This sounds reasonable. Thank you for your explanation.

Regards,
Roman

>
> Best regards,
> Jernej
>
> >
> > Regards,
> > Roman
>
>
>
>
