Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0606C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE56208C7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592572296;
	bh=uYA3rCg5+KAk7BcZzv3tlB7O/8qXjcCy1uR9kVvVMsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FDsXKOpv0sluO6N1Vec/9jO4eoFqYxFELOba0tbSYj7dnJYZPtQ9woiUxKeA7e+qa
	 KAv5PriDKIkXWiUIbX+ROpiKCxPYVRLtAC7HUYR6evmpIuOuCesa3IFTmidgfB0MKn
	 fH5lPVY52hDtHdUxOV1FEk9oP+KrYnPwAFegoFRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbgFSNLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731398AbgFSNLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:11:30 -0400
Received: from localhost (router.4pisysteme.de [80.79.225.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4873F208C7;
        Fri, 19 Jun 2020 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592572289;
        bh=uYA3rCg5+KAk7BcZzv3tlB7O/8qXjcCy1uR9kVvVMsI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gALEAaxJNuOd1l8j1GvK6rpud+0edq4owOPrtXQhZ8ec7W+djOiI0RJid4I3VVmfd
         km+NDBTPqOJRhAYWfqnCuHvLMtDV+0onnzKa3iQAfe47pEamAkuLj3dxhLVYrb7mH+
         gDsWuzTwf50uPkSvPh68wzzT0WBh6O/Se9Zdp6ko=
Date:   Fri, 19 Jun 2020 15:11:27 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Keyur Patel <iamkeyur96@gmail.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: smbus: Fix spelling mistake in the comments
Message-ID: <20200619131127.GB20493@kunai>
References: <20200612212635.177380-1-iamkeyur96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20200612212635.177380-1-iamkeyur96@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2020 at 05:26:35PM -0400, Keyur Patel wrote:
> Fix spelling mistake in the comments with help of `codespell`.
> seperate =3D=3D> separate
>=20
> Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>

Applied to for-current, thanks!


--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl7suX8ACgkQFA3kzBSg
KbZMow//QrAUyYtZt966AADiXMlz1BwIUmutWwUkHzeo6Pg95/JFswwdGSJs3trl
4KHsBPam0AYHWb94Lj4RTMtgVPAWBt4G7cg7L24+lE7H0rgPPt+JUZqPsOR+6/mn
IYDxgKEeNcfZb0Lp1ewWIubBgiXiCpCfXi78HNpvQ9Fm8DO1lmIfHnT7aTfXpCQu
t99HMSzv6lZthOdQDBVgudDWqPZhQd7YwrCVumznXqLyHZxmR77lp1VJwMqIzi98
tkNWmSju0dyI4jMNEpLYJipggGpjCa+rOt1BcnWlcQb2Y2KBqy8OSvzBFjPYCvFS
5qGBsyEY5a0FSmb/+iGC0mpnZ/ywBxYaJoZPf2m8ZmRk0bK6JHPD03sLlnt+l4/g
MkvtAM3L6zQ5DLNGNHBlEDGtvwUsB7RiDzW0SlDTiaKs3gb7uAEsnKVep0ADSIoD
V2WkM4ZlbLPwSShH64yDgUDbUcXKJHLJ/r+39HkLPG4TvAUFSSKV9agOoDHRZ21G
zSfWlS7jmDg6UPBzmKnNTy+S/UcyoaNGblIPlnMhsI1/shZGFIcDje5G9wg1yBjo
+4ZpOXgNRHlghOPsf4x4PmUUqEeOACHG08/nyYir6g03+XF/M5K8TvqWIYHDk/5l
F4zwIo+0fHpVmzpVuql1W4D4tRY4hQL8Tx+cz1sapaopdF6gCvA=
=LjOq
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
