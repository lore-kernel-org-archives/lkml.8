Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2FEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D59C62070B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595938040;
	bh=i89zf4KrxMnYTcBcBgNPBorSV2YMDEBMg4rupQdyRL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W7MSdcz+wOE7igRvby/D7gw3W23oJNugYwoBu65EFqyoS4Vovloi4p+fZWr2vgkGR
	 dXTObMz4zS/1pTs1p1Gf0Z4duHdP+Xp+qgyp6UgGE4oXbyj9VeVw0CvXaC5msaIZdr
	 Yfqtk9KCS6XZdjyV8XLwutUIidyjA4Fwju6OLoyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgG1MHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:07:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728560AbgG1MHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:07:18 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8C50206D8;
        Tue, 28 Jul 2020 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595938038;
        bh=i89zf4KrxMnYTcBcBgNPBorSV2YMDEBMg4rupQdyRL8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eKgH0oek/9Y50A7XqRXtGZQ2NizOut7eUI8p5yAoOEpXYWI0XjTmaNiJmjMfcWQ/k
         +MSyAvroMBPUccgaO1tUqLwGWOewX9YnI4zTNGFnHl0AGFawDFteSLLnn3DHfUvZ6h
         nc4CZYw8XpSE7a7x7ncby8oZ37mpJtekV0ChJfpo=
Date:   Tue, 28 Jul 2020 13:07:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
Message-ID: <20200728120700.GA5055@sirena.org.uk>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
 <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
 <20200727160941.GE6275@sirena.org.uk>
 <DM5PR1201MB01393D93D69F1552408BFE79E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <DM5PR1201MB01393D93D69F1552408BFE79E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-Cookie: Death to all fanatics!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 28, 2020 at 06:59:50AM +0000, RAVULAPATI, VISHNU VARDHAN RAO wrote:

> So Actually for rt5682 codec Now in 5.8 there are three flags :
> SND_SOC_RT5682
> SND_SOC_RT5682_I2C
> SND_SOC_RT5682_SDW

> But till 5.7.8 we have
> SND_SOC_RT5682
> SND_SOC_RT5682_SDW

> So in our design we were using SND_SOC_RT5682 which build snd_soc_rt5682.ko
> Creates the respective codec_dais as defined in that .ko

> If we use SND_SOC_RT5682_I2C we get snd_soc_rt5682_I2c.ko , it is not creating the expected codec_dai links.

Could you be more specific about the way in which "it is not creating
the expected codec_dai links" please?  What are you expecting to happen
and what happens instead?  Do you see any error messages for example?

> As there are three flags defined in codecs, I expect that previous one which we were using(SND_SOC_RT5682) is not a wrong flag and I expect to use
> SND_SOC_RT5682 as it is still available.

Given that the core module does not register with any bus it is
difficult to see how that could possibly work - the core module doesn't
contain a driver at all.  Have you tested this change?

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8gFOMACgkQJNaLcl1U
h9BcBQf/evND4lv/np/6IuxKAr9CDwXqhYJaiRLCi4mRBWhP9tAa96ymV1cks6xu
gLwbaJfqBhYS/hqy1/A382ZnR4exFn7dCuOOwlAG8KSn5IN1K7LLxhghrOpd6rK6
2Lgkn+dS08eyJbJIzMrSPb8t4rHGiN/h8PeXViV+SVI6aYbfmANP8AZWvBCdTAR8
TqjFEUShb8gzGg+vlKeMcfmvJsJilitZYCb4HG6h9QWBvmZJsrNCsdN3MKI93eJw
YCt5YSkDt6C5e+h//rJy1TB++UkHdQ4/KusVOflJ0KGMQTwvwXM5j7RrME056sKu
5HXys5w3c0ZOsPa66tNPGBowUw7SjQ==
=wiz1
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
