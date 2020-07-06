Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B96C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D029C2073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594035850;
	bh=0H/Ci4Yl7iO19bQj63isObhR+3JKKIzIIzqXWiKHn4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O7Ea0sEhedTQDhBzBo4t5lJgKHfZLOSzmjeAwFXWeZv1NpB7acanfMNpZFJIewac4
	 T9tBb4r+ZR2+sLVp72hkHqC1hJu+ICK0DqLRDfloxp9C5kTN5RqRjgqPYlo6BJ9Zz6
	 fRXmXOD6Pk/NbhFG7kWNGqevgJ4pwNSdoMw+SDcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgGFLoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:44:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgGFLoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:44:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B082075B;
        Mon,  6 Jul 2020 11:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594035848;
        bh=0H/Ci4Yl7iO19bQj63isObhR+3JKKIzIIzqXWiKHn4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bax21XBoYtg09OgqEwpKq8jl7FrAnaaM6FUk6WVqXijIL5akmKIvBQhpFh6OQ8sv9
         y7yCyz/PlxGgpMzQELqP2le84UyWwo1CPdteZTAWGXx5Svg4xuRFwI++SAY5kW/z1a
         Jv0+FLvidDsrEDJkTMY5BVSVUG1ZDprKMHKNZDII=
Date:   Mon, 6 Jul 2020 12:44:03 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rohit Kumar <rohitkr@codeaurora.org>
Cc:     Ajit Pandey <ajitp@codeaurora.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v2 1/7] Documentation: device-tree: sound: Update
 lpass-cpu driver binding
Message-ID: <20200706114403.GA6176@sirena.org.uk>
References: <f44e2526-3497-7900-0db6-39b6b5af2d9b@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <f44e2526-3497-7900-0db6-39b6b5af2d9b@codeaurora.org>
X-Cookie: You will be married within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2020 at 04:59:39PM +0530, Rohit Kumar wrote:

> @Mark, I was planning to post v3 patchset series for this and keep yaml
> change as

My name is Mark.

> driver change will have checkpatch errors. Can you please suggest if should
> make

> first Documentation change in text file itself before driver change and
> finally have a

> patch to convert it to yaml at the end?

As ever make the YAML conversion the very last thing you do in your
series so it doesn't hold anything else up.

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8DDoMACgkQJNaLcl1U
h9BXMgf8DNoFvq0IrXAIU2aU8cf2VGs/LC+PJRHbN66SiyRr5VQSchf5GjLi71k+
BJ86YKPLly27ab3Xq/sDsHkNZ2nFi0LPQBJIdQxnm/cbY/iAnKYUxi3lj3OiPauA
NvWjfiWa/qCuixLhj8UOF2zkuEg9bKtboZ986MBvdAmSYzYMuERaSYCwh2rsYsv3
2/pBPzGieCWfQbTWEd8TTg17sgK0jPCwEePJlYlXZ6Rg2cF4MADj207FikGmS83O
1baJtYl84UR3aynPIvzNjX9JIkG3Ffks00738Y6PQ/PQfvg48iEQx0kXFfQzgKHo
2MRtuTCsphZrhghRuKAvOXsO04NkfQ==
=HNKc
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
