Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E5EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F62E2071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 09:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="OCtM6on/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgIBJJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:09:40 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:57005 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgIBJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:09:20 -0400
Date:   Wed, 02 Sep 2020 09:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1599037758;
        bh=tWZLjcjpso7hjA2WIHTYXpXERR7Rr72qonBHENyVUic=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=OCtM6on/gZ0ul9beiqs+h6tfxzqMwNoEgh0KOMhiK4wJgFngrAoHuauJBUvPBXfZR
         ssM3+Fp3Hl4kO/KU6fqcc5xI00srJ+T7mYBlW7KPt6coX3GdGPLb7XoKuWotg6liAn
         UWLMEyEo8Rd3g7rl+56KDPfy4auvXuOm9rLI8Av8jNi3V2exqaGNVmdasJjMG0s42j
         vz+NH/qSj4XBMGp6eLJ/6WTNrKjW62+OBXwVw8Z2yyahKMRhV+TsoAJsvIlPBEPCh3
         3HdEXAjZVzWHEZLX91ti8HnEcZJSmOwJ64n4ajA/mHAa2PmFUwd3d+IKIROMUJS5zm
         K+YTYFZMtCjaQ==
To:     Daniel Vetter <daniel@ffwll.ch>
From:   Simon Ser <contact@emersion.fr>
Cc:     =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        Sidong Yang <realwakka@gmail.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/vkms: add support for gamma_set interface
Message-ID: <DtMHF2YzGDmVCCHE0UKH2NdZW1XmY3V3DoP-rvWbpYlFi1s5ncHyqDZd27U6ya_LBm64G73rqYlZMU0rI4IBcdiUaiSvtGDj2WW3bgZGKDc=@emersion.fr>
In-Reply-To: <20200901132656.GD2352366@phenom.ffwll.local>
References: <20200829140647.7626-1-realwakka@gmail.com> <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr> <20200831133858.GA9280@realwakka> <20200831134852.GY6112@intel.com> <C7EgdPUBX9nRTKx9kkGIZijd0yGMOLEtXOwa2jvk-rKtprmNZKSDP-Jos7mYU88DOQYiXJBnz0_D2FAQ1x7jCwLcR-cmZtzCc5cLsJqyDCk=@emersion.fr> <20200901132656.GD2352366@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 1, 2020 3:26 PM, Daniel Vetter <daniel@ffwll.ch> wrot=
e:

> On Tue, Sep 01, 2020 at 08:57:37AM +0000, Simon Ser wrote:
>
> > On Monday, August 31, 2020 3:48 PM, Ville Syrj=C3=A4l=C3=A4 ville.syrja=
la@linux.intel.com wrote:
> >
> > > > > It doesn't seem like this IGT test's goal is to exercise support =
for
> > > > > gamma LUTs. Does the test just tries to reset the gamma LUT to li=
near?
> > > > > If so, I think the IGT test should be fixed to ignore "I don't su=
pport
> > > > > gamma" errors.
> > > >
> > > > It seems like that IGT test pixel-format is to make gamma lut like =
below.
> > > > for (i =3D 0; i < lut_size; i++)
> > > > lut[i] =3D (i * 0xffff / (lut_size - 1)) & mask;
> > > > And set this table to drm driver. and test begins. It's the test ab=
out pixel
> > > > format. I think you're right. It's not about gamma lut.
> > >
> > > The point of the gamma LUT stuff in the pixel format test is to throw
> > > away a bunch of the lsbs so that the test passes when the result is
> > > "close enough" to the 8bpc RGB reference image. Without it we would
> > > never get a crc match when testing non-8bpc or YCbCr formats.
> >
> > OK, that makes sense. Would it be sensible to:
> >
> > -   Don't set gamma if the pixel format being tested is 8bpc
>
> Hm not sure what 8bpc format you mean here, because we have C8 (needs
> gamma table or doesn't work) and the 8b greyscale one with the R8 one. If
> you ask for legacy 8bpc you get C8.

Why do we need a gamma LUT for C8 and R8? There shouldn't be any
precision loss, right?

> > -   Make the test skip if the pixel format is >8bpc and gamma isn't
> >     supported
> >
>
> Yeah the test should skip if gamma isn't there.
> -Daniel
>
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
>
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch


