Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6DBC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184720801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581953065;
	bh=2zACJdzJWOimtEDKdqtbvKk8L5olDddcqqV+IDbusDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uiGduDM+iQ2vvK6cquByDEeb1jA2SvmIoOdDNWfL2mwEPmp4+iL5TSowumGO7oU0w
	 sDVeW5SBAH+5p7qcEpQw+3dm4fKxrg+wFXfiSFaapO4C6nzZBS5QpOry63ZlrCBRXG
	 CN+vRcdljLaUIMdkjVrjWCAHTN1sIGGXmkXXyXAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgBQPYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:24:23 -0500
Received: from foss.arm.com ([217.140.110.172]:37270 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbgBQPYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:24:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F112530E;
        Mon, 17 Feb 2020 07:24:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74CEB3F703;
        Mon, 17 Feb 2020 07:24:22 -0800 (PST)
Date:   Mon, 17 Feb 2020 15:24:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        =?iso-8859-1?Q?Myl=E8ne?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [RFC PATCH 09/34] ASoC: sun8i-codec: Fix broken DAPM routing
Message-ID: <20200217152420.GK9304@sirena.org.uk>
References: <20200217064250.15516-1-samuel@sholland.org>
 <20200217064250.15516-10-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="opg8F0UgoHELSI+9"
Content-Disposition: inline
In-Reply-To: <20200217064250.15516-10-samuel@sholland.org>
X-Cookie: There was a phone call for you.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opg8F0UgoHELSI+9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 17, 2020 at 12:42:25AM -0600, Samuel Holland wrote:

> This commit provides the minimal necessary changes to the driver's
> device tree ABI, so that the driver can begin to describe the full
> hardware topology.

> Cc: stable@kernel.org

You're changing the ABI and trying to CC this to stable.  This is
obviously not at all OK, this would mean that if someone got a stable
update with this change the ABI break would mean that their existing
device tree would not work.  The code should be making every effort to
provide a stable ABI over new kernel releases, never mind within a
stable point release.

--opg8F0UgoHELSI+9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5KsCQACgkQJNaLcl1U
h9DlOQf/fnliV8i6hOsjjmuPNKhYpYFB0CpQahOVaYcseah4KRMxgLYafPDPCBFi
YOG1uPOnbNmX7j2Vk4tA4fobq2c9iAJjVUafUWsNm6qiftRtSKHw8NgpDcH/i5+A
hQpjcJoW+zdzoV3a/l0/lA0Ntot3eligdLNJZEukfJTWU5KndAo0k6jJH0WNj3zw
xjiw6WNJee1j6xkOZEWzHoIZNZ+eXQjebMa5KbArSwzBXVS3SeaYZ9eMCzph7OpI
CXcIBWJssHvQlSxZeCjB64bwsBCbzUuRW6doz1Ikjn/IdAfjudwjwODeRENTKykJ
JCEiaoF87UkEhPoF68ycyKTgcgrxRA==
=pmEj
-----END PGP SIGNATURE-----

--opg8F0UgoHELSI+9--
