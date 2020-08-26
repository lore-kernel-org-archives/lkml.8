Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21936C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E386C206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598436823;
	bh=7Yiotm++5mcylAUoQcmaIcIXDKlEaC2FfSyZhGHmL0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GmANZnXlwni/UKj4DXLdMtQBC+sWh+Mv99RP91U44zm3By9FqtmLBEZ+wdcvZCGCj
	 rVRs4vb10Am8hes/C+kRX97p7Q9hynB2p1i2Y7AKk7Ujn+qxZ8a+laMhBteqLYp34b
	 iw7tEliDhKLKcvNKw/S8FIUnXdelfZb6GVEKN2/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgHZKNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 06:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgHZKNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:13:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ACD820786;
        Wed, 26 Aug 2020 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598436818;
        bh=7Yiotm++5mcylAUoQcmaIcIXDKlEaC2FfSyZhGHmL0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldry5al5hlgsrc2QLoUyvMu6PHQOSY4Lu+MZ+CvEQfmvK5Z+XlP02cbj4UdBANcs9
         6sPWgAHijrQ2R6p3c3Q46krm/AvaxEgr0uQqe6mqLyFJdyrXL9+lc7hC9SVb588T4L
         sqQkrkqyqGgzbpWgueQ7rpz0Q+FSACjcwxPapUgc=
Date:   Wed, 26 Aug 2020 11:13:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] regmap: sdw: move to -EOPNOTSUPP
Message-ID: <20200826101301.GB4965@sirena.org.uk>
References: <20200825171656.75836-2-pierre-louis.bossart@linux.intel.com>
 <20200825214858.GK5379@sirena.org.uk>
 <6f7e5830-4dd8-1ecc-20c3-df75bc9ef265@linux.intel.com>
 <20200826095600.GA4965@sirena.org.uk>
 <s5ha6yhu3af.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <s5ha6yhu3af.wl-tiwai@suse.de>
X-Cookie: Should I do my BOBBIE VINTON medley?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 26, 2020 at 12:09:28PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > checkpatch is broken.

> Heh, I'm not objecting it :)

> OTOH, it's also true that ENOTSUPP is no good error code if returned
> to user-space.  Unfortunately many codes (including what I wrote) use
> this code mistakenly, and they can't be changed any longer...

It's also used internally in various places without being returned to
userspace, that's what's going on here - the regmap core has some
specific checks for -ENOTSUPP.

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9GNa0ACgkQJNaLcl1U
h9AJeAf/WqsXkrP/82iF/TgEzGg4DDimkCFgDUemLmTimuMP5/11b0qeDKqL7PGl
RACeGo++H3Xr5TS2lKjFInP+zG4aCdpyLg9nxm/TnxMDCJOidLvvvsYO4AdXLNIL
BwOSBWU3o8jXAepH7w9tQ9Nqq28sJPrUrhrju+R7z7eNtmoTksiQwanXiQ9b21Gh
j4Jc3KRhKf4brtnajauLYqNx2spZEFLJ14PJnDTG3vXm8qOtxfqCM8ei+Rd5atAw
N64TV6U6mAQoFJsP4/d+GR7/90opkVVRTZVtSK+bHrH7p6iHPhliPpaPw7PMZnC7
BiZ0HypuoqdvZeQ/0f1cVjuiiGCaww==
=vOnh
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
