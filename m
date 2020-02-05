Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E15C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB209214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gjGg21E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgBEAjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:39:35 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50519 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbgBEAje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:39:34 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48C2kq2Q9Kz9sSN;
        Wed,  5 Feb 2020 11:39:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580863172;
        bh=RgyY/tOo9lziedT4Kg/hB7aY/945tp8KAZmY13gSICA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gjGg21E8GutoxDwoKArshcfZP7OMfo6KXVMdxP1JnveIwqYFf16suHb75Q2KTuoBu
         LXT3ZzH5O/uok0ZrNOkjYZigsK469DDk/P645Ed8drQggyzyPNLml9Ex8aDazeBPVg
         FOswW+53XfDN2d5SFADQ4a3Jxhz22usWTIZBuDNyQhcbyt9mskA7iRoMRCE8tDSgGV
         A9vAQXJtOXjxSCOLf/8cM51siKyIAdxtFtoyYO8VEIgfFpvnacjBixIDIa0V717uTp
         24qpMp/Op4Z7cz2UvdqGbPY7Vf6eExy6PbdB0PfMZzsKGqJB5yiwiMx0/LGQuhWS0d
         +puw0yMXuyeuw==
Date:   Wed, 5 Feb 2020 11:39:30 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency to
 SND_SOC_ALL_CODECS
Message-ID: <20200205113930.5eb08bb4@canb.auug.org.au>
In-Reply-To: <20200204131857.7634-1-geert@linux-m68k.org>
References: <20200204131857.7634-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Hiz/NjwjpbUPYg/fH_/v/0X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hiz/NjwjpbUPYg/fH_/v/0X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue,  4 Feb 2020 14:18:57 +0100 Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
>
> Just adding a dependency on COMMON_CLK to SND_SOC_WCD934X is not
> sufficient, as enabling SND_SOC_ALL_CODECS will still select it,
> breaking the build later:
>=20
>     WARNING: unmet direct dependencies detected for SND_SOC_WCD934X
>       Depends on [n]: SOUND [=3Dm] && !UML && SND [=3Dm] && SND_SOC [=3Dm=
] && COMMON_CLK [=3Dn] && MFD_WCD934X [=3Dm]
>       Selected by [m]:
>       - SND_SOC_ALL_CODECS [=3Dm] && SOUND [=3Dm] && !UML && SND [=3Dm] &=
& SND_SOC [=3Dm] && COMPILE_TEST [=3Dy] && MFD_WCD934X [=3Dm]
>     ...
>     ERROR: "of_clk_add_provider" [sound/soc/codecs/snd-soc-wcd934x.ko] un=
defined!
>     ERROR: "of_clk_src_simple_get" [sound/soc/codecs/snd-soc-wcd934x.ko] =
undefined!
>     ERROR: "clk_hw_register" [sound/soc/codecs/snd-soc-wcd934x.ko] undefi=
ned!
>     ERROR: "__clk_get_name" [sound/soc/codecs/snd-soc-wcd934x.ko] undefin=
ed!
>=20
> Fix this by adding the missing dependency to SND_SOC_ALL_CODECS
>=20
> Fixes: 42b716359beca106 ("ASoC: wcd934x: Add missing COMMON_CLK dependenc=
y")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Seen with e.g. m68k/allmodconfig.

Also seen with powerpc/allyesconfig

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/Hiz/NjwjpbUPYg/fH_/v/0X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl46DsIACgkQAVBC80lX
0GwzRwgAgmwTJPOGlGhFjolOKlrmmYlrenpXgKt+jAHgVCjxg02BcOjHK2fq14FZ
+EHbzsS6mcSM3yjNhuObh1tUMdIRxCCssy/mHdFuCO4QnDeDf2EuCMmCDz/8icqD
vdBkRhMbB4EbX/1B5tEwACPmunrYRCoQ4CrOUvDMAbZ6tztglNDe1fqJxpr9QBFT
lW69SSDX5JALt3MOBvxO9rWsoG51beKLwuMg9lEON64bzp9vA2xq5Z44+asHWfxB
pnLa8MlKG99cxqzXDy+kPaGFRlfVy4XHwyn0bJJnHjLSkQXibYrIqKbxyUNfjfGS
3rMWUB3s4Kg/vPD6FlvW7MPda+QjcQ==
=16Dv
-----END PGP SIGNATURE-----

--Sig_/Hiz/NjwjpbUPYg/fH_/v/0X--
