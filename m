Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64C52220D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594726295;
	bh=ByDfIhzyLIF+vxT7O3HCwTlGfVoDr8iCeDZjjO1kjSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQH2nn7ZusynC2VNcGLUo7wAobNEqyUVS/roP/fUCJn4H/PcBvPlfSZYOmKvSa5GI
	 ychi7j7hdMdRyrAG82+Y2D9xN99IxkNH+M+LLE35Ri4JkkugRvC1EGomKYIPv1d2B0
	 /91j+Vo2+FKRbwxnywrq6IxpcPacOKcZ8ite2m70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgGNLbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 07:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgGNLbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:31:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D16D22203;
        Tue, 14 Jul 2020 11:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594726293;
        bh=ByDfIhzyLIF+vxT7O3HCwTlGfVoDr8iCeDZjjO1kjSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ojMGVQNRvCT1i+Lq3g27M788fPIs2mQipsfzj6Dbax+imQP17p2RvPs07Esdj3KN
         n1zxv+Et6cLRWsHjPxZpKuvxqlQNRjw7H7qfiCMSh1OYaWtxm310M2qTiG+P0e2U6Z
         pMUbCrTHeYLX0E9UkKbQZVMoKLSSdzUCdQHlBb0E=
Date:   Tue, 14 Jul 2020 12:31:24 +0100
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
Message-ID: <20200714113124.GD4900@sirena.org.uk>
References: <20200623114005.791643-1-yamada.masahiro@socionext.com>
 <20200714022252.GA1151466@bogus>
 <CAK7LNAQrdqztMrHtAHnbMkxeaDLLyBS68WVovev+zytHdD7RVQ@mail.gmail.com>
 <20200714095259.GB4900@sirena.org.uk>
 <CAK7LNARUwPRtG0uMZ4rwr7=+3wa9X1B70AXbnFL-CF1_wMvevw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Content-Disposition: inline
In-Reply-To: <CAK7LNARUwPRtG0uMZ4rwr7=+3wa9X1B70AXbnFL-CF1_wMvevw@mail.gmail.com>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 08:08:45PM +0900, Masahiro Yamada wrote:
> On Tue, Jul 14, 2020 at 6:53 PM Mark Brown <broonie@kernel.org> wrote:

> > No, bindings changes usually go through the subsystem - if there's any
> > other work on the binding then it'll usually also involve driver
> > changes.

> OK, then please apply the following two if they look good.

> https://lore.kernel.org/patchwork/patch/1261568/
> https://lore.kernel.org/patchwork/patch/1261569/

> Both got Rob's Reviewed-by.

Only today...

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Nl4sACgkQJNaLcl1U
h9DDjQf+ICe/5B7o/Oiyd40Fde/y+G/XbqI09gtp9WstNujmZycGh1Ay9lDK6mWE
l0GU3797amc+EOUhRKxHBvwwVnqKzNw6cDzDvskzKMzZfOW3d4OIRUF/lhy5RZiV
9JMRdrwfadw8Wuw8wtVVN0y61xM7HsdKTFCdCIJOZnvm5fWeVweBu99fNxooHQKP
yFIfSlOyAvA4ASbhLOyNr1ZLfKQIgpTqn3JYP2YsxSlwujGXTD2X4CrKMIcn5IES
KSv8q4XKLlNf9rirc9U3K2ikaw3hJSbTSy55+cMsTgoy7WwjJUgBCLC4/zqyvOc6
RDbGRwjDz/WsYtex4W5gNBgzxstL6g==
=UlzO
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
