Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6DBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D05C20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583239663;
	bh=UbXuZRyvxQEDOwMNOUPOm66QPzbIXhylpFRPvHLl7So=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pXsG7NnJnvWBGkBzDc1r0Fk484BTfm/cgkoBgLhBv5t0DUoYZ2XrnPVooukPXFnuD
	 jkLEYortW2vpvfPbOK911ZoE4TdQ24SvTQ+Pwc99wKsuD06eLHeBX5AOJllhE30kib
	 WXF94h+DR1m5bsXS/FGJHvokjtU6IzkTQrDuVe3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgCCMrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:47:42 -0500
Received: from foss.arm.com ([217.140.110.172]:46650 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgCCMrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:47:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBA03FEC;
        Tue,  3 Mar 2020 04:47:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FB513F534;
        Tue,  3 Mar 2020 04:47:40 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:47:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>, linux-imx@nxp.com,
        kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/8] ASoC: dt-bindings: fsl_asrc: Change asrc-width to
 asrc-format
Message-ID: <20200303124739.GE3866@sirena.org.uk>
References: <cover.1583039752.git.shengjiu.wang@nxp.com>
 <872c2e1082de6348318e14ccd31884d62355c282.1583039752.git.shengjiu.wang@nxp.com>
 <20200303014133.GA24596@bogus>
 <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XuV1QlJbYrcVoo+x"
Content-Disposition: inline
In-Reply-To: <CAA+D8ANgECaz=tRtRwNP=jMXBD0XciAE0HUYROH8uuo03iDejg@mail.gmail.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XuV1QlJbYrcVoo+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 11:59:30AM +0800, Shengjiu Wang wrote:
> On Tue, Mar 3, 2020 at 9:43 AM Rob Herring <robh@kernel.org> wrote:

> > > -   - fsl,asrc-width  : Defines a mutual sample width used by DPCM Back Ends.
> > > +   - fsl,asrc-format : Defines a mutual sample format used by DPCM Back
> > > +                       Ends. The value is one of SNDRV_PCM_FORMAT_XX in
> > > +                       "include/uapi/sound/asound.h"

> > You can't just change properties. They are an ABI.

> I have updated all the things related with this ABI in this patch series.
> What else should I do?

Like Nicolin says you should continue to support the old stuff.  The
kernel should work with people's out of tree DTs too so simply updating
everything in the tree isn't enough.

--XuV1QlJbYrcVoo+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eUeoACgkQJNaLcl1U
h9AJywf/bSiQfVDbeUAktcdvjHCRmCvZQ5r/DETvXQh3jrq8ZMfLbfd8mIoxnaPL
QCqx6aL0X4owNuPMZ8fq3jStJL1uCFJudtfA9a+H/n57opep5mhmsAw0VTUSRKxV
3YPmdTKQtoGd3GnxrcUo9Z62ssQY3K0bCy5wGjcCxOW8alaFlJqj2st0dMbC6UNb
UbxOrZp2jWpVH3U+/0qh5i5QiV9h+ctw/f1BmEPzZYb32S4Ie9Q2ldINFhbMbnMQ
gwAeyISGShAYVLuWzbVCe8e09slQqGYmKprtmCn4xgokE2+UvnQNCIuxyx+TLeXY
6xJH0vBb6D/26k+09f8BENOxCCBv4w==
=EdGJ
-----END PGP SIGNATURE-----

--XuV1QlJbYrcVoo+x--
