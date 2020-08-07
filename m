Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDE5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEEE22CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596798856;
	bh=AalJ328+Kw2GpSU7PvwDcyeAsPIWJzp6tH6Jz0SFfXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X+4GqzcpdlvRR0uNGKd5KM8cvIov0eHqElISbtiTcrCKrgss7w9+Af1sTV+BkJx/j
	 ZuveWVPT4x5H50GlzokDABS8nLz/Kz3E4cJSctvS+F6OvRfxR9rYmK1+KFuJ1GdS53
	 qS/SGbD6HR7rYUKQKit4bsT+xtSIHs16DwXth67Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgHGLOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728383AbgHGLNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:13:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED96A2177B;
        Fri,  7 Aug 2020 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596798831;
        bh=AalJ328+Kw2GpSU7PvwDcyeAsPIWJzp6tH6Jz0SFfXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=If8Hdv3JWrN2SKiaxTY7ICzHgyqblbV+YiwLt02EBMz/LrhNhvN/Q/sw5wiwui2sM
         jxmcht9s2x6Jp8/V7PK0Y1Hv1/SCMjSDcgCKp6TRL46hqfQ73Hn6rQOAXul6BbYWC1
         cScDcgzg0GlDAN5Z9u43NWm2sGPaRvmVUTqmW30w=
Date:   Fri, 7 Aug 2020 12:13:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>, rafael@kernel.org,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, benjamin.chao@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH 9/9] mfd: mt6360: Merge different sub-devices I2C
 read/write
Message-ID: <20200807111327.GB5435@sirena.org.uk>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
 <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com>
 <20200805161021.GK5556@sirena.org.uk>
 <CAE+NS360iKLoGxiiz8NmQqCp2Uge98Eehe4g2sn_N0e-E3DgyQ@mail.gmail.com>
 <20200806121332.GB6442@sirena.org.uk>
 <CAE+NS37tr65GnTue89wJkPvJzddahKj__KPgzmjzwkOfWQnc8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <CAE+NS37tr65GnTue89wJkPvJzddahKj__KPgzmjzwkOfWQnc8g@mail.gmail.com>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 10:16:08AM +0800, Gene Chen wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=886=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=888:13=E5=AF=AB=E9=81=93=EF=BC=9A

> > You really also need to write a much clearer changelog, I would be hard
> > pressed to tell from the changelog that this was moving things to the
> > regmap core rather than shuffling regmaps within the device.

> MT6360 has 4 I2C worker devices

It's still just a single user with a single driver.

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tN1YACgkQJNaLcl1U
h9DvqAf/ccwwW2FC3T3xh4YHttvbhhV6yhTSQkpczkqwcVenOgtKJKVK+iZP8LyV
Y9McD3B0rSmN/uEIEASXLkWZL2OMQBLE4743J4oIv0xsbi8rIugjXmE7o00is7QY
ZFs587wrz0YEdfEaQN+rX559JCAoo25IbONlya/hhCSfAyYo3jtJK+rKRXbNBnk6
MCeMAg2RGiL1UGHVXcWT/czs/pYilonaX7cQ56CnbdpiRCbmv3DNanwGvvrfx/vl
D3wyuvK8f1NucQMgCMkWAE5dROcgka22mqd2T+mdfP5SWmID4H+Eln0NmG2QAEda
DHWwC7CDn+MepI6basM9jZOdWnSdgg==
=39J1
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
