Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF124C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C4620739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594204388;
	bh=AhnJoMBPbxKfUgHX720jeUrzOme8kKo3MjbmvB/JDAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gq0OfxezZdh9z0aVr0EXCjLspoeXpDGPFHvVUxqcHjWbbBoyf3CHZ6zHm8FogZWgL
	 VcQinkvbqCZ1QjLTLOjnirL/nhJ94kuazwrFoIgRovQvkE8z7X46R8/VzsGBip7YiR
	 extK3TtDzpTMWwsWANiUsb6qaG8jjcHypDAwvIQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgGHKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 06:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGHKdH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 06:33:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E852206F6;
        Wed,  8 Jul 2020 10:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594204386;
        bh=AhnJoMBPbxKfUgHX720jeUrzOme8kKo3MjbmvB/JDAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdfRpI1OCGj1tiJyd4YF76KEhAOKiosCRz6S8D71iqM7NZYRdH3E7SJ+EN0Db1a83
         yObZEvZN6+2kxF805MnfEGD5K+lUgsguzT6g8yAsnWVZieSmcZ5kh2OfPHQq90fbCh
         zsvJSp8+oRIWVV6QQicJIi2CVqA3Q4DYLBhXRMNI=
Date:   Wed, 8 Jul 2020 11:33:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Pandey <ajitp@codeaurora.org>
Subject: Re: [RESEND][PATCH v3 7/8] ASoC: qcom: lpass-sc7180: Add platform
 driver for lpass audio
Message-ID: <20200708103301.GG4655@sirena.org.uk>
References: <1594185286-11323-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wTWi5aaYRw9ix9vO"
Content-Disposition: inline
In-Reply-To: <1594185286-11323-1-git-send-email-rohitkr@codeaurora.org>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wTWi5aaYRw9ix9vO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 10:44:46AM +0530, Rohit kumar wrote:
> From: Ajit Pandey <ajitp@codeaurora.org>
>=20
> Add platform driver for configuring sc7180 lpass core I2S and
> DMA configuration to support playback & capture to external codecs
> connected over primary & secondary MI2S interfaces.

I only have patch 7 here, no other patches or cover letter.  What is
going on?

--wTWi5aaYRw9ix9vO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FoNwACgkQJNaLcl1U
h9BTIQf+Pzg18KzFR1F83jYFACOsU3RoGhxBsfnTFuUTgZk3ldcDm3SlAKiQ1uwo
Ol2ArxJ/AJ1llEZO3q3T5yv+Xp59WZWKaGNqIqeksbcSNQIVcmKle48bDspuaq8d
vrYuPRUmsij4QsaCBO+FZEjIFpMgN1t+hSjneIU4yvbHS5p+uphg8o485E/aqLC1
KaGwY9njulUK+BYodMNvvLz/MctN5GYaWecf9WonuXHsy0oxg/DLluKqXQpumYWo
vUgZBasWFJW0uwB/bdB2u0tbTUAH6p2YFuTrHcSfiaiGWXg4P9PD5gjHn3ND3QBp
EUYKEtftH2KYxmANHezDbVwOBrJt+Q==
=NjIB
-----END PGP SIGNATURE-----

--wTWi5aaYRw9ix9vO--
