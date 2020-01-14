Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B291C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFB82072B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579013407;
	bh=0jHb6kMp0CNBC+SiDAXiaMDFC9ABzASpcEWvhIP6RHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b+wKT7EPcN54UaqQmc6a0461GDCJpoGkpPC9Fy8H0QxVmAyx8fQwBb/vcXKhf8na9
	 WtOLTaI2+TXj5zQqntKXqrVMw4CXPv6yhOi/Dhm93Kvy6ZHfHTQBXXaq9UdK1a0gk8
	 q9TlDENz9PvEzDQmvxUH21+uGVwdaUyFM1Z+3ONQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgANOuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:50:06 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44982 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgANOuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6nJUJhhumQt0VjlRrHEVPz0UIG6WR97W9B6Dcn2o5bo=; b=amMLuROlHT/tLBsR+5kwzWHb7
        naLAfg3uDbdvdIcSpnBKTj9lHHnRZCrjQukY2soUdDUpHasEnZRnagbYgTHyiHQlKJeHF//0nrZFK
        WLr+qr0loLSfVMA5aBNaftPEU3fCh1PvgjHcwFkbtPPYOHhak//E+0XGT2DyOyHtjc3GM=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1irNVp-0008Pd-SH; Tue, 14 Jan 2020 14:49:45 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 32656D01965; Tue, 14 Jan 2020 14:49:45 +0000 (GMT)
Date:   Tue, 14 Jan 2020 14:49:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     jeff_chang <jeff_chang@richtek.com>,
        Jeff Chang <richtek.jeff.chang@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20200114144945.GU3897@sirena.org.uk>
References: <1578968526-13191-1-git-send-email-richtek.jeff.chang@gmail.com>
 <s5htv4yfpnt.wl-tiwai@suse.de>
 <36357249c6ed4a989cd11535fdefef6e@ex1.rt.l>
 <s5hwo9uqrbu.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/7+LvQqw8N5lf/3J"
Content-Disposition: inline
In-Reply-To: <s5hwo9uqrbu.wl-tiwai@suse.de>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/7+LvQqw8N5lf/3J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2020 at 11:12:53AM +0100, Takashi Iwai wrote:

> So, for the codec, it doesn't matter at all about the signedness and
> the alingment of 32bit / 24bit of the incoming signals, but magically
> handled as is?  Interesting...

On the playback side CODECs sometimes don't care that much, they
clock data in and if it stops early they just go on to the next
sample with the width being used to configure filters or
something.

The signedness is a bit more surprising I have to say :/

--/7+LvQqw8N5lf/3J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4d1PgACgkQJNaLcl1U
h9D7qgf+KdBUSPJ38rdTjpyt2K7lYvMyXL5+ZUVws3WSh8Mf6NKFkc2TRAtLJLMm
cqQxLWHy6m4R7X+tZtn2iwoi5f+RDi8uYHOcvSfU9qoI5KQeCgHQjXwaU6tnx7fx
UeeJ0kwtqgsO3xcGpn6DUjoujSvxI9dyr83h0MS3EhX216xvzEDBgF/ujsbnYfCj
ukYd9ZB/jD9aFtelkTHgJh6zeKPkcLTLhBB+/i3AalSM+yBR2eLgXkVUGBB7pPMD
k4LL/2R2f91ziU7J/6NgZuO+X6RzXAmYNDs2nH28v9sQotj1KTXXFl3/t5L42zm7
3XPg4S+5Q5SefOGfY4kvylDWjank2A==
=ff88
-----END PGP SIGNATURE-----

--/7+LvQqw8N5lf/3J--
