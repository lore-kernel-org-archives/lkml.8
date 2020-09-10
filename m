Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F542C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C72921D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599773208;
	bh=Sf1qebIUqiaky7hv/BnFelFwbArV0b890mZdIPxHgfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ZYdGcZo4lSHvtf8YayDWKxjCjCpXcpE+WrFH6TqaDENKiMx1jlfohj1xDAdNdojz
	 SQpZQvWiT1DhQn19XePZ/Fbair/RO3XLC8NW3icYJ5/AUXxv2PQs9I+W17+Y7xhYsC
	 buNYvl7ZjNhX6eHBKahh8IuKv5QvAf2c8rxzV5bA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgIJV0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:26:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731068AbgIJOXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:06 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 885CE2075B;
        Thu, 10 Sep 2020 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599747727;
        bh=Sf1qebIUqiaky7hv/BnFelFwbArV0b890mZdIPxHgfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BAfnSibZvJFwZ5iViUavWC2EqcP/X1N1HUfi+qrjt0yNALHtsLMs+EZIDJcUzJyqY
         /ZmyEI18F/rIQV2QXTumUdsuxI4Ai9tY7IHyz4uLe8kbjjXw1jxjpU11e71fCtHh0k
         9pGFi9nLMwTB/FL7ASk40CzRyP/ItUCctdwvSoWs=
Date:   Thu, 10 Sep 2020 15:21:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: ak4458: Add DSD support for ak4458 and ak4497
Message-ID: <20200910142121.GC4898@sirena.org.uk>
References: <1599747032-20055-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <1599747032-20055-1-git-send-email-shengjiu.wang@nxp.com>
X-Cookie: I disagree with unanimity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 10, 2020 at 10:10:32PM +0800, Shengjiu Wang wrote:

> ak4458 can't support DSD512 format, but ak4497 can, so add
> a new variable in ak4458_drvdata to distinguish these two
> platform.

> In hw_params(), calculate bit clock according to different DSD
> format and configure DSD register.

> +	SOC_ENUM("AK4497 DSD Data Input Pin", ak4497_dsdp_enum),

This control name doesn't seem to match up with the description - it's
talking about a pin but the description sounds like setting a different
format for the data?

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9aNmAACgkQJNaLcl1U
h9BvlQf/eYFovk6PSnGjHMoTkXtDd6ZSB8Bjxc2PaaM25GOwNdAcktYXdamyEJM6
8w+4vwJdhd4xAgWbaO9KAOdoyfrGCPqSEmv3Q97DT/gZRQ3xAAlyujp+5M4tE0QI
O9GMTIJsvZO7UtU9izkr8vuwA1W/1HoTmHVmLQ6XcjP3h/z0R8dn2BqxKZKLlN9i
SkbS+otZRdb0bBP3sDSVXdRn5T4RREx3BQEQOjzHEcIhJEuviqrc47/A9VcrUjfs
pf7VFaoeNZCjGUy0CDeLElP3UtQQMMc6RWsPPdIk1QOlMAdy6j3/BYtxa7ubbqcR
xV7s7W5Gf1fTY+siHZzyoPPCQ6M5RA==
=tBUD
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
