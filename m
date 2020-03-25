Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F420C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048B2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OupybIii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgCYV1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:27:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39364 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:27:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id a9so4740070wmj.4;
        Wed, 25 Mar 2020 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j2/1Dbn9ytplycMiraI7qSjXKdTbS/HlaoeByMQZV30=;
        b=OupybIii4o5OC8/8iCCIWB8RYTtd2SRNfJChHHgxLUrgHbSQpANM3JuPbDY8cmDsWO
         L9TSkrUeJRAFB7N8w1wIqkflf5ZnE8TFGPZKJsNIhBVFxyY2fP65Y1Rf+fuRpFDF6BhZ
         780f4HuCXjqsdoJI4Zc0LmlaNjocvXu0m8jjJkcah8rekQ0h4Q0Iuj/YvIjWBL/bxtfI
         +a6bwoK8LexzG87oMU9rS6Z+25UQRe/9kkDmIFksKZ8jjLNPnUafYVSvIUtCnivYCryY
         opNjZ8UpQcux8KjwuZ0DOsBVGcRcQzLIKpvEOmBk8gfWVq0zkbWzonUETRfeuZm1/zBH
         I/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j2/1Dbn9ytplycMiraI7qSjXKdTbS/HlaoeByMQZV30=;
        b=rJhhxy/mtcBjpQ9FBTu+7yh703hoJlPQ5kkAoMmUdfZBU1CpDWw9xfOvcwwOv5rLBl
         vJzkJD7P1Skatx4cXiS4I8v5CGnFP3+AUDU5VnE5N+d725dezy6zR17FvV4K9eqFlO04
         xghONIfxatR5yITIqU+rlZxrVOW7WrTFSE8xTzvNh+v1bpGlQboIDOgOxQNhHAngq4IC
         yL8kZkuLM1FxD66boIFA/pr1qBRYoQGjCXCoDwVJF5bjKyTBgIiDdVXOG/iP0qOu6bg6
         yMJ/wEuB0pwsECwnuCZSX1HJCqjyTcKsSh2AItX0iOmXEybpeLv76HagCY62SN7aQ7nN
         uRYg==
X-Gm-Message-State: ANhLgQ0W5Qh3gXSnuNcCG6GYxB8qNyU5ATnwdF9+YpAgpptRJ9aYKdhb
        ogPbuzm+WLhc4HQ1h1ZccmY=
X-Google-Smtp-Source: ADFU+vuCKeFMo1LEunZD98eUjX6VM0bC6khR8nzBxytY1ME/zCO9aGl5H0izZ8Hh2thLagL4h9kYsQ==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr5654579wmj.156.1585171631851;
        Wed, 25 Mar 2020 14:27:11 -0700 (PDT)
Received: from localhost (p200300E41F4A9B0076D02BFFFE273F51.dip0.t-ipconnect.de. [2003:e4:1f4a:9b00:76d0:2bff:fe27:3f51])
        by smtp.gmail.com with ESMTPSA id b82sm401960wmb.46.2020.03.25.14.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:27:09 -0700 (PDT)
