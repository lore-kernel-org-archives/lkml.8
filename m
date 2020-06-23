Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91525C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EEE52072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6t9Walx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgFWMrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732604AbgFWMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:47:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2546BC061573;
        Tue, 23 Jun 2020 05:47:39 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x24so437707edi.4;
        Tue, 23 Jun 2020 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m8ije2B4PI1+pUOmSGnwoGL08wYxdnSPx9jj9fWDxW0=;
        b=c6t9WalxME4N7Lip205kFsD49aYPKPULsToZq4eLJ9ejlhskVfsHvUzrEMpxHQUzxI
         4GPHEAuW4SayIQfDBJ0XEhwN8OjzclJnElDwAyxw2xtsSl7rEIl4dgipGHzdLdnRH3j4
         3tIGGxcZen8T+w6h7FfBq48nfjReCew/aUnDAGesQc6jbhBNuvGcdKnU+coQUFgi6n0m
         uGexdvSoZgQnEwu8bzyOqeB4iG6DvYKPpR7+XJRZ7M8BRCfP4KWwQ+POFTXI6Ud6+EhO
         jOz0RBElp6Gw+LWK6Y24IzNapw0WdofMZ4airsVPW36UDuU347HRF5BRCwOzCrmiPucs
         q5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m8ije2B4PI1+pUOmSGnwoGL08wYxdnSPx9jj9fWDxW0=;
        b=qN8EksYRusNeCwfKuEaql9DQz1PWpLjDWNML75rv0UXmRr4MNgkhlyweoW2dptOPWX
         98h36y/PSpcYGZ1Fs6iG4NORLQOkCzclnuOjg3F4dAO6oFsQToetPFGzFmpocb6XWWVJ
         uWCPL3DGax7Dlf3s5HTlTv9Nmv1+o+mMyhlPs6hxhu//FJEEA0zpiNauY6WOwEVoAlX9
         SlH6f5YNtmprU7p+seFZi/wDwa0GeZHClHIkA1Ir4ifBCFgJjeV50lq5mY2ipc5k/ICo
         L3+lQLq40/hLlt3+K7OecSHvn6/Q9sAE8daFcilsKVCMD4/ex4hW7UIKoxsGKjkiDdF9
         cDuQ==
X-Gm-Message-State: AOAM531hhfT9dmpEVgoo2Q1fBWIp9nQ0yKn0f5/otHlQOMI4zim4LMc2
        wlLwhevTjn9yELapon1hmCo=
X-Google-Smtp-Source: ABdhPJzkZdYHG97SAQhLllrKGFWqQ9Qfqc5IYwXev2WxixR+hJY2bpOPAEi3WgO/fQOtjr+YCp5ARQ==
X-Received: by 2002:a50:f01d:: with SMTP id r29mr10323801edl.158.1592916457779;
        Tue, 23 Jun 2020 05:47:37 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id n25sm14636560edo.56.2020.06.23.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 05:47:36 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:47:35 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Krishna Reddy <vdumpa@nvidia.com>, treding@nvidia.com,
        bhuntsman@nvidia.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, mperttunen@nvidia.com,
        talho@nvidia.com, snikam@nvidia.com, nicolinc@nvidia.com,
        linux-tegra@vger.kernel.org, yhsu@nvidia.com,
        praithatha@nvidia.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, bbiswas@nvidia.com
Subject: Re: [PATCH v6 1/4] iommu/arm-smmu: add NVIDIA implementation for
 dual ARM MMU-500 usage
Message-ID: <20200623124735.GB696655@ulmo>
References: <20200604234414.21912-1-vdumpa@nvidia.com>
 <20200604234414.21912-2-vdumpa@nvidia.com>
 <20200623102927.GD4098287@ulmo>
 <5f29c794-406a-db13-d6d0-75dcb0d0b0cc@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <5f29c794-406a-db13-d6d0-75dcb0d0b0cc@arm.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 12:16:55PM +0100, Robin Murphy wrote:
> On 2020-06-23 11:29, Thierry Reding wrote:
> [...]
> > > diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-i=
mpl.c
> > > index c75b9d957b702..52c84c30f83e4 100644
> > > --- a/drivers/iommu/arm-smmu-impl.c
> > > +++ b/drivers/iommu/arm-smmu-impl.c
> > > @@ -160,6 +160,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct=
 arm_smmu_device *smmu)
