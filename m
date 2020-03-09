Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F309CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972021655
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583760414;
	bh=XwOj/Fq7pJa3hdSOHycHp5sHElq2J4GoqKSBoBad8Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XBwDEXH/qj2X+htLkyemerdlAKAaqKK6LTIr5l0R26H7R+9oZ4lN76HufIrS84EjC
	 vBNwDYJXJZr4hQS4Jm7HFyRcPr1XEtVQmMZWhZFl5Sg+VaiUhCXQxbN24uIo3IZsbN
	 SimBtbG7MN0RUQKqOvi7moMhmB+WpoTBB76SapY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgCIN0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:26:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgCIN0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:26:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36DD30E;
        Mon,  9 Mar 2020 06:26:50 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E5A3F67D;
        Mon,  9 Mar 2020 06:26:50 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:26:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Zhou Yanjie <zhouyanjie@wanyeetech.com>
Subject: Re: [PATCH 1/6] dt-bindings: sound: Convert jz4740-i2s doc to YAML
Message-ID: <20200309132648.GG4101@sirena.org.uk>
References: <20200306222931.39664-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y+xroYBkGM9OatJL"
Content-Disposition: inline
In-Reply-To: <20200306222931.39664-1-paul@crapouillou.net>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+xroYBkGM9OatJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2020 at 11:29:26PM +0100, Paul Cercueil wrote:
> Convert the textual binding documentation for the AIC (AC97/I2S
> Controller) of Ingenic SoCs to a YAML schema, and add the new compatible
> strings in the process.

Cleanup and new development patches like this should always come after
any fixes to ensure that there are no dependencies which would prevent
fixes being merged as such.

--Y+xroYBkGM9OatJL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mRBcACgkQJNaLcl1U
h9BiJwf+Pe/BdGSq2c2anqasfwrrUL4Abk4Cu+i1KO6pNmEVWD+KFE9ZvRA3YPSb
lEPhE+2LfrkoEBPPx6mWVpvl28egf0kwTsX6tynIJsQi+eL1qlRr2fLfvKCEQzVL
/OAnAMJVXJgSg+wF+p1/Fjv69bkPJUBPX+OK6ooyQNUraG//rSygcKSBtrdvzZOE
vg02RvfhG9cp1JnhfW6uP7xwG+ISdzyQyDePpgHO1fFPhqUTlM95xRNTUzGGJo/L
E+5Smb+rEKN3QRWa+J9Nynvrb+zdHtYMrmr/Hi1THgSsUiqfvNlfraITOiiUDCbj
Rkbg8Bq3JOOSyC9jcOUzTQw3EJhK6g==
=40Z2
-----END PGP SIGNATURE-----

--Y+xroYBkGM9OatJL--
