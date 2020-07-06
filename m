Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E0F206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgGFN0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgGFN0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:26:31 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94805C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:26:31 -0700 (PDT)
Received: from kevin (unknown [IPv6:2600:1700:4540:6a60::34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alyssa)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9691B2A3C95;
        Mon,  6 Jul 2020 14:26:27 +0100 (BST)
Date:   Mon, 6 Jul 2020 09:26:22 -0400
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/14] Add regulator devfreq support to Panfrost
Message-ID: <20200706132622.GA1881@kevin>
References: <20200704102535.189647-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20200704102535.189647-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patches 1-12 are=20

	Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>

Thank you!

On Sat, Jul 04, 2020 at 12:25:21PM +0200, Cl=E9ment P=E9ron wrote:
> Hi,
>=20
> This serie cleans and adds regulator support to Panfrost devfreq.
> This is mostly based on comment for the freshly introduced lima
> devfreq.
>=20
> We need to add regulator support because on Allwinner the GPU OPP
> table defines both frequencies and voltages.
>=20
> First patches [01-07] should not change the actual behavior
> and introduce a proper panfrost_devfreq struct.
>=20
> Regards,
> Cl=E9ment
>=20
> Cl=E9ment P=E9ron (14):
>   drm/panfrost: avoid static declaration
>   drm/panfrost: clean headers in devfreq
>   drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
>   drm/panfrost: introduce panfrost_devfreq struct
>   drm/panfrost: use spinlock instead of atomic
>   drm/panfrost: properly handle error in probe
>   drm/panfrost: rename error labels in device_init
>   drm/panfrost: move devfreq_init()/fini() in device
>   drm/panfrost: dynamically alloc regulators
>   drm/panfrost: add regulators to devfreq
>   arm64: defconfig: Enable devfreq cooling device
>   arm64: dts: allwinner: h6: Add cooling map for GPU
>   [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
>   [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
>=20
>  .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 +++++++++++
>  arch/arm64/configs/defconfig                  |   1 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 165 ++++++++++++------
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  30 +++-
>  drivers/gpu/drm/panfrost/panfrost_device.c    |  61 ++++---
>  drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
>  drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
>  9 files changed, 290 insertions(+), 109 deletions(-)
>=20
> --=20
> 2.25.1
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl8DJnkACgkQ/v5QWgr1
WA2plw/+MP2+7xJ51qGsZtJWvdP8wW6JbZZWAgkV/W5Hrbx+U79L41RtyI3++Wyk
V1wKRexTb/ZaAhEod+7tkMTJgIzGEh4r6sQTE46ua66iltg/LOLoCrS90Q+n1ZKz
voATFXc8pFG89hJRbeXeawLHRitmEM//cyskejG7okH3IOPd0P1wg/h21VaZIGOD
0t+Pl1l57KCHyM1LruPefCDvQPLi8L2BTF5XbfeEt8TwFxKvzLboKLMNj/PxWfJo
U08k9ZhVkxG7Xao/m+sEAMHrqd+chmj7z9rGnRQiCxyyTPLCT8FYk0OGb0TGolS/
lsyp1WR0upCKFKVAYqnzkSSU30Ovd4j72wYiQ4kkuJORXdi89UDGv0U5s4S2a1bI
VzG5gykUnmR8rzzyrIipjsqiEvTNQRgtCvRYkNYVUbHcawWoX4YeuI3k2mouUDDN
zU4hN1seZLGFKy3g9nPDI+7yilFWoSo3pExqo8vwVdHOrAB8nEhbAt88+GihkT4+
LwRN51PeKlcxruN2uCvsvnkdbuBK0N/3ilXhyLunE4RJ1yHih1SkBA0YNJVe3UWU
yAuVWjALGidP61oJ7RyGisj3z9pfua72DtBt3yr80ApiLQDYg04QIFVZ41fr3Qrk
WWYbwHzYnqHLhzwGl4hxIHY6Okcs2d2XdZ2cXlW3/d26ucM4vZs=
=xFiH
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
