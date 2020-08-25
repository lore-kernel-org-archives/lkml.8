Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF24C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 836E82074D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598349471;
	bh=DDyn7T6pv3pFn55/jArUvWOixIWyxxy7KV85+SC9Ols=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YC5g7vZwD/v5MW1iaEi+OayjftLWVXTnfeyeMYjUUx6OEhDbidD3hWwHvPW8V47yf
	 fgEt7+qQe9zQkCNXWLqT2rXII9EvkjupBMe+9YP2AFT/9AiCB2UTaSo2aCmeZGl654
	 leDRSIcCCHioWeMzU4iW8VbyuGNpf6Pge6GMohZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgHYJ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:57:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbgHYJ5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:57:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94F492067C;
        Tue, 25 Aug 2020 09:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598349468;
        bh=DDyn7T6pv3pFn55/jArUvWOixIWyxxy7KV85+SC9Ols=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOVNpwPtqLO7lhzYv4NKFyetmPAwodqOF0c3l1RhvCGTvlxjz7LPsznPv8iQ6kTnM
         nexi5J1zh7App8pz5p+WXV5rLhFRAFPGte+DcJIlFhNFZTHSUIdD7zotCF4XDy7NtE
         tCc7v8SALe9PEtWgUEKgchy0SbN1/72KXdFM7qkY=
Date:   Tue, 25 Aug 2020 10:57:12 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     lgirdwood@gmail.com, cy_huang <u0084500@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene_chen@richtek.com
Subject: Re: [PATCH 1/3] regulator: rt4801: Add support for RT4801 Display
 Bias regulator driver
Message-ID: <20200825095712.GC5379@sirena.org.uk>
References: <1597461262-25878-1-git-send-email-u0084500@gmail.com>
 <159776976828.56451.5593321071237177212.b4-ty@kernel.org>
 <20200824212341.GA3321545@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <20200824212341.GA3321545@bogus>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 03:23:41PM -0600, Rob Herring wrote:
> On Tue, Aug 18, 2020 at 05:56:08PM +0100, Mark Brown wrote:

> > [1/3] regulator: rt4801: Add support for RT4801 Display Bias regulator =
driver
> >       commit: 5bbbfc7f7f0a44b7a85ab3872dd2ccce7019f7b1
> > [2/3] regulator: rt4801: Add DT binding documentation
> >       commit: fd6b928db8a05fcd8629320c52eae214a8615aae
> > [3/3] regulator: rt4801: Fix the dt-binding document for dtc check.
> >       commit: 6f4ac2844b61d43c0c48b7c67a974d9f6e4ddd9c

> Really? Despite my comments patch 3 should both be squashed and is still=
=20
> just wrong.

Sorry, IIRC this raced with the patch being applied (the mails are
generated after things are pushed, and the scripts take a while to run)
and TBH I missed the bit with additionalProperties: false, it looked
like a mail with no context deleted.

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9E4HcACgkQJNaLcl1U
h9A6YQf+PSS4fWNofcu6+DESWsRtOwgQym/Bme4A8feEn+CCJh0U1TV7NUFrpv/n
QLYFbFwjQvDIrquZKze/+7NFTqi1zu0lun5Sw0gUqrffV9Z1LdXGmHVY5mDOo/MG
Sm/UHUDlt17A66jQBhbrRm4XK3SBTvoG5gyLGnFIougYUq1ucKypurqETDzat8ho
IXzMyvFy9AwQaHIQg35V2+eqF6QbBBA2AGZ3ZgZMuqPwkaulcBH8mLEuE+iRexFR
X+y++NrAa5IinuePbkUNaX5SNBXJXYWYvHU4mrPvR4Q6T9SMhrnrofyMJQO11ZRs
9bduCU7+3aDvdILkEYFQRBiFXvPFcQ==
=bgmB
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
