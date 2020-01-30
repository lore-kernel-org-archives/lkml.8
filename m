Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52FFC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EDD206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580388121;
	bh=qzZKzJgbkkvTCNT1E1c6c/3+Mf9tyaDlOB6yKOTF4Us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=B1Kc62IpQF/j+8gNViSdJuw8U2fler+cknxNLZcE6HRkgYc2YxTxlWuz0GPtS0rl3
	 4jA80SMkZP289kquzZ+9pIm+YMApNqibhmeWMUTK6bKhdWdWHjSPq+qQRF38ZCKZcM
	 Y3r2lvyA00mjMyUgCSmLBfzoGnmlp+djQ3JsLoms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbgA3MmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 07:42:00 -0500
Received: from foss.arm.com ([217.140.110.172]:51960 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbgA3Ml6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 07:41:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04C4328;
        Thu, 30 Jan 2020 04:41:57 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E7B43F68E;
        Thu, 30 Jan 2020 04:41:56 -0800 (PST)
Date:   Thu, 30 Jan 2020 12:41:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mirq-linux@rere.qmqm.pl, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH] ASoC: atmel: fix atmel_ssc_set_audio link failure
Message-ID: <20200130124155.GA6682@sirena.org.uk>
References: <20200130114930.28882-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
In-Reply-To: <20200130114930.28882-1-codrin.ciubotariu@microchip.com>
X-Cookie: Positively no smoking.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2020 at 01:49:30PM +0200, Codrin Ciubotariu wrote:

> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I can't take any patches without a signoff, please see
submitting-patches.rst.

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4yzxAACgkQJNaLcl1U
h9DhMggAgULBasGe93GC8xP7foe0sWUQUTvtUeuVxUrWZlYrXAPuYZI6f0/bMeDf
chL5NIydQW2a9sMqyqBKfu5WZbl1k1ABVrFmA/CmUflMej4IdsVLM6mKdkhetmgu
XjQtVObQGU7Rx7dkpGjsrVQkzuC94G5DfcGWJYq3uABTsMlDM5+Xdp6bUbWXHza1
uCdbwrrbNivS4UH6WPvYW7I82MpdvonLc7ZhsDFa3yonrmHSnIvAQr0KLJZkCE5R
6zGBQike3MUxHiwIYAslGI3Kc7pmMlVNUHzja77PpZVFNGN7TYCeRri8FQtLXZQt
1lhBjUL3wgBwVOAYTzHtsXtUEgCOoQ==
=f+66
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
