Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9E5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E079C22CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595243186;
	bh=fMzQZxCjA9TLLyynEttPLRdt9/QovZwDeBBAMGz57gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cyqz2zuZDZSValw5N/Sae+BNScgmkjbc9iihXixUV4PYZDJ1ui8sAQv2OgAmqRjkV
	 AbbPOpuB8cSFDo0N1NdgD2fDzMUK8Lu9eJda1DHVuV6/0xU+OEyfkNpD1D6BR2YVsy
	 2ZTp6c2MKyYdb8SqRBEPgauGohqcdGFH1kxX2Kuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgGTLGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgGTLGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:06:23 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0468322BF3;
        Mon, 20 Jul 2020 11:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595243183;
        bh=fMzQZxCjA9TLLyynEttPLRdt9/QovZwDeBBAMGz57gM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x9t2Q/Mm4W029+S0OHhdCYt1Sl01zy5Hnmf+NSEMxM8zA/CKA30fGnjyaaBkssNAJ
         /xa1MG9fDgjDNU96yTbEsFRkb0xvBcbdFLmGhwNx1x2xIF2aRwxt2uPMIGJ1CLlTZM
         hzYcdrXSfanWfcwT2/hFBFHLDso3HRV0iYjyR1sM=
Date:   Mon, 20 Jul 2020 12:06:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2] regulator: gpio: Honor regulator-boot-on property
Message-ID: <20200720110610.GA4601@sirena.org.uk>
References: <20200720100113.6481-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <20200720100113.6481-1-wens@kernel.org>
X-Cookie: Be different: conform.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 20, 2020 at 06:01:13PM +0800, Chen-Yu Tsai wrote:

> Also drop support for the undocumented enable-at-boot property. This
> property was not documented in the original commit introducing DT
> support, nor is it now, and there are no in-tree device trees that use
> this property.

There may still be out of tree users, an ABI is an ABI.

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Vep8ACgkQJNaLcl1U
h9A9Nwf/dcUIHywQFVenvO17WuYl81IoCPpJi+2uE90Pyw/nVR1g1fgEHwKN15bS
UjhFTe0ULwd78w/qRBmOuh+uF/SFIwfUa+cQIRiJ1X8lKrA4YycC+oBMDskfsffr
tzMs+RCPBM2/jq3WEnypFnn25Y9r5W2nwwiTKLCMs+p6py/DnN8MyDVd0JFV4LDx
HnYJ/DhwHDEFxjOobc2PuMABgOZ0tTzogx9o3AdlW3OdY+4n/IZsysUbkzYhahoA
ssRZgm4liCiYgzjANE/uEge8oGnRNgBUoD7EF09XUe81al8oSdFfMHOJFjv2oH5J
YXt9p2CUA+hSQ1851RaWuJolt2wILg==
=cHRV
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
