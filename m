Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE77AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C091B2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583323405;
	bh=ngZGyk6qLBiIKqhNyOYfQtSNN1Zuio5UyG02XlxIspc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZkSkzdozhBGqbsUTfIOSHUBFkZmIHXIBbXBgCdqWUnJRyOF3FsLjfk48zap65hVRo
	 urJSYYAYDqjE84Q8NrlWzC0PwaNc5ztIrvUJB37hmomihXB4H3KG0MCsolMo20xAIR
	 6rFnj5dHbbEZxefsuJl5ff3s5sTDXYK+hSaD8eRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387950AbgCDMDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:03:24 -0500
Received: from foss.arm.com ([217.140.110.172]:33380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgCDMDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 07:03:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95AE831B;
        Wed,  4 Mar 2020 04:03:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1947D3F534;
        Wed,  4 Mar 2020 04:03:22 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:03:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lars =?iso-8859-1?Q?M=F6llendorf?= <lars.moellendorf@plating.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question about regmap_range_cfg and regmap_mmio
Message-ID: <20200304120321.GA5646@sirena.org.uk>
References: <d2eb2248-0120-7b0f-9bcf-4f9c71954117@plating.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <d2eb2248-0120-7b0f-9bcf-4f9c71954117@plating.de>
X-Cookie: Tomorrow, you can be anywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 12:25:09PM +0100, Lars M=F6llendorf wrote:

> this mail is copied from internal issue written in markdown - I hope
> this is still readable as mail.

Not really frankly.  I *think* you are saying that paging doesn't work
due to relying on having register read and write operations?

> My assumption is that paging is not a common use case for Memory-mapped
> I/O and thus has not been implemented for this case.

> - Are my assumptions correct?
> - If so, what would you recommend me to do:
>   - Continue using `regmap-mmio` and implement my custom paging
> functions on top of that?

This will obviously work.

>   - Enhance the current `regmap-mmio` implementation so it does paging
> and submit a patch?

That's not really possible since MMIO never writes the register address
to the bus.

>   - Write my own `better-regmap-mmio` implementation?

It's not clear what that would mean.

You could also look into making the paging code not rely on explicit
register read and write operations.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5fmQYACgkQJNaLcl1U
h9D3yQf/UKX+tbsv4ndgOEtwq4K+LBy2wvNpprCJ4eStbWILTnSqxHW4Va0aJG/6
z4w2M11jzUjyrqXa3dDKTTFjeRo/n27XmGhu2x1IQJq+kMHKMRywIrhEPMcfljeX
cZX/J0GmELaRISFqzAKuSZ7v7ct2wdpdjRTJQQb1D9pvxUlE+SlCQTyHRY64T8JC
BQW12Dg7YasFxRcpp3+Le0Er6ez7GYslXKGNdR9JEMQnI+e6KBXpI2s9pql+p7eA
EnAejaDidYxptqlsw94VOAa50VtXd0/oGxkOcXuZLQu5fbWb3qwHQgNOVy+D3vYZ
zBjvE6GPIxSUwNZ577VOAdHu3ni7GA==
=91IF
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
