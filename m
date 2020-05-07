Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E84BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F54208DB
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnIAbXnc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgEGUCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:02:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F9C05BD43;
        Thu,  7 May 2020 13:02:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so7890201wra.7;
        Thu, 07 May 2020 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VAjjagUIED4AtWW/kvDiQTKteVZtsEvk40+7qXQuD8o=;
        b=MnIAbXnc+k4yZvtOe8rJ3kc7H1BzlG2+54F3qKz/Vgklw08oyxR4nImID0g7aMwKUE
         rvvghPTdsyzr2WqXEMvSlSX4+lsY8P+L9QFY9BywTIsqlyy2AsE6Osk9rRzxGxZ591SG
         14/wlPmv4C+gHtk3YgW4eX8ZpnYcJW+3qvw/0bazCqclWbKCe3VKIz5aMOXZWW3cwbNR
         FYssSJ6CERRLoeT1aD0RaE29B41HMmsbNWxJ2aYKiU32lCX7OTNKRDfjt8oqzxtagTyY
         fiVAes92mbgF2h5H6K7ks6taNGrpP5SGzEjAw0j/z49QzZDtniaUeFYBnUBRoJTos1yP
         UAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VAjjagUIED4AtWW/kvDiQTKteVZtsEvk40+7qXQuD8o=;
        b=gbjCxiPLvTDIBYVpbyxaq4r299ZyMk2aC8NuBlKxU6RseKsJYg/VMWuFGZzcq10Ryn
         jmXAKm5Awd0O3tsvcDXyZpCVRFOO5m4wEjK8daUxC/2MpKIZr0YPEzshdUxgH8dkpOHv
         VTi+2+TsQpFKx4galeT0WGB/SngRERBBkToWeqt8kRFRksLzkeZU0KoIASrRwmX0hdzk
         +uovab7tIztSMbhRQJfpUbLUJHs9+xNZGUSaXVfABIeQLN2Ouupy3LIBKPjDmOLC65Q+
         c+rPUK/HSpGGB2dT1uIpi61jOkJZHn/ETvvciAj8i8geYLsJfHNemVkfDfPItdkca+Lo
         mJJA==
X-Gm-Message-State: AGi0PuY2DRmiPfG5+M24kfp7qKH9IT8ym9hWmYVSv5U5nOyGRh+IAaKd
        5d13fdaTATPYcZRABzlCSni7UMZKXTk=
X-Google-Smtp-Source: APiQypKSMwNkdwKsiEakQ6SafujPAdYB4/F0ghRwsHD/Wmpptr9mN/o9A38D0m58QkclWlIeLjst0g==
X-Received: by 2002:adf:8b45:: with SMTP id v5mr19024913wra.175.1588881762418;
        Thu, 07 May 2020 13:02:42 -0700 (PDT)
Received: from localhost (p2E5BE57B.dip0.t-ipconnect.de. [46.91.229.123])
        by smtp.gmail.com with ESMTPSA id n6sm9111679wmc.28.2020.05.07.13.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:02:40 -0700 (PDT)
Date:   Thu, 7 May 2020 22:02:40 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: avoid unused function warnings
Message-ID: <20200507200240.GA2981633@ulmo>
References: <20200408190043.532711-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20200408190043.532711-1-arnd@arndb.de>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2020 at 09:00:30PM +0200, Arnd Bergmann wrote:
> The suspend/resume functions have no callers depending on
> configuration, so they must be marked __maybe_unused to
> avoid these harmless warnings:
>=20
> drivers/memory/tegra/tegra186.c:1578:12: error: 'tegra186_mc_resume' defi=
ned but not used [-Werror=3Dunused-function]
>  1578 | static int tegra186_mc_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~
> drivers/memory/tegra/tegra186.c:1573:12: error: 'tegra186_mc_suspend' def=
ined but not used [-Werror=3Dunused-function]
>  1573 | static int tegra186_mc_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~
>=20
> Fixes: 177602b00641 ("memory: tegra: Add system sleep support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/memory/tegra/tegra186.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-5.8/memory, thanks.

Thierry

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl60aV4ACgkQ3SOs138+
s6HB4xAAtc0jHXbJjHqyz+xVNP+KreaFGVRf3w9YmnJhAFFOhWaUf0/5UUOKwzp9
5XwyYYa5cSzJtk/AOGPgfEtGF4pBx7KJKF+Sxhg8jVJXMfRwYc4q2wqoKsfbT42h
fslFVb7sGWUiUtCvvkCFlDLw+8QhmbTqnG4zCSL4d/YdNqTPKAZIFrivP5LU9UZT
m+VSSrSegwekwvHN1oWtoXIrO7j8tCoXHHjzvHH457ijv/s7QXW2GycnNstPOOIj
KqLLCyrY7UPxJykiGBsO+tCmT8bo/xZKEFOTtxsZNFAmA6Ckzx5s1KA5EX8Gf/G6
zg/+9t1DATutn+USPq3yTznqN+OnN8R6xohhC5CjsxHSWsxmQwtaYH4rtr49sRp8
TaMtA3Rz4bD+8MUoT69fXC7xnj7fmXDZh2NwK4AnxlDvV+YFsz7Fj614IqOucDzj
b/vXJkT4VwHjmUg9yIAKDiTVSeT/y25xWtI8uEbEJKHNCRv9ybfZOqi7gnAIsa9M
oSCrBL8W8aDsze4kpbWnOvadFWEOFErhWShPTA5I+sgYCvstY9OXg+75/0QBa/1L
+YooiDJWhAjlM+o/f+2Unb/DB2VQsIToYTTu6VkKe66+9xZ3ki2qt149sEKu4piQ
VTGmTotNkWBSKivcBqU10+rJPbNmeJYFNGfWiLC+Jz2SkNaeU+g=
=xt3U
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
