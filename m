Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41335C47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167742073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588591722;
	bh=8dnHAlveF8oSzyRI/bshOeUXvAOZ3zOI0uKOwMIafSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VKnsHoRkYtHM7ztV7edX+j3xg10XeGQyu8z7vfqSKq0WjVRqY22kWJs2fHzDKaKMm
	 egKp6oi0lALt5kfD7/XjZePeRws8sV9MJY+iW+o+duJixywjYFX+LRILgbj4XbNHTL
	 dFiXr0/wBAA3joJsw1KnSi1j+0GEIaDMVPeswR6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgEDL2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 07:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgEDL2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 07:28:41 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F190A20721;
        Mon,  4 May 2020 11:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588591720;
        bh=8dnHAlveF8oSzyRI/bshOeUXvAOZ3zOI0uKOwMIafSU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5QRijKOE29Jo+EKAdkh+ewKNtgdqP49U526Q2Sfxi2stgSeoXwYEeo4vzFwII7Nb
         JAqhvbWO3/mpTHvBOlkjefENX/UF/jjBUXzuHtCj1Zw4IYC4e3oA8UZbPwN0f569Yx
         3hRVp5IdHkMViNHlTTIoUmfezAB+MvoUejMxdi6w=
Date:   Mon, 4 May 2020 12:28:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Jerome Brunet <jbrunet@baylibre.com>, kernelci@groups.io,
        Kevin Hilman <khilman@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, stable@vger.kernel.org
Subject: Re: stable-rc/linux-5.4.y bisection: baseline.dmesg.alert on
 meson-g12a-x96-max
Message-ID: <20200504112837.GD5491@sirena.org.uk>
References: <5eabecbf.1c69fb81.2c617.628f@mx.google.com>
 <cc10812b-19bd-6bd1-75da-32082241640a@collabora.com>
 <20200501122536.GA38314@sirena.org.uk>
 <20200502134721.GH13035@sasha-vm>
 <20200502140908.GA10998@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20200502140908.GA10998@kroah.com>
X-Cookie: My life is a patio of fun!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 02, 2020 at 04:09:08PM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 02, 2020 at 09:47:21AM -0400, Sasha Levin wrote:

> > > > >   Result:     09f4294793bd3 ASoC: meson: axg-card: fix codec-to-codec link setup

> > > | This clearly describes the issue as only being present after the above
> > > | commit which is not in v5.6.

> > > Probably best that this not be backported.

> > Hrm... But I never queued that commit... I wonder what's up.

> I saw the Fixes: tag, but missed the changelog text.  My fault.

> I'll go drop it from everywhere, sorry about that.

Ah, that explains it - thanks for sorting this out.

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6v/GUACgkQJNaLcl1U
h9DTqQf+J1WhHhwnr86jT/LtdmuYxn4YhdfaaW+RFSBKmakNZhXZ9BKok8utln+p
PkdIEGrfr8QfsSuhz4WYKDcN6K72tM+U3j0c4UFrYlm9kEfpuDr5AqJrdAclL76T
Ns2oaZFZEnIpHnkajK6KCa1Ss4Ka7AvQNuVJfZ+/d4DdAVDSUl3H9TM+1yJyR4Cz
FjMXYnlw+kp4LGSLCUy2yMEZ6YR1dzgDi7PIae1IYwwourTFOVjsox1CQPmE2bYv
32U+RLyE6qxAlFRwVqmhMqBWYr/ZUEmV8W026fEQWprg7jCq2oPCQxALfanL9f/X
rKflgftgFph+o3Rxz/MB0jHdsT/FbQ==
=KlPi
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
