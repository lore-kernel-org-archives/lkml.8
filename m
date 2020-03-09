Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F89C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C22520848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583781497;
	bh=se/d+EDwhKOuLrL9ms7Er05T5E0qGIDXciOKBgVJz5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=shN6hrqFkSU3+BV5NnO89BCPcwOjsqy6KdJZ1XA8aBBL/UizVwz+IkcLGfJj8lAsp
	 wXX9URR+Pu7mhsB5fVABXBLU7RtIYCmGOjbfYiX+WHVuMnUPHSThsSyjgy3o72aqQK
	 4jtDgNXRggatYWuedlGSNk/dLhQwZXDenEtP/1po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCITSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:18:16 -0400
Received: from foss.arm.com ([217.140.110.172]:56512 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCITSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:18:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 796B01FB;
        Mon,  9 Mar 2020 12:18:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC4793F67D;
        Mon,  9 Mar 2020 12:18:14 -0700 (PDT)
Date:   Mon, 9 Mar 2020 19:18:13 +0000
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
Message-ID: <20200309191813.GA51173@sirena.org.uk>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk>
 <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
 <20200309175205.GJ4101@sirena.org.uk>
 <8113837129a1b41aee674c68258cd37f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <8113837129a1b41aee674c68258cd37f@mail.gmail.com>
X-Cookie: Beware of dog.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 11:14:18AM -0700, Kevin Li wrote:

Please fix your mailer, it looks like you've included some text I wrote
here:

> I can't really parse what you're talking about here (perhaps some of that
> context would have helped...) but it doesn't seem to be the clocking of
> the I2S bus which would normally be what master and slave would be talking
> about.

but it's completely indistinguishable from the new text that you've
added.

> It is the clock setting of I2S bus master or slave.
> If I am playing music only, I set TX as master. All others are slave.
> If I am recording only. I set RX as master. All others are slave.
> If I am playing and recording at same time, I set first coming stream as
> master second coming stream as slave. If I shut down first stream before
> second stream, then I will set the second stream as master, otherwise
> there will be no clock/FS signal on the I2S bus to maintain the second
> stream to its end.

This is not how any of this is supposed to work, it's unlikely to work
well with other devices.  If the device supports both master and slave
operation then you should let the machine driver pick if the SoC or the
CODEC is master via set_fmt(), randomly varying this at runtime is not
going to be helpful.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mlnQACgkQJNaLcl1U
h9DJ4gf/W/+cBKoBjZFDxUg3x8GtQhsWd7Wv5h7M1lAX2b3JG3TYTn/9KTw8pw9t
IqRQlZ5fYkIaqXjoH9c29EHV+7Oc1H7ipYTypjRpmai4D17oAixzgMg6JfsdczV0
RpmZZbDWEYfaIHAC8mAetFWYs0JAd9VLDjRUVY0ineBnXdjCrsZBc4UQsg9vYj+h
uV3z8auOgOz1dHgOk/FYdomT2aXtIJ3vxYQPzXK1Q19uhmlLcO3ELmk+I4opLVZH
CnUx839AjYN+UOsa7z5I/z3RVndp/dtPIBF6TMTLrBJmgdU6QLCPBuVgLE4gdCQ2
W4g38ZUD3DpNTiKgsPbhrXu/v7MxQg==
=Ukbe
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