> > >   	 */
> > >   	switch (smmu->model) {
> > >   	case ARM_MMU500:
> > > +		if (of_device_is_compatible(smmu->dev->of_node,
> > > +					    "nvidia,tegra194-smmu-500"))
> > > +			return nvidia_smmu_impl_init(smmu);
> >=20
> > Should NVIDIA_TEGRA194_SMMU be a separate value for smmu->model,
> > perhaps? That way we avoid this somewhat odd check here.
>=20
> No, this is simply in the wrong place. The design here is that we pick up
> anything related to the basic SMMU IP (model) first, then make any
> platform-specific integration checks. That way a platform-specific init
> function can see the model impl set and subclass it if necessary (although
> nobody's actually done that yet). The setup for Cavium is just a short-cut
> since their model is unique to their integration, so the lines get a bit
> blurred and there's little benefit to trying to separate it out.
>=20
> In short, put this down below with the other of_device_is_compatible()
> checks.
>=20
> > >   		smmu->impl =3D &arm_mmu500_impl;
> > >   		break;
> > >   	case CAVIUM_SMMUV2:
> > > diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu=
-nvidia.c
> >=20
> > I wonder if it would be better to name this arm-smmu-tegra.c to make it
> > clearer that this is for a Tegra chip. We do have regular expressions in
> > MAINTAINERS that catch anything with "tegra" in it to make this easier.
>=20
> There was a notion that these would be grouped by vendor, but if there's a
> strong preference for all NVIDIA-SoC-related stuff to be named "Tegra" th=
en
> I'm not going to complain too much.

Maybe I was being overly cautious. I was just trying to avoid adding
something called nvidia-arm-smmu which might eventually turn out to be
ambiguous if there was ever a non-Tegra chip and the ARM SMMU
implementation was not compatible with the one instantiated on Tegra.

Note that I have no knowledge of such a chip being designed, so this may
never actually become an issue.

In either case, the compatible string already identifies this as Tegra-
specific, so we could always change the driver name later on if we have
to.

> > > new file mode 100644
> > > index 0000000000000..dafc293a45217
> > > --- /dev/null
> > > +++ b/drivers/iommu/arm-smmu-nvidia.c
> > > @@ -0,0 +1,161 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +// Nvidia ARM SMMU v2 implementation quirks
> >=20
> > s/Nvidia/NVIDIA/
> >=20
> > > +// Copyright (C) 2019 NVIDIA CORPORATION.  All rights reserved.
> >=20
> > I suppose this should now also include 2020.
> >=20
> > > +
> > > +#define pr_fmt(fmt) "nvidia-smmu: " fmt
> >=20
> > Same here. Might be worth making this "tegra-smmu: " for consistency.
>=20
> On the other hand, a log prefix that is literally the name of a completely
> unrelated driver seems more confusing to users than useful. Same for the
> function naming - the tegra_smmu_* namespace is already owned by that
> driver.

The ARM SMMU replaced the Tegra SMMU on Tegra186 and later, so both
drivers are never going to run concurrently. The only "problem" might be
that both drivers have symbols with the same prefix, but since they
don't export any of those symbols I don't see how that would become a
real issue.

But then again, the Tegra SMMU is also technically an NVIDIA SMMU, so
sticking with the current name might also be confusing.

Perhaps a good compromise would be to use a "tegra194{-,_}smmu" prefix
instead, which would make this fairly specific to just Tegra194 (and
compatible chips). That's a fairly common pattern we've been following
on Tegra, as you can for example see in drivers/gpio/gpio-tegra186.c,
drivers/dma/tegra210-adma.c, drivers/memory/tegra/tegra186-emc.c, etc.

Thierry

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl7x+eQACgkQ3SOs138+
s6GQ6BAAuC+O1E0XBRiRyV/lar7nlljqvp4Z3V8QPPBm+vu4HT67YEP97q3fRts8
NvEwoueGRYB+gC9rimuFcbW+2+dpWDR09UqjKefH+zLc4M8lWA4NGkMaZQYZ9ffX
pzjlT3dGL19K6Qsi3esMMps1+p2N69kuum1BORc9lKjayqcV59tc+3wPkZ3/guvn
CBgzh7ZnbFW3bkRLqnRxIfNtrEVw0jDWeI0CE7EYxSzP2pgL/h7ab8ixm19G8CG/
LqVNWlhtn8o7s+EJVoBU/PY9ZqGGcTFiMe1xFW67nb3lrJjns024Hr9//IDRPKHx
dxXIQJpAtSl8qo3Z75suNGoeLOp/yrrQsoGcY5BObJJpzAlQscNj93c373Gzc5qj
uDYK4eC2wE+st177p6nHaCn7ti8MvTd/HcNgCToAS1PBf1T5dlvriVvCixxV73Ls
+fhO00LuWH3luLh2xxx07yxvBMfVsujVn5jwFhvpraeqbQAkA6lXi0qCMJw+iVhF
2Y+bxHrFqEgnZwCAeqRLaEYBnepYZNehTPMVJjQiT00Vrx82CXGpmFc9dmQpQMdQ
RSP8RSIt3+piUgbsiGLZeQLF+SI2g7ISn46xWe13Lx2+3yKaklquH+To2YIhTUbh
bZvRfHKL6fTN6WWMFC41HQU1UPSiplf0ECIBCy3K8JHkowJRinQ=
=4bht
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
