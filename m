Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CF3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3048920780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593514866;
	bh=yq0EKJ+zwKlc5ZQq5pq9eWRJFHa8ScWog81thjg3OHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aN0JvxXnWvwHfomcPkoKE4Nc/OSGR2K70WQLa2+TG5kj5ZS58TPLrUdbRrUNO7dD2
	 H5upg/Q0KlMabJ15w2gvk/+ElUo612a4tKnZNtbHXC3TJMib8MMu2dLVqmW8lrEfYL
	 FEYtIuEiN9LQpmv1TLF90fxdr6yOU6KK9d42eMtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbgF3LBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:01:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732578AbgF3LBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:01:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 415BC2067D;
        Tue, 30 Jun 2020 11:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593514862;
        bh=yq0EKJ+zwKlc5ZQq5pq9eWRJFHa8ScWog81thjg3OHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmVCthbaWYXcHgcWflGwipFqgak7qqScwUP7vj1UStWrXRF+ihacneLzao00Sk51S
         DpFQV3T4MLt3CjbAOyR+n6HpX8ugFHL+6cKHzDumRHZ1lwRsKFfRrkvPu++A47KBga
         B3WBJTz0axs4C9Nqbi+WhRi3PMx/9UnEQTTW20Fs=
Date:   Tue, 30 Jun 2020 12:01:00 +0100
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
Subject: Re: [PATCH v4 12/23] ASoC: simple-card: Support DPCM DAI link with
 multiple Codecs
Message-ID: <20200630110100.GH5272@sirena.org.uk>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-13-git-send-email-spujar@nvidia.com>
 <874kqu1x70.wl-kuninori.morimoto.gx@renesas.com>
 <1e0cf6d1-bf4e-8808-5390-c8a3b7c7fe7e@nvidia.com>
 <87mu4lz6pt.wl-kuninori.morimoto.gx@renesas.com>
 <1d7888c7-a8cc-e891-01aa-016e31cc9113@nvidia.com>
 <87ftadyrec.wl-kuninori.morimoto.gx@renesas.com>
 <492079e9-4518-78ba-a227-859d31594369@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="82evfD9Ogz2JrdWZ"
Content-Disposition: inline
In-Reply-To: <492079e9-4518-78ba-a227-859d31594369@nvidia.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82evfD9Ogz2JrdWZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 01:22:29PM +0530, Sameer Pujar wrote:

> Yes there are complex use cases, but if we look at the amount of changes
> required in simple-card driver that is not too much. Existing binding for
> simple-card driver would still work fine for our cases. Yes there are some
> deviations and we don't want to break existing users, that is why a *new*
> compatible was introduced and specific items can be pushed under it.
> Majority of the simple-card driver is getting re-used here. We just need to
> make sure it does not affect anyone else.

Why simple-card and not audio-graph-card?

> > Using fe/be instead of cpu/codec is easy to understand.

> I guess you are referring to DT binding part. The parsing code specifically
> looks for "codec" sub node and thus present conventions had to be used.

Remember that this stuff gets fixed into the ABI so we'd have to live
with this for ever.

--82evfD9Ogz2JrdWZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77G2sACgkQJNaLcl1U
h9DLaQf8CxFbnQfdwGWMqWzwX2nlKaR7uERgOdrildCUvaMKInQJ3nSQzOwEqxkq
NMi/PKvwmR+2xteMNBYYMvXO739dNZj9Y9vvVHOmAUtPwVMEebs45t4Km2qwLx25
t5d/6KK4UUC8RghBJr0Ls1Ywhqbp6CSieyt9ogqvrb0PrVGITmV2fpklh26gw75d
/yzh/obJaTotGhYRuCFMvB7mTNOiitRXr08p8kRJSbEWZKw7+ebUQKhiuu6Ximk6
1Uso6kJgROaHZhl896uSlbnW4odrn1t/JSHxJ9yRNedpvwV+E+8ZGHo75K6SEwRx
4NOG2mHbKSXZ3Ta+h/R4+Q4B2STg3w==
=eDum
-----END PGP SIGNATURE-----

--82evfD9Ogz2JrdWZ--
