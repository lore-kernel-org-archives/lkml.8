Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B91C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F87A20848
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583857693;
	bh=bY0YlrXe+z0B33TzYbdnT6Y3nRnk/0wddKXDasYDUfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PxNzW/3DaZXLNFvDrdgYRrcXGtAL/yBonbo0QTd+r1bYNjMEftGeSeU0RFsqCvCYA
	 Oa/k18HijBN8ayAT3u3ryqzCNojdWw+M8o1MPVRf6VWVeJgVDrMt0GqS+bccd6bQKo
	 ywfNqgG6MFsYzkGQ079LrPmvrlWB/F3ZdPhFRquI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgCJQ2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:28:12 -0400
Received: from foss.arm.com ([217.140.110.172]:39216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgCJQ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:28:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ADE21FB;
        Tue, 10 Mar 2020 09:28:10 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC453F67D;
        Tue, 10 Mar 2020 09:28:09 -0700 (PDT)
Date:   Tue, 10 Mar 2020 16:28:08 +0000
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
Message-ID: <20200310162808.GI4106@sirena.org.uk>
References: <20200306222705.13309-1-kevin-ke.li@broadcom.com>
 <20200309123307.GE4101@sirena.org.uk>
 <69138568e9c18afa57d5edba6be9887b@mail.gmail.com>
 <20200309175205.GJ4101@sirena.org.uk>
 <8113837129a1b41aee674c68258cd37f@mail.gmail.com>
 <20200309191813.GA51173@sirena.org.uk>
 <1165b736-d0fc-1247-6f46-94a51d392532@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WR+jf/RUebEcofwt"
Content-Disposition: inline
In-Reply-To: <1165b736-d0fc-1247-6f46-94a51d392532@broadcom.com>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WR+jf/RUebEcofwt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 10, 2020 at 08:49:08AM -0700, Kevin Li wrote:

> > This is not how any of this is supposed to work, it's unlikely to work
> > well with other devices.  If the device supports both master and slave
> > operation then you should let the machine driver pick if the SoC or the
> > CODEC is master via set_fmt(), randomly varying this at runtime is not
> > going to be helpful.

> Maybe the name "master/slave" is confusing, these names come from internal
> chip signals and do not represent the state of the i2s bus master. Our SoC
> supports only master mode in the i2s bus. The Rx and Tx block each have an
> independent bit to indicate if it is generating the clock for the i2s bus.
> The i2s bus clocks need to be generated from either the Rx block or the Tx
> block, but not both.

Right, at the very least this needs to be better documented in the code.

--WR+jf/RUebEcofwt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nwBcACgkQJNaLcl1U
h9A6pQf/bT2lCprxs3DA2/Vx/yM3Ff2ZDC3VmEzFcFoscpWNx2hOh9KohpTKb48l
laXl5M87VISWnaTdNMb1uBh1FPljBqHfYdE8IlUbr9qU0i88TJ883m9YxTPQ5xv7
Xt27ndFU/3gzEzDrpwKB/tbCCcYKoCwMIgPTs5eRNUzN+TY46HcgnxFFQ6ztGQ99
lh/5tl7Bgchn3Vy0GgBJKj0LDxkZta0GAI8MMt5M4pMOBUFJSG9ULQfdyNhB1n8D
ev0H3RU4FWKIfJx6CkWwwhnb/BrdZ+xPTF1kTYaGmkXeL7dJgjwJe6rfsSnDWbOU
01yQDtxGqZZMUMHy7OA6TlHLpyd5UA==
=Pkro
-----END PGP SIGNATURE-----

--WR+jf/RUebEcofwt--
