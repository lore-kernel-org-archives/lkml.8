Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35260C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090132080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLXm0Nba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgAJLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:08:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36871 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgAJLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:08:14 -0500
Received: by mail-wr1-f68.google.com with SMTP id w15so1411967wru.4;
        Fri, 10 Jan 2020 03:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TOO/pt3OpqfmgxOuHg6dFQjzgEqjdxbZaKm7ev6AP/s=;
        b=KLXm0Nba+2xhcmOIq9Eey9pnNs7qbSW6XHQp0o1AD9o7HnZfUPQfLvJzfq+x5ojgC1
         Hw0Mrnwl4bKTRuXwUGePNYwlCMN7ye67iu+tW05VR7jW2MUdKE8uegtVGlgXu1qGXhl4
         WUbOXP9n7Frn5+L7DQLAj/zwhHT8el8ufrEJxrBZM0RQ5/1BOnZAQZOT9rKANl9HwLO3
         UjYwVNRz8NAT0bNegfP0Y+YbAXG4A6fQLj5pV7mXkcsuhoB6z0Txwxw1BjXwe1jrWXnT
         gezbbBUv+nFpd3kTVFUhPeSuH6qwc2qt84dP3gj0056Tw6id2KaD6Ja9GGv0MVPrsRZx
         12Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TOO/pt3OpqfmgxOuHg6dFQjzgEqjdxbZaKm7ev6AP/s=;
        b=Xhk4rLuQewCPIapo2eFvk2kSFXBkQo2Uk07q3fOaF3RslR8pIgvUz3w9zL3MCdnzXR
         KtDbYCLB/i9mrHYFRzbT5Tq3o5Wu265uNiwzZDcN2Rd09p2QkozPhulymmN0iAF6dTGI
         ZRf6UljpHCqyRzvHoGuScJkfob4ICiuGdA5QYV9qIVZYeZG/gzOCflvZzvAA6TK0B9yJ
         MA6sekUuDw0Tv7ohV/Tkn8376j4u79UyKM0jXet6Bp4nvNzcfflGI6eRV1NoaqoR2Ry2
         FoPU03rzDP1UtjQHvGWctOl7epQw4bfnoPLZWh/MI+vOoTibdbn/IVVkfXb6YNAu82N7
         XHZw==
X-Gm-Message-State: APjAAAWFPXHu351d4TvcclitJTJojz/6Sf/tE3hoh7SRx4XmTpKSYkJA
        Y7Tu/NBfmR+Mk0sIT6qsMzc=
X-Google-Smtp-Source: APXvYqypTaDE0q0lCAn7yGVg0zSGEpC3vJ/2WARvmaD/IEK+KtWiy7M9AoemJ8+66PZTfaiOjlPXtA==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr2980725wrq.196.1578654492072;
        Fri, 10 Jan 2020 03:08:12 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id n189sm1877059wme.33.2020.01.10.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 03:08:10 -0800 (PST)
Date:   Fri, 10 Jan 2020 12:08:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/2] enable Tegra194 fuse
Message-ID: <20200110110809.GA2233355@ulmo>
References: <20200103083018.10575-1-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
In-Reply-To: <20200103083018.10575-1-jckuo@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 03, 2020 at 04:30:16PM +0800, JC Kuo wrote:
> This patch series enables Tegra194 fuse registers access.
>=20
> JC Kuo (2):
>   soc/tegra: fuse: Add Tegra194 support
>   arm64: tegra: Add fuse/apbmisc node on Tegra194
>=20
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 13 +++++++++++
>  drivers/soc/tegra/fuse/fuse-tegra.c      |  3 +++
>  drivers/soc/tegra/fuse/fuse-tegra30.c    | 29 ++++++++++++++++++++++++
>  drivers/soc/tegra/fuse/fuse.h            |  4 ++++
>  drivers/soc/tegra/fuse/tegra-apbmisc.c   |  1 +
>  5 files changed, 50 insertions(+)

Applied, thanks.

Thierry

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl4YWxYACgkQ3SOs138+
s6EK4BAAtbeDyCnCYBEbKXjx+1prKfhmQ0MbAc7Qr0b2XeX4daJwGCg1rD/lnQhY
dEXWoUm5EwUBaaxzZYAFif9PD1Ks0BE6M6jaBt9PhUIPZnfIsKjDfZJKNrXzTTbA
hCUPJ9LwJdO0tdf99C+GIa9yZRu2ZeJy0qKMHydUwcy4MO2VxIO0+IQelyqB6TOb
o2zzN51jk5Y8smwxBtDTOVIavrsm7k9sUPz+7XryYzqQyeaUPG5rGtoQhpH66isv
U3imJKXmY9O4IV6Z7/3/6jrSHQi2s2+a1OTk87Lv5NHN3WpM20zxDpP4LrZL/nwd
qzQHhabI7ot27cNOpu7YYoAlyrs6Eh3srJMef07qQZ2XiZ2Kkgh18aaFHx7mVJsM
KLM9SQinV4WRS+72hbwOdrYpTC8haumldfPLua09pzfL3rBC3nBFp7B5sQ8rTtmK
3Qrxtvyhv3AOqD4b0qkx3WZaiwtS3sB1RP1yq5iEO8YiNehQh7QV74P/TCz7ZL8K
NcjrQwjnozbACeaPxFRQLl+eYrq3FqoZnwKqB3qLWz1g/VfS6MOLQiUQ2ewdSRrh
7SWs7oRN8o5JotMyEGWlSSa2dr66hZURkqXOEx6tQGS0bQw8NidFJ4E35CaonZbA
IagR/rzfChZLzwP87bbAGCEVYXzI1d+XpiX1tJOcwxyp0SlXcxM=
=HJXW
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
