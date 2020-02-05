Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F46BC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C0521744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 00:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Hll0/GjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBEAiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 19:38:02 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:47467 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgBEAiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 19:38:02 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48C2j223psz9sSN;
        Wed,  5 Feb 2020 11:37:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580863079;
        bh=D4ySHA1AZdixCqz+gphCjWo5PwSShyuxhG5htucJUPs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Hll0/GjARY18lDVuv/HjMGHWHf7qmMgcjP2k+i4xyHJOjpH9Coq/3bXzizD4td1kl
         gnmuBBC9WXKxOTQ358RMfpH7OCuFFTlRNfQOCYZCQBTaNeiodRJxXZ0tn9xCinT8dD
         jKXjvdxz+WR1jn5KHZrq0D6Yz2qFB2BFQjxeImE3G5aEItXCh+ytYyANfxCKp2N3NR
         MZIOHxr2u4no0TP6BG8sMYITVaqSSuBoVtT1P0TlEKQ6mZLX9iqziBTHskZyGF7mIH
         PzSKtSe3sQmnpqw35+XG5iKSE9a3OUXdc+RfSSjnUVDFfnrjjv73ZD+EN8Zlg0J86z
         f0whArJZLCejw==
Date:   Wed, 5 Feb 2020 11:37:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: wcd934x: Add missing COMMON_CLK dependency
Message-ID: <20200205113755.7daca1f1@canb.auug.org.au>
In-Reply-To: <CAMuHMdVw0crXH+=7e9GGLUR-c-SxZDz9kQdeWxkZyZ9Jx7CVig@mail.gmail.com>
References: <20200204111241.6927-1-srinivas.kandagatla@linaro.org>
        <CAMuHMdVw0crXH+=7e9GGLUR-c-SxZDz9kQdeWxkZyZ9Jx7CVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_1_fW9as_IaoGbJacvoUTVq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_1_fW9as_IaoGbJacvoUTVq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Tue, 4 Feb 2020 14:21:01 +0100 Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
>
> On Tue, Feb 4, 2020 at 12:14 PM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
> > Looks like some platforms are not yet using COMMON CLK.
> >
> > PowerPC allyesconfig failed with below error in next
> >
> > ld: sound/soc/codecs/wcd934x.o:(.toc+0x0):
> >          undefined reference to `of_clk_src_simple_get'
> > ld: sound/soc/codecs/wcd934x.o: in function `.wcd934x_codec_probe':
> > wcd934x.c:(.text.wcd934x_codec_probe+0x3d4):
> >          undefined reference to `.__clk_get_name'
> > ld: wcd934x.c:(.text.wcd934x_codec_probe+0x438):
> >          undefined reference to `.clk_hw_register'
> > ld: wcd934x.c:(.text.wcd934x_codec_probe+0x474):
> >          undefined reference to `.of_clk_add_provider'
> >
> > Add the missing COMMON_CLK dependency to fix this errors.
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org> =20
>=20
> Thanks for your patch!
>=20
> But did this change really fix your PowerPC allyesconfig build?

It does not :-(

> SND_SOC_ALL_CODECS will still select it...
>=20
> Fix sent.

I have applied that patch to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/_1_fW9as_IaoGbJacvoUTVq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl46DmMACgkQAVBC80lX
0Gx/DggAj9lmiFpTN+bBrorpgSuNVYj4avD/gKtS0FdPBJaSx+Xqeux+QRyKUfyr
gJ/XgiVrgJAYPxUrXsMJUm2TWRYRQVlgkBqr94OD+hE1WnB0/pIwA5IIaEKXX/lW
UJcfm+fj5tXfolbKJA0rZAYtSOR5lBEH+cyuSMs2oIZKBUkqOmTFxWkHoQhVT0si
f+NDywZ1q7CarhMmnStOoZerBuDpdz+j7wzpreedebU+m/VSEJA1Kt33/RsAqLUF
uGctV/gbqqgVtiY0d0dULjpyrD7FswfK6GurAVrycpFyJvKda0bqiE7QV96S3Qdz
e1ZbwL6QKEXK+754qrD4/9IebKFnsQ==
=z7P8
-----END PGP SIGNATURE-----

--Sig_/_1_fW9as_IaoGbJacvoUTVq--
