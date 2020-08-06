Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E28C433E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FA523117
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596731202;
	bh=O+Yq62Jpar2u7KQqkWw3dmiGoRjXxGUD+TIIm4JmqPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J8AuCNRErIN2iXP8T5Is9WO0g1HuJG2JFtsTsUJtzB6cx6imRHFgOUld6zAPltXGk
	 si/h2wjfl2KqgkgFwNPLv58B3hhjptxS3ptD2e2xoiUlbuuxFDw1o888fGz/EHIPF+
	 6mLMmsvDyEm1lX7cu5ViqlntAfHSB67XZ0iejKsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgHFQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgHFQRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:17:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E66DE22D71;
        Thu,  6 Aug 2020 12:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596716036;
        bh=O+Yq62Jpar2u7KQqkWw3dmiGoRjXxGUD+TIIm4JmqPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UVLTvmkatzujC2ujO9N7gWd52kh2sNsgn5jwQ+uywt+FYWEPpJBsVba/+L3uMReZm
         63eUsD7dqXhwQ2ECvgg8qWpw/0ZDSTubwwYZUAEirXTLleLjzlzlfRAOUraMbW650E
         RVkGTvGqJr2ao26DVT9G+MDQ9KjBGWZVD6ZAxpRA=
Date:   Thu, 6 Aug 2020 13:13:32 +0100
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
Message-ID: <20200806121332.GB6442@sirena.org.uk>
References: <1596558782-3415-1-git-send-email-gene.chen.richtek@gmail.com>
 <1596558782-3415-11-git-send-email-gene.chen.richtek@gmail.com>
 <20200805161021.GK5556@sirena.org.uk>
 <CAE+NS360iKLoGxiiz8NmQqCp2Uge98Eehe4g2sn_N0e-E3DgyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Content-Disposition: inline
In-Reply-To: <CAE+NS360iKLoGxiiz8NmQqCp2Uge98Eehe4g2sn_N0e-E3DgyQ@mail.gmail.com>
X-Cookie: Hedonist for hire... no job too easy!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 06, 2020 at 11:30:56AM +0800, Gene Chen wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=886=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:10=E5=AF=AB=E9=81=93=EF=BC=9A

> > It's not clear why this isn't just done in the device regmap, there's
> > exactly one user?

> because I use one regmap to access 4 I2C devices,

There appears to be only one device here?

> I need change the regmap_bus struct to fit I2C read/write with CRC bit
> Therefore, MFD reviewer suggests I can move the regmap api to regmap
> folder such as regmap-ac97.c

AC'97 is an industry standard bus used by a range of devices in
different subsystems.  You can already have custom operations for a
device just in a regular regmap using the reg_read() and reg_write()
operations which are there so devices that individual device support
doesn't need to be added to the regmap core.

You really also need to write a much clearer changelog, I would be hard
pressed to tell from the changelog that this was moving things to the
regmap core rather than shuffling regmaps within the device.

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8r8+sACgkQJNaLcl1U
h9B2agf7BQ0T2JHp32v4pfLGpKGHkSI9JcjEGjBwSmahI1cX35HCV5U268ZSJX3d
BLazy73BTK0mInugyZ9eWwpku1FaC3/t7Iof6Vm8rLUkpEPezWLYamGihace/tjc
qAUXy954H3ad8WHYtHulkoolE9B8YXr5hxMJ+vN8PNOYMkCuCWHlis1hR4ipH6mJ
9xdU/uD88UEf/E0JjxmKr/szzWQVrdfQ3pN7j1T5cl44fzYFXpyeH21pq+Qjg6tX
8moEToplBFHmRmrDPDryDbqRLHLhCLknTcfyAfYM8T9aZUysEdcSDDh/A7FQJ7cq
f2/PfBNJ2N1pmMGhdyZd01U9Qjr41w==
=qguZ
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
