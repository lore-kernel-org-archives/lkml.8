Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD37AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82A5B20789
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593110750;
	bh=GQtwcOiEBS2HHEq79NnPPfp5gviXKLl6/pBSn3mULqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CXo6iUxLPEKnoxvvm3ZFa5kI8KYbjFU+tAZP7MJ0Y0RwNwSRUDn1hX+liHuarvrnX
	 5MkG6CGAbK+W6E0+ugDLBe2UHfLWLdcrqav1Pml+nC2DNECRWzJbeW3hgbfXM7CdKN
	 nXWGKsxRcDLWHTS4H4Jogpqwzngn9rbVRbCV39bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406300AbgFYSpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:45:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406321AbgFYSpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:45:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F063C2067D;
        Thu, 25 Jun 2020 18:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593110746;
        bh=GQtwcOiEBS2HHEq79NnPPfp5gviXKLl6/pBSn3mULqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZ3VCCLQ4zBQV3TNalCCGRnG3ehG0WE6FBnB6E3RNWV2cLX57FOn/OBLRVx1WKr65
         5rwdKwhCAG+Q81slscZl9nbluOxibB0MNBvDXWJSO3UUOZPtLL4peGpRqZc5EMzTvi
         i28P2DGcg5Z4cMaNVqYfxXSI+WbL/wvRyg87dA6k=
Date:   Thu, 25 Jun 2020 19:45:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] regulator: devres: Fix issues with kerneldoc
 headers
Message-ID: <20200625184544.GG5686@sirena.org.uk>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-3-lee.jones@linaro.org>
 <20200625172813.GD5686@sirena.org.uk>
 <20200625184218.GU954398@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KIzF6Cje4W/osXrF"
Content-Disposition: inline
In-Reply-To: <20200625184218.GU954398@dell>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KIzF6Cje4W/osXrF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2020 at 07:42:18PM +0100, Lee Jones wrote:
> On Thu, 25 Jun 2020, Mark Brown wrote:
> > On Thu, Jun 25, 2020 at 05:36:06PM +0100, Lee Jones wrote:

> > > + * @dev: device for regulator "consumer"

> > That's an odd style you're using in your "change" here - why the quotes?

> It's taken from other instances in the same file.

Should probably fix the others then - I suspect it's bitrot and
cut'n'paste from when there was a parameter called consumer.

--KIzF6Cje4W/osXrF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl708NcACgkQJNaLcl1U
h9Dm7Af9GpsYiaxlugAid1HtpIboMQBNtP7D8PTHVlBJmr/ZlGPe17gNFmHLA+jw
LbRxfyNw81E2Y4vOMf57BgPwjTBnzPRU5EKFw4fNmv0wQ3FCCQxt1AqYm66xuagM
6IjlymzQxtJE02c6425QV4snvR9I3qCl0zuO5o83Y2KpEI+Zgxmw3hPPaH5D1w/b
Em6Cqxss/QNM3L8KR1KvbRKZxcJ2V7wKqmiBCzGNDhg/joigP6Ppdd41pqs/UAzS
drf9fiylLIKMjnDSwf2GNfbnwQRalkiqZcho4V/zV249PBgriPGJjuhnfkpgTpOy
YyJnW8xhAKg0KXk3ulkqCUSV6aJ2fw==
=pHSu
-----END PGP SIGNATURE-----

--KIzF6Cje4W/osXrF--
