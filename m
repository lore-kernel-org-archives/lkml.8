Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3986DC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3E22467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 20:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9ggXdNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgA0UNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 15:13:53 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56039 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgA0UNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 15:13:53 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so8221569wmj.5;
        Mon, 27 Jan 2020 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZqAnZBwcnhyQqDJBqIeAARnv2kOsFYQ9h/65oqYJNc=;
        b=I9ggXdNplkom7TI2aomDIxCSwPVq7O2O3ylck0bFQYFgKX5Vk6rnte7i658A8xV6z0
         wmiUySOv2wK0y7w633siiKEx6JOAGevj/jLyUkyCaCKU5AZmXrV6xXAnm3D+Z1vTwkuH
         UiunR55xaUpY9a0X5F1X48ixkgOFIDbHN7D3cVoHwDpEJSTp6FclcP+I9EE+XR3HYUiL
         ij8gh2fw7bC7+8Vp72l6dz2QIhGspWgdMyKMT88SANIdx+GDNFtERcgVw+bm3gQdZv2R
         InWKYwhh2Muv/Bb/H63GoWuINchdphyKqPERFDZsMzhoH7mdmXVmC1rW/HuFvEYtjJPE
         eO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZqAnZBwcnhyQqDJBqIeAARnv2kOsFYQ9h/65oqYJNc=;
        b=Av3Id8x5zAPUw5A16PCBjOWWSpnFGYBqR8KxjZskkHrI5MgvEh4GMs+thHDmU6qIL8
         Afsx7UBq/abdfOj3uwjWo5JTKVk+ceEweG+W9UTxVqgomi9kP6VDl9SkISJhiFEGdLf2
         0QJdRAGaTfvMEymlVmrB3cw2WmuRZUdoipNAe7rmNITgSWIRqLCgD2/qjAdTS0t1kKHy
         4RyNcAnFZZvOgqpcErF7IkkWzV8UM16PQHSs89xuXG4HjqNl9fKIXIs2L8xruKGAW9Hb
         3+nN1ZzQIj5v2swSnsOShDRIxvY6wKkFUqAa1Kcr2ZOOswQiXDT7IMPxK8NM7/Tk/Bp9
         M8/A==
X-Gm-Message-State: APjAAAVh4Z1meVARTnETfQnfgnMIhBSHAGSDjSlevwPAJQot+qWvjVQ6
        rJ8ClhAIHb5d6+6FTF8fmdGWWHZdHkKkEhfJdm8=
X-Google-Smtp-Source: APXvYqwlN+rBTe7uyFI9aWzv0Aywb7BH112o8q2fCzdWoixSvVh7yVuI2k81MSNszj3fsA84LxG5T+1k+CxY8qX0scs=
X-Received: by 2002:a1c:9a56:: with SMTP id c83mr372759wme.79.1580156030302;
 Mon, 27 Jan 2020 12:13:50 -0800 (PST)
MIME-Version: 1.0
References: <20200117133305.113280-1-colin.king@canonical.com> <5E21C422.6040708@bfs.de>
In-Reply-To: <5E21C422.6040708@bfs.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jan 2020 15:13:38 -0500
Message-ID: <CADnq5_NEgC5u0t_m+nWiOVTptFwrxeGKVpQwegF9s-51tjhWEQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix for-loop with incorrectly
 sized loop counter
To:     walter harms <wharms@bfs.de>
Cc:     Colin King <colin.king@canonical.com>,
        kernel-janitors@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
        Wenjing Liu <Wenjing.Liu@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Nikola Cornij <Nikola.Cornij@amd.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with Walter's comment included.

Thanks!

Alex

On Fri, Jan 17, 2020 at 9:45 AM walter harms <wharms@bfs.de> wrote:
>
>
>
> Am 17.01.2020 14:33, schrieb Colin King:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > A for-loop is iterating from 0 up to 1000 however the loop variable count
> > is a u8 and hence not large enough.  Fix this by making count an int.
> > Also remove the redundant initialization of count since this is never used
> > and add { } on the loop statement make the loop block clearer.
> >
> > Addresses-Coverity: ("Operands don't affect result")
> > Fixes: ed581a0ace44 ("drm/amd/display: wait for update when setting dpg test pattern")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > index 6ab298c65247..cbed738a4246 100644
> > --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> > @@ -3680,7 +3680,7 @@ static void set_crtc_test_pattern(struct dc_link *link,
> >                       struct pipe_ctx *odm_pipe;
> >                       enum controller_dp_color_space controller_color_space;
> >                       int opp_cnt = 1;
> > -                     uint8_t count = 0;
> > +                     int count;
> >
> >                       switch (test_pattern_color_space) {
> >                       case DP_TEST_PATTERN_COLOR_SPACE_RGB:
> > @@ -3725,11 +3725,12 @@ static void set_crtc_test_pattern(struct dc_link *link,
> >                               width,
> >                               height);
> >                       /* wait for dpg to blank pixel data with test pattern */
> > -                     for (count = 0; count < 1000; count++)
> > +                     for (count = 0; count < 1000; count++) {
> >                               if (opp->funcs->dpg_is_blanked(opp))
> >                                       break;
> >                               else
> >                                       udelay(100);
> > +                     }
> >               }
> >       }
> >       break;
>
> Nitpick:
> the else is useless you can remove it.
>
> re,
>  wh
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
