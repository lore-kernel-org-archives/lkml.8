Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B57C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8A692070E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592224816;
	bh=EO5ZRYBpH1C4C5qa2NcbMw592fMRBuFirZPGlbFWgZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ant5bMl4m48UhLhXm4yzHl+4bffUq6kAv8WIKCbrY2kwtHZlamGywfwmHeLG6i1Ea
	 bjzwEwJyJ797pRPEWlUCHbIyQEyw9BeIBDPRm3ZD7/K31fNiX4etKQNt5rwluITWKp
	 4v1v2YKgzwhnHt0YFe4+QltcX/qZdmxF8i/BoGVU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgFOMkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgFOMkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:40:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA07206D7;
        Mon, 15 Jun 2020 12:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592224814;
        bh=EO5ZRYBpH1C4C5qa2NcbMw592fMRBuFirZPGlbFWgZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oL7MGWqxb7/sHBciJkrGU8DD+KZlRiKzHJ74HIG12Az6wHonwsHTNTgtloHbnGRcj
         /QwdGybYjHazzpVxdUQsYIm4bLsnRA5KW8pOQwTqgJDVshFRmE6VWUuBA7bQe8LRSF
         CpA46qSwmr6OmDHrvC9yir2bl19Ej1Vcl5GQH/74=
Date:   Mon, 15 Jun 2020 13:40:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jonathan Bakker <xc-racer2@live.ca>
Cc:     krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: sound: Document wm8994 endpoints
Message-ID: <20200615124011.GQ4447@sirena.org.uk>
References: <20200614202411.27843-1-xc-racer2@live.ca>
 <BN6PR04MB066019A8783D22F1C4A588B7A39F0@BN6PR04MB0660.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0pkK7MCEo5hACTvx"
Content-Disposition: inline
In-Reply-To: <BN6PR04MB066019A8783D22F1C4A588B7A39F0@BN6PR04MB0660.namprd04.prod.outlook.com>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0pkK7MCEo5hACTvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 14, 2020 at 01:24:09PM -0700, Jonathan Bakker wrote:
> The wm8994 exposes several inputs and outputs that can be used by
> machine drivers in their routing.  Add them to the documention so
> they don't have been duplicated in any machine drivers bindings.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--0pkK7MCEo5hACTvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nbCoACgkQJNaLcl1U
h9BsHAf/R6p55ub66+PR9VoeILZ3Cel+cYNBquoO9QHAW7l3ZzoLyIGqAp3+HqMz
CDspNYVkwDTh/lheZ5gCxCJojyx+XZIv7ypw7jk8qmPlq4ICg3Mfr8CYedv0iOWt
3lllvjaGn3onurgnp5AL086sjlU04BVyfi5NVt6RtCxYVTZM3lmJbOvS063tcHIf
+95X95RPCersu7prWaUarL/MD+PKPMdLvzQqWo8+YZ5CmtdJULDPPfk6l6trGiuH
nCLjvbWMZu8OGLAqcgf2bWDbu6RbaCCIO9SmGfl3oBOS1aTyoCHk5uMhuhCBxRfn
3q3R0h86r0xl2NoEBOrRZ+gCE7y4vQ==
=Qt7u
-----END PGP SIGNATURE-----

--0pkK7MCEo5hACTvx--
