Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3554C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8CE720663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584625303;
	bh=38o30hEvqmGagEyrNXlCMAobxn0SdVwqjNnaeQeIwwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=srFrAWkdJlIuF6dXad3DG1qTvD7jSaRPPIKYmV2Sx1Ik+bagFcdkurTJSazdl3F8i
	 HMmw0gym70sMaYRpiNe1rt0cCCArG1BEptrLiPiIsg7fq8bcs7vB3HvCjZkET9Fvcd
	 /oyopcH8h3WKJ0aHVnfAS2arWEMcq/se0uJphRQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCSNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:41:42 -0400
Received: from foss.arm.com ([217.140.110.172]:36264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726793AbgCSNlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:41:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3D7830E;
        Thu, 19 Mar 2020 06:41:41 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 668483F52E;
        Thu, 19 Mar 2020 06:41:41 -0700 (PDT)
Date:   Thu, 19 Mar 2020 13:41:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200319134139.GB3983@sirena.org.uk>
References: <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oLBj+sq0vYjzfsbl"
Content-Disposition: inline
In-Reply-To: <20200319130049.GA2244@light.dominikbrodowski.net>
X-Cookie: Captain's Log, star date 21:34.5...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oLBj+sq0vYjzfsbl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2020 at 02:00:49PM +0100, Dominik Brodowski wrote:

> Have some good news now, namely that a bisect is complete: That pointed to
> 1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
> therefore I've added Kuninori Morimoto to this e-mail thread.

If that's an issue it feels more like a driver bug in that if the driver
asked for ignore_suspend then it should expect not to have the suspend
callback called.

> Additionally, I have tested mainline (v5.6-rc6+ as of 5076190daded) with
> *both* 64df6afa0dab (which you suggested yesterday) and 1272063a7ee4
> reverted. And that works like a charm as well.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--oLBj+sq0vYjzfsbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5zdpMACgkQJNaLcl1U
h9C9pAf/RrCobt9NlyJGaB9AaEXAdgTfVIaiKtTXJ5DhvxWM/1HLH5xPAWkrBa32
EVE4KvTS0DinbpCuAEeJRcQVFEpH6+y+kRnzntxmdsLJFRHzfcLYq/d/robTV221
r5m6o8+hQSDrSPyQ4UXtUuWcaf8BSWogQpdhBYvhd/AU5yLjRiRc5P3p13A8nliv
mLpj3QoOlBMigo3MnqGSFBp1AG6Nroyqt/G9uVsyOEZazhPHVX93NCIf/z5v3KHk
7MKeZjgFbJc5hphI+nZoMa1GuraTXSn0f4tfm99wRRu0Pcb1yoyYWpTiYOKziwXX
wR44Gs0iHetTwjYP+jmjXGeO6rjTkw==
=bKjM
-----END PGP SIGNATURE-----

--oLBj+sq0vYjzfsbl--
