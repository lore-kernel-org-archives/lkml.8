Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEACC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B4302075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 21:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598392176;
	bh=9BrDq6Gjq/Y77i7qs+NbOYbjNIjZinMPZkwE9YvtUjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rtvI34XAiUUwFERMOsWFBc3xeS1KlI9e4BxmKrWm55Dp0rydWNJxM1bq78AO46rfq
	 gs/wtjiBze4BYckZx+782YoXEQhLWIp7VstapHblJ+jizYJEp4Hko3DbaILR/0uxhl
	 agKAm2R+NBcoQPkXVIEEQB/uWl80b/UPIgkRBApk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHYVtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 17:49:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgHYVte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 17:49:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACFAA2071E;
        Tue, 25 Aug 2020 21:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598392174;
        bh=9BrDq6Gjq/Y77i7qs+NbOYbjNIjZinMPZkwE9YvtUjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVppPwLq36+HSZ5f14EL8j46bG9IbZ0AJSo/oTViYnbKjmzg3aM/nWhvjH7S+Nuzk
         DOQ3h1H2OIJ3ngRNujyjDsESlFtSSlyTdb1oHtZO/Rz3XCjO7X/Cgq6j/Xma0xhrPV
         eaCdA+pSkcGdyRZj8IeDDvcehjTMr9gLnQyWmeKA=
Date:   Tue, 25 Aug 2020 22:48:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, vkoul@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200825214858.GK5379@sirena.org.uk>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DfnuYBTqzt7sVGu3"
Content-Disposition: inline
In-Reply-To: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
X-Cookie: Don't get to bragging.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DfnuYBTqzt7sVGu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 12:16:53PM -0500, Pierre-Louis Bossart wrote:
> -ENOTSUPP is not a valid error code, use recommended value instead.

What makes you say this - it's what regmap uses internally for
unsupported operations?

--DfnuYBTqzt7sVGu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Fh0kACgkQJNaLcl1U
h9D4Vgf7BdFX5Dbcg2/N9Rn0iKz9WFK0Q8Wf7j3HHZ9+IFyb7s1woC1ODAYmdK4V
exXPOHHe/01Wchdbbd285hFg9dmvi0LrIgck3vu0g9RsiUu9xIKcE+WlUOJWXyKq
0FvkMXGZA+WM4h85C9IAXgghI3aTX+rLZX0eASivujZu4m8SCii2g+oD2crk7e+5
SBzKjm3QR7bWSSgJmhrlFFVF2gUaTLVlLiM80dymV9rS6+OtDyyptl/586owjA9q
I9Y7II+RCy9ZeDeVjsgBcxFXsu8+MlnUd9QLT7uzqzNRBcl1jWFCLTg0bRzKq2Zx
Au0AkyS+sLDojGFTaWGPJnECuZ4QzA==
=Hv01
-----END PGP SIGNATURE-----

--DfnuYBTqzt7sVGu3--
