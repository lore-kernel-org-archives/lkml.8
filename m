Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08D9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84DE2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594821931;
	bh=OsRhntqAyN9mOY8U9CdqOwYBY4i2l3Qux14A9WHRYhY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mkSz6QvQqH8fSIWhAkxNwiB3nDSH29CVBvDqXS/8FcnkU/oyYZ3fsbS84F3i2oqin
	 Pwztlqf74JS+pk9QKeD9xq+lOYSW5tB10a8udJLJDLYpMRQyFYSMMMMnbOMUnSwL8F
	 oNPx0/TANfi/t9AeTZB28+re/PrtN/1KKq6W8zVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbgGOOFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727822AbgGOOF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:05:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0B6C205CB;
        Wed, 15 Jul 2020 14:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594821929;
        bh=OsRhntqAyN9mOY8U9CdqOwYBY4i2l3Qux14A9WHRYhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kUxdDYMrISxD5G0l2FMnWPMBLh3uWpKF5s/SbJgKqgjvDzTGAPs3JxlKjcV16/wh6
         Zg+RfOOP3sXzrq2Es0XaPWd+8TyDG0a9msLnNCGT3Cac6iOBFrkHAgza/TUMjSIA6H
         CW4oT2uw0ZQV/X3UI0Vqiv7USca/rfpN+XvUOP6g=
Date:   Wed, 15 Jul 2020 15:05:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200715140519.GH5431@sirena.org.uk>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
 <20200714205050.GB10501@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vjQsMS/9MbKYGLq"
Content-Disposition: inline
In-Reply-To: <20200714205050.GB10501@Asurada-Nvidia>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vjQsMS/9MbKYGLq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 01:50:50PM -0700, Nicolin Chen wrote:
> On Tue, Jul 14, 2020 at 09:27:53PM +0100, Mark Brown wrote:

> > The nominal rate might be the same but if they're in different clock
> > domains then the actual rates might be different (hence the desire for
> > an ASRC I guess).  I can see the system wanting to choose one clock or
> > the other on the basis of some system specific property (quality of the
> > clock sources, tolerances of the devices involved or something) though
> > it's a rather fun edge case configuration :/ .

> Thanks for the input. Fox i.MX6, I don't feel it would be that
> drastically different though. And both SSI1 and SSI2 can simply
> select the same root clock source to avoid that happen.

If you've got two radios that both need to sync to some radio derived
frequency it gets a bit more entertaining.

> Yet, in case that we need to support such an edge case, what's
> a relatively common practice to allow system select the clock
> source now?

Honestly for anything that fun it tends to be a custom machine driver.
A property would seem reasonable though.

--5vjQsMS/9MbKYGLq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8PDR8ACgkQJNaLcl1U
h9B3vQf/f9mEX7hrtyk9FWvaZgsqLq+mUUNALFg5rWK6DoRHzdL5zBIlHuZUkcxD
dwIy0B20CLI43Xtu8/yIkVbPb9X5f2FfoJ0Jo9+R5I6yP6QIMR7ZVVbFwpsCoMGe
nuf4HosTeun7cv9MbTQe/wMbF2kWdX/xPZyEN/DGDvXLs1e/vQHjg0g92LZYLK/A
5tLPFNHJQULz/QKxzHxCdgwNKeA5jKvSZK8I6jNBa+7HKFXbZl07pUGHpSEQ6aFI
iuvyUH8NtvVj+P9f41yHAj3er2TEmpEg98M0JEmE61dahy+oGSivEyqcmJlfKxxd
4nn2FfBH1xDjNZn2ShW+vYcooN+k0A==
=X4/g
-----END PGP SIGNATURE-----

--5vjQsMS/9MbKYGLq--
