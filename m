Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C5C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395602077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587649769;
	bh=L5kU010tRLvlDykx2R2LNiOC7P2uliyNrRS983QiysA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SduvzqXstEiZM+bS2D2pcNPaphcUbLRTk1Xt+8rtoQXPfvnzEbQSkuA1Htk9qz21Q
	 /BCKDDXEfjOJu/fpSFaWk5JCrN0Cngvu7PcmY8TIC7xiLlEtG4zaviaMnUTQcZ0nSj
	 Kcq5prqcG5GW98r20Vmxqnm0AOAT+VxEio84o1GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgDWNt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgDWNt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:49:27 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F87D20728;
        Thu, 23 Apr 2020 13:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587649767;
        bh=L5kU010tRLvlDykx2R2LNiOC7P2uliyNrRS983QiysA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvr+wOAne/Dt5gCDxSwumAQtaM06h6Rcx2mWfPYuxyWvAg3INOrC9pI0TVoGhWBJ3
         jkiC3PBLU2ox2NIZk0eLhWl5o06CytG87FVIoGtj8Hb6SQ5VaJo5kYvFjWZZJvLkJI
         yoTLzM0JfEldXK7OyD+07JPX6BdYQbwWSboj1+44=
Date:   Thu, 23 Apr 2020 14:49:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: soc-compress: avoid false-positive Wuninitialized
 warning
Message-ID: <20200423134924.GA53068@sirena.org.uk>
References: <202004201540.vYPhhYMs%lkp@intel.com>
 <20200422073543.1671-1-rong.a.chen@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20200422073543.1671-1-rong.a.chen@intel.com>
X-Cookie: Must be under 48 inches in height.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2020 at 03:35:43PM +0800, Rong Chen wrote:
> gcc-6.5 and earlier show a new warning:
>=20
> sound/soc/soc-compress.c: In function =E2=80=98soc_compr_open=E2=80=99:
> sound/soc/soc-compress.c:75:28: warning: =E2=80=98component=E2=80=99 is u=
sed uninitialized in this function [-Wuninitialized]
>   struct snd_soc_component *component, *save =3D NULL;
>                               ^~~~~~~~~

> Simplest fix is to initialize it to avoid the warning.

This doesn't apply against current code, please check and resend.  TBH
I'm not 100% sure the benefit here is worth it, this is a very old
compiler and it seems like a bug in the compiler.

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hnOQACgkQJNaLcl1U
h9B11gf+Oc9Yy/dxZEWmYZXf4NvQ//qzlH4elElRYAl5NqjfV3NVh5GQmoZRnerX
uA8j0Nkb9lM/Tw+mpj7W4YYu8seuBqFolV94YnsPGnlsVcePMlFZuZGcAeeMQ3QW
3oMOcmp8EqlC2jtKTK4apSqOqJSnJdhRWRcGl/4KiFAodJ12bRASMJIKONxVDfT9
tRqC7l4xmIoblzQ58tocFy6cTZMFzC9Rtx90T/3QFMVaDICCWEU0AwKmUqLeWxXW
d3dbyaDaabfmjbSFGAdUY5/mEAiJZN3g9MgJUcxTdtuXZcW+Dw3+ERCmS5XHIeVd
75wiLWNECNnXTUKVn6QWhSJjEDdEgQ==
=IV9o
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
