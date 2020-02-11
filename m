Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6669C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A535A20870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581435558;
	bh=vaUxnP22bcA3W8Oj/H35rQr+94g+pJKRkOs3Xybfxfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JGtYkC5jjg7NDa4lx/lGOq8B6QwaGng3re3XWCYywIuFtgciHSlYV/IJRGGcc197t
	 L6qkPJFR7Xhh/10f3IY7Yezgo+kwhsU6FsyKi3N5GrSPjRHul7ekI+FiL03aladLMJ
	 0nCkI+oSAQu65bpIPA6MOCGU1VEf019jZlrrT6So=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729401AbgBKPjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:39:18 -0500
Received: from foss.arm.com ([217.140.110.172]:48008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbgBKPjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:39:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430A231B;
        Tue, 11 Feb 2020 07:39:15 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98DA83F68E;
        Tue, 11 Feb 2020 07:39:14 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:39:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        andrew.smirnov@gmail.com, manivannan.sadhasivam@linaro.org,
        marcel.ziswiler@toradex.com, rjones@gateworks.com,
        sebastien.szymanski@armadeus.com, aisheng.dong@nxp.com,
        gary.bisson@boundarydevices.com, angus@akkea.ca,
        pramod.kumar_1@nxp.com, rabeeh@solid-run.com,
        cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com, jun.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3 1/4] dt-bindings: spi: imx: Add
 i.MX8MM/i.MX8MN/i.MX8MP compatible
Message-ID: <20200211153913.GL4543@sirena.org.uk>
References: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xjamM5M9kpPM/bcu"
Content-Disposition: inline
In-Reply-To: <1581425307-18567-1-git-send-email-Anson.Huang@nxp.com>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xjamM5M9kpPM/bcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2020 at 08:48:24PM +0800, Anson Huang wrote:
> Add compatible for imx8mm/imx8mn/imx8mp.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--xjamM5M9kpPM/bcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5CyqAACgkQJNaLcl1U
h9DOwwf9FtG/iaQJVuAEOHRrJ9sfIJHvcKeiEzx4CbvNw5x48fs24VzAWO2rg7+t
iyze1NRFVPS9oH0RLhrQ7jTj+W2t/2Ab8aF6SdK7GhHrIHPRnISNg9Gw15CpTNhv
G28a9MR8eOddt9JprJ9GE37oyZyaBrFKCojNYlCIRDUxWVQH9RLjh4WjEy2RXxFi
/OY2G513MX3vivd/04F+9O3KtfOqYdMjgeZ5gi0wbmK4MauyjdMGdrkMbrFcWwKC
HdoAfGE9ounM1hYtYgAJRoGl20p6Z1n5MQ8HUHeEQkViPA+x4hiFgnRfV3xxtMiu
rMm3Cu+06Jk9hh/fqB6Qlc92m6Up0Q==
=TZK0
-----END PGP SIGNATURE-----

--xjamM5M9kpPM/bcu--
