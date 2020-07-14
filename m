Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7CC0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D23D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594758485;
	bh=O20GcOLOg0ZHMThXbLDLtb0d8nA0bfVDYgFNb7RkvkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yiRaRLRn18fSutsFEp7QSZ9B1Nf/mrv8s2QEQXC/dh3j2rW/4tLc+iXflPFiAVZQE
	 K/WYtvL4LE0tI8pX+FiV+L16BUP31vFdpd4pRLs1x5vpnxK2YZGyUN6MY2214iI8wM
	 rlsEhyYVrHILTPwysL714iadqNJ/DuvZJih0GVFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGNU2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbgGNU2D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:28:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09CD206F5;
        Tue, 14 Jul 2020 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594758483;
        bh=O20GcOLOg0ZHMThXbLDLtb0d8nA0bfVDYgFNb7RkvkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwYkfz5vHa0na1sEdlHRsjcxFA5xtFj89EgYrkqMn8rPUwU1u4UiTYO2ESyrq0LT7
         xE8GWdhqU8LkgcYvIcZPd9abQDDz8/RcPwC8Ly/ViIawesFSdMhUb/PTzEKCtFsNWv
         3H2HCwuRbAh86KdqQ+bhjXpeRZkITDAH9/eKWpmw=
Date:   Tue, 14 Jul 2020 21:27:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200714202753.GM4900@sirena.org.uk>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
Content-Disposition: inline
In-Reply-To: <20200714201544.GA10501@Asurada-Nvidia>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 01:15:45PM -0700, Nicolin Chen wrote:
> On Tue, Jul 14, 2020 at 06:20:32PM +0200, Arnaud Ferraris wrote:

> > Here's some background about my use case: the i.MX6 board acts as a
> > Bluetooth proxy between a phone and a headset. It has 2 Bluetooth
> > modules (one for each connected device), with audio connected to SSI1 &
> > SSI2. Audio sample rate can be either 8 or 16kHz, and bclk can be either
> > 512 or 1024kHz, all depending of the capabilities of the headset and phone.
> > In our case we want SSI2 to be the input clock to the ASRC and SSI1 the
> > output clock, but there is no way to force that with auto-selection:
> > both clocks are multiples of both 8k and 16k, so the algorithm will
> > always select the SSI1 clock.

> Anything wrong with ASRC selecting SSI1 clock for both cases? The
> driver calculates the divisors based on the given clock rate, so
> the final internal rate should be the same. If there's a problem,
> I feel that's a separate bug.

The nominal rate might be the same but if they're in different clock
domains then the actual rates might be different (hence the desire for
an ASRC I guess).  I can see the system wanting to choose one clock or
the other on the basis of some system specific property (quality of the
clock sources, tolerances of the devices involved or something) though
it's a rather fun edge case configuration :/ .

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8OFUkACgkQJNaLcl1U
h9DuHAf/TDGYWuygKrfJ8bywVG9u74SpJ9heHBWUzyeOwBeMmD2EcIZQTbcYbFy0
R2f5uRyhd5nQrLyrkVLq/o5HEgVV8Zpfi0OGQ25q5ehRQU3ni+8fkcHYtq3/uaI7
z8tQG2zuZiUDmN+thLC9a/H6SWEZSySVThHUsyFg+zU7WXVTmrMGnCIcjV5IlXPf
ErlMV1E0eWVn+Ti6rIYbG3RhGi7B4ATv3AY+0BT628Bel2zqknmTkFYH+SXMPspc
FzT/bvTQxCOOFl75BY8+qSS2H2MEVzdVSrhEEvopDBXCvspyHMMBX50CqcNJnFHc
4q3Oyckri7vWm5rmbqcwsCwbohRa0w==
=/XN2
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--
