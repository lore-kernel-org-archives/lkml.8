Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B818B20820
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591864900;
	bh=QsS/tOLm0lwVFkLv1bvdt7t2u82usdSBFhe+D9o/m6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YCSI0hDstDYMejVYm5onGhWsvRYdFER97EMlagBlW0Db2JeIzHwWrCWSv8QQ4E3VY
	 tX0nz37UnM0TgrcxlnVVE5Vp1WsGcqkSNcPDQ4HdEozsEsAo3sj4dQHonsJ0fnooDQ
	 9pxJ+j85OQBGrT7Ml8Mb1RKKzFRZYgaaI3AOIDco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgFKIli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:41:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgFKIli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:41:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1BA8207C3;
        Thu, 11 Jun 2020 08:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591864898;
        bh=QsS/tOLm0lwVFkLv1bvdt7t2u82usdSBFhe+D9o/m6U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGxrGjOWwMM0evGPt5Ai7y8Msl/Mu9rWs4Jh+j+NCI+6ybG4fyAaQG95heLlaEva3
         18bYty9pvqxD+hm6te8k4z6gksi6PrmTG4hZWVEF1PU7wVevrLjQuqzz9Dv5e4v7Yd
         RktG4MAt4nWzQJi9xmao8Qt2Svg+PlTXwDUaGDd4=
Date:   Thu, 11 Jun 2020 09:41:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200611084135.GB4671@sirena.org.uk>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
 <20200610180118.GZ3720@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yylu36WmvOXNoKYn"
Content-Disposition: inline
In-Reply-To: <20200610180118.GZ3720@piout.net>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yylu36WmvOXNoKYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 08:01:18PM +0200, Alexandre Belloni wrote:

> My point was that if we were to keep that driver, the goal would be to
> have it out of staging instead of simply making it compile.

Yes, definitely - that should be the goal for anything in staging.

--Yylu36WmvOXNoKYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7h7j8ACgkQJNaLcl1U
h9B1NQf/eAOKPLkgcd+pMevL+wJlH7JsRYzk65f9i97F+wSsVXn1QDXkKiiOR1bD
rkFO3C0++31H/brsYSkLpsxhMtika0T1WqwxskXs5xER584Xt9SEfONh6yX7Uzyq
Recbx5h8Hwq16z0jC2SAemnXl2pbz5LMQYGIPP9jj6gRY4KImCCSqPbl763oYHKE
jvUH4vyHODWSzAmSYqGv3lIkRE/oZbcNKatDxgPzFrcXFilmuZt/hRt+PPQ5vtiK
r/9vWSGxW/UO6K39svmHjEMOQXtGC8S70/GT1ODLxesgEqRX3NCHZAuWR3TOFfM4
nHoamPxEb2LydXYOKZmETMIlngmTcw==
=nIE1
-----END PGP SIGNATURE-----

--Yylu36WmvOXNoKYn--
