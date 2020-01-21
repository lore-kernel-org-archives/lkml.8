Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA8EC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A15206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579627620;
	bh=gze/C3hpk7sc3iWmW/KEvaoeJUnGudmqmDjYEPW1V1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QlWO0FHgGOB3f2Ax8aASQV1MnYvHR+Ar/DVxzgDevohOPb+F+vaqQuX2z9nVY+QzN
	 yUSSsOR6j3h9PxSlqRuCpqwg6/UVFCKatcFJHmIFX/eLsMOLahIosE5HJDCAnxzkgG
	 i3SVm4smFSImC4Z76+l4ez9Nb/QQZa3w7c48WNYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgAUR1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:27:00 -0500
Received: from foss.arm.com ([217.140.110.172]:46332 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729080AbgAUR07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:26:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3040E30E;
        Tue, 21 Jan 2020 09:26:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A064B3F6C4;
        Tue, 21 Jan 2020 09:26:58 -0800 (PST)
Date:   Tue, 21 Jan 2020 17:26:57 +0000
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
Message-ID: <20200121172657.GK4656@sirena.org.uk>
References: <1579603421-24571-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200121165925.GH4656@sirena.org.uk>
 <DM6PR12MB3868B9744A40D41450155534E70D0@DM6PR12MB3868.namprd12.prod.outlook.com>
 <20200121170811.GJ4656@sirena.org.uk>
 <DM6PR12MB386893EE3876B51B35A1787BE70D0@DM6PR12MB3868.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zPXeIxDajdrcF2en"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB386893EE3876B51B35A1787BE70D0@DM6PR12MB3868.namprd12.prod.outlook.com>
X-Cookie: You too can wear a nose mitten.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zPXeIxDajdrcF2en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2020 at 05:12:42PM +0000, RAVULAPATI, VISHNU VARDHAN RAO wrote:

Please fix your mailer to quote replies normally, it's hard to read your
mails.

> In what way is it part of the fix?  This at least needs some sort of
> explanation somewhere, the changelog at least if not the code.

> When we play subsequently we hear last played sound for moment.kfree clears the structure.

If the rtd is still being referenced after the kfree() you have a use
after free bug so there's a serious problem there and this change is
introducing a bug, you can only free things if they are not in use.  At
a bare minimum I need the changelog to clearly explain what the cause of
the clicks is and how the change fixes that.

--zPXeIxDajdrcF2en
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4nNGAACgkQJNaLcl1U
h9CM4wf9HXTZtK9+VuEbzuneGipxxDkweRo9fNWDmS99cGqfZ4b02i/Cudd1lseC
UFrh2Wdi+7RL5mSZhaGqi9XSgfgrl+rVPtX/MTKZ81OjzU49YIoMBf7jGi5Hvt7f
8wfoyzpnQ+mPecpWLQr9K2krccs2I/H40U/qOY9YHYraAKq1sM3qYZL0jKa45PYH
CL80QIqHSVKyf6k3aptNYv045aqVKyZ992lSmGBa2zud+kdsUEimJNtado1bm3fX
QSthv9uf8J3sOBJZ76yjDPRt9miQ1qt8DSsPCw+dJ9zONy8ZSVN68EshAhFhqMvH
khbp0nAECP4U9cdYcWW2Ni2gaNqSVA==
=Bp1m
-----END PGP SIGNATURE-----

--zPXeIxDajdrcF2en--
