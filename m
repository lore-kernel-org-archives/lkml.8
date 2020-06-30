Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B52C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:57:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F66A2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 21:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593554265;
	bh=CzBx6x00VbHMHS4DcAYU1yThrTZSIpRMWNsv23BXRPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b7xyad+PZnyezzo+3tR9m5bxjmvecVBaE0M55gzcFZCUr78AyrALdyIp+moPfNjRJ
	 CPRL+yDPnHRn0hsjRJXJ3lem9jHpMr2PT9sREFYBTXBRdF0XCDemo8lxRom9/6HBFv
	 AAo2Mcsrww3/aANoyTmzPWsoDEEY7Y7sKksVWzg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgF3V5o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 17:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgF3V5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 17:57:43 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 067E4206B6;
        Tue, 30 Jun 2020 21:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593554262;
        bh=CzBx6x00VbHMHS4DcAYU1yThrTZSIpRMWNsv23BXRPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1oNgD8S6Xyn8aq/Y9CFhNwnBwDz+MhMQXIKUnw1RiGZR7yGSDUNMy3scILBP4vI6/
         /rSXJB9w49IGm455kc1/cI2VYSKXaD31YUbMPhi8CfEJPxlbkcjEZ9lSCTyOA+5f2Y
         A3JyCEvSKkAvVMOOERKezcFug3Jbzj2ZUz/FPVWc=
Date:   Tue, 30 Jun 2020 22:57:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Sia Jee Heng <jee.heng.sia@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ASoC: Intel: KeemBay: Fix header guard
Message-ID: <20200630215739.GN5272@sirena.org.uk>
References: <20200617010232.23222-1-natechancellor@gmail.com>
 <20200630210441.GA3710423@ubuntu-s3-xlarge-x86>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kK1uqZGE6pgsGNyR"
Content-Disposition: inline
In-Reply-To: <20200630210441.GA3710423@ubuntu-s3-xlarge-x86>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kK1uqZGE6pgsGNyR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 02:04:41PM -0700, Nathan Chancellor wrote:

> Ping? This is a rather trivial patch.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--kK1uqZGE6pgsGNyR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77tVIACgkQJNaLcl1U
h9C7WAf+JjcaYs5BFK44gTZgBmWsKTiCopbq3uQWJFLJ+feviYWrqG3/X2GpjxYn
YidHVwaQU0nI0uAbrHUyM+RILZ5ocezuzQ1ydnolNLS0Y4k6s57DV9SA6AthD6a3
mVDj1kV3r2IxSs6dEGLV57Nncs5jP4bvaV1lqt/2vvQXgECZFlVNWZmcY7m2OLep
AUjPC6mn5pfN4ekDOXcEDh6D5RgWzgw0iGg/sgMCkiIqbQjvVo1Vb6wdkl/7q0yC
fRijXM94eslYKA7dzh6Wwy5rlOBQWdfkdsbR9CMOMLdPO1zwozXCu7liK66b9Q3M
WMxtYJBX2NejwkxkRJGcleYW+miaiQ==
=Xj8M
-----END PGP SIGNATURE-----

--kK1uqZGE6pgsGNyR--
