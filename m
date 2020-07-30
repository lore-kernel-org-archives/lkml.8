Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82870C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A90120829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596135172;
	bh=p9oPba0mvh+97oJckDtVD2Q3rUl/khvzbYhc/m/Wsrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1DWEcLvbpPW2A4lzIRIrFJqBRz6nd4Rsrcn2P4Ud+CMxG1fcsRes2a4QAPRdfoygT
	 3IeDVqlAqcmIgOYit9SdCdfU55GLVc0BoY2yDs5CqMgxmqMViSOdLGQmHyXmCctzvW
	 0BylGn6Y0Rx7HH/HdO+XB77sZSmoE9g9Q0kkaEDg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgG3Swv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:52:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726343AbgG3Swu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:52:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0543B20809;
        Thu, 30 Jul 2020 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596135169;
        bh=p9oPba0mvh+97oJckDtVD2Q3rUl/khvzbYhc/m/Wsrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWJFJd+rtMgYBOsBvF27NSJHWipQKLgElYBHEU6AO+7oj00vU85cw458+CwQ6nU2E
         7v8IfL/PsQpLmnkvm9Ke+QNRay67GMHHbxadMWcf2pLfAWcrWb3KP3vZUHRA0MDJpu
         fxKyeiy8R/Aj0WUCwc8NOfu9xVuAJ4BleP0rV7l8=
Date:   Thu, 30 Jul 2020 19:52:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, zhangn1985@outlook.com,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
Message-ID: <20200730185229.GH5055@sirena.org.uk>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <20200729154639.1983854-1-jbrunet@baylibre.com>
 <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
 <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
 <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline
In-Reply-To: <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
X-Cookie: Alex Haley was adopted!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2020 at 11:06:23AM -0500, Pierre-Louis Bossart wrote:
> On 7/30/20 4:04 AM, Jerome Brunet wrote:
> > On Wed 29 Jul 2020 at 17:56, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
> > > On 7/29/20 10:46 AM, Jerome Brunet wrote:

> > > > The flag previously allowed card drivers to disable a stream direction on
> > > > a link (whether or not such feature is deemed useful).

Right, and I can see a use case for this if someone has a board that
for some reason didn't physically connect one of the directions for some
reason - perhaps they were running out of pins or something.  It's not
clear if anyone's actually doing that though.

> > > > Forcing the flags to be aligned with DAI caps just make the information
> > > > the flag carry redundant with DAI caps, breaking a few cards along the way.

> > > > This change drops the added error conditions and restore the initial flag
> > > > semantics.

I'm not 100% clear, have we actually found cases where the flags are
used or is this something found through inspection and review?

> >   * It worked for every user of DPCM so a far.

> Not completely true, when Morimoto-san added snd_soc_dai_stream_valid() it
> exposed tons of cases where the information on direction was not provided in
> a reliable at the DAI level. I will assert that we are still finding out
> cases with broken DAI configurations, and as a result we will also find
> broken dailink configurations. Your picture of DPCM as a perfectly
> functional system that I broke is a distortion of reality.

> The reality is that we have to work in steps, first make sure all DAIs are
> properly described, then work on the dailinks and optimize at a later point.
> we will need warnings to find out what the problem cases are, and move
> slowly.

This was all triggered by Morimoto-san's changes like you say.  DPCM has
quite a lot of problems in general, here IIRC the issues were that we
had multiple different ways of doing similar things which it wasn't
quite clear if people were even using.  The intention with the warnings
was to remove them one way or another, they're mainly intended to flush
out actual active usage of the flags as opposed to redundant usage of
them which could be confused/broken.

This could definitely have been clearer in the changelogs though.

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8jFuwACgkQJNaLcl1U
h9AhwQf/eNX0synxDEgjT7FmPWLDHvEYP9WwcQyfMCzHdEvV8d3Iiq/P+C6GW13d
ehcDWOK1wzrqJjMyjh8jp+04kuRwwsL+YHnRD2FqYm1ajOp3ADdT3+ekGQXG5rZ4
KG99yZALADgpmbl6VOluas2lkeiWIjO3nZEFJypz0VJKtEyxCiXzzPbA81wgsyr4
pu0Q1XmfbUpAsLCeGlrjdENOLdW0Kfb0fjXcEy8ks0NHUfbAOj2JEr5uYTjPLZTt
8OH9bbhLUIhwGirTdF5piPsHbYq8ybFWDvKQ37qjqK0L7Nec0UdaTIqlroiOs1Xo
fFI19TW9/zN4P9cxHXwEC07WllXelA==
=Icbr
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--
