Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D70C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F90E2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583239422;
	bh=044UYjZT4SSbVtehGTLNQnkP9+qCXgs6Amiefo4tRXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CbD/Ey3q1MUSEdw40cVsTnGWHZry75woWRYLmI7lFzln8/6rEy6vLWafL15u0IAYE
	 eJpfT2JBBUAZLCjU4FNOBSgTglPSPh3wjZgmRjBoN9Ga2RCRhPINaXTzUwJERyn4gr
	 5lkTl8Fr9/yaGF0AdNXN17MrsjIZs0iTf7E1F/24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgCCMnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:43:41 -0500
Received: from foss.arm.com ([217.140.110.172]:46538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727922AbgCCMnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 07:43:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82C99FEC;
        Tue,  3 Mar 2020 04:43:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050CE3F534;
        Tue,  3 Mar 2020 04:43:39 -0800 (PST)
Date:   Tue, 3 Mar 2020 12:43:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Message-ID: <20200303124338.GD3866@sirena.org.uk>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
 <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Content-Disposition: inline
In-Reply-To: <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
X-Cookie: Drilling for oil is boring.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2020 at 09:42:45AM +0000, John Garry wrote:

> However, maybe another callback could be introduced, .early_setup().

One thing I like about the explicit core code is that it makes it much
easier to see which drivers are doing the worrying thing, with just
overwriting things in a callback everything is very freeform and you
have to audit things individually.

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5eUPkACgkQJNaLcl1U
h9BYcAf4kl/gydZycwZtTddrolWZTe5aGp9hdBn91H5K4i0f3Sp/wzjZi9Z7NMLZ
hFT1kd7fwU9kHr5QBDt66s8mnC/A8WU/yLekP7hKQkumLFBXT+EzpW4ZsD0OFB8R
KvAr5BCFqvJMdRPYCqsqi1nvZwNA4jYhWXp5sGlT3T/4GH0ulhQDZghULkx+8e06
Kd23pOwyQmDQgwVTqQ/YuB36cPzriYsoxu3vijQZLIVGO4K/PPqiaoq5Af1EiGlr
mcwa0IaW3IMQbjLk5KPuITz8YUMrPryVc+unOuertCfFYoHcYmgIO/Aq6yOpnbRl
UajtjXoFfB5jRdSGvoDFHjZcfYfJ
=FOcd
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
