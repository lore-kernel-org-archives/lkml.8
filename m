Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787FAC47255
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E0B02071A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 02:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTUTR10H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgELCKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 22:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgELCKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 22:10:15 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC30C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 19:10:15 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id b8so6194532ybn.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 19:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zcq/C2mPvyaxNF2lVsVAAK7HuZoD0vL2Lekk73ttM9c=;
        b=QTUTR10HRSLC/TmGuicNIvhxEmKHNlDigJZyRKIMl5gsEAteM0iWF2eGAR9PHoTKdk
         At3sV9vTEbhZ8oRwK/8/kCkUgmTNEE1Repq8YEpp93GaLiWSyTmfOzhDkJz0KlCT55JN
         bsVpDPvwP32JFAJl9iu8vSl5V6tSmUurImMPDwvROdzbHw9ELGxiq0ZF6ucA3herDxcs
         WdOWxLlkcB3zq4eaI1iWNmf3/S2ZT5nUyhO59z7zVvp+IXyTabwffYP4Zt6ZelvPvVIe
         nqaNU/M2Q7apIJRecgFESPxwZzKAh4utAi8TGLCalSX5LLlpvewah/jzj4b6sJ0yGDs6
         ucuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zcq/C2mPvyaxNF2lVsVAAK7HuZoD0vL2Lekk73ttM9c=;
        b=N5TjXKAMLfVAbhi4SRDqKJRxsavfXX4283cgCoH/z8PVgr6wq4ZNWhHjnG0ED1cUvH
         oaBfmlCEfNA4cJOxoA5IPH0jVeDDq97DaUtytxIbid32SX2SRsNwFnJuBBrBehrI9TWd
         HtFp6RgBe+CZkPOWHC8Lfx9Zz23ovhJIawetVZCEfFcNcB55F5ddH5XXBqrR3Nxbkq9k
         oGjJsxvzzJ5eEzKxJjpOrkCfVe/tsJKAA1wDroYmoeMEdp3k2u7wlWxzZSBuAUA/Y21o
         /Cae+cjI5+cx5u69yr9j5wophF8wCEs2Se+0b7x1E3C1FcSzfMTNqh+dJ+sKfcKqKnYI
         L13w==
X-Gm-Message-State: AGi0PuZsFdwegChaykTPbOYMH2wGdSNTbRVMFMC0LAoIIdJ4cwYvS3YG
        wTsBwnG8NTReSiIZz68L2P19kKjebR7TDvFFbmc=
X-Google-Smtp-Source: APiQypJrvsmTHW860BhtnJ2gO7lfm9Dv5dNGo6aH4Lk4s07qsm3DIExyEcz8w8paVk2wwZrwAOzwCSLAi48y0m9hQv8=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr29859246ybp.268.1589249414325;
 Mon, 11 May 2020 19:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200511224148.598468-1-lyude@redhat.com> <20200511224148.598468-4-lyude@redhat.com>
 <CAKb7UvjQfw9UvxCdcu1k3t0dnq7PdQJrw5CtWhB42=uiW9-4dA@mail.gmail.com>
In-Reply-To: <CAKb7UvjQfw9UvxCdcu1k3t0dnq7PdQJrw5CtWhB42=uiW9-4dA@mail.gmail.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Tue, 12 May 2020 12:10:03 +1000
Message-ID: <CACAvsv7V4wHhCKVaA7F-GiF-cN21E-z82JBp=pnePgWj-Kcq0A@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] drm/nouveau/kms/gv100-: Add support for interlaced modes
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 09:06, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> On Mon, May 11, 2020 at 6:42 PM Lyude Paul <lyude@redhat.com> wrote:
> > diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > index 43bcbb6d73c4..6dae00da5d7e 100644
> > --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> > +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> > @@ -1065,7 +1065,7 @@ nouveau_connector_mode_valid(struct drm_connector *connector,
> >                 return get_slave_funcs(encoder)->mode_valid(encoder, mode);
> >         case DCB_OUTPUT_DP:
> >                 if (mode->flags & DRM_MODE_FLAG_INTERLACE &&
> > -                   !nv_encoder->dp.caps.interlace)
> > +                   !nv_encoder->caps.dp_interlace)
> >                         return MODE_NO_INTERLACE;
> >
> >                 max_clock  = nv_encoder->dp.link_nr;
>
> You probably meant for this hunk to go into an earlier patch.
I fixed this and merged the series.

Ben.
>
>   -ilia
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
