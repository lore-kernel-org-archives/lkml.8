Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6780C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B454821D7D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594720390;
	bh=69NDwPfEkbnCl+IKo1KaYa8NHEQkLg8q/hcElxsnFJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=neqz7NfGfjubvpDgftxmyzbF418EZ5j24eMResxKn5TxhFXConPIyY/bURo1PXCj3
	 hkpISjGwXwc/AZzNapy8wFIyyXoTdUZ2V+Yw5wml47P5RQQ81ObU02XWDGl8N/ippy
	 9t4nbg5FaIBDSe+nUaF2JX4GmVt6aBupE7wP2F30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGNJxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:53:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgGNJxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:53:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B50DD20EDD;
        Tue, 14 Jul 2020 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594720388;
        bh=69NDwPfEkbnCl+IKo1KaYa8NHEQkLg8q/hcElxsnFJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b4S3d/Cpg/SKJZaLtxCRtdwqV5R+4hYj1NBblToFHsT2iKgKg7o6lDZaJdoaFwGDB
         YMjhQ6hyYwLYhwntegIrVyCLl1RkVr/LLUoSutGgg06I7ETTTHTvEwd5VW6DAEDgV8
         nkw33EMoPHD/WMF7+Ij0eHGWTVzqvo2vM4TIZBIs=
Date:   Tue, 14 Jul 2020 10:52:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        DTML <devicetree@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        - <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: ASoC: Convert UniPhier EVEA codec to
 json-schema
Message-ID: <20200714095259.GB4900@sirena.org.uk>
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
 <20200714022252.GA1151466@bogus>
 <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 03:13:26PM +0900, Masahiro Yamada wrote:

> What do you mean by Reviewed-by ?
> Do you expect this to go to the asoc tree?

> I just thought the schema conversion
> would go through the dt tree.

No, bindings changes usually go through the subsystem - if there's any
other work on the binding then it'll usually also involve driver
changes.

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8NgHoACgkQJNaLcl1U
h9Dsrgf/fPLrNlqqgRY19cFoFt6CgtBbNO86y/JcGKXNAdFdJ5lG9scZL2Rgzas/
0/YpfGyCQAOMGEWc5Icxjhcj+geFRr+aqL7mtvz4XT+Wv0I0VSWeCdVEeoYcFUpV
/J6PxuLhaOhAKkcKcm0UNz+dI5TmhySRUnB97ikprAPWs498y1c0otugjbP9hClu
nhkI6a7K+OtE/t21oN80kQzqNGfaMgai5G3t0kZ7knfmJqyXanwYZLUWxZuBueoR
4CDY9eOE/jaTkLyIerbibswcLl+MYv/L/jkh3Jmd3v1xmDNailW5yjE/TsZvc5E+
RUaalfr2073gZqSDnJz9e1PoPrNzzA==
=+jbC
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
