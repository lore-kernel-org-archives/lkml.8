Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CB7C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E8920755
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGZix1b7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387560AbgCKXYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:24:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34609 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgCKXYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:24:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id z15so5011278wrl.1;
        Wed, 11 Mar 2020 16:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jyc0DmthNhbkCDc5Lj6koSBgtM563eXtr/p2glAoIaI=;
        b=BGZix1b7KHoar2w0KDkHKidsyWc1e2dOusEd1oRs45/s1nggef2xVx77KJhjpnHSZk
         clVpjWcxMXAz2Sp6VMP7X1PUzW83cu0C+GqZmtsev1i8DJ1LiL5oCHS7yXFgwD4pLhhK
         26XSPDcZJp3Xz1X4RKfN+bU1eAByqCGB+tvGEL++pVnTSttlfApzWL8sfRhRpaIfwvyo
         6YxlScvRT1IvIhRTxn5zAUrrntcB2R9XwHwGAPueZHGGmINqQS2CIxJp/0f2feMAs7mF
         YArekIqu36WA8HNcwXZZr5xjZuxJjNtW96TET/2jsDNwqHnCNRyGXEfoh42XwOxbegRA
         DPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jyc0DmthNhbkCDc5Lj6koSBgtM563eXtr/p2glAoIaI=;
        b=TD3UkVYfxAq1lI1RdICkexLcE4NwExXnnFEU0XxOV16xeg4OC9IJPU2Yl1DHMsrFOe
         kN1D4UU7hu8rvKEmJGkLNbCX0RT73VsQA3sbbutPb9nMTLGpDK9uoU9bTvgy2n3mpHex
         BR/afj8/PYFsdDtDyqY4Pa+CPojER/rMGp4B3BcsHLVAPEAERiPYO+BmHglek6duNFOs
         4vOVJjMi479ZyCr5JW7m10alxZv7B+V4BHE9V7JHN1b0zPYMyKvXPcCgp927Q27AlTSN
         wPsqYsuHL0CsVnfyWftd/LAZNnJ2NMamxRQP1uV2VGxLeZtFWxFRE1APl3pU4aeLEKW8
         WAxQ==
X-Gm-Message-State: ANhLgQ16dUnXolJtnQxkEXPJomwECPsqrb2CSBOns+rYh6c4XI1u+FuL
        NGApcEDLLerFR7voyVOV978=
X-Google-Smtp-Source: ADFU+vvQooBGL6xviIsa9Gml2WDmUUkSluU/bVnFryBT//SefAXth7hGYISugMiyVH+g1RlgJResZA==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr6839433wrq.19.1583969091424;
        Wed, 11 Mar 2020 16:24:51 -0700 (PDT)
Received: from localhost (pD9E516A9.dip0.t-ipconnect.de. [217.229.22.169])
        by smtp.gmail.com with ESMTPSA id p10sm8421253wru.4.2020.03.11.16.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:24:50 -0700 (PDT)
Date:   Thu, 12 Mar 2020 00:24:46 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     daniel@ffwll.ch, airlied@linux.ie,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 10/21] drm/tegra: remove checks for debugfs functions
 return value
Message-ID: <20200311232446.GA998881@ulmo>
References: <20200227120232.19413-1-wambui.karugax@gmail.com>
 <20200227120232.19413-11-wambui.karugax@gmail.com>
 <20200311143753.GC494173@ulmo>
 <alpine.LNX.2.21.99999.375.2003111750360.14786@wambui>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.21.99999.375.2003111750360.14786@wambui>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2020 at 05:54:46PM +0300, Wambui Karuga wrote:
> Hey Thierry,
>=20
> On Wed, 11 Mar 2020, Thierry Reding wrote:
>=20
> > On Thu, Feb 27, 2020 at 03:02:21PM +0300, Wambui Karuga wrote:
> > > Since 987d65d01356 (drm: debugfs: make
> > > drm_debugfs_create_files() never fail) there is no need to check the
> > > return value of drm_debugfs_create_files(). Therefore, remove the
> > > return checks and error handling of the drm_debugfs_create_files()
> > > function from various debugfs init functions in drm/tegra and have
> > > them return 0 directly.
> > >=20
> > > This change also includes removing the use of drm_debugfs_create_files
> > > as a return value in tegra_debugfs_init() and have the function decla=
red
> > > as void.
> > >=20
> > > Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/dc.c   | 11 +----------
> > >  drivers/gpu/drm/tegra/drm.c  |  8 ++++----
> > >  drivers/gpu/drm/tegra/dsi.c  | 11 +----------
> > >  drivers/gpu/drm/tegra/hdmi.c | 11 +----------
> > >  drivers/gpu/drm/tegra/sor.c  | 11 +----------
> > >  5 files changed, 8 insertions(+), 44 deletions(-)
> >=20
> > Applied, thanks.
> >=20
> There's a newer version[1] of this patch series as this specific patch
> depends on other work in drm.

Oh yeah, I just noticed that this patch causes a build failure, so I
backed it out again.

If there's dependencies on other work, it's probably best to take this
through drm-misc, in which case:

Acked-by: Thierry Reding <treding@nvidia.com>

Let me know if you'd prefer me to apply this to drm/tegra instead.

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5pczsACgkQ3SOs138+
s6HS4Q/+P562RsBDU9ZpqlH/UKz4Fl0liGtZcZPtT8vsdxVvw6pnXlF1Flc0b99d
EPk6sJ/3s+cWhfClB1ZlOnn/insCTRmtOLpqFaN5qmtbQNCG0jI84s+4uJJU5lgx
drcSDnXfLGTaSVQBPzwVS2gYnuM0rduA3M5MfCq7L/V+K2Cbs4k3r9BUyDKPZ92N
P8XzCqdfB4nj9tX3fAP5PCncio8wOvWtvUVkH3ZGDTypbNWkbF2wbQ2ESU7uis3q
aeTA74Eqv2z/lq2uq2Jk9QqOko31i+6SUIv3x/MOxmOXXpN442ib7DoAXCGvroIK
IvPDD18Che8PeUi2zLe+2pT/9AHR4ZN9SqBZ72rEhOsGNczJEo57uy2J+ZL8yZnH
4u7trV6ozHtOlFPrn5LNQONpbNG+esnsghrWwm7tz8Mscq2CiFCvHioyN4lzhOKd
gHJ3ZkZPFXqgmALsnAhP9vpLuQ68aGsrkW4tslBZNp/T2xzU27lG7r8JKyBkADSN
hkYfhsPlhJXJozmgVBJK6cJnstGJ2jaQjIKy/pZYb+g8T1upzykbTkJaT9CF9hSN
NE+lWaQ+OITnBwN76VMnuotVwoM2dB8lChqHLYFhqMk52JGEFZskpI/RO5MKejpH
BZddEqbYrBfBmUQ4V2BdkxjKrRlXZvLl5x0RC/wjdNStNQqKPx8=
=pQXY
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
