Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B999C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C7942187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583151744;
	bh=4GT4ZXv5h0iaS5Rdn8ybWt3lPW2MFe55v1Ixidf5Jm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tz01MuwUfaMPPbYhku/CTqqly6J5i3xDs9x8eQIU/Dlep6SOCDjxrZfNGjb2+IlxN
	 8htcfZFA0UIVS03RW/SF7qVm+ZtvWLlh+NSlyhdf5i0nALYt6PI4uOJ0xT84KWPURQ
	 2dyT7Si2ga9LIXWji0ziF/yFyc2Om+ZIg8I8DbPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgCBMWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:22:23 -0500
Received: from foss.arm.com ([217.140.110.172]:60180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727267AbgCBMWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:22:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAA52F;
        Mon,  2 Mar 2020 04:22:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3AB73F534;
        Mon,  2 Mar 2020 04:22:21 -0800 (PST)
Date:   Mon, 2 Mar 2020 12:22:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        linux-mtd@lists.infradead.org, linuxarm@huawei.com,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Message-ID: <20200302122220.GA4166@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
 <07bb2213-5543-0ef0-9585-be83026c1199@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <07bb2213-5543-0ef0-9585-be83026c1199@huawei.com>
X-Cookie: Whistler's mother is off her rocker.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2020 at 09:30:08AM +0000, John Garry wrote:

> Do you want me to do anything about the above superfluous newline?

Whatever you prefer, I don't really care either way.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5c+nUACgkQJNaLcl1U
h9A0cAgAhO/A6BTXUMWdGAfjAzNW8PGJ9Lj4J+5Bx5ztCAo0mIWdqA6Rvvo0jCqj
+rqUFeBsR4ym3KMc/r7piRdyd+G/o1ocRMMsV4A65kZ0LDAfMrvnYriUbRiJ/Esq
czu2tBBtbmHHD+j+LK4vl93h55XPm8L/Jk0Zc6mbwEWm59wNDePbIjxsugiY/bzc
wU0OjmZVIXAi7ydgkXmEzDMgd5hg8uVIVatw5tLqwPtVBJE0WJS8vBtk9yo9GMmh
5A5HJDcTPoxU16RlR/KbVbxr+HYxP2tCBTHe3xpUgGxijuFpIMcvdkGoA9UVAdVU
oBL1j2g7XpgsNnryB6+dxQ2FR52DYQ==
=yrZR
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
