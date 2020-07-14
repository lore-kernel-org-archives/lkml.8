Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EB0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F92251E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2+O0TC2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGNQSO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgGNQSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:18:13 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C4BC061755;
        Tue, 14 Jul 2020 09:18:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id dm19so17827896edb.13;
        Tue, 14 Jul 2020 09:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zAjrXG9HRck33siO67wv3KsLM2e4m1G4T3NRF0VxAEM=;
        b=d2+O0TC2lgSnnnM/V/d0AkLmwNcwRJ9WhowEoFpUMrBgVtZ+7kJpHV6+iMoTNL5Awa
         J4ny7YatE9BdM1dd7toiSFFzVbvb/PhVSeeci5PWdfSKl4i1rDrxxRtT/2JqDlUDoAH5
         5lC5XtPGoaVj11A3Ytz1vru3nqzVn1Xc8i/2y97TGgh5U6mHVnVbgO1O8HfPiNsmHcIz
         swtr8U3Vw6qMkdS09ioOYFbJbOjWfH++5DJBK3hx4QfUTz/vaocyYvkatlofk3uDv2+F
         cScLX67m2C6+AbJxVEm3WZP1G2othr1z21zLOm/VbCk4uFTSTAlKxGxzoTBvTDm1Z7PG
         +uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zAjrXG9HRck33siO67wv3KsLM2e4m1G4T3NRF0VxAEM=;
        b=AxZX3hna+ouvOqacayeKs1S1VOw8tzTzhSSHaBI0DXQ1TnMJYJAX1m7o6Nq23aUxP0
         r4jMYpeiA6HjpMQMBdlaKSFklua8TjsgZ8+Amynmq88i4hRgRu644xMTMXoHMvTrbQuF
         0tj4lYYnx3z/Pr2tIaoD0wNaMTVOdMixqRPJnkKmQUWECzGI5RNyha6N9Y7e8easfgDi
         KpF39uu90MH7NIPvcl4WZH/gfbA2/m9Xc6v8NCQu5K9UUdTaNmssEq01Mq3YGYTNZVu+
         pORixmikMg3SWZJWCHt1nvKbO2LDl+dyuPE0E6F2YFUBt3+F0vLb1kLPNqrLwCzqQaJv
         S5dQ==
X-Gm-Message-State: AOAM532X9Yb3m9u/QGfg18qazVPbpcIwRuvqfpqzb9JZMvKniWUlJblM
        CTH6XmSeVnUPomJ2h94taScSE8xr
X-Google-Smtp-Source: ABdhPJw6tXmAPbuJxT/b+tXKd+9Cgq1wbjcO4YfB0qlpjk7wjvT4EO0WpJkjvt2rBoXB/XBqMO5jWA==
X-Received: by 2002:aa7:c54e:: with SMTP id s14mr5370829edr.81.1594743492066;
        Tue, 14 Jul 2020 09:18:12 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id i7sm14762045eds.91.2020.07.14.09.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 09:18:10 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:18:09 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] firmware: tegra: Add support for in-band debug
Message-ID: <20200714161809.GE251696@ulmo>
References: <20200712100118.13343-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20200712100118.13343-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2020 at 11:01:13AM +0100, Jon Hunter wrote:
> This series adds support for in-band debug messaging for the BPMP and
> updates the BPMP ABI to align with the latest version.
>=20
> Jon Hunter (4):
>   firmware: tegra: Use consistent return variable name
>   firmware: tegra: Prepare for supporting in-band debugfs
>   firmware: tegra: Add support for in-band debug
>   firmware: tegra: Update BPMP ABI
>=20
> Timo Alho (1):
>   firmware: tegra: add return code checks and increase debugfs size
>=20
>  drivers/firmware/tegra/bpmp-debugfs.c | 436 ++++++++++--
>  drivers/firmware/tegra/bpmp.c         |   6 +-
>  include/soc/tegra/bpmp-abi.h          | 913 ++++++++++++++++++--------
>  3 files changed, 1038 insertions(+), 317 deletions(-)

All applied, thanks. I had to tweak a couple of things to make
checkpatch happy, though. checkpatch also wasn't happy with the ABI
header update, but I left it as-is to make it easier to update in the
future.

Thierry

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8N2r8ACgkQ3SOs138+
s6HKbQ/+OyWkNabkwaz2VIm+/UvhFTkpltTAO12a9bnuwIL0Gt4mTs2HF+aDlcnZ
fxDfrDxElOe9OJzNGxrbaKoM9ADIllqkiAw9OAgyDJG5SfdIRcZmD0gucFzM0mrS
uHPduH0SvnW8lZaRO89886bZeODiIZwlQyy4VxntIlnhX5D6cb8Rvxx3R3r2KuT5
SrRE63hz2C6HNuuBgzn6VNRzwnnc8FZkTzI6o2Oy3Rl86hOXe0W7YQZrl8UVtKEM
5u3GmJPaxNU8FTzaq2iOLyy+TfElwG2a3O/z/31OAtMJp30eBeL3o92hOl8QUdC3
uhYWerRv1d6Ykxm/3/bWyXYkm8hoKCMSHZW464mtCLOMH0RNM0+ZGgOVVFIGJROE
0wjTdj+Lf05IF67jgCYXLAAqbB2Cl4ZpOwH8Yv8EY3exoObwMWEMwbZiR35LZlLw
xe0GwwYFyCQLMAMLiXmqYqouQD7hlHWPHGjJ9KqcTwcdRKzvuDM40Nsm3fviJ+X8
6qV1UGva09j8KlbNnotMEpak9J4meQlubD2BgRBXnfEjNwm369+z0BgxFj36LwT8
+duclmGy9s5fTi+U4IbGD9i5kmHUQ/7bcRmmortkuR8LfNZ8bvL3C/yo3OSpVeKJ
n6cMzHSArgZA6z1Qf6MTSsDOecytuH7K/htthYF0T3w8QNdkbjo=
=k44N
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
