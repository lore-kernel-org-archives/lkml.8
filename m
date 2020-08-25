Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62A4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E4472074A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598385717;
	bh=9BFGQrBVGwKkcS5++4f44QQmctuXCZMD3MvnoANhqaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=If5OEXMpPTmhsccIDcwXPFK4iAucyE7256UBakFQzrxzhXa2kxCCJGyWF/r3Wgpiu
	 Ib71xva0TzWXEN462ExYqNTNwiieNz5eV/14eHwIKlNFWG3vNIx/JR3Pd318KulrE6
	 h90/deuiA4UnekPpneOTc32IuwffXEgRFyyCylf4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHYUB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgHYUB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:01:56 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEE442072D;
        Tue, 25 Aug 2020 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598385715;
        bh=9BFGQrBVGwKkcS5++4f44QQmctuXCZMD3MvnoANhqaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAySD+XMelBy6xMUpOIqw4YpRkgDbT4b4mDBDHcmzKzdvZoX1y8uMEkmJRnt9M/3J
         vUUbAchCmMJyuGVSIpK3iw5IDCGbLy5HNFw3elDGvG1F2CTvLsPTAbz/HNhbVUeqG6
         dxoQLX56Im+R5kSZilq/m0C+5rYKGuN8/wuS1am0=
Date:   Tue, 25 Aug 2020 21:01:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao <srivasam@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vsujithk <vsujithk@codeaurora.org>
Subject: Re: [PATCH 5/5] Optimise lpass variant structure
Message-ID: <20200825200119.GJ5379@sirena.org.uk>
References: <1598375788-1882-1-git-send-email-srivasam@codeaurora.org>
 <1598375788-1882-6-git-send-email-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0FRtVia6Q6lt+M0P"
Content-Disposition: inline
In-Reply-To: <1598375788-1882-6-git-send-email-srivasam@codeaurora.org>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0FRtVia6Q6lt+M0P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 10:46:28PM +0530, Srinivasa Rao wrote:
> From: vsujithk <vsujithk@codeaurora.org>
>=20
> lpass variant structure has I2S and HDMI register fields, which are used
> exclusively. To optimize memory, replace with union to select either
> I2S or HDMI register fields.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--0FRtVia6Q6lt+M0P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Fbg8ACgkQJNaLcl1U
h9ALOgf/Q++4zJDPt4TU4W9oHkQIZCvfQJMKc660SOgV0anLwXafEPGpcSmNY3zu
5D2MW7A+6NBByXFp0BBGwqjlzOTKK71zef/OxrHl+suzaW/XWe2rDb3AF5oQU01i
/jPDI0aGAZ7+4yR23sEVtgGb++1yTXTNIbBQWRxKSxC+cQaj0dsP8KfIJZGf2PO9
67Exr6RYsqID8IoFuFXSnux1FiCVzzGLgejwfnkH5baqGmA7/ck7H3ehIavVWed4
AxF30mewbt4QOlghFcCtFQwgZqDCE1fD/OUxO0GW+Sf9i6BGW4P3G3qXYOVGpXL9
RluWkG1MsxgEcVsF59UP9OHeFAn1SQ==
=8Cu3
-----END PGP SIGNATURE-----

--0FRtVia6Q6lt+M0P--
