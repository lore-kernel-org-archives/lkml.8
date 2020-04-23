Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22351C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7422077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587640969;
	bh=Dx7pQDrVmQyMAWZBprtve56fnyMOnl9a9oj3FT6oQHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iSVKB3oci5gOg15i6UixwWsOBorFQrfUqZYOv+HEKY26Ni49utsRWkJGvOHZVMnnv
	 mLePjQ3A8akJ0+vdAn2VF2Z3041EoVJJ3exfzOYKXbeKFKPRmezkAlRkiXnNPa7Ojm
	 m+TYivKEiGcbGA9o9y1rPHSshYrVKoB1NagNwvxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDWLWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgDWLWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:22:47 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D209E20728;
        Thu, 23 Apr 2020 11:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587640967;
        bh=Dx7pQDrVmQyMAWZBprtve56fnyMOnl9a9oj3FT6oQHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FI5+FPsZ1FmhD66ETyrYkhZNgHK867H3td2EoxXUWTV4/dyuTWffaL/B01Pj3kIO0
         3oPVjAJzOpIacBxufSHVnC8tJ2Bdv5XnXoj6ZwqTvmBvOV7GGV3hi/4Gt9ospB7JPL
         HEi7L5mlrbqNZlgvuc+YnWebDmR2ZmgFYwgSczgE=
Date:   Thu, 23 Apr 2020 12:22:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] regmap: mmio: prepare/unprepare clk only when read/write
Message-ID: <20200423112244.GH4808@sirena.org.uk>
References: <1587620791-5279-1-git-send-email-peng.fan@nxp.com>
 <20200423104000.GD4808@sirena.org.uk>
 <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0OWHXb1mYLuhj1Ox"
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB27600084E4A040609EF620A088D30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OWHXb1mYLuhj1Ox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2020 at 10:51:36AM +0000, Peng Fan wrote:

> > This will mean that we're doing clk_prepare() during I/O which isn't good
> > since for MMIO regmaps we support I/O operations in atomic contexts.

> Ah, yes. Do you have any suggestions? If we use clk_prepare at the very
> beginning, the power that binded to the clk device will be always on,
> and cause power consumption high.

Not really in regmap itself - I think your best bet here is to move the
clock handling out of regmap and up into the driver.  regmap won't do
any I/O unless your driver calls it so this will work fine, this support
is only there in regmap as a convenience but if it's getting in the way
then you're probably going to be able to do a better job pushing this
into rutime PM in the driver or just having direct clock calls.

--0OWHXb1mYLuhj1Ox
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6heoQACgkQJNaLcl1U
h9CBywf/fnPhJcXY/ZcsnQ/vi7O9VXPKIUEMsFAKUwu8ovYZddm/l6F8UyHMsiC4
F2UqvKs2OQYkgFaYlFPX1Iz7/6mIh6tP/GvG62CtvCj4a1cBfnORs0bz9+N9fbiS
ZPvPAkToWzpV46b11jtFNkipWF/B0/9R5p6DDmA67GkLp8lTTotLqEKPg1aAMWHr
6oyxAIE/wE+j0ZSbueHwMInY2ZDZ8tMetzOw2AEx9VIKyWq36iSXu1u+B0MVlzzR
Wh/4GDgenCPocGtQLUpsjnIKP3Md2VdEShpziIDHTZd3FTW7swo582KksFKOK/jq
NjoDzT5amhMVYNtmsTdgyAZ/E2vxig==
=Krch
-----END PGP SIGNATURE-----

--0OWHXb1mYLuhj1Ox--
