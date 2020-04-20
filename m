Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8280C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6F9206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587384232;
	bh=Uz/u8Mva1bGcBUWnr+fKCRbTRah6M1SnMjedSw2/cwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eQB4OLIndfgWO63Pr3oUYzT75uGmQXcCBzS2eeJhFA37Lu5SE5O8cy7mfY+o/rYPU
	 1Qh/nPFINv1I1LYn5dvq+82E4sPG+xzFypbBHttLfbIqpEDUhTP0FyG+0NhrLna1eq
	 npz04CAxRSrSbjnVydJmv787q9V7/kMv77KpzSBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDTMDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:45602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgDTMDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:03:51 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63C7B2051A;
        Mon, 20 Apr 2020 12:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587384231;
        bh=Uz/u8Mva1bGcBUWnr+fKCRbTRah6M1SnMjedSw2/cwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwLVwy+TMYRkAkS/gh4iSe/qgG+jao+3rXaiCw2vv+AQZhmaTJrssFW6+E1RE8VL0
         1ulxmBLXavpIBjD+6zR//4dbb+LWwdDieM5X8lY17xI4EK287uMSsXsdkugPPzuHvU
         lOYL3XqhzT3zHwjN/VhhkfGOXDOnNJ9jADLxiyPw=
Date:   Mon, 20 Apr 2020 13:03:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: intel: use asoc_rtd_to_cpu() /
 asoc_rtd_to_codec() macro for DAI pointer
Message-ID: <20200420120348.GA6507@sirena.org.uk>
References: <87y2qqvdxu.wl-kuninori.morimoto.gx@renesas.com>
 <20200420070816.GU72691@vkoul-mobl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20200420070816.GU72691@vkoul-mobl>
X-Cookie: Can you MAIL a BEAN CAKE?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 20, 2020 at 12:38:16PM +0530, Vinod Koul wrote:
> On 20-04-20, 16:01, Kuninori Morimoto wrote:

> > Now ALSA SoC needs to use asoc_rtd_to_codec(),
> > otherwise, it will be compile error.

> Applied, thanks

This fix is needed in the ASoC tree - are you OK with me applying it
there?

--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6dj6EACgkQJNaLcl1U
h9A7tQf+NlpjcVDSx9Wy6gSlg4Xu5wRpfne2xXViBwEpyhpx8CDbEYzkpAo7cK2j
iHKps3mihF/Q+DkHVcI+vZ7KIfAX1SGxKv6IxnlXb2xI61WiYoiyoBZTJ4DYtqmc
96/ZRqcepdytZeLoK1p6haNtJK7yxA0MmNp1x7hK11Vv51DL1SbUfd4zBCwLbwux
uaNbtTH/4SQBQFmrYwetsAo9xaRBVhtfGl8b/oF7alnQa+ug18EEsTB8t+WcTPw4
pL5eK2AIeyA6eKsB4+wct1XZBwosTV10JpYTjr0o4dDUUYhTN6NaSfLmsNUD0T3k
QtXAXGKRs0y4NNswDWeub7Z8hpgr7Q==
=iK34
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
