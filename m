Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79985C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5524B20786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595950566;
	bh=+Qv843WX0BAFbIyq+Ws3moPqPQwPgQC5NAL9fW3CxTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RatkG8EsaZlGh5AGwwdUsi74qxao4EB5fqWo+L38H4lk/QdUCaXTh7dHBLEu/abZK
	 GrRoaZH/a6FIbJhOVfGaILFyLNpcJ9BKf9lMvMIjgJE79n45PdEPpX7+jjxCw0WLRA
	 Fg8p/aJLoD9WN1aT/GoIM2nlW1QIf0ZyEDofS/TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbgG1PgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730824AbgG1PgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:36:04 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2171B206D8;
        Tue, 28 Jul 2020 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595950563;
        bh=+Qv843WX0BAFbIyq+Ws3moPqPQwPgQC5NAL9fW3CxTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVYL2L+3EJhasNWcQkLBOuC0Mb4hM5ogQa9ZtCLgvwJp3x5gI3iy6ilFRIYKAxKGp
         GLc1KQbnEuLeIpc4WT6N6rVTPQ8OrewLfQB54T/AV05SeImCYqj30vySxT/h1NWtH0
         3PMqaykz0JuvTABu3QyxYc/K/OZUUFBsSCu8UmVI=
Date:   Tue, 28 Jul 2020 16:35:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Takashi Iwai <tiwai@suse.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5682
Message-ID: <20200728153545.GA24701@sirena.org.uk>
References: <20200727145840.25142-1-Vishnuvardhanrao.Ravulapati@amd.com>
 <20200727145840.25142-3-Vishnuvardhanrao.Ravulapati@amd.com>
 <c467e2ee-727d-4bf5-8ceb-90c784245a43@linux.intel.com>
 <20200727160941.GE6275@sirena.org.uk>
 <DM5PR1201MB01393D93D69F1552408BFE79E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
 <20200728120700.GA5055@sirena.org.uk>
 <44e86246-516f-3a32-af66-e1c23f560e77@linux.intel.com>
 <DM5PR1201MB0139AC067DF7F2E2AB9FCC96E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <DM5PR1201MB0139AC067DF7F2E2AB9FCC96E7730@DM5PR1201MB0139.namprd12.prod.outlook.com>
X-Cookie: You will be misunderstood by everyone.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 03:24:42PM +0000, RAVULAPATI, VISHNU VARDHAN RAO wr=
ote:
> [AMD Official Use Only - Internal Distribution Only]
>=20
> -----Original Message-----
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Sent: Tuesday, July 28, 2020 5:48 PM

I'm not seeing any new text in here?

> To: Mark Brown <broonie@kernel.org>; RAVULAPATI, VISHNU VARDHAN RAO <Vish=
nuvardhanrao.Ravulapati@amd.com>
> Cc: moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM... <al=
sa-devel@alsa-project.org>; Arnd Bergmann <arnd@arndb.de>; Liam Girdwood <l=
girdwood@gmail.com>; open list <linux-kernel@vger.kernel.org>; YueHaibing <=
yuehaibing@huawei.com>; Takashi Iwai <tiwai@suse.com>; Deucher, Alexander <=
Alexander.Deucher@amd.com>; Mukunda, Vijendar <Vijendar.Mukunda@amd.com>; E=
nric Balletbo i Serra <enric.balletbo@collabora.com>; Agrawal, Akshu <Akshu=
=2EAgrawal@amd.com>
> Subject: Re: [PATCH 3/6] ASoC: amd: SND_SOC_RT5682_I2C does not build rt5=
682
>=20
>=20
>=20
> On 7/28/20 7:07 AM, Mark Brown wrote:
> > On Tue, Jul 28, 2020 at 06:59:50AM +0000, RAVULAPATI, VISHNU VARDHAN RA=
O wrote:
> >
> >> So Actually for rt5682 codec Now in 5.8 there are three flags :
> >> SND_SOC_RT5682
> >> SND_SOC_RT5682_I2C
> >> SND_SOC_RT5682_SDW
> >
> >> But till 5.7.8 we have
> >> SND_SOC_RT5682
> >> SND_SOC_RT5682_SDW
> >
> >> So in our design we were using SND_SOC_RT5682 which build
> >> snd_soc_rt5682.ko Creates the respective codec_dais as defined in
> >> that .ko
> >
> >> If we use SND_SOC_RT5682_I2C we get snd_soc_rt5682_I2c.ko , it is not =
creating the expected codec_dai links.
> >
> > Could you be more specific about the way in which "it is not creating
> > the expected codec_dai links" please?  What are you expecting to
> > happen and what happens instead?  Do you see any error messages for exa=
mple?
> >
> >> As there are three flags defined in codecs, I expect that previous
> >> one which we were using(SND_SOC_RT5682) is not a wrong flag and I
> >> expect to use
> >> SND_SOC_RT5682 as it is still available.
> >
> > Given that the core module does not register with any bus it is
> > difficult to see how that could possibly work - the core module
> > doesn't contain a driver at all.  Have you tested this change?
>=20
> I share Mark's point. Have you tested this change on top of Mark's tree, =
or only on top of the stable kernel?
> Ok. I will drop that patch and send the other series.
>=20
> Thanks,
>=20

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8gRdAACgkQJNaLcl1U
h9BBXwf/ZN8QadzJHuG8zpsrk+YJVBuEouKFAFQJAZrcmA0pVaoJ6GXQhPOfyh4U
eZOAB91y+rWKikfX+fQJWrKbw1BJL9CIvPpzij8TP9oe92wV3NtjqDAZEHRqvFi1
oV4m5xo0DZjfRmTceHnzMs0hzsBLYZJUHTjznDyHJDPlMmG3pQxfobG7uVsvDEzk
+piMnsq4OOf8DykqUa77xFZh+yNoc4PSLDxx2psU4sEEW+9/FmGht27xiTWku1P5
bGbqtge9A4FNHW7ptQp3oupV5zscQxQ2HkKnRVOx8FuH6GPhwK9vQffUkdo6sRnG
FFxN2l7Fo6MsDMV7C/d+mo90beIDng==
=QiuZ
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
