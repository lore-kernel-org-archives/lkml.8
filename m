Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9974206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725546;
	bh=J8tlTkffI9vT+ZtetPjpRh4/bBL9Hh7emd0zTozTyXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RqexkgC14b87B/EZZNj9WG5BsCoqFuXQW9nVGBoZD2PH0ooGeURfl+5f/58m9cZ24
	 jByd5NK/IuMdqawxoeSlbw3t+E+aVuu9W0iKy5PhYuGLnIOlm00FzJ/D8mh63R0a19
	 CoLpDJ5M1Hnz+cUtXzyRgRbbOL7HsicwJb9KkdsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgFIR7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731651AbgFIR6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:58:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 777A720801;
        Tue,  9 Jun 2020 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725535;
        bh=J8tlTkffI9vT+ZtetPjpRh4/bBL9Hh7emd0zTozTyXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qF1dpbq4r6LixfMDbilCvEkZ/h6ZYJ1hJewkW/W1R/P4ihpjzb1aQ6Vqyu57/RnlE
         1SXfvJeSswwlhZftcwITa7SGOlKrsZaPDX+PAwZ0JDQDw7COQCJH0tNaPuFmyJDIZ2
         y1et7/fTJBDLN5J5sfQf0qMqwE6qExDOFqlvAYFs=
Date:   Tue, 9 Jun 2020 18:58:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200609175852.GQ4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JaBjgNvtdKe5H086"
Content-Disposition: inline
In-Reply-To: <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JaBjgNvtdKe5H086
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 12:35:50PM -0500, Dan Murphy wrote:
> On 6/9/20 12:31 PM, Mark Brown wrote:

> > Why not just use a standard name for the firmware?  If the firmwares
> > vary per-board then building it using the machine compatible (or DMI
> > info) could handle that, with a fallback to a standard name for a
> > default setup.

> The number of firmwares can vary per IC on the board itself.=A0 So you may
> have X number of firmware files all with different names all targets for
> different TAS2563 ICs.

> Also TI will not be providing the individual binaries to the customer.=A0
> There is a customer tool that the user uses to create the binaries.

> So the output names are arbitrary.

> I was going to mention this in the cover letter but did not think mention=
ing
> the user tool had any value

That's all fairly standard for this sort of device.  You could still
cope with this by including the I2C address in the default name
requested - do something like tas2562/myboard-addr.fw or whatever.  The
concern here is that someone shouldn't have to replace their DT if they
decide they want to start using the DSP, and someone making a distro
shouldn't be stuck dealing with what happens if multiple vendors decide
to just reuse the same name (eg, just calling everything tas2562
regardless of plastics).

--JaBjgNvtdKe5H086
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fzdsACgkQJNaLcl1U
h9BKVQgAhwdvHDREJ2LZnjNuwAcY2lCGKrqH/sZ5zCuez+GTC3OioTnr1/2fRJP3
oeO4H/IRo6/PsE6dhcl48e+/CVM8p9IBC4J7eLYtvwC3iOd5qZGUXq1HqoYQaYYp
cJ22lWuYmG6EXPtcTM7eflfBIEdgbluyeksxIc1WSTccPFpEOkc8tElhlNN4eowI
34B18qXdsfvX3eOghVWTAD/IoyTPmyvWLzOkrRSpk+oPKsiqJnx0g7wEAg95sBKg
luhCZTAe1gaTpMC44kBIMN1ZVd22wZIGCJqXKY434H4xiVImRvv2/uqxbm0GsQQy
4Wqt+BFO7MwvkNsDYTTFA/Uj8xQ++A==
=re6H
-----END PGP SIGNATURE-----

--JaBjgNvtdKe5H086--
