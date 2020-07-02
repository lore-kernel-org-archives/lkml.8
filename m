Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F318FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5EFF20836
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593692770;
	bh=CTOwxLg+n8bAvIzD1IVs4kKNUWk2tiRGSHFgkCW870g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HXy2g7PJ1hKDJdoFU+5PXCrpLsaYWuJfBCPjFrFIk3vdcvVCGyOHT+RZZNzOpuWlB
	 drRspTtMWOQHmp8Olt67pUFj3Lzj8mkeUolz8JXFnSUaINYUekWe6XqsDono25LRfL
	 pE/yVb7d/1ea9YON72R1TdskkE7m/klXn8OqbRKM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728930AbgGBM0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:26:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728854AbgGBM0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:26:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 726CA207CD;
        Thu,  2 Jul 2020 12:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593692768;
        bh=CTOwxLg+n8bAvIzD1IVs4kKNUWk2tiRGSHFgkCW870g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1T1sJiBrL93OzyoE3j8Pp+hjxq11/0nZA94VY4Vad9HkKNAyoEOK7UpSMMwootbsB
         gZ6UOeWnQipL/sYc92CJBnUVnaoUlUkZ+3b6dNAh/HHnRSLCfvkHLG8p/b5sm3vAgn
         c+Z3ZIeRIY2VLdmtGpHq+Hq/Aum9RTvwSju2PH7g=
Date:   Thu, 2 Jul 2020 13:26:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org,
        lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com, nwartikar@nvidia.com,
        swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: Re: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI
 link with multiple Codecs
Message-ID: <20200702122605.GE4483@sirena.org.uk>
References: <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
 <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
 <87mu4lz6pt.wl-kuninori.morimoto.gx@renesas.com>
 <1d7888c7-a8cc-e891-01aa-016e31cc9113@nvidia.com>
 <87ftadyrec.wl-kuninori.morimoto.gx@renesas.com>
 <492079e9-4518-78ba-a227-859d31594369@nvidia.com>
 <20200630110100.GH5272@sirena.org.uk>
 <81d106c0-e1c8-a79a-8caf-1f3be0d61f0c@nvidia.com>
 <20200630153220.GL5272@sirena.org.uk>
 <fb286ab7-21f2-43ad-2751-c76b7b6e4cf2@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
In-Reply-To: <fb286ab7-21f2-43ad-2751-c76b7b6e4cf2@nvidia.com>
X-Cookie: I'm rated PG-34!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 02, 2020 at 04:06:14PM +0530, Sameer Pujar wrote:

> For the HW I am using, there are no fixed endpoints and I am not sure if it
> is allowed to have empty endpoints in audio-graph-card. Crossbar/router
> provides the flexibility to connect the components in any required order.
> Patch [05/23] exposes required graph and MUX controls for the flexible
> configurations. Mostly, in DT, I am trying to model the component itself and
> finally router can help me specify the audio path to interconnect various
> components. Hence I was trying to understand if it is really necessary to
> represent the links using audio-graph-card. Kindly help me understand what
> more it offers. If simple-card works fine, are we allowed to use it?

The links in the graph card should be the physical links at the edge of
the devices, those must be fixed no matter what.

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl790lwACgkQJNaLcl1U
h9BPigf+JRDzmC/OXZU6GO+RPto06SdJhbNhvLjXQA6BqKzqFg9qNRwNxEK38qz/
nBq43rOuPFzPkX8j9qxChkJ7pIyhNHx+Vkqo3fRnulH3afFxAiCLKq0IkFph+A0q
vOOpNX/7HPZHTXzCWDrSF/pkQvgf+ou9X+K6johBzn/Wtd36X1okIf4LCkmrrhzs
/HXd6bGFbGzUC86c2F2Vqbq9aFWhxRMBWGnV5LTGz1I+Y1RiAqUE7yE2whTTGRhv
WdrHBrGkXU2R1mtjoecmZ5k86iY8Ho2PQ6ropR7AHRZXmlEYor7T0ViwjXETvQie
m0fVcHg7vi04mLyDdmy2dUZwC7oo/Q==
=lgFt
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--
