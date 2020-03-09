Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8157BC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7A820727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 17:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583776329;
	bh=rhCco664qrQmoqD2GFkLT+u27MXwyZpSuWrcWe1m4dc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qAp36pMds56VoyA4DWUF1tLa4avYF+36NThTW/YiMwGqCqSi/wlBSjsRasvbMPtD3
	 BaUtmygS3aj27+rBTpVDKYb04LWOJg7l+xHiJYmXQCn5UFFbyyWqDa/1GWpDvA3oeM
	 zgzeltFjRQMceL0R7NxEBa3DlDTikKZBiuxOy5Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCIRwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 13:52:08 -0400
Received: from foss.arm.com ([217.140.110.172]:55254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgCIRwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 13:52:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A28C37FA;
        Mon,  9 Mar 2020 10:52:07 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14E243F7C3;
        Mon,  9 Mar 2020 10:52:06 -0700 (PDT)
Date:   Mon, 9 Mar 2020 17:52:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Li <kevin-ke.li@broadcom.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: brcm: Add DSL/PON SoC audio driver
Message-ID: <20200309175205.GJ4101@sirena.org.uk>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk>
 <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fKov5AqTsvseSZ0Z"
Content-Disposition: inline
In-Reply-To: <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fKov5AqTsvseSZ0Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 10:33:30AM -0700, Kevin Li wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The SoC I2S block we currently have shares one clock and frame sync signal
> for both playback and capture stream, plus playback and capture can only
> have one master at a time. If we set playback and capture master at same
> time, it will have jitter on clock and FS.

I can't really parse what you're talking about here (perhaps some of
that context would have helped...) but it doesn't seem to be the
clocking of the I2S bus which would normally be what master and slave
would be talking about.  If it's something else perhaps the code needs
to be clarified to make it clear that it's not talking about the bus.

--fKov5AqTsvseSZ0Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mgkQACgkQJNaLcl1U
h9A5Fgf/Urnfg3j5PZES06ywstEE7IyxgzPd7YpkYqxz2XToPpUnbB1SBhF0Lfxk
xo/iCZDUkh8H259e98Hq1BEN/mB8UROBB4E23KAY/cYsoFYjU3ZQQtGL3InblMsO
6fFx4mnUIX47TvK9S5oIsXpsS/+mrTx5GPmY9Xg/gBy32d15wnNFYtGP9mCGEgOi
hRj/VQ2vuAbiHk0D3Qjd6GvUZMnvF88BMndqq8wtUMjnwPK5pfk3SD62n1dQkuov
5MClefdJR/qwrpfLHjEzOzfSqrRceYcim8ccxQHmU/5qHgBm2xMTQFQeBjTLWIFs
7Qdtn3SNwtwyrW55Xp9IrO2+zHwjJw==
=VLrd
-----END PGP SIGNATURE-----

--fKov5AqTsvseSZ0Z--
