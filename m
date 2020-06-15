Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9539F20738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592222422;
	bh=rwqUCTO58i5LtMrJbfCyPSZGV/lwxxKzZFf+w5tF0KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GoGmKjitjUk7k6YE+h0YQ5Fi41ESt4xXqNaYxxrX9fGK6UYtSPDbbtKx2r9eJ61qW
	 R2p02wOlqVFLLgog3klRCuoTOeVODIc1y8XNy1Ni39d4Od2qsIuZpnEWvklKiRcEJv
	 E+cHGcWJHlMaUUI19dCJFIPLKo0G4jFFYcTTbPYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgFOMAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:00:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728510AbgFOMAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:00:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE34320679;
        Mon, 15 Jun 2020 12:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592222420;
        bh=rwqUCTO58i5LtMrJbfCyPSZGV/lwxxKzZFf+w5tF0KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuhaZ1E/uhWGMwQOmHLl2x6A1HlqNMW1HoJtbYQhBCTFc1nVg02Z9xiV0yNrZ2reG
         fj/OFvspf1huUFCt74ieeXEMIaZsNyKAz/9h7eJ08tsPsSMVGMk/Q08009XSx9VM6F
         P5rY10LRbpeIRSbYQzyxKJYgWng20BFWrnTVI+2I=
Date:   Mon, 15 Jun 2020 13:00:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, agross@kernel.org, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        lijun.kernel@gmail.com, rdunlap@infradead.org,
        jackp@codeaurora.org, bryan.odonoghue@linaro.org
Subject: Re: [PATCH v2 4/6] regulator: Add support for QCOM PMIC VBUS booster
Message-ID: <20200615120018.GI4447@sirena.org.uk>
References: <20200612231918.8001-1-wcheng@codeaurora.org>
 <20200612231918.8001-5-wcheng@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VkVuOCYP9O7H3CXI"
Content-Disposition: inline
In-Reply-To: <20200612231918.8001-5-wcheng@codeaurora.org>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VkVuOCYP9O7H3CXI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2020 at 04:19:16PM -0700, Wesley Cheng wrote:

> +++ b/drivers/regulator/qcom_usb_vbus-regulator.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static int qcom_usb_vbus_enable(struct regulator_dev *rdev)
> +{

> +static int qcom_usb_vbus_disable(struct regulator_dev *rdev)
> +{

> +static int qcom_usb_vbus_is_enabled(struct regulator_dev *rdev)
> +{

These operations can all be replaced by regulator_is_enabled_regmap()
and friends.

> +	init_data.constraints.valid_ops_mask |= REGULATOR_CHANGE_STATUS;

No, this is broken - regulators should not override the constraints the
machine sets.

--VkVuOCYP9O7H3CXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nYtEACgkQJNaLcl1U
h9B2xQf/elyk74snQRDjxhiJQzyG+kMEpR5muDGLg/ZKzb0LHtRNb+t0RcqkzTFm
7YlZ6L0oMl4RX8ZsVlZT+RxWROHw+MuYF5itiC5pbDvWl2jjIJGn2jI5/wq+7zQD
LfHAJWQCUCzjHGuTgtXXzoejILvkrSaxPkffHfQj/zTX/kfLciOlMmykYEDVTOWM
h8AkuzhvtQEAJMpzF986hzyhjx/gAfNNbkGiCOmJPoeFMXF7kqtRjZDIN59pC/se
oJ1zDYM0gzqUDki1mrfW9UdGKXKr5egUvBT11dbZKWzOOIKizDyLlmmaH8s2p5d5
Y3gJnWM3vmGfn0YrVIAA8bzUHRrbRQ==
=2JmG
-----END PGP SIGNATURE-----

--VkVuOCYP9O7H3CXI--
