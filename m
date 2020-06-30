Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B1BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC322073E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593514540;
	bh=wWEquVMFKXy588FnMroMAEIB7yZ2El1wF3pvAg8G+us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dLvxGKOB8YXCOkZIXvRZ5ksWqkdJOsbrbJdtvsWSCVn2G6+yAZTc4trYMCJpWS0n3
	 kejmKaqFSJAvpWJ3dHqMCLItQ48oEU4C6VvA74SguHiP0u640fJ5SjJoaTHE+F5QeV
	 UObDaOYA0E2aXMtZNVJfajjRXSmSYZz4s5sXPccg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732707AbgF3Kzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732641AbgF3Kzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:55:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6367C2067D;
        Tue, 30 Jun 2020 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593514535;
        bh=wWEquVMFKXy588FnMroMAEIB7yZ2El1wF3pvAg8G+us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ4PP3lA+9OQXQXTKh9wAZLuw5BlWl3O8LNVmIN+HRZd1eYn6Rhr+lkn1m5+1yi8w
         9Yql01aDsfT08gki7cfAonM/MG2NmByEPY39KRuJ6ZpmTVLhi4cedXQS6qnqXY9kzd
         5dXxbh8MIwmxGK/dxGK9SO8pPCVVpVanMwriZsA4=
Date:   Tue, 30 Jun 2020 11:55:32 +0100
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
Subject: Re: [PATCH v4 11/23] ASoC: simple-card: Loop over all children for
 'mclk-fs'
Message-ID: <20200630105532.GG5272@sirena.org.uk>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-12-git-send-email-spujar@nvidia.com>
 <875zba1y28.wl-kuninori.morimoto.gx@renesas.com>
 <58000bd3-861c-bbc2-75e1-128cf0199a76@nvidia.com>
 <87lfk5z4ov.wl-kuninori.morimoto.gx@renesas.com>
 <b33d5a1b-ecd5-3618-4894-c3ab0f4b077d@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <b33d5a1b-ecd5-3618-4894-c3ab0f4b077d@nvidia.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 09:53:13AM +0530, Sameer Pujar wrote:
> On 6/30/2020 7:38 AM, Kuninori Morimoto wrote:
> > External email: Use caution opening links or attachments

> > > > > +     if (cpu != codec)
> > > > > +             of_property_read_u32(codec, prop, &props->mclk_fs);

> Sorry if I was not clear before.

I agree with Moromito-san that the new code (especially the above bit)
is very confusing, I'm not sure how the reader is supposed to figure out
what the purpose of the check is or how the CPU could ever be the CODEC.

> simple_parse_mclk_fs() is used by both simple_dai_link_of_dpcm() and
> simple_dai_link_of(). To make the same API work for both the cases, I had to
> use (A) in DPCM function. Now (B) does not get used for
> simple_dai_link_of_dpcm(), but will get used by simple_dai_link_of().

> If it is simpler I will just avoid 'cpu != codec' check and keep the
> function simple_parse_mclk_fs() as it is.

That'd definitely be simpler, or supporting this with a CPU node as
well.

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77GiQACgkQJNaLcl1U
h9ARuwf9F6cRaR8lFHxz06jNWSZeUUWjcGZNbZVTPkDMRXKH+RKTvtX5ac3/WiX1
NjQFs+TK8LV6s36/D9pbDL+8tWytYKpmU5R4T82nWEl2QJLpcn+baR5mZ74u5ZUH
HyUKVyPr/xujUOBmFCLBZkLexA+f8pICIwqskTUefJe9yJwvTj2wTtj9zD85PaMz
2Mu+EtDEvw1/2bvn1jaHvpYHmhDqHALoExw6AIRiuWSdOBNESBMksOE0Cn/qBuwA
BsOQz+jwqyAGR0K8VpGGhFnt7xXCRK0eFWzD95FIxpQnq3CqLrphjK6wA5nL+vV1
4n4ZkVcumkebzoPUrfnpt3DSzYCwbg==
=gAuw
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
