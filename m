Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A29C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8664720722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582199985;
	bh=DgIDC6AkM6u7D6TFw5trf2GMUZytPlcHAL4yQI7PLyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hrYHYkRCH3+vX++6KANtPoQ4FHypWeGK7khv9lB2P1DGwNxvT5AceZugcMpL+9QF0
	 n+OfToqk20UdZO2UnDKq+lzkQreYZ5dyQMDPFWyulAg/aoHs5NOKWbtWByk15okEvL
	 yQ4WnSkqV4caCCiJG7oi2GDa22m8QomYSYk9DteI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBTL7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:59:44 -0500
Received: from foss.arm.com ([217.140.110.172]:41274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727393AbgBTL7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:59:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AC9630E;
        Thu, 20 Feb 2020 03:59:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F503F6CF;
        Thu, 20 Feb 2020 03:59:42 -0800 (PST)
Date:   Thu, 20 Feb 2020 11:59:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Volume control across multiple registers
Message-ID: <20200220115941.GB3926@sirena.org.uk>
References: <20200219134622.22066-1-dmurphy@ti.com>
 <2f74b971-4a6a-016f-8121-4da941eeccef@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XF85m9dhOBO43t/C"
Content-Disposition: inline
In-Reply-To: <2f74b971-4a6a-016f-8121-4da941eeccef@ti.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XF85m9dhOBO43t/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 03:11:47PM -0600, Dan Murphy wrote:

> I was looking at using the DAPM calls and use PGA_E and define an event but
> there really is no good way to get the current volume setting.

Store it in a variable in the driver's private data (there's a number of
examples of doing that for various controls, the process doesn't change
just because it's a volume), or if you've got a register cache it could
be just as easy to do the register reads and combine the values.

--XF85m9dhOBO43t/C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5OdKwACgkQJNaLcl1U
h9A0RAf/W6cdjwyRlUnVVDMRW9E8OYU778ZcT/8O3eYOjfj3OliJKZes2TIivLM8
FdRFixhp7U/o0zx3SRlCj4NcwGh5JNXGp5NU26NhEwUlB4WrvGEZJboN4cNTd42z
woKw/OgNgoBjaB79q4OWG8ms8/Wos+Pf2Kft4ihHoAGYfL4udV2CAbcwf0zvfjaU
gI3vDSEwT3C4PIRmwumO2AVW6/23YBuJA8ftoD2hzZPw9xwImpNHayXHKYo3arwO
0hwIF6njdvkMHjTjkrJSPwdcbiRU1AIYTbuFkq0A63tVzVueEn0UKlRAMKDDUX2s
A92V04yL3sc7xYYS2OxKi6O3fkGciQ==
=tSQZ
-----END PGP SIGNATURE-----

--XF85m9dhOBO43t/C--
