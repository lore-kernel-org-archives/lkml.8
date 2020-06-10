Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251CEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E288F2072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591810636;
	bh=utG4SogSUZldhtrkFrDEcO0SomUMTV8zNf9Bc9crx+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Rbkc8YtMac4nZ64BUJ+lg/mivh27fhNE3+48KJ+OhIJEDjQovoBRwAbfDdtz/rmTF
	 Gq43pnzzuy/cIA0VBhlrE6WCbSAEdApYwZgId5On2U74OksZBg+e2oFWYYLXiuYmlv
	 g1IaB1XnqdTM5ugH688BBJFPACF+WFvD56pU5VuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFJRhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726307AbgFJRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:37:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35D01204EC;
        Wed, 10 Jun 2020 17:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591810633;
        bh=utG4SogSUZldhtrkFrDEcO0SomUMTV8zNf9Bc9crx+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhlvajO+Sj3UaawAk83wrJJ3AnCgi4UDhNSl2AqvNYAnOPDjnxEaCjzA7uHkP/TKX
         FYThE/vd7Gm9pv/M49vtKTTD8Ug+p2Qxu/v4Tf/kJtZNPlBxhPhZCFCAPsYc4hzIMY
         oXTO1oIkY7YTpPnN9Iagl7dcMSq4UelELdwXaFgs=
Date:   Wed, 10 Jun 2020 18:37:11 +0100
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
Message-ID: <20200610173711.GK5005@sirena.org.uk>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <cover.1591802243.git.vaibhav.sr@gmail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2020 at 10:58:24PM +0530, Vaibhav Agarwal wrote:
> The existing GB Audio codec driver is dependent on MSM8994 Audio driver.
> During the development stage, this dependency was configured due to
> various changes involved in MSM Audio driver to enable addtional codec
> card and some of the changes proposed in mainline ASoC framework.

I'm not sure why you're copying me on a staging driver?  I don't recall
the base driver having been submitted properly yet.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7hGkYACgkQJNaLcl1U
h9CrqAf+PTr4Z6aVY9XOlKtwcNflVCkOCX3qxnt1cwrgLmhUdXwDJ7MRRcKyzi2i
vCqjsn1rj9GAkhIwt0CC9FRnC+jq7pGLNucnbEugF6VuEr4GWTxKkS2P+yldMV2x
pdq12Re+x3tXN6oqziMyMcVWnqXXWdcxVaacEx2jqeXADr9pYkiQtN9ScJaERvPy
ComnaHl20yeooKklC7JdWutUyFCxijoMdkqhTPtO8lu5MoSk7DxuRlFgWD6EhyoP
Xx+2OdPgBaQMaIMk4GBm5Arornj2W80mLsVorGWV0SdWQ6gYuvoCn3U3h/IW6YS5
0/RCEd2Bon5c7Hd0v5eAUxPVChr5+A==
=yTza
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
