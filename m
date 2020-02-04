Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28CBC2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76657217BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580810444;
	bh=xV5ppSyRVBUmtXdj0G9nyVc0qBTFXFAbMois+jXeZrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ASQhRFxG0iqPC/Dk+JJFn1esJHLvas3KaH0wdf+OH5O5Tg7GJkB1i+ESjTTjyvPMP
	 eJyIpGb0eVZdvIyHtE0+zPfQXB9glzLiALWGHWeJn+TUJjeejgBIYmEF1Zb/z38l3K
	 uRXVkhc2YgToVc02pzwlCfJoRnRbNZUrBOBfCfXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgBDKAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:00:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35422 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBDKAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ssxr3RN87YVt9erEY/AmThQqgJl7IC/HXQPGjVWT5dc=; b=FNpve2cc6sJHkS1nA8oRLmsxd
        t1E2xN4YDhZWy2Pqv+QVOWbhJfoocNsBM/hrWZ+rerZ3JhbwRi65s7x4w/wVd69LKrVMX5VueiTbb
        MOkdi1y2uQK0MFpBcWUmmMmLCQaEGmbDvQVS4qhrteHZQKccgf/TF2aobKvraWLnV+wQU=;
Received: from fw-tnat-cam5.arm.com ([217.140.106.53] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iyv0a-000765-4J; Tue, 04 Feb 2020 10:00:40 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 94AB4D01F30; Tue,  4 Feb 2020 10:00:39 +0000 (GMT)
Date:   Tue, 4 Feb 2020 10:00:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: wcd934x: Remove some unnecessary NULL checks
Message-ID: <20200204100039.GX3897@sirena.org.uk>
References: <20200204060143.23393-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ka8pmxPp9qZnI4DD"
Content-Disposition: inline
In-Reply-To: <20200204060143.23393-1-natechancellor@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ka8pmxPp9qZnI4DD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 11:01:44PM -0700, Nathan Chancellor wrote:
> Clang warns:
>=20
> ../sound/soc/codecs/wcd934x.c:1886:11: warning: address of array
> 'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
>         if (wcd->rx_chs) {
>         ~~  ~~~~~^~~~~~
> ../sound/soc/codecs/wcd934x.c:1894:11: warning: address of array
> 'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
>         if (wcd->tx_chs) {
>         ~~  ~~~~~^~~~~~
> 2 warnings generated.
>=20
> Arrays that are in the middle of a struct are never NULL so they don't
> need a check like this.

I'm not convincd this is a sensible warning, at the use site a
pointer to an array in a struct looks identical to an array
embedded in the struct so it's not such a bad idea to check and
refactoring of the struct could easily introduce problems.

--ka8pmxPp9qZnI4DD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl45QMYACgkQJNaLcl1U
h9Cf8gf8CZ7NH/RKF60fNu1KZA25wBAuUOMAzTNY+DTfeFpZorShbSWMtzL1fI52
FeYZWbk/WzCbrCWG5PQAT82GJT5qevp2Kyvm88/LgHROfRtzZpKV5f4dNnrqWiNW
xH0sw4D/gdLq3i4nJGfENO+cywG/6JvuwlOE9A5NdabBR9RzfAfuDNNtCxXuiyfq
lb25cFa262Q0uwXVrPmFOFFj/OaEA2K88IQl4sFc0SwKu5gr1W1P3K6p6Y+c1jOW
0fm32OI5+0MqzRi60nb8IXFgwsCr0rCqSeoNPjM9xnLNxfJV8HPYvuVwuo0SRBsh
h70U8U+kRSGnqm/VsF0vNVUKWdey8Q==
=9EMo
-----END PGP SIGNATURE-----

--ka8pmxPp9qZnI4DD--
