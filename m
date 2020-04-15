Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E0FC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F009D20936
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586967917;
	bh=AYPtS0WYn7H0E9PHyEfI6x2/DOj+Yai+eeorng2znKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxplT6CCB8kw7apAql415yw7bXbtfdOMOLr9OwIZTZyvqqKglT58l0y8h0thytgio
	 RFDxT1BIXAF+vUSNzTKREqWyqQVsCdsIJfTU+e82y7hXgLAub3S93i0FgOC+jXLEJh
	 /P93kU5Syl9xXQPC5mVLZNktMyLD9vjuxTt4zACs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415774AbgDOQZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415766AbgDOQZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:25:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F0A2206F9;
        Wed, 15 Apr 2020 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586967909;
        bh=AYPtS0WYn7H0E9PHyEfI6x2/DOj+Yai+eeorng2znKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLk1w3TmchJiUPIe10WuPbeSkMldK/0Wq18qjxpzYBAl3uQY4SqrCC/8Bv7D4tVvD
         TEmkSlnhTOw0Rokgd9YNTV78Ne4d/VRzuLuE4soUhGi9hUm3yKoNoL9rLi1XdgRaH4
         sMqE69DntHmURf7FN2A7K9yihVim0wjoENhwK1Mo=
Date:   Wed, 15 Apr 2020 17:25:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 8/9] ASoC: rt5645: Switch DMI table match to a test of
 variable
Message-ID: <20200415162507.GG5265@sirena.org.uk>
References: <20200415145524.31745-1-andriy.shevchenko@linux.intel.com>
 <20200415145524.31745-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20200415145524.31745-9-andriy.shevchenko@linux.intel.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 05:55:23PM +0300, Andy Shevchenko wrote:
> Since we have a common x86 quirk that provides an exported variable,
> use it instead of local DMI table match.
>=20
> Note, arch/x86/kernel/quirks.c::early_platform_detect_quirk() prints
> the detected platform.

> @@ -3674,13 +3675,6 @@ static const struct dmi_system_id dmi_platform_dat=
a[] =3D {
>  		},
>  		.driver_data =3D (void *)&intel_braswell_platform_data,
>  	},
> -	{
> -		.ident =3D "Microsoft Surface 3",
> -		.matches =3D {
> -			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
> -		},
> -		.driver_data =3D (void *)&intel_braswell_platform_data,
> -	},
>  	{

Are we going to convert all the other platforms to using a variable too?

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6XNWIACgkQJNaLcl1U
h9CV0wf/em9G/ERwnZy11DLRg2vrxZxULM/L8dpShtUtkEt3v/SYJ85NTVR9CAJD
vjbPS3J/WeRpLmdCalBk8O/QTApngJnK/q4xz0v+/qaYTWQYwlE+NXvsHa1l70Fb
v5H1hEMwq+2ZeDv3TwU0yAuDK2HlC/IDlppdWDGT5k5tQDAaCVzbs8sMm8fbCa2b
avEyI1dX3f9ovT6qZUiFEhudRVXLKrb56f7pecBIXtP/jalNrZ8MtKGxNHgDzDzf
tpXHfW9UH+7cvEn2ZShxvm6O++ye1gmRlzfnHLtf0Y7qlGN1dTVlVgJ2Vw1DubvW
9SJPbBT5dfSidGq/aedmAqzpVbddKQ==
=HWhC
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
