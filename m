Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB91C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFDEF20733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581360684;
	bh=CMQkbzde5JYenRlbaYzOW6JTpk2NrCG3Lp673j2vPeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VcSvglgV1JpLR7OQAomUdoj2X7YNDNwV2LpaHaT7rwYrqO0M3osWJ53Pk7F4FV1vK
	 3xUej51otC8uTm3sX9Ss3rhdj7RQZnI9PEYp3lLJBfhlnjD197uEnfT1lq//uO2oLw
	 +lIey0EuEHACXqd2xlLqEmkP6UbYlJcoMh5aKkMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbgBJSvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:51:24 -0500
Received: from foss.arm.com ([217.140.110.172]:37630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbgBJSvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:51:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 175711FB;
        Mon, 10 Feb 2020 10:51:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 913B43F68F;
        Mon, 10 Feb 2020 10:51:22 -0800 (PST)
Date:   Mon, 10 Feb 2020 18:51:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com
Subject: Re: [PATCH] ASoC: MT6660 update to 1.0.8_G
Message-ID: <20200210185121.GC14166@sirena.org.uk>
References: <1580787697-3041-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <1580787697-3041-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Cookie: No lifeguard on duty.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 04, 2020 at 11:41:37AM +0800, Jeff Chang wrote:
> From: Jeff Chang <jeff_chang@richtek.com>
>=20
> 1. add parsing register initial table via device tree.
> 2. add applying initial register value function at component driver.

OK, so there's still a problem with the whole concept of putting
"initial register settings" in the device tree - this is clearly not
idiomatic for an ASoC driver.  If there are machine specific settings
that need to be done unconditionally (eg, values controlled by external
passive components) there should be specific properties for them.  If
there are runtime options these should be normal ALSA controls with the
default values being whatever the hardware defaults are.  If there are
things that should just always be set no matter what then they should
just be hard coded into the driver.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BpigACgkQJNaLcl1U
h9BiyAf/QaAXZr0p0rJqLpG7vmgoly1T9FBkezqmJEiv3P33z9JTA42AEA+m+4/+
P4rXU6XE8hpiODCHfl8xxLY3VzihTReH7vIZf3BsGdsKNxOGTv/srMC0GxLynuXt
aVgdqh/a1iVFpHlExbNepcncR7OD96NAQT90Qg25TkDEGQAKcX6KxFtD7xshp/jd
dx6o0pSY4sypcaPDro+KSOzXDNdRv9tF0/mDKCY+nMpkX6mtFHVhJyp/W3J6bMDS
hdaaLnWJ5qLwJa9d2wmuu0Mhgf8dcftSBHOHa1jPVYhloldoFGZTPtAa0BQdFH/z
kGDUjJRGtISjBD+mJLho5/CiPPhPFg==
=WFJc
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