Date:   Wed, 25 Mar 2020 22:27:08 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>, jonathanh@nvidia.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/22] Move PMC clocks into Tegra PMC driver
Message-ID: <20200325212708.GA836215@ulmo>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2020 at 11:24:05PM -0800, Sowjanya Komatineni wrote:
> This patch series moves Tegra PMC clocks from clock driver to pmc driver
> along with the device trees changes and audio driver which uses one of
> the pmc clock for audio mclk.
>=20
> Tegra PMC has clk_out_1, clk_out_2, clk_out_3 and blink controls which
> are currently registered by Tegra clock driver using clk_regiser_mux and
> clk_register_gate which performs direct Tegra PMC register access.
>=20
> When Tegra PMC is in secure mode, any access from non-secure world will
> not go through.
>=20
> This patch series adds these Tegra PMC clocks and blink controls to Tegra
> PMC driver with PMC as clock provider and removes them from Tegra clock
> driver.
>=20
> PMC clock clk_out_1 is dedicated for audio mclk from Tegra30 thru Tegra210
> and clock driver does inital parent configuration for it and enables them.
> But this clock should be taken care by audio driver as there is no need
> to have this clock pre enabled.
>=20
> So, this series also includes patch that updates ASoC utils to take
> care of parent configuration for mclk if device tree don't specify
> initial parent configuration using assigned-clock-parents and enable
> audio mclk during utils init.
>=20
> DTs are also updated to use clk_out_1 as audio mclk rather than extern1.
>=20
> This series also includes a patch for mclk fallback to extern1 when
> retrieving mclk fails to have this backward compatible of new DT with
> old kernels.
>=20
> [v8]:	Changes between v7 and v8 are
> 	- v7 minor feedback
>=20
> 	- Audio mclk is needed only for audio, but there is some unknown
> 	  dependency of audio mclk and suspend-resume on Tegra30 where when
> 	  mclk is disable, suspend-resume doesn't work.
> 	  So v8 undoes v7 change of mclk enable and disable during machine
> 	  startup and shutdown and keeps audio mclk enabled in ASoC driver
> 	  tegra_asoc_utils_init.
>=20
> 	- change in the patches order.
>=20
> 	  Note:
> 	  - Patches 1 thru 5 are to change CLK_M_DIV clocks to OSC_DIV clocks.
> 	    OSC_DIV clocks uses same ID as CLK_M_DIV clocks during the
> 	    transition to replace CLK_M_DIV with OSC_DIV.
> 	  - Patches 8 and 10 registers pmc clocks as pmc_clk_out_1/2/3, and
> 	    pmc_blink to avoid using same clock names as pmc clocks from
> 	    tegra_car provider to have them functionally work with all the
> 	    transition patches.
> 	  - Patch 11 adds audio mclk fallback to extern1 to have new DT work
> 	    with old kernels. This patch need to be back-ported.
> 	  - Patch 18 adds audio mclk parent configuration when DT doesn't
> 	    specify parent configs. This patch retrieves pmc_clk_out_1 as audio
> 	    mclk so added this patch after all DT updates to use pmc clocks
> 	    from tegra_pmc.
> 	  - Patch 19 does audio mclk enable during utils init to have it
> 	    enabled all the time.
> 	  - Patch 20 and 21 removes PMC clocks from clock driver and their IDs
> 	    at the end of PMC clocks transition to tegra_pmc.
> =09
>=20
> [v7]:	Changes between v6 and v7 are
> 	- v6 minor feedback
> 	- Added DT id for Tegra OSC to use in device tree for pmc clock
> 	  parent.
>=20
> [v6]:	Changes between v5 and v6 are
> 	- v5 feedback
> 	- Added ASoC machine startup and shutdown callbacks to control audio
> 	  mclk enable/disable and removed default mclk enable from clock driver.
> 	- Updated tegra_asoc_utils_set_rate to disable mclk only during PLLA
> 	  rate change and removed disabling PLLA as its already taken care by
> 	  pll clock driver.
> 	- Removed tegra_asoc_utils_set_rate call from utils_init as set_rate
> 	  is set during machine hw_params and during utils_init mclk is
> 	  already in disabled state and this causes warning during mclk disable
> 	  in utils_set_rate.
>=20
> [v5]:	Changes between v4 and v5 are
> 	- v4 feedback
> 	- updated dt-binding pmc YAML schema with more description on power
> 	  gate nodes and pad configuration state nodes.
> 	- update tegra_asoc_utils_set_rate to disable audio mclk only if
> 	  its in enable state.
>=20
> [v4]:	Changes between v3 and v4 are
> 	- v3 Feedback
> 	- Updated clocks clk_m_div2 and clk_m_div4 as osc_div2 and osc_div4.
> 	  Tegra don't have clk_m_div2, clk_m_div4 and they should actually
> 	  be osc_div2 and osc_div4 clocks from osc pads.
> 	- Fixed PMC clock parents to use osc, osc_div2, osc_div4.
> 	  This is not a functional bug fix but correction to use proper parent
> 	  name.
> 	- Register each PMC clock as single clock rather than separate
> 	  mux and gate clocks.
> 	- Update ASoC utils to use resource managed APIs rather than
> 	  using clk_get and clk_put.
> 	- Updated device tree and ASoC driver to use clk_out_1 instead of
> 	  clk_out_1_mux as PMC clocks are registered as single clock.
> 	- Update clock driver init_table to not enable audio related clocks
> 	  as ASoC utils will do audio clock enables.
>=20
> [v3]:	Changes between v2 and v3 are
> 	- Removes set parent of clk_out_1_mux to extern1 and enabling
> 	  extern1 from the clock driver.
> 	- Doesn't enable clk_out_1 and blink by default in pmc driver
> 	- Updates ASoC driver to take care of audio mclk parent
> 	  configuration incase if device tree don't specify assigned
> 	  clock parent properties and enables mclk using both clk_out_1
> 	  and extern1.
> 	- updates all device trees using extern1 as mclk in sound node
> 	  to use clk_out_1 from pmc.
> 	- patch for YAML format pmc dt-binding
> 	- Includes v2 feedback
>=20
> [v2]:	Changes between v1 and v2 are
> 	- v2 includes patches for adding clk_out_1, clk_out_2, clk_out_3,
> 	  blink controls to Tegra PMC driver and removing clk-tegra-pmc.
> 	- feedback related to pmc clocks in Tegra PMC driver from v1
> 	- Removed patches for WB0 PLLM overrides and PLLE IDDQ PMC programming
> 	  by the clock driver using helper functions from Tegra PMC.
>=20
>  	  Note:
> 	  To use helper functions from PMC driver, PMC early init need to
> 	  happen prior to using helper functions and these helper functions are
> 	  for PLLM Override and PLLE IDDQ programming in PMC during PLLM/PLLE
> 	  clock registration which happen in clock_init prior to Tegra PMC
> 	  probe.
> 	  Moving PLLM/PLLE clocks registration to happen after Tegra PMC
> 	  impacts other clocks EMC, MC and corresponding tegra_emc_init and
> 	  tegra_mc_init.
> 	  This implementation of configuring PMC registers thru helper
> 	  functions in clock driver needs proper changes across PMC, Clock,
> 	  EMC and MC inits to have it work across all Tegra platforms.
>=20
> 	  Currently PLLM Override is not enabled in the bootloader so proper
> 	  patches for this fix will be taken care separately.
>=20
> [v1]:	v1 includes patches for below fixes.
> 	- adding clk_out_1, clk_out_2, clk_out_3, blink controls to Tegra PMC
> 	  driver and removing clk-tegra-pmc.
> 	- updated clock provider from tegra_car to pmc in the device tree
> 	  tegra210-smaug.dts that uses clk_out_2.
> 	- Added helper functions in PMC driver for WB0 PLLM overrides and PLLE
> 	  IDDQ programming to use by clock driver and updated clock driver to
> 	  use these helper functions and removed direct PMC access from clock
> 	  driver and all pmc base address references in clock driver.
>=20
> Sowjanya Komatineni (22):
>   dt-bindings: clock: tegra: Add IDs for OSC clocks
>   clk: tegra: Add support for OSC_DIV fixed clocks
>   clk: tegra: Add Tegra OSC to clock lookup
>   clk: tegra: Fix Tegra PMC clock out parents
>   clk: tegra: Remove CLK_M_DIV fixed clocks
>   dt-bindings: tegra: Convert Tegra PMC bindings to YAML
>   dt-bindings: soc: tegra-pmc: Add Tegra PMC clock bindings
>   soc: tegra: Add Tegra PMC clocks registration into PMC driver
>   dt-bindings: soc: tegra-pmc: Add id for Tegra PMC 32KHz blink clock
>   soc: tegra: Add support for 32KHz blink clock
>   ASoC: tegra: Add fallback implementation for audio mclk
>   ASoC: tegra: Use device managed resource APIs to get the clock
>   ARM: dts: tegra: Add clock-cells property to pmc
>   arm64: tegra: Add clock-cells property to Tegra PMC node
>   ARM: tegra: Update sound node clocks in device tree
>   arm64: tegra: smaug: Change clk_out_2 provider to pmc
>   ASoC: nau8825: change Tegra clk_out_2 provider to tegra_pmc
>   ASoC: tegra: Add audio mclk parent configuration
>   ASoC: tegra: Enable audio mclk during tegra_asoc_utils_init
>   clk: tegra: Remove tegra_pmc_clk_init along with clk ids
>   dt-bindings: clock: tegra: Remove pmc clock ids from clock dt-bindings
>   clk: tegra: Remove audio clocks configuration from clock driver

