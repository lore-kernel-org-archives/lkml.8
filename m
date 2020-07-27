Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4C4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209A02075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595845417;
	bh=XxYim61vj9XWnTWAtCc0xM5uLcDRky2FtTMJkZV70us=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SgxVsvnObRlTPuh8fNH4BLdxKzwo5O2N3uevgbxLCH/6ZQlHYO4F1W4IMkhQ24iwq
	 c+RhzSRklFn3u8qlhzjL1kz+h01z/RABegJZkE75ycJVNdUFhuHe7M9x8l8wL8xflx
	 TJtDY/ZCNzq08rsEu2hXeL+yRVS9ZNqNlLeMOkaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgG0KXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgG0KXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:23:35 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4646720759;
        Mon, 27 Jul 2020 10:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595845414;
        bh=XxYim61vj9XWnTWAtCc0xM5uLcDRky2FtTMJkZV70us=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NnLmhWv6HUMsyD3x495ERz0avjjxK92vbN0UJjhd++oT+8cMBQ/pSVQ2M38/ot9eT
         S6X2Wc808FKsqOH+QlgIJWSHj1/Ml8R4Pbermm0l7ikLZ/i8mJjP+lVpHFaHGzloDE
         C0XYDif9CRWu/pnNJJUZRWGqfTLkRlEDI6cMrvCY=
Date:   Mon, 27 Jul 2020 11:23:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        balbi@kernel.org, gregkh@linuxfoundation.org, lgirdwood@gmail.com
Subject: Re: [PATCH v3] usb: dwc3: Add support for VBUS power control
Message-ID: <20200727102317.GA6275@sirena.org.uk>
References: <20200619142512.19824-1-mike.looijmans@topic.nl>
 <20200723075612.tn5dbkhes2chohwh@axis.com>
 <20200723110523.GA4759@sirena.org.uk>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2698920d-90ba-4c46-abda-83e18e2093c8@emailsignatures365.codetwo.com>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.0d2bd5fa-15cc-4b27-b94e-83614f9e5b38.ac9c2a67-d7df-4f70-81b3-db983bbfb4db@emailsignatures365.codetwo.com>
 <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <e63ee918-c9e3-a8ee-e7c5-577b5a3e09be@topic.nl>
X-Cookie: Doing gets it done.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 26, 2020 at 09:10:39AM +0200, Mike Looijmans wrote:
> On 23-07-2020 13:05, Mark Brown wrote:

> > Does the device actually support running without power so that's a thing
> > that can happen?  _get_optional() should only ever be used for supplies
> > that may be physically absent.

> It's the 5V VBUS power for the USB "plug" that's being controlled here. It
> must turned on when the controller is in "host" mode. Some boards arrange
> this in hardware through the PHY, and some just don't have any control at
> all and have it permanently on or off. On a board where the 5V is controlled
> using a GPIO line or an I2C chip, this patch is required to make it work.

That sounds like the driver should not be using _get_optional() then.

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8eqxQACgkQJNaLcl1U
h9D37gf+MqVp+KCPE5nCp6z56WtbbJ2SsaT2cXZ4Bu/Tftpv5fJXImgfZVXoiMo8
izzNNNSlBbUvB4O9eBb5M303A+ObHHVGTYkZ7L2HO87ulhK3y0Xj/8mXti+IatXD
uRLB4S5p4mf4tVxQYtWB7ipPMTfwrc3EpqnEb6pScY4OTtshbBoJH5sBKI6h2qnf
5NRbXA7INPlp/nnobxhy1PL4sPs3sI8PCaBXbTWA+Kb/g8vVLUSGi32/zDTtjL2U
niI6uey6i9PwraKfP+ZaU280nuoHd0zrs7MnGXuUcP0sxgd7NIRYQ7DMs/hhIhF4
ebDKZ3eJuHkhhVWxU2ukURV5h+LOcw==
=OkVm
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
