Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0266C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0207206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594117859;
	bh=eWilmxL1Pp5afMTknP+I9u/CgSUT6XCuGkQ3LcJjx+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g9PDas3+ti2SZSzFNW50OgZhhr9t85tDJ4Nh7idB9GLXPA27SW7ppI2Ttp+LAHDM/
	 t1RCEFQWgfXEwEG7TYhow2IJJw4qmxG1pQpHsh9T6FGKdWbvPUqtYRj35WaFaAsG0/
	 AGp/TuX1o2vPyYWjbbWGtha5gCKVUk4m9PYO3c4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgGGKa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:50668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgGGKa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:30:58 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB582065F;
        Tue,  7 Jul 2020 10:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594117857;
        bh=eWilmxL1Pp5afMTknP+I9u/CgSUT6XCuGkQ3LcJjx+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tvG/T9F7afny7pIuP/iUdkoeTgIxUliBMpmWH/65CxrDm0Bp1+wvuPzMdijN5LkeD
         vCLXbP8KtNdtkYG4dQjLuKYiTn5DXSNsMeDSlksYoO4zRPYv1QOEt3e2JRaWu5OiPJ
         DTWLAUrFxK8QPQk87x1aLNKvk53EHwvdbXIhfkNs=
Date:   Tue, 7 Jul 2020 11:30:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5682: Add fmw property to get name of mclk
Message-ID: <20200707103053.GF4870@sirena.org.uk>
References: <20200707100825.24792-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20200707100825.24792-1-akshu.agrawal@amd.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 03:38:25PM +0530, Akshu Agrawal wrote:
> Non-dts based systems can use ACPI DSDT to pass on the mclk.
> Thus add fmw property mclk-name to get the name of the system clk
> and link it to rt5682 mclk.

ACPI doesn't support clocks at all, you need to add a clock binding to
ACPI first.  The idiomatic way to do this would be to have board
specific quirks.

> +	device_property_read_string(dev, "realtek,mclk-name", &rt5682->pdata.mclk_name);
> +

No, this is not at all OK - you're adding this via a device property
which means that this will show up in the DT bindings too.

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ETtwACgkQJNaLcl1U
h9AN6wgAgo5at99d+D1JNkuzvhAbwOx+ZYmgFdlmbYCjbCSCW1rALhghF5kzFGTN
Jq+x6GVw0RX2O1hXNrNdhZdNTdRgxiZzOYMGbaLmnj9DSJj57hUEEynQhI0wOpRN
/vEG2xzLcd3B4wPhfv7uVzMcO4miHVIkY7RAEYnpeKD4fan0assPAjFJwUX0VCz0
D+qy3FGEpAulCk4HtidGRZVAIF1bsFehFrJc9FWurg2CGQDfyhn4BjVPci3eGl2j
Gwgr981VctOUltCO3nmMIeXUiAm4JMdBKb4BBpu13417GjFxXUpY0sPxhnHGmhgH
4t9vGlxY36bl2v6R1B5Y00Pkt30JJA==
=n+az
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
