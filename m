Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47C520855
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597157666;
	bh=Zl1pJ2DFMmfKMyJErLFYhmOgyXO6PRB0VQI/KuGEDw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U03R5ka4fyGRi/ciTt3T4rSOm4q8YaqR1J2BfO1i/SZnhUmfQVLZNg4SuFwAtpUeF
	 yB96kmUVAOGXOrWDq943O3zCtEw1mnbhBloBLCTGpx/rip07p5y6hAoRgB9Vrz/0gd
	 AffLrHHu60H71/P22g0SoIesNbCMTGt/yQbi+F/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgHKOyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:54:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgHKOyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:54:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B492083B;
        Tue, 11 Aug 2020 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597157661;
        bh=Zl1pJ2DFMmfKMyJErLFYhmOgyXO6PRB0VQI/KuGEDw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iH7qbb0GzuMV9fPw7/HNe4Txfq+eGeS0iW+h2zR9twWkwrCwj6bRX/czJr6xvZmxO
         BJhNNJLU0wdnPYenJjKjIfSaNWPOJfypoLhQb4DrxzJtSR5eW4EKVvcU3DmrjWI4kE
         ZJXvf1YeXxKuNSeNN5/3K+lEqj30omp1+1UMbIKw=
Date:   Tue, 11 Aug 2020 15:53:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     Takashi Iwai <tiwai@suse.de>, "Lu, Brent" <brent.lu@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Sam McNally <sammc@chromium.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Stuart <daniel.stuart14@gmail.com>,
        "yuhsuan@google.com" <yuhsuan@google.com>,
        Damian van Soelen <dj.vsoelen@gmail.com>
Subject: Re: [PATCH v3 2/2] ASoC: Intel: Add period size constraint on strago
 board
Message-ID: <20200811145353.GG6967@sirena.org.uk>
References: <6466847a-8aae-24f7-d727-36ba75e95f98@linux.intel.com>
 <DM6PR11MB364259049769F6EF3B84AABD97480@DM6PR11MB3642.namprd11.prod.outlook.com>
 <3f3baf5e-f73d-9cd6-cbfb-36746071e126@linux.intel.com>
 <CAGvk5PohOP0Yv22tb53EX=ZLB9_vOMb=iujTh64OvHmjC1d4mg@mail.gmail.com>
 <DM6PR11MB3642AC7F8EC47EB48B384D4797450@DM6PR11MB3642.namprd11.prod.outlook.com>
 <CAGvk5PogmqfEnFRA8hzby+AGgbOSvbELamh_1=eA9KTpyBMPYQ@mail.gmail.com>
 <s5htux939x1.wl-tiwai@suse.de>
 <CAGvk5PpcmkZ2HarqeCDaXm4id=84wYs-u4vWxJunHaf09gj66g@mail.gmail.com>
 <s5ho8nh37br.wl-tiwai@suse.de>
 <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5L6AZ1aJH5mDrqCQ"
Content-Disposition: inline
In-Reply-To: <CAGvk5PphzkdiNfW8hiDuqX+2eQO2FvrpzA0qR3=3VvqM3GBhAA@mail.gmail.com>
X-Cookie: Gravity is a myth, the Earth sucks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5L6AZ1aJH5mDrqCQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 05:35:45PM +0800, Yu-Hsuan Hsu wrote:
> Takashi Iwai <tiwai@suse.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=8811=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:39=E5=AF=AB=E9=81=93=EF=BC=9A

> > ... Why only 240?  That's the next logical question.
> > If you have a clarification for it, it may be the rigid reason to
> > introduce such a hw constraint.

> According to Brent, the DSP is using 240 period regardless the
> hw_param. If the period size is 256, DSP will read 256 samples each
> time but only consume 240 samples until the ring buffer of DSP is
> full. This behavior makes the samples in the ring buffer of kernel
> consumed quickly.

> Not sure whether the explanation is correct. Hi Brent, can you confirm it?

This seems to be going round and round in circles.  Userspace lets the
kernel pick the period size, if the period size isn't 240 (or a multiple
of it?) the DSP doesn't properly pay attention to that apparently due to
internal hard coding in the DSP firmware which we can't change so the
constraint logic needs to know about this DSP limitation - it seems like
none of this is going to change without something new going into the
mix?  We at least need a new question to ask about the DSP firmware I
think.

--5L6AZ1aJH5mDrqCQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ysQAACgkQJNaLcl1U
h9AeeAf/UWVHZwuLSbdU4F24gTh9Evg65nXjOQ/J9iQI9FUTAWaZmBBgfnbWlbRx
1sqvxQ03kOtC40oS9jFz0hYMwDMQm4seHQfg9Zy0gr6DUHcZBnh+eTmn//6u6Xto
W68Wr61drakKTT+9jqC5j694fxtAl1uAvrySfjiIoAJFUg+JRsytjzaeUWRGY1+z
9EjA+q5dX7LuwPKxUmkPkSipJwxXF4zateJ3VnKK2dmNvtnFbYAYD+b7FK2x+9sK
Q30ZaYcs5rlAif136+aUFKABTBjVBjxzE1yGlD66ZipYapXuFo1IyGiQWwq2phPT
ZRU1vj4Zn9eW/Ma7XKCxMWgxJHEoOg==
=CfWE
-----END PGP SIGNATURE-----

--5L6AZ1aJH5mDrqCQ--
