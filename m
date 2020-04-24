Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF58C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D062064C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587725211;
	bh=IewgKVWJvxyhdE4TKcCYoEvv7xD+0FgI7QpltLoN86M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i+Bg6UNhZH74KXGuDAk1xi2hyObygXvzZH/e+FBfh+chjAS9HWu8Z9x38S0UVIc/L
	 OiaQqgibg9UnnFh6W8IubAmeCEO4O+o4G4scjToP+GsQ7nSk6kgTDdnZw6QKuGNjhK
	 464UJBhNLlyOozoXVRcOaJbtBuDkdX3nydLURXLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgDXKqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:46:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726842AbgDXKqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:46:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 146732064A;
        Fri, 24 Apr 2020 10:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587725209;
        bh=IewgKVWJvxyhdE4TKcCYoEvv7xD+0FgI7QpltLoN86M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GP0EHgRP62u/B+a36tX2U1F85Xn34FBjvigS/Dh48dUQcn+s+5WAOzeGnKIQb/g91
         ZUpE4Znj6F+mCM+3S7ncf/anWckRzANZL1ebbEG8WmnbkOplFDkoNtXpONO8UnKm4m
         ORzXELHjJGWh9a9316DHpqzcxadJBitPQ8SJUh5o=
Date:   Fri, 24 Apr 2020 11:46:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, tglx@linutronix.de,
        allison@lohutok.net, info@metux.net, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wm8962: Force suspend/resume during system
 suspend/resume
Message-ID: <20200424104646.GC5850@sirena.org.uk>
Mail-Followup-To: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, tglx@linutronix.de,
        allison@lohutok.net, info@metux.net, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1587708727-13657-1-git-send-email-shengjiu.wang@nxp.com>
 <20200424104347.GJ44490@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
In-Reply-To: <20200424104347.GJ44490@ediswmail.ad.cirrus.com>
X-Cookie: Information is the inverse of entropy.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2020 at 10:43:47AM +0000, Charles Keepax wrote:

> intended to put the CODEC into runtime suspend. I am guessing the
> reason you have problems is because of the driver doing its own
> pm_runtime operations in set_fll, which probably takes an extra
> reference preventing the power down. Is a more complex fix
> correcting the interaction with DAPM the correct solution here?

Or just updating the machine driver to turn off the FLL when shutting
down (or even when the device is idle in general).

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6iw5YACgkQJNaLcl1U
h9DD5Qf/aNoM7gNzCjtutvsHglTVC2IeVikq5qWepEIkjE2Za8SbDHTb+o+EFvnR
D21oMf1biEpUZitXu5tFrk+vhCLLXD+lsPathUE0suZubm1tUrmsEyLmZ5tzWO5R
LE/KIAA0VGzkInIq8ywzUP15Yu8ruUMFfDWiKpFWn8t8yFfkOqWhH5VpvE59b0za
dixQK3ngHIh2D37+GxZ0iJWDpaF0mmk1qfn8wAKYWp3RxMCTbNRcRfzZm+qXkGPd
QUJnnN3+dovMnbR1U838fb9x83DjFndOOCGoRbNJ9NA6mPuB1Ubpu/e6QE8d0BOT
7G3qLT5B4KrGBSIaRbBzSj9flX7Snw==
=SsMB
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--
