Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81630C2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5718520801
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3CCYlyY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgDGKu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:50:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34728 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:50:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so3364426wrl.1;
        Tue, 07 Apr 2020 03:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=amPYgdlLGhWc+0ojfJPO8krsqf8U5xNGSa0wf2ccSKY=;
        b=b3CCYlyY9xhzitc78hkXpZ1gIUYPF7KzBXSYpqojtuQupSJ6+DrUCxe8FH2jW/v9IN
         mmiI0EKVYXfUpjcCJCdQQNOMPqu5X7PQNjy/shuujY7mh2l+wTUqkhsT1wnbBwqV/7E+
         2PubsF6JiCerT5L4ZrKen1I3oa5MN5Po8xDFfWEQzk7HfYe4A78UGRVAZSKHV07lFmOq
         qXU3LWk80e3OtZZyInEOoOsLmDd4mXCqpzziH2Fynm9CT52eVSCo2nDbJeyf4ymAwjXM
         zFQ6O1js/IitR3+FIcnoYfKJ+9CAkcY/X41nNxYn4kfCU5y3PpD2LdtCu7hWgsx4Lr+3
         jhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=amPYgdlLGhWc+0ojfJPO8krsqf8U5xNGSa0wf2ccSKY=;
        b=Xgdn+8pVxDZX9Rls2CUbqKvTvsthfPs+blOqeVUTZ/JIJZZhBH94zIxVezcGGgWvnR
         dy1+1hiPPIlePR9ixAxtgIDue0yTFh67rjKIG0VzrDkLiKk6YkhwadnjECgw8T7rwWx7
         9+s+6jBDEcrfvw+H8vSIQ6eUmpQKh1ZsPETpz39f9qh71y9AU6WQL4tu1LiUkyAPryOn
         FSXLO/Sz6Y2Z5yL7YUwGK6o8Hd108UFh4dZ99hmaHPMqaquYKmDhbdA/v3/6y9H3I0y0
         DbJUMjQcno+q0aKzQF0o0PG9DCy5/5PRP95e6ys+fOwWWRo9XFp3ZbxSUfmyiBwQp+iv
         5PHg==
X-Gm-Message-State: AGi0Pua/Ss61Z7yED+Et7clEicPSZWkCl3IChCmztqnB7g0vMo3NY5UB
        P32kdgJ60daGvEt4oPUGKq8=
X-Google-Smtp-Source: APiQypK2b4OXIxuXoJyQ4fHa63DR9pfnOD8PvvRreqrLTWsZW8M6lrkz2Z8K3TIgliXbrE9X5C4YeQ==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr2163780wrt.67.1586256655703;
        Tue, 07 Apr 2020 03:50:55 -0700 (PDT)
Received: from localhost (pD9E51D62.dip0.t-ipconnect.de. [217.229.29.98])
        by smtp.gmail.com with ESMTPSA id n6sm1799380wmc.28.2020.04.07.03.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:50:54 -0700 (PDT)
Date:   Tue, 7 Apr 2020 12:50:53 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Pedro =?utf-8?Q?=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ARM: tegra: Add device-tree for ASUS Google Nexus
 7
Message-ID: <20200407105053.GD1720957@ulmo>
References: <20200406194110.21283-1-digetx@gmail.com>
 <20200406194110.21283-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20200406194110.21283-3-digetx@gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2020 at 10:41:06PM +0300, Dmitry Osipenko wrote:
[...]
> diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
[...]
> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		linux,cma@80000000 {
> +			compatible = "shared-dma-pool";
> +			alloc-ranges = <0x80000000 0x30000000>;
> +			size = <0x10000000>; /* 256MiB */
> +			linux,cma-default;
> +			reusable;
> +		};
> +
> +		ramoops@bfdf0000 {
> +			compatible = "ramoops";
> +			reg = <0xbfdf0000 0x10000>;	/* 64kB */
> +			console-size = <0x8000>;	/* 32kB */
> +			record-size = <0x400>;		/*  1kB */
> +			ecc-size = <16>;
> +		};
> +
> +		trust_zone@bfe00000 {

Given that this is trademarked as "TrustZone", perhaps drop the
underscore?

Other than that, the same comments as for the Acer tablet patch also
apply here.

Thierry

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6MWw0ACgkQ3SOs138+
s6GFUxAAjuO9EN/TXj4dinbIrLbtW7TMjcDyz79Bogtubyxa0vfYgHB14xoBe5tm
xRsBWLwvJho9KUQZo2eo8prLaI1Wv2hZNy5T94OmmBRfT52Vfg+xLdRySwwDruft
Shw9b0FPXFJQAuV4R2BcWav7nznEiB+1d/NVwa/Je4bexYWWjXlcdjWDsx5fpBhd
SQaXl+P337dFW9xsoXSzM7Cxv9gMvZXxe61qgWTKCnTzkyvRZjPlnp61RgHaB60b
R9X4h4Llu297J3Abz8xfniQPj2V2ivcm5G7uOIeAlJFDNht78Pirytg8X8G2c3Iv
KGdz6NmV9yCkNSGjJ6gkQEH5BuI/dQbcmRkEw3CaD4hB2fWOvEfLqlSbplc/b3MT
pY7z60pREG06H2VlqrFMVQH0JFLkFNVMAZzDkvxpE9y+hLLDUYVjvHXti1HOTIBW
IJA+aiqaxiDDtghn4gp254d6n0Toq9knu3PIaKFf8ssv7VlrAFYUrScXnnXZfbG2
Nhu7szpE0ejt1+LwJkKWybeIEuKP4WK1cVmyd9vNPSa+i6WBNAmfxtA7SZ22ZF3+
nCZokOQ9js77AIIzz/WbtwG9miq6S2W1At7itN4IN2pt5B358kiXHdjk3y32k4Pz
ZM2/ODOgdmAKILn8xfXqi1S1ITKlUYD62qu86RYDiWclgDIOLJU=
=MqrP
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
