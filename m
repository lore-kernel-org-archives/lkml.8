Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74C0B2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595502340;
	bh=cDmd+AClrTIXXvkMIxqlnPN85VW8f4Ew+hvTI4Dl0YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m3ydUB6zvQY74/1U6hoPTgaWc5dH4UtTLYjjdzanB911MZ7CAcqCimzOAIUV5Ss23
	 pXxeSz3gsfN/siPz1H97c6X5U063DdHX9/jqt6Tz/2BDHjq85J3HuvDFs/Ss08/FhF
	 SjGwTC/kOg6vIsu9J9yvxJVlNRC2FnGEnLBO7LPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgGWLFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgGWLFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:05:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E75206D7;
        Thu, 23 Jul 2020 11:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595502338;
        bh=cDmd+AClrTIXXvkMIxqlnPN85VW8f4Ew+hvTI4Dl0YM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eI1p89PtcGu3MfxPsU3nMkAU3wyuB88VjWAtDh49sWjehzT6n+lmak60sBC2zxI3Q
         AhlS/vADDJRlX3c72RLDz6kDNXRMHyNaQEc3loIaAEsbiBTCr22H7ASuR7k+K46dxR
         zQPSN09nPBlOfNHOspFPYhRhgYL8wdKBc8JrAyYk=
Date:   Thu, 23 Jul 2020 12:05:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
Message-ID: <20200723110523.GA4759@sirena.org.uk>
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <20200723075612.tn5dbkhes2chohwh@axis.com>
X-Cookie: Down with categorical imperative!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2020 at 09:56:14AM +0200, Vincent Whitchurch wrote:
> On Fri, Jun 19, 2020 at 04:25:12PM +0200, Mike Looijmans wrote:
> > +void dwc3_set_vbus(struct dwc3 *dwc, bool enable)
> > +{
> > +	int ret;
> > +
> > +	if (enable !=3D dwc->vbus_reg_enabled) {
> > +		if (enable)
> > +			ret =3D regulator_enable(dwc->vbus_reg);
> > +		else
> > +			ret =3D regulator_disable(dwc->vbus_reg);
=20
> dwc->vbus_reg is set to NULL when the regulator is not present.  These
> regulator_* functions expect a non-NULL pointer so a NULL check is
> required before calling them.

Does the device actually support running without power so that's a thing
that can happen?  _get_optional() should only ever be used for supplies
that may be physically absent.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ZbusACgkQJNaLcl1U
h9A0nwf+IJuuTu/qlJsYFuUJQPV3t/N46dHV6PYxmEqbAuqbolii0elI2nQniu4X
nwgotmRkWYCkBZXMaO9TCifxNsrY+sL5zmuMBORCVAXnHarhx/CV6W3sEqe3+4eJ
CUeY6BeuOONdHbgItrnqG1aJ/MzFPHajuOWQNBKrwZgXWWT9B0sVru59Kw2MFBwD
FGfRAFMcMW890e4/H4MIzD9lIMINZkz2Dj1xDaxgmVAcpxItwbdfOLdVUiJu9QTP
UfEEZLdJaIeB3mbgl9TDBG9RB5Q9dq/X0IcGqX2X9WP4DI+DND0TUZFz7kwwo9pC
b9yadDCwFqRaBP2zQQadLc4c4XcEoA==
=mOZg
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
