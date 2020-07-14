Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5B7C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DAA2065D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAYTZqW8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgGNIzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGNIzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:55:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CCC061794;
        Tue, 14 Jul 2020 01:55:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dp18so20680888ejc.8;
        Tue, 14 Jul 2020 01:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BYpCX/p81FQOHpa4gqb+UE0SHcspB7H1zWvoCgfKkuU=;
        b=cAYTZqW8l+uFf2mrwz8ziuGrMu/fOroZuQlZenYADb6Bjbyd7idbvTE3Iozi7BrznA
         JIEZkDHiyh7tA3LztNUWuoONszuymZTJNtOXrh6er5WWJLUPBFniox7NBz4kPhAD1/tI
         5rMYD/SP/IHfHFb5zjsPvk4yftUgFDiYGnyCMLeoG0o+BDDVB+wKO069x6/14j2dWSt8
         sVkWzOi7nh4p3XwtNQhpqtWLi4JfDuf9v0wOU8AoYmkJM9kaH8B6ZMBGoQWJsXiBpfy9
         6ASZ6gX9BgYdn5ojXMV5Z8QolKqrV7aoVAN4GCqnDAxCe9qNfeQg0euYp37EXLY0e+0Q
         VJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BYpCX/p81FQOHpa4gqb+UE0SHcspB7H1zWvoCgfKkuU=;
        b=nPfFsqrRYocy0Qu/m03LNLUoxZRnvLc6sVjFjCNCbQhcBBfLqaOyYguwO1BJH5cZOx
         PyJcG1Zmbb96NNTOtomPlDPcsliwDWRHylZi4gFXsKeqqEohSiz7MEe3XBxTvp+AjLc8
         twb5COJFSNlRTV5V3R4EynUcmckWO7HfSXY7FO22+gIztvwK0pKxGj/zdmzuAsit44XI
         bAuLMQZ1pCgcpW2cCEPzJM9M34mU3fyQHacWOTvQAO7i3bSrf8JW32yxV33GfzeKmljB
         NmCobFuA1ZhId8C9h89hZGpruqrLLPjT30wIFnWpn03ZCuiaYhpdPu8sFbUGcV224IlU
         PBRg==
X-Gm-Message-State: AOAM533r6XyVH5rLX/Tq8OCG+D+JF0iuxrrrf3jS3fZY4KzUqqIN/PLH
        Cq/FhcoKRdSgvAGxlmslnms=
X-Google-Smtp-Source: ABdhPJycnijtvoHofHTPhh5AKxCI5zDgniYWn7cKHiQYJNanzDYohFgfiNCy1BVH50hsgdN4yVaCsw==
X-Received: by 2002:a17:906:81d2:: with SMTP id e18mr3431938ejx.341.1594716913971;
        Tue, 14 Jul 2020 01:55:13 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id jo25sm11922404ejb.116.2020.07.14.01.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 01:55:12 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:55:11 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     robh+dt@kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
        lorenzo.pieralisi@arm.com, amurray@thegoodpenguin.co.uk,
        bhelgaas@google.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] arm64: tegra: Re-order PCIe aperture mappings
Message-ID: <20200714085511.GB141356@ulmo>
References: <20200706171454.11316-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5/uDoXvLw7AC5HRs"
Content-Disposition: inline
In-Reply-To: <20200706171454.11316-1-vidyas@nvidia.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5/uDoXvLw7AC5HRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2020 at 10:44:54PM +0530, Vidya Sagar wrote:
> Re-order Tegra194's PCIe aperture mappings to have IO window moved to
> 64-bit aperture and have the entire 32-bit aperture used for accessing
> the configuration space. This makes it to use the entire 32MB of the 32-b=
it
> aperture for ECAM purpose while booting through ACPI.
>=20
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra194.dtsi | 36 ++++++++++++------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

I've had to manually apply this because it conflicts with some of the
cleanups I've been doing to the DTS files. I'll push it out later, so
it'd be good if you could check that I've applied it correctly.

Thanks,
Thierry

--5/uDoXvLw7AC5HRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl8Ncu0ACgkQ3SOs138+
s6E9+w/+JjZPchwPj6idBmuMBbMOr4W0imsNtOOmtge31wagIjngpHj1pNYFjZ42
qAgefyMb30w8IWMP8tkKHby4+UOXYE9mb6lqiertUynhPRCQDVu1+o3oWPRnmFd6
ajnTN7/9ZhXJ83NmYm/h+0Zqk/2mvg6P2DjAdOkw2ioYGmfI9g6gBh6E5ypoC+sV
Lr5VntibAYLU8+zGjkfg4yyMHHM/ljG4h6F/ybVdfkM0kqomUMkE7TcustiXXosy
pdwUv53VDf2z1FRs7UbXzZSXY8G7Xo9ZarbUtjpf5+iOr1uys484/PU60qtAY0MC
gaWp7qRtkYVDjJUNrWKGF8H0P5BNKRPQ8Nd9dyBP/QMhos8e78C6SaWHTbdCJhXr
FHys9ND/Lvv9lBEq8zG+WvDuhZlbAzjYv0mQ0qn1lDQS45ObJsxnj2Ztg8q91K4W
gWBmNyiltbRGlSYMFDeWSbvSK7PBNzrg0If3GOh2Ok5nQb3DlxQIBjmnTGeVPrv7
lS5VjzyLQgxhsoTGURMBLqFICKV5gtNBhMc6FGMzK5QCcjgzdzlP6HeO/feXhYnn
28gsh8VzOVdIkoyMLZljOp4XsNiQi2sEnG6jGJZjaIB/bt3di/hT0IZkSVt+EjK/
ilRWmKI08vgWXbM+EnVILaUJDVHN50Zqi41IYhWhyEMaReFdf6s=
=jJwZ
-----END PGP SIGNATURE-----

--5/uDoXvLw7AC5HRs--
