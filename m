Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B72DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 262CE206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588679472;
	bh=zHBoT/KGlclwyw1KLVdz+tgGbFh+vVpAI9xL1PxTI1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V7IkR1FgSkbUMfnhL2zmjWPs4HwlRkRX3I2nFf2EgalNZs/79u83bybMk3SZ35kdz
	 rmH002cE9uosXsxJ3uSL9VxVA1YTMufmPt4jEIbf3u0M+b9XaGkhlSvpHvU++vou6P
	 UveKaOyXgv/wrbmtip0DhUL0beCtJE+Xfx47ok+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEELvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgEELvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:51:10 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABB69206A4;
        Tue,  5 May 2020 11:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588679470;
        bh=zHBoT/KGlclwyw1KLVdz+tgGbFh+vVpAI9xL1PxTI1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FsNbVa7spd2Y8tI7gvo0xNcUmz1Whzp24fe2RRo/xczxXI/Yx3Yo/JAU0Yh1O80K+
         LxhE4qrre5dkF+oH6EcXgtLsqmFfQRHrvtFX5Y4SgIZ95L8mKwEGWTy+9NjarPWJB8
         7v9l4sngn1CMqXhkIjeyVzzOCWHBgtP3ej1QcvtE=
Date:   Tue, 5 May 2020 12:51:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Akshu Agrawal <akshu.agrawal@amd.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd :High hw_level while simultaneous capture
Message-ID: <20200505115107.GD5377@sirena.org.uk>
References: <20200505114023.251409-1-akshu.agrawal@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hxkXGo8AKqTJ+9QI"
Content-Disposition: inline
In-Reply-To: <20200505114023.251409-1-akshu.agrawal@amd.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hxkXGo8AKqTJ+9QI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2020 at 05:10:20PM +0530, Akshu Agrawal wrote:

> Simultaneous capture on dmic and headset mic is having
> issue with high hw_level being reported.

> Issue Can be reproduced by:
> arecord -D hw:2,0 -f dat -d 60 /tmp/test0 &
> arecord -D hw:2,2 -f dat -d 60 /tmp/test1 &
> cat /proc/asound/card2/pcm?c/sub0/status

What is a "high hw_level" and how does this patch address it?  As far as
I can see this patch reorders some of the initialzation but it's not
entirely obvious what the issue was or how this fixes it.

--hxkXGo8AKqTJ+9QI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6xUyoACgkQJNaLcl1U
h9CM5Af+JYWGYgh3XlATPjacnOL+W5keHgZMiQQM+Ga6iTruOWyQnCQn1RoFa0jS
YmP9je6E4IGkUqgzXg65+E8fuiY4wWmuNbi7EE8zrBmCd3uJVd7B4gMTp+JU8vL4
0dSiN68vCcL7G8ksqtRd0lslBy5bf4tdlJBejP/KvvaQyObEYZBZdPEqObOsLV+7
hiKkM2bE9cQU2Jl4YhfkuDIozbCglRjX4Z0hwoVaBY6vBK0oIlkh797jFa1T4qsm
sUBqDeK45EzB29lyaCYeMg2IggTgpyGfeYTGBCvj78viipVIGnxjNgK60skm/pdX
vdbxD0/69T9kMNCvmdMw9fVPjNbk5A==
=W0sp
-----END PGP SIGNATURE-----

--hxkXGo8AKqTJ+9QI--
