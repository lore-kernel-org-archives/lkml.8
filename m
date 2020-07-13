Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F2AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8B7220773
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594637536;
	bh=lvbFaXFQbR/7umDrIr1GanWR2tymD8YjdnO6h+nUkkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Vx5ETGsf3Dv6j4BwpC8SyBlVaJse9lk7zrImD8CP1UTN0l1VwqbojGuTaMchJUZk
	 hbx8tdDtLEZHT9HmuKW2wf2MnLPwTSj3I+fllaDTOFl9h/tISQbuiz9TU8FsmR100e
	 rkbMOI1a/qGvvF0CHbDxBAoZ6xicPnSDozaqpp6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgGMKwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgGMKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:52:14 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0353A20758;
        Mon, 13 Jul 2020 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594637533;
        bh=lvbFaXFQbR/7umDrIr1GanWR2tymD8YjdnO6h+nUkkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ocP4Ux2CUAYvjXjjQsB9zFl0IWNu+EQRqcrvcsAdVW3Z9zY8JwQAQAi5bobGb9ASq
         6ZURIa/5HK/mNNKQpYKvNvZKs5eK4du3/lGgDNK2a5xidsQWUf9bRFnMjPnIhhS8iS
         Bnm9LVG5hXtV12uvHOLPzHf5xfU/cZtDlsnvEXXs=
Date:   Mon, 13 Jul 2020 11:52:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Agrawal, Akshu" <aagrawal2@amd.com>
Cc:     Akshu Agrawal <akshu.agrawal@amd.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5682: Add fmw property to get name of mclk
Message-ID: <20200713105204.GA4420@sirena.org.uk>
References: <20200707100825.24792-1-akshu.agrawal@amd.com>
 <20200707103053.GF4870@sirena.org.uk>
 <a2cf09b4-5f49-ba74-060f-bec9a49d21a6@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <a2cf09b4-5f49-ba74-060f-bec9a49d21a6@amd.com>
X-Cookie: Fast, cheap, good: pick two.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 13, 2020 at 06:46:29AM +0530, Agrawal, Akshu wrote:

> clk binding is present for AMD ST platform and using the same.

This is something you should be doing through UEFI forum as a generic
ACPI thing, and if you need to read the name from the firmware that
really does sound like something that should be raising red flags as a
binding.

> With recent submitted patches I am making them generic for all AMD
> platforms.

> Please refer patches:

> https://patchwork.kernel.org/patch/11658505/

> https://patchwork.kernel.org/patch/11658507/

It looks like there's clock names hard coded into the driver?

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8MPNMACgkQJNaLcl1U
h9Cm5Qf9HSdUmLAUKpOpEqWwQEPxscyY/1nC+8x22/phOhDS2GHVlDxezrpymhGg
ge5ftP74TKyK0vbz4mzL8tkaHuQoAGx8vfzUQl/ei4d6XyuW2YDA7g3/Q4mzJbEg
dVamLafpcr2dOl0dA/SsOxjgJBuUi25izLhYtvBakigGFYgs884gck6+XB0pgJ4V
CnumvVcUglSVbx90fxuhmKHyR9CcvKETocFjdFp7a8H462o7fSEKNXkbnsBwY3K6
VbBmF0lveiNZh5QlCoIyc8ie5B4tb9sMLvt9uVKGoeP/PCCCbhM4jQxIf7P9yh1D
D6fXetAl84iaEuHHIyRONHcCClXfiA==
=lj5n
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
