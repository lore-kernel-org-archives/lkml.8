Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C442067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598972202;
	bh=sCpI4sCnV3VGw7tpt2uhRXxYsas+I7NB/Odw+Dl23IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FTo5IDwxCsslGfKlvXiDh5LZVa2UlOl76M1l7Sl7UwyF543K3eD+Xrd9Ehk6goXUd
	 YO3Hi0dbWK4OGl1Nw9sdpu7Z6jWmPl9Kcg/ihD+SjIZ6Kip5OOfTDLaBmkiXXgcyrq
	 usSI4ZfzZNmB9qWvtMdJqAi3ESKmOC5Ene5RvfKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgIAO4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbgIALbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:31:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A09206EF;
        Tue,  1 Sep 2020 11:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958269;
        bh=sCpI4sCnV3VGw7tpt2uhRXxYsas+I7NB/Odw+Dl23IY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FDd3LEddcQgT0dEr51HuI/Fty7nNad3vVXzB/Minh19fwULeTvHYJBVc55s4eLpbi
         Ezharmx8LU+LlA4FUvouooc2+VAvv/clRrm1h0zLWfMr02QvnX/a0TPzJTnB2FUQJz
         OGJ6uDai7gdiYK0TaEVL7t8ylfh+2c7WS7AXdI2g=
Date:   Tue, 1 Sep 2020 12:03:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200901110349.GC6262@sirena.org.uk>
References: <20200830112633.6732-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20200830112633.6732-1-krzk@kernel.org>
X-Cookie: Equal bytes for women.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 30, 2020 at 01:26:32PM +0200, Krzysztof Kozlowski wrote:
> The "sound-dai" property has cells therefore phandle-array should be
> used, even if it is just one phandle.  This fixes dtbs_check warnings
> like:

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9OKpQACgkQJNaLcl1U
h9DsLwgAhvsY22laZUsm46wBuYEqas5QBnB4KMgxezBwkPaRr5NrJsVQMp2S9QI1
gZzZ5eFVZZYB6Ij8hFNZKlgGp5W+D1negXAJ8WhH8zFXsgg1F+SZmFFD9/6reT5M
1gab7+yPGHs6FLLJ1VbQnyv0xEcV6RnNgTKC3KuUH4Y2LHSDj6qzwYMZWl29Xu8t
p9VZtWTg5g/upxDxbsW8vLVddkjb6KcdhbVsZQ+qb0QxibK8nX+8XbTWyH6T3OeS
4FtJYdEsaHXhkrSDJtf1XpnXVG9RfBgNReqwmHTxdP2PSLDpFR7sCB6FLtNrJfAI
fpab8x1a5104UrbblCQD6ny1IGwvQg==
=Emty
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
