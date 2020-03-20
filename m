Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F11C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C261E2051A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584706543;
	bh=7DU4BFEH027DS1xtBiza35jxnRowW4xC2oTqrwQMZWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bKv1CBS5csvTE4X/hVgHDdg6CDq368CQ0i8BbrwTj/ncb6vf72LssLSchwXTu1q6m
	 vhGUwKCoLZN1pX63Sse8OmxmMNeqGpZHVzbpmpxluUdi5p+az9pBW9bOwf3dzEM3Wc
	 l0A8Kii0Ms086bi6ZygHFygtUkYIf6Z5ndCehRcs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCTMPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:15:42 -0400
Received: from foss.arm.com ([217.140.110.172]:48282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgCTMPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:15:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A50AC31B;
        Fri, 20 Mar 2020 05:15:41 -0700 (PDT)
Received: from localhost (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A0E13F85E;
        Fri, 20 Mar 2020 05:15:41 -0700 (PDT)
Date:   Fri, 20 Mar 2020 12:15:39 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Alison Wang <alison.wang@nxp.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [alsa-devel] [EXT] Re: [PATCH] ASoC: sgtl5000: Revert "ASoC:
 sgtl5000: Fix of unmute outputs on probe"
Message-ID: <20200320121539.GB3961@sirena.org.uk>
References: <20191212071847.45561-1-alison.wang@nxp.com>
 <CAGgjyvHHzPWjRTqxYmGCmk3qa6=kOezHywVDFomgD6UNj-zwpQ@mail.gmail.com>
 <VI1PR04MB40627CDD5F0C17D8DCDCFFE2F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <VI1PR04MB4062C67906888DA8142C17E1F4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <CAGgjyvGAjx1SV=K66AM24DxMTA_sAF2uhhDw5gXCFTGNZi8E7Q@mail.gmail.com>
 <VI1PR04MB40620DD55D5ED0FDC3E94C2BF4550@VI1PR04MB4062.eurprd04.prod.outlook.com>
 <20191212122318.GB4310@sirena.org.uk>
 <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9zSXsLTf0vkW971A"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU0xZOb0R2VNkq6k3efdkgQUtO_-cEdNgZ643nt_G=vevQ@mail.gmail.com>
X-Cookie: Laugh when you can
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9zSXsLTf0vkW971A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2020 at 01:49:37PM -0700, Tim Harvey wrote:

> The response above indicates maybe there was an additional ALSA
> control perhaps added as a resolution but I don't see any differences
> there.

The response is talking about existing controls that are already in the
driver.

--9zSXsLTf0vkW971A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl50s+sACgkQJNaLcl1U
h9BQ8wf/bNkc+gfjOgAy8vg35nBok4c9UrW/sr+phlxjxTDNXqHsikV9NU5wVryf
PPMFtP7SNRjy3sKVlkVzph8IhxbMv5BA1DDp2ejW6L0Gh+atXdN4Wr9Cupiw4+PB
mf9bOzJ7Ol0cL9nHaaLBZKyBRg8kjw2h9g5T94UDlelR4csnAI7NYlO6crY2xOlR
CIDGMt06OapXefylEtQFRXc2usw180zscmOlEmafMku73M2qsyAWiXbvJD2O38Dz
QZ9M/NoQpp62WHkPawJXe19ju6n1KrEuPhIr8hW2EcHRbWligh3stcdBrZupXQfd
0TV+XAdvYJRrLzbCEu8v4+poN+b6hw==
=PTUB
-----END PGP SIGNATURE-----

--9zSXsLTf0vkW971A--
