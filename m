Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEB3C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA3420B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587391299;
	bh=JIEc9NL+YGHp5avkzPHDLltDVnHfQiZu6/QeeqDEzTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bu8d67faoJzr4kkZi/IoDEvHMj98jq3IsY8DMqOCcvgOJVM4eqHaLwbBry8R3HcAt
	 awGOzB/WJwT0mLjNYINtTkDtSh+TDr9Pmwx+CFAL3EpLZIxbOg4Oc98/y/jBa7/uis
	 fKYsuD1jgjVefslZ2AcMGNr/8MIO0YqRNyogAF0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgDTOBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgDTOBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:01:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E1720722;
        Mon, 20 Apr 2020 14:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587391298;
        bh=JIEc9NL+YGHp5avkzPHDLltDVnHfQiZu6/QeeqDEzTE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ReP00+K/mNd2j2m1umhFZPjekFioKVHUMeATnOkOVVRwBvS1n8IBVHScYhlGh5fl
         5dWzGq1ZBKB5r8komqr/siCzwONV6ndKIWgQVGQLDRjMsevbPD1i9CRHdRqiuHQhrl
         SvOI5HuM2EF7EmMY9cxptl4lVk1JT3tPvMWhHp+8=
Date:   Mon, 20 Apr 2020 15:01:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420140135.GD10045@sirena.org.uk>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
 <20200420070816.GU72691@vkoul-mobl>
 <20200420120348.GA6507@sirena.org.uk>
 <20200420121752.GY72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20200420121752.GY72691@vkoul-mobl>
X-Cookie: Hope is a waking dream.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2020 at 05:47:52PM +0530, Vinod Koul wrote:
> On 20-04-20, 13:03, Mark Brown wrote:

> > > Applied, thanks

> > This fix is needed in the ASoC tree - are you OK with me applying it
> > there?

> Sure..

> Acked-By: Vinod Koul <vkoul@kernel.org>

Hrm, actually this doesn't seem to apply against the ASoC tree - looks
like we might need a cross tree merge if there's still issues in -next.

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dqz4ACgkQJNaLcl1U
h9C1OQf+MHwo1vgtr2S63TReVr+n0rVxeCKflOFkzT3yNEOHYpRgpoYgWg5iSZxM
hdjvyUVt/ajvFDgx3rfTygqddvoYeZILb7GTmcAQ2KNy7OhtdSGIXohiZGY3+1by
IBdzI8uteoh6Bv+FiyIsClFzez2DvPRd2oNJywKQ7lVByBlqMPscIJLXfCbY81dc
I2m3ISJrt97mpDkoq9bweSKxgiscWJ+BsTKsB849LNU453Abim+JkC0IZ944WeUw
LREfpN8Btfgaji/x+o6oWEDQOdN3hl8rgUdEIQMe/nqH91bE3k5q/kzq4ikPJj7W
i3kPCrvHIcERSOadrvOV6SawOmkW3A==
=NMpD
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
