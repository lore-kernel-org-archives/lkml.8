Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60269C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9A6208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599160420;
	bh=ieMpRIR6pWoOu4w8pRpaOou18ysCy/LkGmskOztkzAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CJl1Zg0c2e1+TRA50d2gNIgkUbETscg13PZvS9efYsU86U5c9Px+lSrsGjzWGST4A
	 /l+hbl4LcDyTPwlFpSp6DTG0PCKa9LmZ04tns45YOuuaohm8ZDI/8mnNtIwmPHrAB9
	 fXYzFQmgz2wVcLPeXN0Ei7T0Dae/0LRFVq+kEb/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbgICTNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729242AbgICTNd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:13:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B189208CA;
        Thu,  3 Sep 2020 19:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160413;
        bh=ieMpRIR6pWoOu4w8pRpaOou18ysCy/LkGmskOztkzAk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuN1RwT3WszF1ZmfxbChiM7DROdOiwGq+YjoKQ/Kry5aYjdAVaPZ3pvBlajIqNSU3
         CE5cola9kBD7agmSRBO+jJYSxJzvF4QPwZahdzDTsvfhPA+2jUOw1Mn11Gf+jnhLap
         yuFQJ294zJddWZKbC8Ha/EI5OPWthypO8uuBhFIQ=
Date:   Thu, 3 Sep 2020 20:12:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Sangbeom Kim <sbkim73@samsung.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: sound: midas-audio: Correct parsing
 sound-dai phandles
Message-ID: <20200903191252.GE4771@sirena.org.uk>
References: <20200830112633.6732-1-krzk@kernel.org>
 <159897179515.47719.6003518135515395142.b4-ty@kernel.org>
 <20200903164738.GA2929052@bogus>
 <20200903172645.GC4771@sirena.org.uk>
 <CAL_JsqL+_5Lc5vwtqnCZd6Tz9eB1m_oy2r3gtv0cbwBwKTU=dw@mail.gmail.com>
 <CAJKOXPe2XpciJtGAFq8c7E=7wrrzK0XUrquDCaNQK+u-2yLByQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KJY2Ze80yH5MUxol"
Content-Disposition: inline
In-Reply-To: <CAJKOXPe2XpciJtGAFq8c7E=7wrrzK0XUrquDCaNQK+u-2yLByQ@mail.gmail.com>
X-Cookie: Murphy was an optimist.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KJY2Ze80yH5MUxol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 03, 2020 at 08:08:51PM +0200, Krzysztof Kozlowski wrote:
> On Thu, 3 Sep 2020 at 19:49, Rob Herring <robh@kernel.org> wrote:

> > Just 1 other you picked up. See "ASoC: samsung-i2s: Use
> > unevaluatedProperties". Patches adding the missing properties (and
> > restoring 'additionalProperties' on these 2 if not reverted) is the
> > correct change.

> > I've gone thru and NAKed all of the others so more don't get picked up.

> Ah, my bad... Mark, I can send a follow up which restores the
> additionalProperties (so kind of revert of the second patch) and fixes
> the warning. Other way is that you just drop it and I will send a
> correct fix later.

Sure, that sounds great - I'm just finishing up for today anyway so I'll
look out for something tomorrow.

--KJY2Ze80yH5MUxol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9RQDMACgkQJNaLcl1U
h9ASeQf+PmSYAK9ZIthpegCdJtDuSz+BrehOdRUQ0tfVbcxq+q4LbOhvj2ctLk1o
l0HNN4x7H2UN7WSHcmB+8SeU5LnQ3Ru0DVVa4WO1FlV9ddw59+XSA60OlPDud34D
oulKn2YOwZZvHHhuq03PELn8Mt3ziI4IW3I7olw+sUWqjRMdxWkgWDmZ9FUhtfBm
w1lkgD4O5uzFml8NgnrGZrcXJa7hvFQ7pPZQ5EWCTaz2G4wsIMKyC/li6B1xDji1
9Cg52p2xTfU1zEoeODp0mY1KTk/33rPs+n81jvfwZ5+8ZUll12oq5xg+DwRqUPbN
Qzl2uW3vsc3+m9C1WENdcJtMsWHEkg==
=r9OV
-----END PGP SIGNATURE-----

--KJY2Ze80yH5MUxol--
