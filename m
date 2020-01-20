Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A846C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D48D92073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feubInFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:09:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40396 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATHJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:09:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so13499269wmi.5;
        Sun, 19 Jan 2020 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jC4BMofX4ULcGoP3faAtWvOIgbJpEDzUZLRdWTvccnE=;
        b=feubInFzc3vSXTqm0B3WoEVwqwIjV6G8LnNZyDfPXudQnsSspbO3+gOYzpFoyvrP/u
         zZKC788BEidBCJWOcVywx2UPa5pkIH6VOGocO0CAEZ2eJ0dpdeDcEuEsQ56S30kp6QnP
         KydSTXvcZC4N4kzk0AXCjuUT700NEaWBTt0f2m/Tr3hT9itBrCiyYQYDT/G+hpInxd4v
         6SHZ4ke+jVf1rzVZnVAnOcbccwhSJdRiSb7/CBGrAmO6BPJERh0o+1zQRwzpxq2+Py0h
         YpKetGJJ3uaU5Ua/OvTx/hG3eYUJbrHb0VQ670wWKIjSTNxBq951pr7HTWT4wcrOujXR
         fDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jC4BMofX4ULcGoP3faAtWvOIgbJpEDzUZLRdWTvccnE=;
        b=nI+kUXvP3nC41K7/WvibTfKZ7ybo7sM38uIszLEDS4cYgntyVHiiN0B+mBXj9qmw3y
         J+Yj9IvhrHYJ77QYxNrvZgeGxuPPGfHIdFacVk1Euw2FcSwlPX8B2C0F2336sdTCqU3G
         yEwWiPunZXKv59npf2RuSYKFgrTGhxyfLlN85GIZtUBoH3fIoGP3N11WsOPwf8vfNr/f
         /jrCQfKkPLtudxokswwzhCYd7BNSOVXftBdW5hvQXlK6LsEc9oZCDQgLY2KoyPahPgxm
         IA0yQ0YfzosTikWqMRXDPUVJOxNBpPhxDRRXkSHn2Qwl5O6qaGzRdXmKqFCuCTV1R8Kf
         zlvg==
X-Gm-Message-State: APjAAAVJXrKGQLn7jrFgPQNCVq3CCzSRppIE6v9lOghqKMp8Q4KkaFX7
        LCrPRWXj7VBoQPIvSEaqsT8uvVG3
X-Google-Smtp-Source: APXvYqws5QWUBaccaF/hM5PNGQAiw6gh1OkE59RPb1vBC5q/3NoeLjQc4gNxSRIToglT7nNXnPJ7yg==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr17238611wme.52.1579504187566;
        Sun, 19 Jan 2020 23:09:47 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id b21sm11206535wmd.37.2020.01.19.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:09:46 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:09:43 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     allen <allen.chen@ite.com.tw>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] Revert "drm/tegra: Move drm_dp_link helpers to
 Tegra DRM"
Message-ID: <20200120070943.GA197819@ulmo>
References: <1579488364-13182-1-git-send-email-allen.chen@ite.com.tw>
 <1579488364-13182-3-git-send-email-allen.chen@ite.com.tw>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <1579488364-13182-3-git-send-email-allen.chen@ite.com.tw>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2020 at 10:44:32AM +0800, allen wrote:
> IT6505 driver ite-it6505.c file using drm_dp_link helpers, so revert.
> This reverts commit 9a42c7c647a9ad0f7ebb147a52eda3dcb7c84292.
>=20
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  drivers/gpu/drm/drm_dp_helper.c | 128 ++++++
>  drivers/gpu/drm/tegra/Makefile  |   1 -
>  drivers/gpu/drm/tegra/dp.c      | 876 ----------------------------------=
------
>  drivers/gpu/drm/tegra/dp.h      | 177 --------
>  drivers/gpu/drm/tegra/dpaux.c   |   1 -
>  drivers/gpu/drm/tegra/sor.c     |   1 -
>  include/drm/drm_dp_helper.h     |  16 +
>  7 files changed, 144 insertions(+), 1056 deletions(-)
>  delete mode 100644 drivers/gpu/drm/tegra/dp.c
>  delete mode 100644 drivers/gpu/drm/tegra/dp.h

Sorry, but no. Please just duplicate whatever information you need from
these helpers into your driver. The decision was made recently to remove
these helpers because they were a premature generalization and unlikely
to be useful very widely. See this commit:

commit 9a42c7c647a9ad0f7ebb147a52eda3dcb7c84292
Author: Thierry Reding <treding@nvidia.com>
Date:   Mon Oct 21 16:34:37 2019 +0200

    drm/tegra: Move drm_dp_link helpers to Tegra DRM

    During the discussion of patches that enhance the drm_dp_link helpers it
    was concluded that these helpers aren't very useful to begin with. After
    all other drivers have been converted not to use these helpers anymore,
    move these helpers into the last remaining user: Tegra DRM.

    If at some point these helpers are deemed more widely useful, they can
    be moved out into the DRM DP helpers again.

    Signed-off-by: Thierry Reding <treding@nvidia.com>
    Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
    Link: https://patchwork.freedesktop.org/patch/msgid/20191021143437.1477=
719-14-thierry.reding@gmail.com

Your new driver here doesn't change that, in my opinion, so just follow
what we did for other drivers and duplicate the corresponding code into
the driver.

Thierry

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4lUjQACgkQ3SOs138+
s6G9LQ//RT0oF0cSY99rYD5a4Gq9xwF0NRauxZ2UB31AHTClEOxlB2UvUO3mGmAO
guZ+9+1YTOL35FeRJIeE322/P+HOt7fp6iswZmIvVxfIHlp2+DjViefo/c3RVTCU
EegQahcz6HMV3uxCn0R0h+ZspQustfsd6JSaqbb0/ByUwz5CtmBg78v1NX0svp/w
v7bRIbANkre6CW7QoEZLQUuXcos81GYep0i4IxsjUFG0lavYTmt7sngYMWzio0Xu
ynQEspvKmyTEQoHBvNzvRrqhJxyYIBWB4JPYsqmf3Swb/xixh+ibD0ojhj8kXeTw
1OAFkzXRE4YnvaFwOBMTt84q7r40y+tolILK7M/e6pgOL3IBdeBothqQhFTbN88W
bCGlip7H74N4E6tSkH1x2lZTeiaAr7q6nHZsMleUtgs8+xt05sK3cO08tAfRqqpW
HsyN+1C5YP3hAq+XoTiWCU4OfcUX6QXsDoUwiFb/KeT6VoUuYVomHUzhAUDBmC/W
38IZzaBs4wnhCCrko8KJT7znM5os9pGFnYxHpkw9RhBKBfDOMt5U8dNgfPmmJx1f
nI8CjoxIGbP/rFrOL2yexacluAnFkoYy4+S81hnQT2C9Xoc1FtsUnB+xqpymiRtg
M97YeTh5QL2UT6MYm+Ot/4GRLo+jLlHSeESvCtojJEXzL9PDElQ=
=y4+8
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
