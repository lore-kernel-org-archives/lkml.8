Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 513892065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594117369;
	bh=UHtw6MeLR2PbjZOILpcJU2lXzsz+tYXwTsaXz6IERvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=f9rBMlzzhgKT82cvEfTqoh60lJJ7upQ5XwQ3B8oMTg2x7ZdvuBzZ8zbH+u9MDGgKp
	 Rs0ddWRiTCkxgiU/wBmRUZcXcWAhegvLCkoXIm8oUqeAVIDRw2E/wxzY44MLRdwYQE
	 6Hvcnq/55E659QYYLLLbB0oa+LA7v34aVSD0cfVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgGGKWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgGGKTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:19:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD11206F6;
        Tue,  7 Jul 2020 10:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594117159;
        bh=UHtw6MeLR2PbjZOILpcJU2lXzsz+tYXwTsaXz6IERvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PiF81EvX30apx9Ee27/EN5d/rxv99l+LJ7dLxxuXdcJKRcZjZnDF0WJcR8a7gyMw3
         mhBm8kGJIOaUYVpOh4g7ix4p+cEbp3rX+2JwnBVSF/9mFa75svG2aZWlr8XPnNCU1b
         wDGPrrl4HKTWoNVdT4gn7ajWkmKXsVTFT16KiI5A=
Date:   Tue, 7 Jul 2020 11:19:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/28] Clean-up ASoC's W=1 build warnings
Message-ID: <20200707101915.GC4870@sirena.org.uk>
References: <20200707101642.1747944-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20200707101642.1747944-1-lee.jones@linaro.org>
X-Cookie: I hate dying.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 11:16:14AM +0100, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.

Please coordinate with Pierre (CCed) who is also submitting patches for
this issue, there's a whole bunch in flight already.

--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8ETCIACgkQJNaLcl1U
h9A2lwf/WHxiQ4N0fIy5r4w2N77ELaYXlxUlx7kooARFaGhCerRy8YXOb+9Zc4Z6
xGYqdqv7T4xqUsVP8BiO8hqnKfJgQPO2dWOfWO0BZm5BTng2eI/7I3R57cw+luCw
i6OIo6CncxzZRNlhZiHfkUltuOmZ3snr7dW3jTzrtWJtMKCIdsOcmDKNBeUFEBtA
sWcqsutEZ5puO5BmS/kKkfmPKEZl3nOFOJOLK8IVNZM8usO9wknx66RGct78t7qc
vjIoNoVUaqabFnRnZ74RtOxoLRSUXNJ1Wivxj4I4nsZbq6LhlxZk3hg79hq2+pOZ
r1f85V6q6MI+l6if565oFynaC210rA==
=Qi7z
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