Liam, Mark,

there's a few runtime dependencies between the various patches in this
series, so I think it'd probably be best if I picked up the ASoC patches
into the Tegra tree and let them soak for a day or two in linux-next to
make sure everything is there and in the right order.

Do you mind if I pick them up and send to you as a pull request in the
next few days?

If you'd prefer to pick these up yourself that should be fine as well.
They've all got acks from me and the runtime dependencies are causing
annoying, though harmless, warnings during boot, so I think it'd be fine
as long as all the patches end up getting merged for v5.7-rc1.

If you do decide to pick these up yourselves, please omit patch 11 in
the series since that doesn't do what it's expected to.

Thierry

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl57zKkACgkQ3SOs138+
s6Eofg/6AzZGzQ4CTqgVrFQ5zZqjgotIQAHd6yuXPYMhMdnhO+DavwWbTbXUjRCu
qlGM5mkAiuHFDyDYYWvH0QoEGATbsQL4rUABTHMi39p9pE+oOXqoLbDy7RvPiJs3
c7Fmt47VKnhC/yEH6a/Z+Pw9lWkPk08ee220O+oqEUqXCRJKwpHt2YVFAMVpCiH2
kvPd3s8iQpMPBv2WxKBfl/9wky8jYVkkrczLbHfg74p+lcyvOGXbhbvvjCg/W0XA
XwgFXXMaJZ0p4GHqPZj3MLQAzBsWaDLLCbjhAVVsUyfjtS43BOl37Yt95XfASBDF
yqVL25+L71lOWC5paPK0Os/chaA8uyaNEE9mNR9EMiA8hxyXwXxhtwhfg0OkXWKR
AYDamsQjllCQOcpB+YuX+cRtyzthRkeYOsnBPf6HZn8pdKa4ZqybP4OaTSnOe0KV
4pPYzMbUnJafaX5dVXa8WCC/dTCNsSP9vznbXiVvqaN+zH+TmbTDT6biReoOO6io
+Ce7iBCm7HTQeLVD8pTsjSGsHskR89x6ZZGTQqARjfJpqIN5BWeO7hXzQSP/S0zp
bsF8YMgJyL2bd9r6HM1pYAUYagIyI1h8z9vzuXbB3lDTZFWIRrI9JuREmTg2Ydby
7mTrmUyNWiYstLA4hlsoQzwKe6IX/t2WPzeFSyYdKPBGsHPshH0=
=RTq4
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
