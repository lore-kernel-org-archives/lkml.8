Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D93C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27A8214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578907854;
	bh=kO4+vTp5Pf9yF5MFBXYv+fbzeN3YsHdoVpGiHtqh4oE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MulCDBDdvwZW7cZAMCUO6Vr5jFITXFBMFWgE5bOb0hzC4aCDwAd49A/61fn+KCLPr
	 7xsneM3n6iDNtkl+SM+IH0Yiljr0nHnjGAM+V3dDVm4ZQoNAfGMGBzwIFm1onEHpv9
	 frnFH5gIZYMwxuvXvPLzi0VgCVSzO3o1olQDrs6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbgAMJay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgAMJax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:30:53 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053062082E;
        Mon, 13 Jan 2020 09:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578907853;
        bh=kO4+vTp5Pf9yF5MFBXYv+fbzeN3YsHdoVpGiHtqh4oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O2ZzGY/1L6N03VHwkufdNp/AHbueNn8soeStyXgMUkkTGq8XHEBb7x2za3xzp3r4T
         MH9n4iKviuLAxyZPwtSyKle2pH4ZoSY0AUdZmcyg+biaY95r2aE46Mwk+opOU5Rw+P
         LaQQtlNuJYEB7yIjjlfy6ux6HnqINLIrtO4q/r0A=
Date:   Mon, 13 Jan 2020 10:30:50 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v6 1/6] dt-bindings: mailbox: Add a sun6i message box
 binding
Message-ID: <20200113093050.32qv7l7466c5mz64@gilmour.lan>
References: <20200113051852.15996-1-samuel@sholland.org>
 <20200113051852.15996-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mjfyfyav2c5rsq4t"
Content-Disposition: inline
In-Reply-To: <20200113051852.15996-2-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mjfyfyav2c5rsq4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2020 at 11:18:47PM -0600, Samuel Holland wrote:
> This mailbox hardware is present in Allwinner sun6i, sun8i, sun9i, and
> sun50i SoCs. Add a device tree binding for it.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--mjfyfyav2c5rsq4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhw4ygAKCRDj7w1vZxhR
xag8AQDndez/6x/OQZ3/TuccUojDbTqhJitIb4T5bYONg/61zAEA3gsBZUTbUxVl
riZ0r5u5J4h8Y7XnMXS3oFkAhIoMkwI=
=LNDX
-----END PGP SIGNATURE-----

--mjfyfyav2c5rsq4t--
