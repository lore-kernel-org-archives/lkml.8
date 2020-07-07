Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5A7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D51A42065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594117274;
	bh=PkcT89RF+rNKPiYJ2NVnhgVw6bD2ZCcxYHYZ6FlrF48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1EBEibBQbCk+hFsPxeG+y5/hxQNzLZIK2zagZ6qafFUYqKy0Ylv+uE1ImpT2BLlWa
	 IIoucqS3Uw6aMWPd4815mB/UAv05Uv0k+bSBqLqyvGaYX8ZtRhRh0t9pMHheVjcSIU
	 3V4m+s6uLisIzXwL8GHZSkmHZt8dhmWUEmARS6JQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgGGKVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgGGKUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:20:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 171B32065F;
        Tue,  7 Jul 2020 10:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594117246;
        bh=PkcT89RF+rNKPiYJ2NVnhgVw6bD2ZCcxYHYZ6FlrF48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DaMl84SGNGIJ8ham15BOct3E7GRZKaH2J5K3tfz4AfsKXSLuqQJE69KWyFCNaYaBq
         kWdws/cxLGxJlKMfQWkrgdk3dNFNEi9ccDo+SV1/NyT957WXVl41Z9yFQI0B7ycHy1
         DJ6lY7VTJzLndY+wSNn7KPHCH7sQowBCNcRznW/w=
Date:   Tue, 7 Jul 2020 11:20:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: fan53880: fix Kconfig dependency
Message-ID: <20200707102042.GD4870@sirena.org.uk>
References: <202007071433.Z3bmcgjU%lkp@intel.com>
 <da3aece9abd23b12837e9abf908ee67f0c2c988c.camel@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <da3aece9abd23b12837e9abf908ee67f0c2c988c.camel@googlemail.com>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 11:03:23AM +0200, Christoph Fritz wrote:
> Currently the fan53880 regulator driver needs a device tree to get
> probed, this patch provides the necessary dependency.

It doesn't need it to run so it's better to leave an || COMPILE_TEST in
there at least and fix the warning with ifdefs and/or annotations.

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ETHkACgkQJNaLcl1U
h9DxZwf/R/uqIbe5MYZNckOGk1OOJBAvUf7WxND+oaQEes3BNouCRoOApMyQHAti
uWJZEzz5H+35rzTZgb9SK7LSfZ6G6hTK8DVDSH1ckjnELqSj95DCC2D5JbDczJtr
OZEVp0soIuSn3HQRDbrD71Nrxp3bcz/d3taRdms5PfAf1cC4Iow2OnGxRWcPyWWc
NIszbOdRDrZc/IO4VDaCjJhf95KOWxGeiRTqzR/ng+0sTjCwMv+eLz1h2ygiN55v
6Q0RVMyohM2sOO++n08HcQyI9m5Zb6HbpHYkv4e6oJ8KD756SMUbMYItlzYuXHkr
sU7OO7Yi5lYWgbcgKrNWB5tXn6cQNg==
=zBYZ
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
