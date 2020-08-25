Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E04C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ACA62068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598350122;
	bh=n9qU1VSIX6taYiBT6mEUe2Plo9U8hi0SVYmW+Orzzd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oELp7j8L7DUmphXoF09Q648qu3q5D8wTQM0BZr9dKpVdaVRieWmdezOz/AhdlLWmQ
	 wsnxnxSPpyJED7IO4dRoE8O+/JOdPwvINZhzqdyFHmFjJmnp1oYnpNbcfXCFn824WL
	 Nhg1mwN00KQpv9n6wY8xSez2vcblOpayyMXkcYn0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbgHYKIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:08:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgHYKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:08:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A7F52068E;
        Tue, 25 Aug 2020 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598350119;
        bh=n9qU1VSIX6taYiBT6mEUe2Plo9U8hi0SVYmW+Orzzd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oAHKwHhEbqG3Luk+KNI3Up89EAA3hMJmJGkV9m4yPc1m6UsLhIV28q2ZTJ9lSXR4l
         wnsPvF0CxCwEVBMzwt4znGF6GTXVcAT3C1VP9lT3jxhqWkqvIGvuPScHpuSCsFNrVE
         +/0SJQNTnYv3XgOWHf5riql3ZsVpVqXizwtWvmnw=
Date:   Tue, 25 Aug 2020 11:08:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
Message-ID: <20200825100804.GD5379@sirena.org.uk>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200820113015.GB5854@sirena.org.uk>
 <CAE+NS36C0AwbrFJdYGY6_n_g3DVitp_e1GfZUxjMbKu1bJ_t4w@mail.gmail.com>
 <20200824194840.GF4676@sirena.org.uk>
 <CAE+NS37p38dAN1bAi_VvEYYGNiWDVFKrdHL-hTgi2nim_7Zvqw@mail.gmail.com>
 <20200825093404.GB5379@sirena.org.uk>
 <CAE+NS35eh9PhRA1M2f2med52WhRsEfWp=zWUfgETq4odHouxDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
Content-Disposition: inline
In-Reply-To: <CAE+NS35eh9PhRA1M2f2med52WhRsEfWp=zWUfgETq4odHouxDg@mail.gmail.com>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 06:01:46PM +0800, Gene Chen wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:34=E5=AF=AB=E9=81=93=EF=BC=9A

> > > LDO_VINx is HW design layout, so actually it can't be changed by devi=
ce tree.
> > > LDO_VIN1/LDO_VIN2 supply from VSYS, not regulator, so I think usually
> > > not to show the supply from in device tree.
> > > or I should declare a dummy reference to system power like "*-supply =
=3D
> > > <&system_power>;"?

> > When you say it's from the hardware design do you mean it's fixed by the
> > silicon or is this something that's fixed in the board?

> fixed in the board, not silicon.

Ah, if it's fixed by the board that's exactly the sort of thing that
should be in DT - the DT describes the board so if some other system has
a different configuration then it will have a different DT.  With supply
properties you can just leave them missing in the DT, you're not
supposed to but so many systems do it that the framework will handle it.
Otherwise if you want to represent VSYS you can have a fixed voltage
regulator with no control and hook them up to it.

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E4wMACgkQJNaLcl1U
h9Co+wf/Xf8KbC9/vFFir2BN6SL1tFkB0IvZMWZj1u+U08sPmTCIh2KRaC8xDJxI
y6HF+I7FRWlcaj9ozuuNedPeXJi29wZC7BkgExRo31AMpx+SWE3blPoJit/M/YnI
zk7ZAQKh63RF/Zaqk+drtruqz4w1yQ5vLXTLoQcbzk8YMTqfnUiBaNkFv1TCL1bq
0Qp6/LyejmL4sHZ2SF8WF0TvepxuR9EXGMB3cabyE+J8nw68QBisaHVFk99pVhul
QIqvJOTMLq/XZeHklnt1rXdmHcIFzp0FUQyx6eek6b2nMjsSPlAtozQjFxZBl9Uw
1fiHa/CwqrgxU5Iv3JIuf+WM1tMNdw==
=M9CH
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--
