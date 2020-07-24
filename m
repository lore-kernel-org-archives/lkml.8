Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F3C43445
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5B02074B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595587879;
	bh=PWG32YcOeMhH2GemOphH4Q5kn3Lnq8/kK3Cn2vynBns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AxRpW5+sPl8oCePpvNZocDXfIXQ1DCCXiWTZLgLKzfn4YBsE3CvOcsCwku0HgH2zk
	 hOUhkJnOuyvPGeZu0Skkh2oqCPLtF16EtI9VrMyvwQBWU5cCUuiKYIESmePms+ggNW
	 BHR8OslhlUpWBJyPNn8aPqYZhLfxrBx1qtEtYBIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgGXKvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:51:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgGXKvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:51:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE4D92073E;
        Fri, 24 Jul 2020 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595587874;
        bh=PWG32YcOeMhH2GemOphH4Q5kn3Lnq8/kK3Cn2vynBns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F13CfL8g3nuEJDlJLOJWXoQxuiGsmhcbLkqR3TjHfE+4YtoZbpNAOvoKtkd2cESJO
         Dflwy+cwmJdExBiwXmtYEDNj1QWcDUekKwgWndHKUXiotd3FTxwjukBYHZA/7fY9E0
         HKqx+IFR1ua1y60dDC0WoFg5wGByT2ZHtSDCuMX8=
Date:   Fri, 24 Jul 2020 11:50:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steves.lee@maximintegrated.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ckeepax@opensource.cirrus.com, geert@linux-m68k.org,
        rf@opensource.wolfsonmicro.com, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, krzk@kernel.org, dmurphy@ti.com,
        jack.yu@realtek.com, nuno.sa@analog.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
        steves.lee.maxim@gmail.com
Subject: Re: [PATCH 3/3] ASoC: max98390: update dsm param bin max size
Message-ID: <20200724105059.GA5664@sirena.org.uk>
References: <20200724085644.9837-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20200724085644.9837-1-steves.lee@maximintegrated.com>
X-Cookie: You will wish you hadn't.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2020 at 05:56:44PM +0900, Steve Lee wrote:
>  MAX98390_DSM_PARAM_MAX_SIZE is changed to support extended
>  register update.

I'm missing patches 1-2 and have no cover letter - what's the story
with dependencies?

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8avQ8ACgkQJNaLcl1U
h9Aj3gf/YVzWgBS3oyh3vmgjlIEpdZ48zKwfNrdP3AjsgdDI/wZsm/firZQBHg7G
6AituA5MsDLLEH8KG4S6HZ30QY3mC4BB0v8ILr9OeOGc/+M1OugxQQPMgK5RqZ8e
o8PGXWFmZdTnE2Uitl70g7Kb0aHiWY3aiB3M8EKVY5+z3OShdaVfcrOJBmssd9Uj
kWF0WxHZzYpkC1xny5352uirIwuv4tVkupZeP4A9Tg6A/LgRlKpqVG/GVZJMjjdY
9d5lewHYM/UTje7Fk+21hvKnGScwlPt9iMejfI0A85Fm0So9WPVGqimIKLn8mu61
ChWNE4Zr+67zERK/T8B8aktKc+gVxw==
=TNpF
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
