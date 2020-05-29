Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40348C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107E52100A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590745503;
	bh=wetxUlZJUVdgGFsLgYSoAqWETsFjhV30MoLoXMoeHmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xtzu0ojq71Xdk74xv34Uh/R1Hn/AO92J/DF0JnVCFHxMf/RVVWz+6bIK01Pk2YTtm
	 ulnUQyiKVD9lipuus7Tr95W0Rz40rUAPf4jYSXM7pTZxVcS7WFR9lqLvA8vavGazxG
	 BijzrTtVa/5Wz7UQSABEdHylUXqk0rjQg88/zE4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgE2JpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2JpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:45:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C33812074D;
        Fri, 29 May 2020 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590745501;
        bh=wetxUlZJUVdgGFsLgYSoAqWETsFjhV30MoLoXMoeHmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vbo8e2T+nqwIbjuaK196ZqyHe5hlo8C4/hDVFf8VAEnBNt2LyT7X1RDqC0cF1Hapz
         8Pbm3L+2NDuQLKu0FWAom47ntL2speUrpJYq1VEgeHvI1UfDmgaxcoUhLltjp4J1xb
         k1hVn6tuXyjZJoBaAVpWQ1E+rGdti7QoK/A35Ov4=
Date:   Fri, 29 May 2020 10:44:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     zhucancan <zhucancan@vivo.com>
Cc:     lgirdwood <lgirdwood@gmail.com>, perex <perex@perex.cz>,
        tiwai <tiwai@suse.com>, alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel <kernel@vivo.com>, trivial <trivial@kernel.org>
Subject: Re: Subject: [PATCH] ASoC: soc-pcm: fix BE dai not hw_free and
 shutdown during mixer update
Message-ID: <20200529094458.GB4610@sirena.org.uk>
References: <AJIAHAA7CLDayC1bgc0c0qq9.1.1590725427357.Hmail.zhucancan@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <AJIAHAA7CLDayC1bgc0c0qq9.1.1590725427357.Hmail.zhucancan@vivo.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 12:10:26PM +0800, zhucancan wrote:

> +++ b/sound/soc/soc-pcm.c
> @@ -2730,12 +2730,12 @@ static int dpcm_run_update_startup(struct snd_soc_pcm_runtime *fe, int stream)
>  close:
>   dpcm_be_dai_shutdown(fe, stream);
>  disconnect:
> - /* disconnect any non started BEs */
> + /* disconnect any closed BEs */

Your mailer has corrupted the patch (it looks like it replaced tabs with
spaces).

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q2ZkACgkQJNaLcl1U
h9D60Af8CU45aZo5/PzFKojHF5n8whHD9QjKTEMtEl3rRdI3xLrFoE1Y5cVEk2jT
A2Jk7V0Q2K3/FHKZ9fysWTVeR8M7jE5yDdlNS6MSnhlkB0Ji3vxRLjQKPE+QLxFj
txyNXY/y3326skNNM7v+sSDviih7lYHvH77X1pnp4mHKXzGNSCcyPGVFjdbwEicF
2bkmwqUtkZLRXCNbHoxVt6HGhkDH+f1a7R+E+Y9JDFztH59t4sBEwL4BJxOGHrPW
ZZV7vHWPxbWDwKAG6nq3WyGZwem1zhjA1hhM9jo+7JamlfVGiFZhSvGoPxa9P0ER
6vlOIG7kPqpdbdDY9WC6hcmesfo61w==
=Strr
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
