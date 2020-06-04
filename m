Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C846FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C9E206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591268883;
	bh=eTEAmGjGSlWnzcnOKFQiS8dTWRfxZH+7OAjcn0kr0Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EgAjHcLu+3MPNQOECl9vbTVd9bBvd1NSP0sPRE3yJXzkwRRGmTftPevjI1v/Hof4R
	 oFJw0MrTPBPw6WLRwXNmBbIju4rMFbw4RRT0naiPwti8jumCDlMBKdoVQxdV1Z2Han
	 NqhJ1GRDtu7jggHpfY9vDq2V5UPidgJ+rD3SAMbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgFDLID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 07:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgFDLIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 07:08:02 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F86206A2;
        Thu,  4 Jun 2020 11:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591268882;
        bh=eTEAmGjGSlWnzcnOKFQiS8dTWRfxZH+7OAjcn0kr0Kg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qw4fDdykcM50sBDnvZFz8ujTWO5HHLehn4Pmqojr1ydXIt2SB2pdJj1zT159eiqaM
         sP2m9cOaVOMotCa+rhYSyhv83SF7VEsBGip5og8J1/pyUZZ410mFI9nRAblA+dPdtd
         tqSuRBURSWWQ6ev2UT2GZ5QMEqzEv96nOwXPP8vY=
Date:   Thu, 4 Jun 2020 12:07:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Keerthy <j-keerthy@ti.com>,
        Axel Lin <axel.lin@ingics.com>
Subject: Re: [RFC 1/4] regulator: lp87565: enable voltage regardless of ENx
 pin
Message-ID: <20200604110759.GB6644@sirena.org.uk>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20200603200319.16184-2-luca@lucaceresoli.net>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2020 at 10:03:16PM +0200, Luca Ceresoli wrote:

> I suspect the only solution that allows to configure the EN_PIN_CTRLn bits
> correctly in all the possible hardware setups would be to tell in device
> tree / board info whether each enable pin is connected or not (which is a
> hardware _fact_) and which ENx pin should control which regulator output
> (which is a policy). But it would make this simple driver considerably more
> complex.

> Any suggestion about the correct way to handle this situation would be
> greatly appreciated.

We can tell if we've got a software controlled GPIO connected, if we
have then we should ensure that it continues to take effect.  That
should just be a single register write at startup from the sounds of it.
Otherwise yeah, just ignoring that there's a possibility of a GPIO we
don't know about seems sensible.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Y1g8ACgkQJNaLcl1U
h9DAGAf/TXyd1JDYoZwYOO3EMr8gkAhvnwUOVgd59xjYbnKmd4YfOuZn8VYjIbP3
C10/tz9k4n4WCg9PtBmUAIrE6tdV0Uj5ZNyhRd51GV+khJrvkq5jLWSyywqZ0jja
hHz7Mbolyr5irTqEkU0kq9ls/O/S5eZjEVRbnfnPuBNlrGifTq52LjMpn3cFW6EF
wnhGuYmk9vuhtX+CFl7qDzAi2MI2JNpdlYrN28pCqUYe12F1s4Ot1XL7DVbtxp/9
6XmFB3ZwUS3h4MuC/+tbn9Q7itTTRefqVZjldvin5LbE1lRKvpsxWS8TBATGpNtH
XqBWCXprfS/vHMESAwnoUbpcvLoN1w==
=Ur0E
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
