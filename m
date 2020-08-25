Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8C6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E7520706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598348088;
	bh=iLhF9CJwZ8QUh5DuvKsLlkhW2dg54+n1MTOWIYJs+9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A/2lvQZVtIAXl1D/Z8nKXZUvtQ40PCWxPGtICVDmnvMhyTZyoFEJmAm8IvJNHgz4T
	 bbyaSOMc0QM+X0nSsS2eLGFcebvOXGSgb7lFAazGchy/O0TN0aWFVACtDfh4mH5NiH
	 alsxqz4ka0ItLhYSANO7jclBs/Plz5n/A/pKbKik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgHYJeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:34:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgHYJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:34:40 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D8820706;
        Tue, 25 Aug 2020 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598348080;
        bh=iLhF9CJwZ8QUh5DuvKsLlkhW2dg54+n1MTOWIYJs+9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTqCrQ8br8SvcPLpu342YqgAXUZTdk11PQz2Du4qg5vwpjaGIeiewhlS2e+9cP5z+
         JjykoK9uYm5+7Q7C5s8rUAZ/ZmWre4R/+Bu6XdbrmgATdWqzXsCOenWNKvNpzjKwkq
         bz47p0VqD5HiByf0Nd+1t7IAJqV5rTtU/TYt1+ps=
Date:   Tue, 25 Aug 2020 10:34:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH v3 2/2] regulator: mt6360: Add DT binding documentation
Message-ID: <20200825093404.GB5379@sirena.org.uk>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-3-git-send-email-gene.chen.richtek@gmail.com>
 <20200820113015.GB5854@sirena.org.uk>
 <CAE+NS36C0AwbrFJdYGY6_n_g3DVitp_e1GfZUxjMbKu1bJ_t4w@mail.gmail.com>
 <20200824194840.GF4676@sirena.org.uk>
 <CAE+NS37p38dAN1bAi_VvEYYGNiWDVFKrdHL-hTgi2nim_7Zvqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <CAE+NS37p38dAN1bAi_VvEYYGNiWDVFKrdHL-hTgi2nim_7Zvqw@mail.gmail.com>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 05:21:06PM +0800, Gene Chen wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=883:49=E5=AF=AB=E9=81=93=EF=BC=9A

> > So shouldn't there be a documented LDO_VIN1/2 then?

> LDO_VINx is HW design layout, so actually it can't be changed by device t=
ree.
> LDO_VIN1/LDO_VIN2 supply from VSYS, not regulator, so I think usually
> not to show the supply from in device tree.
> or I should declare a dummy reference to system power like "*-supply =3D
> <&system_power>;"?

When you say it's from the hardware design do you mean it's fixed by the
silicon or is this something that's fixed in the board?

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E2wsACgkQJNaLcl1U
h9DBaAf/UJOBy/iygjB9JFJ4GtbOAjn/N/rUqf1/KFMnz3cPKgQYUsIJGpdxmbn5
DiJcykHC4+eYbi6+EjG+YXvfTeqXZiqBZgYy2fgI0foL8niNbNR4l4f2dizSAusa
FzlufGHoNmhjW/frLoBo544S4VCf3g/bXwum3c+bkGZCeT4uwKT8spBK1Dqt/69N
bWgQB+uCUjC0vRlMAZAnbAR45zd0H8B/eLyjIK1qGXoEeUpMQPPYbGyg1GypOK6n
h5E6oy2FV29bq/+vsCQ6uf6Xy+CWtkHma69fI1hWNP4SXzePWEpOW5TZbHb/3E3t
SgvJzDJJ2VxGUsR2uxU/jhedGNW/Ag==
=aMgv
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
