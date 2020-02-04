Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5508C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D1821927
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580814045;
	bh=EXjyMCS/CU6QuYda4OxQ96vmFQehlOZekiJFuuvaXTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tAofb9Vldiv5vt1Ms6ZQe2DtLP9ND02Znlc8AUUTuFgYeWoqxs+Ab94m6kZ+R8PZI
	 6ja3SGE4pkUrWTl+QjrkX43ZeAEx94hJDYJLsws91i5+rvCT+dlAQvOk5+eX+wYaR6
	 y1whm5HSQmKI/bBGBCHnsIAMp2BBxSi1t6Ls6Ulw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgBDLAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:00:45 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbgBDLAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VSoKdzuTN654e/B/AIAS3k6Iw50VnzMJb6e2uFqXSFA=; b=ngl16WZ+QvPAC5INvj9tjXxtC
        NbRgf0B1IP/0IpKklrIVGU4jViM6cYpmjE3sfcCmz3tfGfbvHWLLCKBV2lxeraJqEsnGouW/oqu1O
        iL60EatIfqVM+Gp4hheWEfiUiDwNYJZj8Th6805toGDD9j2NY5SNIUpfkexYBfJB26z1E=;
Received: from fw-tnat-cam2.arm.com ([217.140.106.50] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iyvwS-0007HD-22; Tue, 04 Feb 2020 11:00:28 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 98871D01A54; Tue,  4 Feb 2020 11:00:27 +0000 (GMT)
Date:   Tue, 4 Feb 2020 11:00:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     bardliao@realtek.com, oder_chiou@realtek.com,
        chenzhou10@huawei.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ASoc: rt1015: make symbol rt1015_aif_dai_ops and
 rt1015_dai static
Message-ID: <20200204110027.GB3897@sirena.org.uk>
References: <20200203021841.121378-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ghfi4GlmwTrWkODx"
Content-Disposition: inline
In-Reply-To: <20200203021841.121378-1-yaohongbo@huawei.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ghfi4GlmwTrWkODx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 10:18:41AM +0800, Hongbo Yao wrote:
> Fix sparse warning:
> sound/soc/codecs/rt1015.c: warning: symbol 'rt1015_aif_dai_ops'
> was not declared. Should it be static?
> sound/soc/codecs/rt1015.c: warning: symbol 'rt1015_dai' was not
> declared. Should it be static?

This introduces other warnings so clearly isn't the best fix:

  CC      sound/soc/codecs/rt1015.o
sound/soc/codecs/rt1015.c:844:31: warning: =E2=80=98rt1015_aif_dai_ops=E2=
=80=99 defined but not used [-Wunused-variable]
 static struct snd_soc_dai_ops rt1015_aif_dai_ops =3D {
                               ^~~~~~~~~~~~~~~~~~


--Ghfi4GlmwTrWkODx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl45TsoACgkQJNaLcl1U
h9C5cQf9HIUK8FpIx3NDivWZ5zFfq57NOvJExnPqbpFzBxrkvwUyWFk630IJkyUU
TmsT4A/64zxqPPsOG6w1CQvni6mHQ7NNg9fwmNuiyotN8rHq0ILly2iFa2VM9rjq
vTy434JhhicHcRXOz3n/zJNZ9OF/fKlBeAKvwd1AY+38/wUsg5VvN4nx9mY/bj3S
zK3s/qPeNvyhMoEdzY6WlfL8oAF6waL9+EIx/Qz7FJJvOo3XW4O6nnFmjV9sU8t2
oOOO0yAE5VkQgCCG9G/PbgAV1iDJE3BtKWsFx6u0bZRIOs4kjgutgzWEiyDOzzcl
vgW4upIk9b2tAZt2cd151dj82Y/GKA==
=4dPx
-----END PGP SIGNATURE-----

--Ghfi4GlmwTrWkODx--
