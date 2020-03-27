Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE776C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752F42074F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585323911;
	bh=6hwNDonjZflZ7zKTp0aKhEn1t1a6nz/99BhAyhcIGqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mk8uBgx5FYP51x5tHhOT5TlCK0+5Xie1aiCq64jNFct94W0kfXHJXtr5QFuseREss
	 bs3fkdvJSMPyyKe5UaQIO1sEWbuM0lqfUnnsa5CGqKsd4KSUeuWDfVRb+7crKtjMxy
	 4mzPF3jSFl6jCPEf7DjVq2MKqPwCJVyLG8icUxTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbgC0PpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:45:10 -0400
Received: from foss.arm.com ([217.140.110.172]:47480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgC0PpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:45:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4A341FB;
        Fri, 27 Mar 2020 08:45:08 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3402E3F71F;
        Fri, 27 Mar 2020 08:45:08 -0700 (PDT)
Date:   Fri, 27 Mar 2020 15:45:06 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        jonathanh@nvidia.com, perex@perex.cz, tiwai@suse.com,
        digetx@gmail.com, mperttunen@nvidia.com,
        gregkh@linuxfoundation.org, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        spujar@nvidia.com, josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/22] Move PMC clocks into Tegra PMC driver
Message-ID: <20200327154506.GF4437@sirena.org.uk>
References: <1578986667-16041-1-git-send-email-skomatineni@nvidia.com>
 <20200325212708.GA836215@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6v9BRtpmy+umdQlo"
Content-Disposition: inline
In-Reply-To: <20200325212708.GA836215@ulmo>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6v9BRtpmy+umdQlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2020 at 10:27:08PM +0100, Thierry Reding wrote:

> there's a few runtime dependencies between the various patches in this
> series, so I think it'd probably be best if I picked up the ASoC patches
> into the Tegra tree and let them soak for a day or two in linux-next to
> make sure everything is there and in the right order.

> Do you mind if I pick them up and send to you as a pull request in the
> next few days?

I guess, I think I lost track of what was going on with this as it
seemed to continually be getting lots of discussions:

Acked-by: Mark Brown <broonie@kernel.org>

--6v9BRtpmy+umdQlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5+H4IACgkQJNaLcl1U
h9CSOAf/QSUkbVkzKfzHrLVi8t1LfFrrL8b00ZDF6zpPcKZ7xMhrTbzFDBQfh1/N
OMocm4O6vBAKX9nnnW5nQrm0DwtDgBaCdw2LZ2vMHmjj+djIxeLUblO495rjKoSy
eTMOEpejXV4hKE/XEiTeFyF/3xAzWaTwGFU5lnbm6gBGGo7FWHTjAikYvMCxfm85
BFFGdkWccrl+RhvRPqlLqHLh4eLBXkHh6O88XXSkAd1uA74Ajm6KgnngXkowX40d
NkkBVV9/AsRGicERL8Fl35btPAXe07mQNRC7cPcTlqbXOKr+ACnqdmAvPrj67gSd
HfNd9wiUiT5pRu1Vm2vM93ZG0P3vzA==
=JK9F
-----END PGP SIGNATURE-----

--6v9BRtpmy+umdQlo--
