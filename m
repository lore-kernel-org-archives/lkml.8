Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC04C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1649720835
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590611784;
	bh=CNQRsO+0H5i6utzLD3vsY5AjI3hqa7+NllViwRiFbFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2m2sK7lWVou0dbyOesVNN2NbO4WvdVJ/tuqW6GWScuFLrTU4YL2LP80RWDqRTsFnb
	 fGa8nPHF9dQlzbIvta11gJIML49mNozaF67jMsVslh6tVrXxjYoSWrAtP8iZG1cGnP
	 XXtICsZNdzEDKSGk1K1dtooYLSOiFSEKDrZLoT6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbgE0UgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:36:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:52482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgE0UgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:36:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C1A207BC;
        Wed, 27 May 2020 20:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590611782;
        bh=CNQRsO+0H5i6utzLD3vsY5AjI3hqa7+NllViwRiFbFI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d69iFl8NF+FL2E+EltlfExR4guxGUs9T1VPM/MfwkPS7zcyCzVUw+W51ObVX8SIbV
         0ryA0j5ecW0jvASW8S0rngMOn3eu5s87MQpVzthuG+WsatMMXson/tmTVFXdNQag4i
         llC9hyLAQCfFzlSxRT8YVBKA/qwdyoNMrW7QdSOw=
Date:   Wed, 27 May 2020 21:36:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regulator: Add support for sync_state() callbacks
Message-ID: <20200527203620.GK5308@sirena.org.uk>
References: <20200527074057.246606-1-saravanak@google.com>
 <20200527111750.GB5308@sirena.org.uk>
 <CAGETcx_Hr75W7VJT-2CnS=VVCW+B4ktv=4vdVQoxkhP4TAPF6Q@mail.gmail.com>
 <20200527203453.GJ5308@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cN0A5YokcrYPGsSB"
Content-Disposition: inline
In-Reply-To: <20200527203453.GJ5308@sirena.org.uk>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cN0A5YokcrYPGsSB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2020 at 09:34:53PM +0100, Mark Brown wrote:

> Please also talk to your colleagues, IIRC a good proportion of the
> variations on this have come from them.

Sorry, just as my mailer went back to your mail I saw that you're at
Google now - the previous stuff came from Qualcomm/Linaro people, my
mistake.  Not seen patches for this from Google before!

--cN0A5YokcrYPGsSB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Oz0MACgkQJNaLcl1U
h9Bg1AgAgQnlpG35MAC5Hph3XfT1VmOClOgD3Z+806Oe4X8FCOdPO+LTgGI3JiPU
/nf3gNNpRipIkwB6/WRBwbS1qWIN8a35+RidmBt217gMSMFkrjK0bIJsBk9LI85k
0B85PE3mADh+0wYWAE1pH81Z3f5YIHNoYTIAs3VvPce3jyz+VTbZfUHdYFs4nfLA
ih1FE29EbLF3AGdEzjGJ1O6V4jlR8uq3SZjw2TYi6W4yeavxFaFujDdFkrmlCL23
DwNxkjwvf/jMfyIvbB1Dh7pGIoJTQSfYSWeesy4L6f6j2MgHp61keAM0boNRgcYX
smYUBW1dgo8WLxdpV27bDUN6+ZIIkg==
=j4OR
-----END PGP SIGNATURE-----

--cN0A5YokcrYPGsSB--
