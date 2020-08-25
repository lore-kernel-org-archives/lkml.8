Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98343C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDED2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598347601;
	bh=xjRUlLJiGzDBfJ7+riJgK5GH7YnvOwbUoZtfaHvq9m0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J4f3MDxFo+e4MRqdKn3tgtb6gwjfBH97FBs1W3Fy4/xdhmOsx/isPyD4m5VWVnHs5
	 xU7nKWK1YW0mED5vWqnH2tlPTbG3TXJCvu/z14SIHiWW0C7zgZwXTHE3UvhzE/iuDY
	 aJMIzfEgc/uRykCG0QG07k98beZxbcPKkBQohXUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgHYJ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:26:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgHYJ0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:26:37 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10BF02074D;
        Tue, 25 Aug 2020 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598347597;
        bh=xjRUlLJiGzDBfJ7+riJgK5GH7YnvOwbUoZtfaHvq9m0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRavcvUv7eOhBnb8hi8CS7GITp1H59HeJh1ddaYOVbCy65qJuN8J/LYy7j2gUkqkz
         Zh6TiUnjR6b4ZpwfS6oxvmO0bVWNnvCUTzhyu4UI+M8xcKhgFig8Jf8X276o1Kvonb
         ZVeTg/9DI3JKU7BnJWF0LAB4i2rsaw59lpZ9Xw3s=
Date:   Tue, 25 Aug 2020 10:26:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH v3 1/2] regulator: mt6360: Add support for MT6360
 regulator
Message-ID: <20200825092602.GA5379@sirena.org.uk>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200820114524.GC5854@sirena.org.uk>
 <CAE+NS34WuWnT7zvsHhaciWVLT2y0wpwt0wXAp3UmjEuJ2its6A@mail.gmail.com>
 <20200824110458.GB4676@sirena.org.uk>
 <CAE+NS36ZK2pq8CAcmiqiUf6Ph5RET5aO4nUPFUd-EDHVEuharA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <CAE+NS36ZK2pq8CAcmiqiUf6Ph5RET5aO4nUPFUd-EDHVEuharA@mail.gmail.com>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 05:13:43PM +0800, Gene Chen wrote:

> Should I use dev->parent->of_node and set
> regulator_desc.regulator_node to parse each regulator definition in
> device tree?

Yes.

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E2SYACgkQJNaLcl1U
h9BTvAf/SKwBThcS5qz2q647IodkHIleD2IJYA6d9KuYw6T2O4sywHAL61N8i8rS
rYc/hL7MKpp4IuOQ5+jAmS4WhfMrzY9azyZJFtPkcGgs7JioJRT/VoiX8lvr77qP
75NOm9lmwqChKhRvkB0JWcnfDtLvQmY+Iw33HKOHcOPDifnyNtdpGN/oaPVkADvy
vH9MiSFgFumGInyev7zRGedPv0F2EnTD5S3sN0LchDPX8RZYV1ZRNN5mqaPOFxr1
hWZvqoRurKjSL9fCYNZvAc373RwfO9OfaDag/qrPe8f1b3cXxcou8spim5EofU2v
UsmwKIggTpgrLuXqu6tvFiw56F4TxQ==
=IKjm
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
