Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E67C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 558D12071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 21:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF+GOarz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgFOVvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgFOVvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 17:51:19 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FC0C061A0E;
        Mon, 15 Jun 2020 14:51:19 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so10270446vsr.1;
        Mon, 15 Jun 2020 14:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgketSwNHBH9JjKBViUJC5dtablUpG9gaeko3bA7e1g=;
        b=kF+GOarzfpIuy/JohE32cXP4Vd2JnpxHM6h0pYme+S7/RWHhC/TmS14r6nlHzUA7+H
         s338WjKce/rQdZZlsDASW3HB7VCWcETvbyXs5Ia+aeWjOfo2+BUJGG2Fxb36GrbjhXrp
         jSuaGAHywJk+9Yvu636+61kzkxBZNPZywBqUJLXOBQfAwAhROHIsoXp6Du9Z6Mtqxc96
         AmJxrsalGzepTrvbjQHDzP3eAh6alhDAJx2EhVaWiQWYgykER/4i2ofnR1OF7vVHz4q/
         +pBMozwuGP4nTI9vBVOIcndY/I2eL2OkLca321sNh+qPYUJM6wM03a2MSLl/2VkmBCmS
         /DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgketSwNHBH9JjKBViUJC5dtablUpG9gaeko3bA7e1g=;
        b=Kvt3V1oGNqFsQtQxJJYhn3ST/33jQ2AVrA09WbuDqCtRvBnHiE+nKM1LoZaSWK9/B2
         mSC8l3wRrxo0dkydoAA/orVuOljsB8ONe4ycU9RSSrb4SvH+0qSd55hIA2211GSdq0DS
         75YvRuCcNQNOwshPtW5XfDzCV68c6RVWsot7kTn8+ZTp+irThCagNl6Wz3Ia0ESKZU24
         TqoquTuqWTeoNIeGt1W94++81cGajBgIsjGr3xO/wugmft0OPZv8XNjRkbMN1X89FeH2
         BvqSF5Ewuk2++ujb56zTSAunKo/2QY+H6aLmmotDOJXK0jk+LElj/ks0d/2dvyQJV7D8
         FJtg==
X-Gm-Message-State: AOAM5308otkTayKyQg3zIRkzzIaH6cApD9HS6O4nwWM+ui9sMMB/Alip
        qN7hxWLijQRO7bIicUTJwRMmHHhGjBq2WKoBFp0=
X-Google-Smtp-Source: ABdhPJzv/Bc7NGZajPShdorVicz6OHnHErN3ywjEZYsKSV3VG3JL4TYVkoKlW2KXsaRy+3TOPCaluY8wxU3XWXFdMS4=
X-Received: by 2002:a67:b149:: with SMTP id z9mr20210130vsl.85.1592257878077;
 Mon, 15 Jun 2020 14:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200614200121.14147-1-digetx@gmail.com> <20200614200121.14147-6-digetx@gmail.com>
In-Reply-To: <20200614200121.14147-6-digetx@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Mon, 15 Jun 2020 22:47:37 +0100
Message-ID: <CACvgo50P5i2jX6ZrMD=UuGr_bA=8MbFhYBWBNvkMcdCyJKS5xg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_5=2F5=5D_drm=2Ftegra=3A_plane=3A_Support_180=C2=B0_r?=
        =?UTF-8?Q?otation?=
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Perhaps a silly question:

On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Combining horizontal and vertical reflections gives us 180 degrees of
> rotation.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index f31bca27cde4..ddd9b88f8fce 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c

> +       if (rotation & DRM_MODE_ROTATE_180) {
> +               plane_state->reflect_x = !plane_state->reflect_x;
> +               plane_state->reflect_y = !plane_state->reflect_y;
> +       }
> +
As mentioned by Ville the above is already handled by
drm_rotation_simplify() ... although it makes me wonder:


>         err = drm_plane_create_rotation_property(&plane->base,
>                                                  DRM_MODE_ROTATE_0,
>                                                  DRM_MODE_ROTATE_0 |
> +                                                DRM_MODE_ROTATE_180 |
>                                                  DRM_MODE_REFLECT_X |
>                                                  DRM_MODE_REFLECT_Y);

Would it make sense for drm_plane_create_rotation_property() itself,
to add DRM_MODE_ROTATE_180, when both reflections are supported?

-Emil
