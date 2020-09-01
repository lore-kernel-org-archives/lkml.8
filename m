Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61230C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390E9206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="SJFNbnyI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgIAI5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:57:47 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:53562 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgIAI5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:57:44 -0400
Date:   Tue, 01 Sep 2020 08:57:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1598950661;
        bh=xS/YRlImtljqm7ETg33B59R/Pa8qsUPNDUud3zarTGk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=SJFNbnyIAbEItmUJEOrsR896BmZwgnsZxfug7OMUQETCJwyqHaQJ5XATjAPDdlExm
         cm8QRp1uSRQnDL4Adkx8D9PctEtm88pUNQNF5t9O27xzNmfgqsLNQsyDrCRT5w1c3M
         Xrdzc+jt72n788adu8dJVgZYqQcpEWi6tiPviNfk4UQKeGrBQJf/pvcbpA6VehtHbY
         qTCoM3bptvaf7vv7LfwhLFMjQ+hFr0MnSVh3DrYPbzyZmN1mYKIs+g3SG2euEjT/hE
         ZIEgxjyVnswtyIoJmDnvdmFwGEWdD9msLSEAXySmVQBq08PgSmQkQ2KkLRJNoSmsih
         JielrcdRjQoWw==
To:     =?utf-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Melissa Wen <melissa.srw@gmail.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/vkms: add support for gamma_set interface
Message-ID: <C7EgdPUBX9nRTKx9kkGIZijd0yGMOLEtXOwa2jvk-rKtprmNZKSDP-Jos7mYU88DOQYiXJBnz0_D2FAQ1x7jCwLcR-cmZtzCc5cLsJqyDCk=@emersion.fr>
In-Reply-To: <20200831134852.GY6112@intel.com>
References: <20200829140647.7626-1-realwakka@gmail.com> <UeJwFKvmNgKdZY_icN0-nrFly9R1vbzaMZ-TiyxIIPBcdl278uZsK6YdTTdRl6rFukBAmN-eyCFpnfsIB-El9QpyYiutdcpgJg64n4tsRRc=@emersion.fr> <20200831133858.GA9280@realwakka> <20200831134852.GY6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 31, 2020 3:48 PM, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@=
linux.intel.com> wrote:

> > > It doesn't seem like this IGT test's goal is to exercise support for
> > > gamma LUTs. Does the test just tries to reset the gamma LUT to linear=
?
> > > If so, I think the IGT test should be fixed to ignore "I don't suppor=
t
> > > gamma" errors.
> >
> > It seems like that IGT test pixel-format is to make gamma lut like belo=
w.
> > for (i =3D 0; i < lut_size; i++)
> > lut[i] =3D (i * 0xffff / (lut_size - 1)) & mask;
> > And set this table to drm driver. and test begins. It's the test about =
pixel
> > format. I think you're right. It's not about gamma lut.
>
> The point of the gamma LUT stuff in the pixel format test is to throw
> away a bunch of the lsbs so that the test passes when the result is
> "close enough" to the 8bpc RGB reference image. Without it we would
> never get a crc match when testing non-8bpc or YCbCr formats.

OK, that makes sense. Would it be sensible to:

- Don't set gamma if the pixel format being tested is 8bpc
- Make the test skip if the pixel format is >8bpc and gamma isn't
  supported

