Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B40C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55E720801
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582231718;
	bh=uxj2CTanYGB1yEVrPsFy57vqZ7ewHIyjriDExiJsoTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NKQfP5I0A0/5ST2erCw+wf03UIT5qsJEoiPsc27tDnTFA6PLKl4mCQ6b5CFY+ZN5f
	 adTHM/gNyGUHnBMTkV/5fKuf2CK4LWXfDUT6nrVxy6gVw9IB2ejVXAf1w3KsZrM8Ix
	 ur8zdK1FLfJI9Gk3ZFkZvN0SiRFWsh7EAd78KOfU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgBTUsh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:48:37 -0500
Received: from foss.arm.com ([217.140.110.172]:51318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgBTUsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:48:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6072E30E;
        Thu, 20 Feb 2020 12:48:36 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A3C3F68F;
        Thu, 20 Feb 2020 12:48:35 -0800 (PST)
Date:   Thu, 20 Feb 2020 20:48:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200220204834.GA20618@sirena.org.uk>
References: <20200219125942.22013-1-dmurphy@ti.com>
 <20200219125942.22013-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
In-Reply-To: <20200219125942.22013-3-dmurphy@ti.com>
X-Cookie: I'll be Grateful when they're Dead.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 06:59:42AM -0600, Dan Murphy wrote:
> Add the tlv320adcx140 codec driver family.
>=20
> The TLV320ADCx140 is a Burr-Brown=E2=84=A2 highperformance, audio analog-=
to-digital
> converter (ADC) that supports simultaneous sampling of up to four analog
> channels or eight digital channels for the pulse density modulation (PDM)

This doesn't apply against current code, please check and resend.

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O8KEACgkQJNaLcl1U
h9Bt2Qf+NPWxuWjvFJykGdOsQaUJzxyvmW97nFWbcYWGFf6iFFmEHq4uXC0zbBWI
oC7YOTUca78ofsuv7fU9sWAdVMPSB9znSXs+tArD+7e/yUaIhLvSDGEQ7RxwQQ6e
42A18z1q1pI5zuEWlg99RISaeC/yqcpFOT9GevJ6DgP+6k1FGqQwzQ8UChGnggtt
L4q0lG/lEUAEyCCNyhdIKHJkr9Ba++dN9tQptfjofqFgZzAhYb7YdsFln/9xWF69
VXSdPEF0Mz4f36lMCBi7UUvzq+2qFGyc6qTCLq0I5YeDj7j0y4/1o/KofgLH2XFM
wwcuIR1f5tsq+mBxv3jKsG3kFFSRjw==
=X0sz
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
