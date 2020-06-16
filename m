Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C375C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B6942098B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592332216;
	bh=+U43ae00QtZYC2fRj8EXYkuee9mvOqEa/MSbVqqhQYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gXwyrp0t2JK0MHWKF/l/5X9BtLWapt/jB/8hz3oR8SL8ZcbuvYLPxxc2rIoaQgjDq
	 Hdee66zf3ad9xoXo/0VnDGb86i0WWIkoM+1l7DwlD/3T/MehrQBdCsnJANTDWZFP2I
	 pFMiG66KU6aEGJ4LdSZwpwafaxkIq9fEToPSPobI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgFPSaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbgFPSaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:30:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF769208D5;
        Tue, 16 Jun 2020 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592332214;
        bh=+U43ae00QtZYC2fRj8EXYkuee9mvOqEa/MSbVqqhQYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjSqoIQNikTyxryFm+WcT3xZez3p/YRVuJhuvyyKf0te9TU5v5Bsj1AQvUW26LrSC
         rb/jzIJ9n1CPh1t5FkOdVrO9lXkYNHGJ4WtbE99hTBz6BlAJIMd+/fBEYmPaB7+KSH
         RAH1d4wA7zmThijxkeq5mJoI/4RDgUrZrBQT02W4=
Date:   Tue, 16 Jun 2020 19:30:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/4] spi: bcm63xx-spi: allow building for BMIPS
Message-ID: <20200616183010.GV4447@sirena.org.uk>
References: <ea904b53-3f6f-da28-39f8-f811f432395a@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mwz/dta3oUwEdwoz"
Content-Disposition: inline
In-Reply-To: <ea904b53-3f6f-da28-39f8-f811f432395a@broadcom.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mwz/dta3oUwEdwoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 16, 2020 at 10:31:16AM -0700, Florian Fainelli wrote:
> On 6/16/2020 10:25 AM, Mark Brown wrote:

> >> In Alvaro's defense, you applied the patches despite me requesting that
> >> specific changes be made (use the optional reset control API variant).

> > I applied only the two patches that you'd acked, not the reset patches
> > which had problems.

> Indeed, sorry for not reading your commit message properly, I believe I
> request that before, cannot the "applied" response just reply with the
> patches *applied* and not *all* part of the series?

You might've mentioned it to someone else using b4 but not me - AFAICT
it's not configurable.  I can see arguments either way TBH, but I do
agree that the current output could be confusing and if nothing else the
wording could be better.

--Mwz/dta3oUwEdwoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7pD7EACgkQJNaLcl1U
h9DksQf9HFV5rre0PXhojl9tIIGHjFqwzTO6VnO6Odha0mzeLl2hyAjTZxdBxHRW
HxKz0NzZP+QTUCx9IyGAunVqA8IxwHHc7eKeYAhpQhn4078p1lhlVXyg07s5UT4r
DATrqiCQHxPwZJooWA7rqG/So62fVpq7u102kcv9hTBEoUBOEEk4twK8yVVtKYdQ
OOWZz5p+8Mcgn/S1Y/Gm5BnSU5m56Mra/cT/gqAIwp9Twa2otTK4QQeDXWdBsAwL
M42G4vrF9d73GDJ+tB/DAm8XhPvio2dqxUYiXythXuBV0ssE0H2qbYmaqAmzGpnc
I064gIC5DhcmWRuWIVZ9qVviHtQfOA==
=fsdZ
-----END PGP SIGNATURE-----

--Mwz/dta3oUwEdwoz--
