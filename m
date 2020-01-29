Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B243C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEC520CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580296642;
	bh=aFr47fviWd3lWmuSqmoEgFXQv2UXuQmJ8VSfUHvFbbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U7/rRtHPwHYtQUphp7Updl5cdbdfaugK8xVeWYHHiENlEejDTpg9JYSONj8V4wJnU
	 6cvZCi6ufqw3A95klSPbz6m/vKtdoopFLfI/rT++zCDIicwLwWKYKeh0GC3CSQyyqP
	 5V89KVP2nD58+3Qv4OmnnJhFoXUtEv6ZImxzArDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgA2LRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:17:21 -0500
Received: from foss.arm.com ([217.140.110.172]:39618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgA2LRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:17:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 469C71FB;
        Wed, 29 Jan 2020 03:17:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5D9D33F67D;
        Wed, 29 Jan 2020 03:17:19 -0800 (PST)
Date:   Wed, 29 Jan 2020 11:17:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" 
        <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/7] bus: Introduce firewall controller framework
Message-ID: <20200129111717.GA3928@sirena.org.uk>
Mail-Followup-To: Greg KH <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "system-dt@lists.openampproject.org" <system-dt@lists.openampproject.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lkml@metux.net" <lkml@metux.net>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "stefano.stabellini@xilinx.com" <stefano.stabellini@xilinx.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20200128153806.7780-1-benjamin.gaignard@st.com>
 <20200128153806.7780-3-benjamin.gaignard@st.com>
 <20200128155243.GC3438643@kroah.com>
 <0dd9dc95-1329-0ad4-d03d-99899ea4f574@st.com>
 <20200128165712.GA3667596@kroah.com>
 <62b38576-0e1a-e30e-a954-a8b6a7d8d897@st.com>
 <CACRpkdY427EzpAt7f5wwqHpRS_SHM8Fvm+cFrwY8op0E_J+D9Q@mail.gmail.com>
 <20200129095240.GA3852081@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20200129095240.GA3852081@kroah.com>
X-Cookie: Chocolate chip.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 29, 2020 at 10:52:40AM +0100, Greg KH wrote:

> It just needs to be part of the bus logic for the specific bus that this
> "firewall" is on.  Just like we do the same thing for USB or thunderbolt
> devices.  Put this in the bus-specific code please.

I'd expect that this is going to affect at least platform and AMBA
buses.

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4xaboACgkQJNaLcl1U
h9AXbAf+KRZCtLfkXYUWRgFwJkclHlVSyIoUud3CsqCBy5e60mmmGtO/XARpZkDm
riG9GS1aF/2cXrFRpsaj0g9dkUsAhVJPddW/L9xvVP8od3iKT1XRTgLdVaMWZlt+
P8gZ0SdSe7IR2Oedeb3pB8BAAnHLbHroB7PUwxr6/3yVk5XO1JHVh9nD3nHiY8av
VVliKZLOA+nzN7BjsD5uoQeM1wLp7pBNjXdsJXAgwkTYhKQTZCcJvPpz0G/tjF4P
C3l51yXi2jBlsWIChml2OMfEgtTGHQONR2+nXzQ7+gb2z/g0AgjngOBjtbO2B7sM
C33w5SPMmYSvIHOUKPSFodAeeFr1Kg==
=oi89
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
