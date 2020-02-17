Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E224AC761A1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB1520725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtv4hX1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBQJzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:55:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33172 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgBQJzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:55:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so18917845wrt.0;
        Mon, 17 Feb 2020 01:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1vYoVITY3PvpgoA2jpxQdg1bUk5Vwj9BOtmBhApMv5M=;
        b=mtv4hX1+2PxR3HckZP9zsphRYwnFZnzKMhWenU9wDG0Jc1IhAW++Ma10zY5SobsE14
         LD0GT9AHtKDJivDHwvL65mVjf1uvTUt1CExJkDq18djvjaFSeeqXSl/ntT9kjhg1R39o
         BIV5HZXlOKRxLsZrU21kn0xGzSbdm0s8JkXzXFeQM9cwDXUFyuK2BhVpCKOSnigf3jSW
         oMLXwxTOE4qC70+6ZtEX37V+LwpvCSypnr83wFzXbi+fQtXTFjjaGRBw5iW56ORlLu3t
         GO6QgHDLE6/I+0eBGZoLeabXPv5Ye/hHR9wXYyPu6foqqv8WQ+xREj4H7h8ibqu4LaS6
         Q56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1vYoVITY3PvpgoA2jpxQdg1bUk5Vwj9BOtmBhApMv5M=;
        b=VQJ2SfxZtvmC458GsBuHzYhN5ZmewfgqLOa9MUwkWPH28L2TCVDp1PgBkRvVKhgKi/
         FLI77uSek0g9GPOmxOLjLYY8xp2HslZDiipKyVbrk/vRBBGzj6MbrgJFAIR4NgOzJJwp
         HU/yOCD/HWlkAaeIPCvYVTQGhJNXvS/D6jvqYrw7E5lUap8qQMtvCcAbZG3nOVDd6yyn
         UJt7fv4R5ptozRz7MXTPrRcdYVJVyMYxFc5UV2mfFJtYAoSh40X9cse14J+7g1GFcDGZ
         U2wZm9r1Qjkgkq9wBJxbkHiKj3g27sM+5Xgp49ElsBrq79BFPQKcgBXBz+QGbvzDPzrE
         8BeA==
X-Gm-Message-State: APjAAAUdjxiqggCHlFF29Dvnu2atSaOls05QFF9jrDwJzoz45OXJHWSw
        Lc8rQ/W0EEbC293lCvV1U6A=
X-Google-Smtp-Source: APXvYqwKkHqlxM5Mxjv5X4dV1ACYTlR9iKdefWg/n87A9Dx/aXV+S1YP2YhV6XZWb2Oi9458BTSw+g==
X-Received: by 2002:a5d:4e91:: with SMTP id e17mr20235443wru.233.1581933351905;
        Mon, 17 Feb 2020 01:55:51 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id b67sm20248235wmc.38.2020.02.17.01.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:55:50 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:55:50 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 20/22] clk: tegra: Remove tegra_pmc_clk_init along
 with clk ids
Message-ID: <20200217095550.GD1345979@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <1578986667-16041-21-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-21-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:25PM -0800, Sowjanya Komatineni wrote:
> Current Tegra clock driver registers PMC clocks clk_out_1, clk_out_2,
> clk_out_3 and 32KHz blink output in tegra_pmc_init() which does direct
> PMC register access during clk_ops and these PMC register read and write
> access will not happen when PMC is in secure mode.
>=20
> Any direct PMC register access from non-secure world will not go
> through.
>=20
> All the PMC clocks are moved to Tegra PMC driver with PMC as a clock
> provider.
>=20
> This patch removes tegra_pmc_clk_init along with corresponding clk ids
> from Tegra clock driver.
>=20
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/Makefile        |   1 -
>  drivers/clk/tegra/clk-id.h        |   7 ---
>  drivers/clk/tegra/clk-tegra-pmc.c | 122 --------------------------------=
------
>  drivers/clk/tegra/clk-tegra114.c  |  17 +-----
>  drivers/clk/tegra/clk-tegra124.c  |  33 ++++-------
>  drivers/clk/tegra/clk-tegra20.c   |   4 --
>  drivers/clk/tegra/clk-tegra210.c  |  17 +-----
>  drivers/clk/tegra/clk-tegra30.c   |  18 +-----
>  drivers/clk/tegra/clk.h           |   1 -
>  9 files changed, 19 insertions(+), 201 deletions(-)
>  delete mode 100644 drivers/clk/tegra/clk-tegra-pmc.c

I think it's best to defer this patch (along with 21 and 22) until all
the others have been merged to make sure we don't regress. Other than
that it should be fine to apply the others in any order, right? Well,
maybe not any order, but at least the ASoC patches should be able to
go through the ASoC tree without impacting functionality, right?

Thierry

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl5KYyUACgkQ3SOs138+
s6HuCQ/9E10KCNy0iUunarGxx9oFFB+Di1Syr9q5oCVlhGsTqb0+10ggogn9cGrH
M9KP91Us7fdSLarDIL4cbSKiSVsHWEbRLMLZaesgO4fN6vpO7ERknHM5bsEdaBcf
/CQb0HnCNHwZ9oMbJ2l5nWrWmdzL0VR3QxqDm19MBl4pBSZjsyHytQr5TWObF1RZ
G9s9wdnbVP71dqTNxYy4F1+I4V7dDG4hvQ5uCruJK4nhQq1yJqJhTXJxT+OdtXbV
GBcl548K1e0zfxN8PRJ07I6LEA5LWr13VWIB6vYncYcRsyabe//W5peULJqGzteK
j19SHWLh1yHnl+uu0i3ogBnPDesS0g+yd6GRYjeSozlnHyRotr9rF7nhuGP48Ynf
zORxISb+zK/uklAKxn74mOBgYFSZacy+QgwwvRjb0JCvNLdLJRgmHOb3PBfL+HLU
IyrCKzpCw+4SjAdf6qXbv2ge4LEcccrtWxj8R3zAf4p9sDS+2NmqvuS+3vFYaKjS
7gfdkYrwh0wLBeT7IRn3t1MPd5aXSyH5vP07WyfP1X/v/+D12M9TFF5KFqFPz1Ml
uBFPAodiAcDuSo5Mc8Mu4y2xxGpWWd8LgJVyQuv7xpf0VW4uIBabi+hC6NwrzFKo
jXwI0TPX6+GFe65DRv0ZKWVoPyGx6U9ECN7mRgs/wKhPzXB6bcI=
=mBSp
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
