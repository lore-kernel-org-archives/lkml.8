Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A194C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E5020786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598437039;
	bh=5tJW1RUehpS5WybOA0ZAprsp+YpJ4fCRYflUkMT9GYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gs6dnJBOIiAi1vQZ80ELooi/Iyl8+6fnWb8CcK9daX9InkE1XGEOAGM23Jysk7g0s
	 VWY0ImB4cMarlWUTXYD/mCOIq6DqPGiF9SvH0ZelKocS7chq624Nn7/Hhvv9zQ3yba
	 nupVKOQtr9zpq+6Mpp0KOrWKmmXsucIlgce3cs1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgHZKRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgHZKRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:17:13 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF1E20786;
        Wed, 26 Aug 2020 10:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598437033;
        bh=5tJW1RUehpS5WybOA0ZAprsp+YpJ4fCRYflUkMT9GYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ggqjLcsW5r39HmxmZeRwkMMcMvMbzKBucECTKjbLUEN9lPyFhb6B1Wb/65ghmw0qo
         e1etyh5xkqZkG81NZsilBAgDxjMI+QBJIeT9f/qFH4PGjteBTD6/LK13ufuwQx+Kdj
         MajUluJpge6kI0aZyWFntKE2M0iUAamBbiDY3Oyo=
Date:   Wed, 26 Aug 2020 11:16:37 +0100
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
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
Message-ID: <20200826101637.GC4965@sirena.org.uk>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkEUBIird37B8yKS"
Content-Disposition: inline
In-Reply-To: <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dkEUBIird37B8yKS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 25, 2020 at 12:16:56PM -0500, Pierre-Louis Bossart wrote:

> One possible objection is that this code could have been handled with
> regmap-sdw.c. However this is a new spec addition not handled by every
> SoundWire 1.1 and non-SDCA device, so there's no reason to load code
> that will never be used.

> Also in practice it's extremely unlikely that CONFIG_REGMAP would not
> be selected with CONFIG_REGMAP_MBQ selected. However there's no
> functional dependency between the two modules so they can be selected
> separately.

The other thing I'm wondering here is about compatibility - is this
something we can enumerate at runtime and if so couldn't this be done
more like how we handle the various I2C and SMBus variants so the driver
just says it wants a SoundWire regmap and then based on the capabilities
of the device and the controller the regmap decides if it can use MBQ or
not on the current system?

--dkEUBIird37B8yKS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GNoQACgkQJNaLcl1U
h9CrSQf/WFN5slGq6hYdSlbxY9S5fg1zC1mvg9ty1w/5Mz/65Q//rzJpHBd+tYKc
HZLr2kEjM7nBO1Zm3fngADbUmKwlCRFnWwEuzcCibOQbgopTmhVg1MIQOcg32RcU
w2D7/0oZWoPul9tO3UR/cf3I5FgBkuRZfBayFeFb6FbwZVgb4F8BDA8Xobt215Zb
mRVFxChQ7/0IDT6ju1CqDEk6zr1h5zIhqgVXO8YOkvOXh6ObxL1jXvrSMtOVZ2Ki
Kqpf6i6sJxNwu7PF4f6EdhrDKQKLLncW/qrh6Phx383RkfHhdCqGwPAB4H8Vjb15
j70LoMEibs5FCPo/+fD8AGxDkrOU4Q==
=f/l0
-----END PGP SIGNATURE-----

--dkEUBIird37B8yKS--
