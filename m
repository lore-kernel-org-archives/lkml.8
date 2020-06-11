Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E48C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49AD20820
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 08:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591863981;
	bh=YUMp2q/HufrKUWQR8d10DU5EVMYQ+RTK4Ary2FsUxpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=myt1x2eIdlDB3eQB2v3an6vQVBHH6ZISwk8q776yOu/cQRq4bBXvxLJo3DKKBVwpY
	 TNUDXqicmZHzNRSUnRBKiC85Iwlg+W6gPiLsYGk4Q8UPjUl2fL9Hr64SIYHdF/xBXb
	 5vX+UZ1/ISBsVm3t+F8L9qbBz2CV7hCpa/CUInWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFKI0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 04:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgFKI0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:26:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67677207C3;
        Thu, 11 Jun 2020 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591863978;
        bh=YUMp2q/HufrKUWQR8d10DU5EVMYQ+RTK4Ary2FsUxpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g92fsaSSZ1PFMOpD75oQHjkFfyB+k99l45z3iWHzROPI9k1izAbq8oCEuWP9DUh/L
         obOLjjf6Z8QST/NJgwjuLosUkGdMBxHzWtEHhuygRAsfE9IDGk7WpAhK+TtBWi1Uiw
         Ag9Vn2pyP1D/znXiB2AG+PfUPIIy6uIlJDb7jgZo=
Date:   Thu, 11 Jun 2020 09:26:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 0/6] Enable Greybus Audio codec driver
Message-ID: <20200611082616.GA4671@sirena.org.uk>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <20200610173711.GK5005@sirena.org.uk>
 <20200610182322.GC21465@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200610182322.GC21465@gmail.com>
X-Cookie: I like your SNOOPY POSTER!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 11:53:24PM +0530, Vaibhav Agarwal wrote:

> With patch#6 in this series, I'm proposing some of the (dummy) helper=20
> APIs required to link DAPM DAI widgets for the GB Audio modules=20
> added/removed dynamically.

> Eventually, I would like to propose relevant changes in snd-soc APIs to=
=20
> enable dynamic linking of DAI widgets for the modules added and=20
> remove/free component controls for the module removed.

> I'm seeking your opinion on the proposed changes. And as per the=20
> recommendation I'm sharing the changes with ASoC mailing list as well.

These are proposed incremental changes to an out of tree driver that has
never been submitted.  I don't know what the current code looks like,
what it's supposed to be doing or anything like that so I've no idea
what's going on or why.

> Kindly suggest me the preferred way to follow on this thread.=20

This is effectively out of tree code, until someone submits it properly
I'm not sure it's useful to submit incremental patches upstream.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7h6qcACgkQJNaLcl1U
h9ClMQf5AfzPskdM7GJn5Lf8DIJciRGrA08Te9rvY3eabhXU4aiMCp9lBF1prenp
QGLxYB+mW1bdfMOqVwzmQlVKZ6OtZ9IinlKhqWn6cea9eWK3aGo8uaGjp3H8tJp1
HYpMyoBfCedLFxL/YGlhxn2yj5k++pPtDS+6NwEYuec1FV3k46hzKfmzr5BJzgcp
LYLZT8n/3S+AJoCb7NRY07Ptz1+Qev16y+Ta45oolFnFceewDJ+jxt4w7+BLVwJt
rAchPXSGY0SgPhSDu/hPcKODETZ7O2UloPGht/R5SG8Fzabg6ngJqujyawqzDddL
TYo4fg6SQ2NWig21RJ9+2byMqNbgPg==
=yLco
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
