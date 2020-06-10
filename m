Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88BD206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591784976;
	bh=pWbMBf+2NHLWsd74kJCHTKb/ilpX227pIQD4SgmxOzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yjeI54pUk87zP7Zw+pETuv7KXAHP5CBCMQ1uEY67RQ9GeMMmK/3/hd40/OG9VPh+n
	 gC4l73CCwSDs7kpb40iV35qyBbGrgx2zmPuTpVJJ+uLJjeOi7h3cKmN/pUSABfesVH
	 1ElO3G8KVkMSRpxuTet53qELCa33vS/VaZT64l7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgFJK3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:29:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgFJK3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:29:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762FE20656;
        Wed, 10 Jun 2020 10:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591784963;
        bh=pWbMBf+2NHLWsd74kJCHTKb/ilpX227pIQD4SgmxOzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1XmLlrByds01M+op+BGXfLVCmQNRSnVf5dOMutgcNHgrt1Pf4i7SBvhZ9G2zTZsOG
         KtO7gr4mFkvcNsDUD1RoMT4uuweLbOKyjlxmUI5arnGFC+9eE22vLXgefXEnpceHLD
         fXUQQIy6V1Q9PWKQzwHPypIwFKSufu/mSvdOMHsU=
Date:   Wed, 10 Jun 2020 11:29:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200610102920.GC5005@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
 <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 02:20:29PM -0500, Dan Murphy wrote:
> On 6/9/20 1:47 PM, Mark Brown wrote:

> > That's really not very idiomatic for how Linux does stuff and seems to
> > pretty much guarantee issues with hotplugging controls and ordering -
> > you'd need special userspace to start up even if it was just a really
> > simple DSP config doing only speaker correction or something.  I'm not
> > sure what the advantage would be - what problem is this solving over
> > static names?

> IMO having a static name is the problem. It is an inflexible design.=A0
> Besides the firmware-name property seems to be used in other drivers to
> declare firmwares for the boards.

> But if no one is complaining or submitting patches within the codecs to be
> more flexible with firmware then I can just hard code the name like other
> drivers do.

I'm not *completely* opposed to having the ability to suggest a name in
firmware, the big problem is making use of the DSP completely dependent
on having a DT property or doing some non-standard dance in userspace.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7gtf8ACgkQJNaLcl1U
h9CbrQf7B8RtgYmxR3DH0mpsVd3cVro2R/WpXyZk1PyY6j+8VLCYx2e1D8Qu0GJn
6nGhVdulQbM2keMV421wGC73yoAPvIU+UHrW8JdJLJ+Se2uhqZS7DPPjcdUJBmz6
pSt2frp+Jz4iNn+8bFV69Ubj7FoDB71r4wkSqprOW38aB7wNZOIM31mAf+hfn8ps
juyneFqACKwv4OctOdk3A3kK8UP+EQviWvR+EAG5kJIkznLGht+Fx9U5Li8fBXEz
IXv0w6uKhw919KWhtVQg+w2yLPCqDSopsIo7UGg9HJ/FXeVK4qgbXdpvQPo26H6m
Gc92N1Ej/OumXlfZArpAtbFZjNhDpQ==
=SvRr
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
