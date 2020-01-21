Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46059C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A353206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579626496;
	bh=kan10pdGZIkAx1c1W7zvJtSM+irGyICRH5RK1O89bmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=exKQcIiRbDArIjajW9QDIld3ny2e3CQ5dt8ywOSFS2h4Z9EcPHzVyCZmlplwsuZTv
	 MChcTs6cexxG95HDnmmkTS4FISW4+xGHbAz8uOOhxgfRTyST2My9s+yB2gPNxPO2fv
	 g3lrsdFBQsMNTDg+UEcUUyfz17D3kRiaxUqxbo6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729190AbgAURIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:08:15 -0500
Received: from foss.arm.com ([217.140.110.172]:46072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgAURIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:08:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 03ACA30E;
        Tue, 21 Jan 2020 09:08:14 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7211A3F6C4;
        Tue, 21 Jan 2020 09:08:13 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:08:11 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: amd: Fix for Subsequent Playback issue.
Message-ID: <20200121170811.GJ4656@sirena.org.uk>
References: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200121165925.GH4656@sirena.org.uk>
 <DM6PR12MB3868B9744A40D41450155534E70D0@DM6PR12MB3868.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB3868B9744A40D41450155534E70D0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 05:03:43PM +0000, RAVULAPATI, VISHNU VARDHAN RAO wrote:

> > +     kfree(rtd);

> This free looks like a separate change which seems good and useful but
> should be in a separate patch?

> No Mark,

> That is part of the fix. please let this be included in this patch.

In what way is it part of the fix?  This at least needs some sort of
explanation somewhere, the changelog at least if not the code.

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nL/oACgkQJNaLcl1U
h9DmOwf/R4GKNHq0vWy03y4TCcrfj3Qty8T3/Tj3C/59WeAe9C1dbCHMrv0qrOg2
em7HOBX5PNR8V+SlAwiZUVLVADuyimVqYowdn+FhLpCFECEe7DsBXFdgMFADdq6C
4fFiY0LOi75NFjv+ERMTt5WVU8YSX7irTv/E8Xlb3iySeeYsFQCu71/DXIp4Rwlu
JBqFQVspWAJhoZpcyNRkHssx81Tnw7ebGFk2KQWGAoEL1Q49vGsSHrcMFMF5vnWc
pOlm70Vs+qR5oSYE3iR8FfY+NLwZDnO3yAmzPP1nhZ4S1iZYWLhQ4NYO/b/j7wCi
3skMtLFMJZImXBafHotySP/koVG/gw==
=vEOZ
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
