Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5264C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BCF2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592219909;
	bh=Kc5Uu2zfW16GC/jLDwOItAJ1ZCbBOhlBnC7jl4IzQzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LnqRiOlmXW7a+467TvMplEmShDYO8yBrqEwJz44EwZMXxGzJfa+/lrGyakO4BWazQ
	 PgnPUm1T8e9FcvbMj7HAkWa3mSZNqcx2f4jE0qhAgNb44X58nPJ90BEMq+MSDW26Bj
	 4qsHPaFFem+V656ldTv0N08/ZRJJSppz8J35MFJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgFOLS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:18:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOLS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:18:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9183620679;
        Mon, 15 Jun 2020 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592219907;
        bh=Kc5Uu2zfW16GC/jLDwOItAJ1ZCbBOhlBnC7jl4IzQzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLqA0Otm5iTchqOJNuF5+TEvlduYM9+uHf6vsS1atI8wMe7S/kxYzvwUUWFsse4+8
         sH1eDw9PbEF9rDtnc2aheYGa9DNhyAWCXgR4cJnGEviEeGugPmWRca0LUDu2E4mP8M
         PRkjztkO40hmW00EQKRvCSNgeGSBOeUs/BCxQ00k=
Date:   Mon, 15 Jun 2020 12:18:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 14/29] dt: Fix broken references to renamed docs
Message-ID: <20200615111824.GB4447@sirena.org.uk>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline
In-Reply-To: <6866c0d6d10ce36bb151c2d3752a20eb5122c532.1592203542.git.mchehab+huawei@kernel.org>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 08:46:53AM +0200, Mauro Carvalho Chehab wrote:
> Some files got renamed. Those were all fixed automatically by
>=20
> 	./scripts/documentation-file-ref-check --fix

Acked-by: Mark Brown <broonie@kernel.org>

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nWQAACgkQJNaLcl1U
h9CxiAgAhDSjkVNSd4C3SSNbhfInIakuxFRySdIdhdj0LEFFiDgpuSzr3Lod/jYy
mKamyUcBQ6F3CafOHN8nf4MlH9u3CSElXbDvLZlah833W1ak+AWXqFDdqi3XM9Wg
5enzsfi4JHeKxu/NGAt7YUqXKG2WxM4RL0iC1H/CsGsLII4ixSPSNHJ8BsGs2Ehx
Dv2I9zYutWdH+3O8bk4vHtJHpZidjuobydynnmMgcHpeDXVSLPZx22W/LXsUAlfE
HFaK+IberJIeSTebqFLV0fkB5+x9yri0Jg8SLWubAGmqiS/XEvVLx1tF0uU/ukk4
dBx3qCxD+Vtqo7ZF4IYCIM1u5B64lg==
=HhUo
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
