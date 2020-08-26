Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A29C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA82078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598462759;
	bh=S8TXZrq1wbwhPqABDtlshBxR1KjWnaZqnCtcuEK91FA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0i2MgB8VQ3GgTfnSYCP2bPxGWkj0LwfBQL+BEPVYd+iNGiVm7hAoMGja7YrCFSCFo
	 YO63thEc32d+dD/wWkF9CoOT3V3Yn2rT1Cm7ygVf7KstqEqc1nGXsXHf3H3YRvAEwT
	 AL2pXAC9/v+76n6IYo9qPzoia6DR6p8M4yebx8hU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHZRZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:25:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgHZRZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:25:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE5152075E;
        Wed, 26 Aug 2020 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598462753;
        bh=S8TXZrq1wbwhPqABDtlshBxR1KjWnaZqnCtcuEK91FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRE9gAq6ZNqBg3N58fycZZ/pb3EXixz70zN1ZsNqLj65QEbquM7zRlhelGMNG2pr2
         iiIXK2zbHSarABuV77ZxpjApU/K6VsKSvHrr7YqyEyczQNBv4lHPEeYIdoFgIxpA6s
         I53dOocISH2azcG9NvRRUt+xr/E1JC4gQJR+84Rs=
Date:   Wed, 26 Aug 2020 18:25:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
        srinivas.kandagatla@linaro.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200826172516.GM4965@sirena.org.uk>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk>
 <s5ha6yhu3af.wl-tiwai@suse.de>
 <20200826101301.GB4965@sirena.org.uk>
 <s5h8se1u2or.wl-tiwai@suse.de>
 <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BHMq0+oGliEfCAkH"
Content-Disposition: inline
In-Reply-To: <927c93bc-9ad8-7e5d-a5ea-d566e5f543df@linux.intel.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BHMq0+oGliEfCAkH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 10:05:50AM -0500, Pierre-Louis Bossart wrote:

> I assumed this change to -EOPNOTSUPP reflected a consensus in kernel-land,
> it's obviously not the case. This patch was supposed to be a trivial
> clean-up...

No, it's just some random guy sent a patch.  They've not made any
perceptible effort to interact with any of the existing users.

> So to be clear, what is the direction for existing code
> a) keep -ENOTSUPP as is?
> b) move to -EOPNOTSUPP?

> And what is the preference for new code?

If you want to change this you'd need to change it over the whole
subsystem (if not other subsystems), including the places where the
value is used.

--BHMq0+oGliEfCAkH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GmvwACgkQJNaLcl1U
h9CVZwf/X1R3FvN72dVYg3h6EUe0Lc2dc9uETB0siPhxUEa3nMuatoNxcp5W4x1U
d6oIj55I4XmyMV4M7qUTaJWPiuIxptj/X6tuFQysg2QULq98txsRtp/S8+UnSeW3
l9ECbZxahzFi6ydJI+QEZbdTu3gykzMrZ4vPHRJ430/Q9Xof+GSiBQ5yWKwz8Yy3
nmmkeSDJk0AFLkqCzpG3pDRo+HxEnKfcJVaDl//AYnmKySZxzu0PacTVf7ceFYIa
ehD1Z2lBJEG2wcAfwJaEh1IFG+NiqbePpBH+Nziy71y7UVc082qCfE31NZlkt6Ts
MJUmhHp0xcUaBV9koqd5IQKGnmWw8Q==
=ls7t
-----END PGP SIGNATURE-----

--BHMq0+oGliEfCAkH--
