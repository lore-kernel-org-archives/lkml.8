Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A7AC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7D420838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583242427;
	bh=6WOLOOvalCJq579tIa110eukyM4w1wJEZkYifeOpeHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0T1Bn+tVbG/85SN7J/34Vrwn8OmNERcX32y3Zg6XlBtYBCGjvR4n221yKsoWpN2Al
	 RkGSrjZGTbTB3WYf0kDpS+pRHi41N5kB+tI53qAvWr3GCcBlq05AYnWpL5GOqnt8Py
	 JvLx8vMCOXNKelzv0hPEui9uIEO68tgfRjg8t4qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgCCNdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:33:46 -0500
Received: from foss.arm.com ([217.140.110.172]:47094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgCCNdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:33:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 848E6FEC;
        Tue,  3 Mar 2020 05:33:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 087E73F534;
        Tue,  3 Mar 2020 05:33:44 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:33:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] regulator: anatop: Drop error message for -EPROBE_DEFER
Message-ID: <20200303133343.GG3866@sirena.org.uk>
References: <1583205261-1994-1-git-send-email-Anson.Huang@nxp.com>
 <20200303123010.GB3866@sirena.org.uk>
 <DB3PR0402MB39166725152B1B076E035F8EF5E40@DB3PR0402MB3916.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bO4vSxwwZtUjUWHo"
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB39166725152B1B076E035F8EF5E40@DB3PR0402MB3916.eurprd04.prod.outlook.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bO4vSxwwZtUjUWHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 01:23:19PM +0000, Anson Huang wrote:

> Make sense, will lower the message to debug level for -EPROBE_DEFER, it is just
> because that user ever complained about the error message in normal level for
> defer probe scenario, that is why I do this patch.

Yes, lowering the severity makes sense.

--bO4vSxwwZtUjUWHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eXLYACgkQJNaLcl1U
h9Cpqwf/diH8U0BhTFPucJH/RmKh/PiXw1z+Tx4QeXHdDwF121HZlOCbORSYhGRw
5tiCcQn7tAvaCrEWK2hzGRiCyGrSuIphzD42gOjWhfPOFzccYOzDRLJHngdp4Noj
gKpCs8nxqWVk/yO04mugAbVDciAiC+Upvf5OXgjPunWh5YmUX3ZbXoY7hOdKK2Gb
MX/R1SFvNRwoAufSDe5OmKZT6zy0TbLiiNewapPPVD5WP4+8totDkoQqi1PkMoL7
amNtsvKaLAApd0cdTdjgV0RuZlvur6tk7i15rHXX5USzXXs9rWhMAOLefBSKD/eP
9kGUGezR/gywdCYJHcSx8OZcq8lhXw==
=RfM9
-----END PGP SIGNATURE-----

--bO4vSxwwZtUjUWHo--
