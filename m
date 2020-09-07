Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FAFC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DCE2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 11:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599478476;
	bh=ASDavNWFz3Ru48cBueNff8IUESkv+WSF8MU9lmTCDDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fIOrZghpIKlywKblMqMZHNsOU5KdKgZ7ckKB9npncT/qdAw9ijxcT/Y/9on0HGCWs
	 zD9Qt2x6XjgQfLru7ga2K64Q5UJCTVlBCbC9mb5WiO1jPIanLgoUk84jaZHkGd3Tsx
	 ekS+1XMcOyVjI7fXWflc4lJQqQzijzNsnj3gF+JI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgIGLeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 07:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbgIGLas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:30:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27918215A4;
        Mon,  7 Sep 2020 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599476805;
        bh=ASDavNWFz3Ru48cBueNff8IUESkv+WSF8MU9lmTCDDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uizH5gSgQY51RFhQPtobIYQvnQMwEBDfIS1Pk252+RUx7HShA+bOPvpLPoldlaj+n
         rgmiUppSDhdoQrrkxSWP/uOUd1vp80WvfrYpIHJOrJtcyY/dyu7AZLzzkoeIJaoAIG
         uTmLbQhAAMZTRBZJPLle4RUGpWBdWTqFSPtlnM5U=
Date:   Mon, 7 Sep 2020 12:06:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     derek.fang@realtek.com, Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5682: Have global name clock option for parent
 clk
Message-ID: <20200907110601.GC4907@sirena.org.uk>
References: <20200907040038.3124-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+nBD6E3TurpgldQp"
Content-Disposition: inline
In-Reply-To: <20200907040038.3124-1-akshu.agrawal@amd.com>
X-Cookie: Elevators smell different to midgets.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+nBD6E3TurpgldQp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2020 at 09:30:37AM +0530, Akshu Agrawal wrote:
> When adding parent clk(mclk) to wclk, this adds fallback option
> for the case where global clk name is used.

> @@ -2780,6 +2780,7 @@ static int rt5682_register_dai_clks(struct snd_soc_component *component)
>  			if (rt5682->mclk) {
>  				init.parent_data = &(struct clk_parent_data){
>  					.fw_name = "mclk",
> +					.name = __clk_get_name(rt5682->mclk),
>  				};
>  				init.num_parents = 1;
>  			}

I don't understand this change - we clearly already have the clock so
why can't we just use whatever we used when we originally looked it up
here?

--+nBD6E3TurpgldQp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9WFBkACgkQJNaLcl1U
h9BDVgf/TzUykCu0F6H22up3PWm1DPnZbDx/M60THNm08kFwphVcM57B4Jls3/U1
QLLodHKZreIHEu3+WcNDrZdWezwElxhBTfb3PL15lsJbsfQr7v0awbLUO7beDrpB
tHznqF+INvVCU1xHDxUXIvmOp6ftsl+ltLw1I4Va3yIpkM3uFhwJMnZJAJkWj2+9
RPnFT6Ru9Bb7r9F9QghpW4y5rf662w/ugJRNy+1dCGm91GfN0UbbnB7HKPIBXN+2
qsWtFP8Tjk1HBcC+o4Bi9FqF7C0JVVrR0K1dxs2TQWkItdz56TP288gVpVtHDyAm
v/zO5tqxlx4K6u1vbPUAdM3dlMoyjQ==
=yIiR
-----END PGP SIGNATURE-----

--+nBD6E3TurpgldQp--
