Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEF8C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A2302074F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587653133;
	bh=U3TC3bN3p9nhKeritQu2fK5CBI6ltT2H/wZ9X1HyZNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nUDbl/x3/keLRmMhpDPeedldGqE+9dNVGs07YFe3mG06YxhyjlSmD5fZD/4tj+t4x
	 iLMGUnWNfhhe0CVsDoFVX0EbVo6E05BN3oRSN+ZeLB6QCIBzU0FT1NZLTHcOWb5MrI
	 veP63Ikn8jE/aQbtPiZrVHfPDZxDb1mXKcGUL2zw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgDWOpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:45:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbgDWOpc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:45:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6D82074F;
        Thu, 23 Apr 2020 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587653131;
        bh=U3TC3bN3p9nhKeritQu2fK5CBI6ltT2H/wZ9X1HyZNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2GdKcbP/7Ijdm+VeNN6EOWFzP2+mwXdUap8T5O+nZ0CN6YEiDyTb2byLJ89nA8YSi
         VDzwLK9iDw/URifFQJrlhb8BH4/8y1m2hox1gF+EIhfuLSiMBuUt0OsfyvubHM/p7q
         ar2sCqg9tb7xPPSCxfEGFZu0SYh4W7Gg/C/mSyFM=
Date:   Thu, 23 Apr 2020 15:45:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Aaron Sierra <asierra@xes-inc.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap-i2c: add 16 bits register width support
Message-ID: <20200423144529.GM4808@sirena.org.uk>
References: <20200423085857.93684-1-acelan.kao@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EE8jvUPYYQjJtG7J"
Content-Disposition: inline
In-Reply-To: <20200423085857.93684-1-acelan.kao@canonical.com>
X-Cookie: This unit... must... survive.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EE8jvUPYYQjJtG7J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2020 at 04:58:57PM +0800, AceLan Kao wrote:
> This allows to access data with 16 bits register width
> via i2c smbus block functions.

> The implementation is inspired by below commit
> https://patchwork.ozlabs.org/patch/545292/

Do you actually have a system that needs this or is it just being
implemented for completeness?  The patch you link to mentions that there
are correctness issues with this implementation.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

> @@ -255,6 +312,10 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
>  		 i2c_check_functionality(i2c->adapter,
>  					 I2C_FUNC_SMBUS_I2C_BLOCK))
>  		return &regmap_i2c_smbus_i2c_block;
> +	else if (config->val_bits == 8 && config->reg_bits == 16 &&
> +		i2c_check_functionality(i2c->adapter,
> +					I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return &regmap_i2c_smbus_i2c_block_reg16;

OTOH we'll only use it if the device wouldn't otherwise work so I'm not
sure that it's any worse than just hoping the bus is uncontested,
hopefully system designers have taken this into account when building
systems without real I2C controllers.

--EE8jvUPYYQjJtG7J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6hqggACgkQJNaLcl1U
h9DIqgf+O6MUgn8IRhVjKqiNm14EY05T45nx9Glldr42oSPuanv/Og8adXetxcNf
IJP1xEihOrPMS7DZJl1Vc/jbJR3SMX0cbhDNxQTjXV00R02YeHDieCy/991CaNrY
ZwaOEoVjguOHCs9Z5f9jRGTUd2FZ5uLNgpssj3rS4Jugs+GUka5FFQGQMs9ckh1S
fynMgFbn1rsAsSsMnjHSUwgSxp/6ZXsXhnUt7twiQf0B7aW9m7NjsZduXE8LRpJA
hJC5Aj+Xrm0QqtzUmeb/Us5t5IYoE/u3DXLDfghbHkpzeLki86Vxw9m0IuAm0rMP
XhZyIBBMKsTUakQhqffh/aqMFEvckA==
=nI9G
-----END PGP SIGNATURE-----

--EE8jvUPYYQjJtG7J--
