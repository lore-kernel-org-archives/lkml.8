Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624D0C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416C720656
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 11:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587986360;
	bh=Yu0+6vmy1gZqJei6s8N1pKoxn3NJdnoVEX9RSHmQP4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h2X7c624yXzTbH9D7N44HEwwDfp8fO0o958k7RIe2fRbhnjTAg5+++1iIV/etUwDS
	 Pow4RYrdWbdBgp8n/vAXmgmC4f3jeSql48HyixiUG49A2DgodFslSkTWRfrl6pZVMZ
	 GD8cCJLkpMDr+VB5jokUdYF4bRmRkxUnWGnfXy14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgD0LTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 07:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgD0LTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 07:19:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25D57205C9;
        Mon, 27 Apr 2020 11:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587986358;
        bh=Yu0+6vmy1gZqJei6s8N1pKoxn3NJdnoVEX9RSHmQP4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mLdUFEoQu+rt5NOviGBZcZJzCpczuW5FeibZRhKl1c2ZOvvlWtThRtr8WjvHotEag
         UpuxbnPJ+Vjv+WGmHnfeg89n43x3G445Fwv+YakTlI9REOUiJNob+d9FVDswOIovB2
         MnptV7VNmVWadrQ6qCPKiKvqaV1Rr7AUXmlv7KZc=
Date:   Mon, 27 Apr 2020 12:19:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Message-ID: <20200427111916.GA4272@sirena.org.uk>
References: <20200423155539.4492a0cc@canb.auug.org.au>
 <20200423113041.GI4808@sirena.org.uk>
 <20200423230400.2cb1a285@canb.auug.org.au>
 <20200423142114.GJ4808@sirena.org.uk>
 <87a72zgn2m.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
In-Reply-To: <87a72zgn2m.fsf@mpe.ellerman.id.au>
X-Cookie: Secrecy is the beginning of tyranny.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 26, 2020 at 09:30:57AM +1000, Michael Ellerman wrote:
> Mark Brown <broonie@kernel.org> writes:

> > I am doing that but that still doesn't mean that the architectures
> > shouldn't be updated - to me this is like the architectures that don't
> > implement standard APIs, we should fix the issues they bring up but it'd
> > be a lot less noisy to sidestep the issue.

> I don't think it's really like architectures that don't implement
> standard APIs.

> It's more like architectures not building code they don't need, AFAICS
> none of the drivers under there can ever be used on powerpc.

That's generally the reason people give for not doing the standard APIs
- there were a few architectures that didn't have DMA hardware so didn't
even have stubs for the DMA API for example, until those were added you
used to end up with build testing tripping over them constantly.  It's
much rarer to have an incompatible implementation of the same thing.

> Similarly we don't build drivers/acpi.

ACPI has stubs so doesn't cause issues here.

> But if there's a good reason that we should be building it then I'm
> happy to take a patch adding it.

The build coverage seems useful.

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6mv7AACgkQJNaLcl1U
h9C2uAf+Jws7pFf+23DtTiIuLnLp0xfnX1awFhQkI1eCP9tvACqRtjcDHFIMRPsL
1jpb5QPnVkQz6WjKRz1QUV/PF9+svvzhPfrspY9EgOrar8ZPdAMFiFLZf2/685I/
a0JHSUpOMTDEi134N9dst/B2q/t8flhRu+OXErxfvVisIaV5lC38Gr8TN627WgRp
JALiCYQjcWSa14nCRO9nwxBL40zCEamOYGj9LV4SEVaP4zneTf83pYo2PZCdbZ7m
YmOFaC9bMIcZMaKK8xz2N/EDWnvQtd7DSs2j63k/d7WPrA9ZtnTQ1pnnoszkV/ye
BPA/o3glq9QOHgo5vMRPyKymT+r7nQ==
=xYU4
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
