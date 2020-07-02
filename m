Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288CEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 002E820899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593700310;
	bh=yoiiIk8yV7aQeMBE6eGjgWhzrgZn5o4MtsX81urPOGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XalUxhvHcBJQ0mpRAw8UoznVcs21MjTR47U6oRUDDz7XVXEc2Nzpw+eJF4BTQxYXq
	 8hOVMIy6D1RvSMZ4AhnOhKy3052Mmg/FWhHDEPeUGOJtyKlAQRrlOIcpe4B6hgpv7Q
	 xBt0m9a2X2s7PGPmOmT37lTtf++lguKGy7uwj+G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgGBObs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:53090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgGBObs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:31:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1424320890;
        Thu,  2 Jul 2020 14:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593700307;
        bh=yoiiIk8yV7aQeMBE6eGjgWhzrgZn5o4MtsX81urPOGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rh0X/EYuSOXjJd7IZLHAt5PjkHiHVaHXBUckRAW9ESHhInCw6Awe+B4EfTXfWCHVB
         7EktAmVfcIb68os9+HU0zTIMMK2vVgmbUxpjkhl/15jB1bAUYaB/mh6tZxA+Kca9Kt
         8pgI/1MrVOnWgvLgGpKz3zSZFCNbIk1mawQLAFq0=
Date:   Thu, 2 Jul 2020 15:31:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: fsl-asoc-card: add new
 compatible for I2S slave
Message-ID: <20200702143145.GG4483@sirena.org.uk>
References: <20200702141114.232688-1-arnaud.ferraris@collabora.com>
 <20200702141114.232688-2-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Content-Disposition: inline
In-Reply-To: <20200702141114.232688-2-arnaud.ferraris@collabora.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2020 at 04:11:14PM +0200, Arnaud Ferraris wrote:
> fsl-asoc-card currently doesn't support generic codecs with the SoC
> acting as I2S slave.
>=20
> This commit adds a new `fsl,imx-audio-i2s-slave` for this use-case, as
> well as the following mandatory properties:

Why require that the CODEC be clock master here - why not make this
configurable, reusing the properties from the generic and audio graph
cards?

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7979AACgkQJNaLcl1U
h9AxkAf/ayvMQ6Irjwi6oOAqWBxCV2VEySnpQQvROq2t4wDxz2MOOXIE0fZfwg0F
I7UlRDnm9ZyWwq8Dol9pigToIxzfz/G0rxJ0F3jTr5qo/1lt+hFMmdlghcl0T37v
4OP2CPBwJtmavd2mM06870/eXQKtmd3jwRXJ2HKljt9ZSuHVcyOk0t+ZaR0zYD+V
1AvChO6mvUipSO7A82pchm57qOKdBv7SpIGtHf4wsc+MFuEFJYaOtjfCwTrFvB1B
kPACxzQBG4l4xgQtN803PNAZbjbZCBGusst8v4Kpygbpq5OjuhFMJ4xHUVcxHPVk
y4i45+Yv7ceu+GohmwdxDGKnszmETw==
=uElK
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
