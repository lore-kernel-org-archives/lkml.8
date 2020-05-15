Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D01C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328F0206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FNKSQ+ZY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgEOD5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:57:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39895 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728228AbgEOD5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:57:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49NZP230Cjz9sTc;
        Fri, 15 May 2020 13:57:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1589515048;
        bh=12E0Ox0MyQw9cxT/z4meYK73nLWFlNO8zC70oLHAhUc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FNKSQ+ZYBLfP3AA2TdZRkgqeKFKxwncnhQrn2lM7Gr6UznLLjnZPkUnKy6yAiu1Fg
         r7yVyZYABvlb5WAXTxpA3u3HaoOO49sFjRnJZs7lTj3BnxeOgTnZT+wMjnE0oCHGmy
         PrkINelclN1Qvfe8PfYEeJP8kz6SLb/DV+lYqtFyE6MRuvRdFJF9iUnFRbho2U3jXl
         xlRdElKXB25T2UxyOVqwlO1qCgO+wp+oDAlFe7FdFz7ao94cTOXMwxw5jM7QKk5tQy
         +QagFh6LLigEdF/uzZDEIHZS4l/l8J5S4Ve81TA6rIDE9yaZz4NQHMnr/AVbI60FHn
         Ue8svm0QE4FQQ==
Date:   Fri, 15 May 2020 13:57:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: manual merge of the amdgpu tree with the pm tree
Message-ID: <20200515135725.0b1c86f4@canb.auug.org.au>
In-Reply-To: <20200508143457.14acfc46@canb.auug.org.au>
References: <20200508143457.14acfc46@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.UUGG4uWAFbeatE5ZxxWGWU";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.UUGG4uWAFbeatE5ZxxWGWU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 8 May 2020 14:34:57 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the amdgpu tree got a conflict in:
>=20
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>=20
> between commit:
>=20
>   e07515563d01 ("PM: sleep: core: Rename DPM_FLAG_NEVER_SKIP")
>=20
> from the pm tree and commit:
>=20
>   500bd19a7e5d ("drm/amdgpu: only set DPM_FLAG_NEVER_SKIP for legacy ATPX=
 BOCO")
>=20
> from the amdgpu tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index c201bc827389,4e4c9550dcf8..000000000000
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@@ -189,10 -188,12 +188,12 @@@ int amdgpu_driver_load_kms(struct drm_d
>   		dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
>  =20
>   	if (adev->runpm) {
> - 		dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> + 		/* only need to skip on ATPX */
> + 		if (amdgpu_device_supports_boco(dev) &&
> + 		    !amdgpu_is_atpx_hybrid())
>  -			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NEVER_SKIP);
> ++			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
>   		pm_runtime_use_autosuspend(dev->dev);
>   		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
> - 		pm_runtime_set_active(dev->dev);
>   		pm_runtime_allow(dev->dev);
>   		pm_runtime_mark_last_busy(dev->dev);
>   		pm_runtime_put_autosuspend(dev->dev);

This is now a conflict between the drm tree and the pm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/.UUGG4uWAFbeatE5ZxxWGWU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6+EyUACgkQAVBC80lX
0Gxtpwf5ARnjH24OgC6q7HQG4R4ArdGvSQZUTc/rpSUhV2tsRhmTUXBGXkWd8+ve
1c+x2BP2fhwSdQSAjSHsae1b1dP96CbEulGcsIlprKWaU8+7qgXE3cW9gXCNrSXd
r78YrIzv45HjYDnXeGxSD++AIiT7MLEh+gNcZ5cNROZNxeBGxW5jaAfITZE4SdF0
oaDkwt4/pA+u9RQaLzi/Kp9QI2LnMZovp+/yw5PRJaPL85b3oWJbE3uzHdqC6R3e
lN7V7KQvbJOtx0QydK+KMSUOBwJbqbLcbj7d7YxbDwc6OGo2IPEOVyYqqf2zaWpC
KRWZTUJObUzwHHU3wbhEJU949df/yA==
=N9JX
-----END PGP SIGNATURE-----

--Sig_/.UUGG4uWAFbeatE5ZxxWGWU--
