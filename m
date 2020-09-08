Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D634C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CBD206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595830;
	bh=tJsIwenxLQUdiskJ5RPhYYEEkBlmKh/SwM1IpIoH9Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rZUUigvcW+Nj41/sLq4ZgUUwy2icYIR0AEaqTTqMJZI8YLEmdD4sqP5JWPmPbvPTe
	 U6P/reE5N22DH6g9bxQwvFlktuiUb+CtqFeiH7ZuVxWEpqbZmnRje8A0huHlxNF88O
	 b1Csi9DS18dVQ4KXfw2dG8fSs6yqZaxady70awJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbgIHUK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730251AbgIHPQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:16:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB5F922283;
        Tue,  8 Sep 2020 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599578097;
        bh=tJsIwenxLQUdiskJ5RPhYYEEkBlmKh/SwM1IpIoH9Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCAc21pvEnm1zOz0iewDMkO+bBetG4dCzIos6oEczR8k7J6FkTt1P7c29Rt382CDj
         0zggzJktRU/QgFKmSdQWSDqj/1qfKzh1LYeYfjnFRuv4Guoq4A/5MEJG4mfR7kZpw6
         OxiaFvMnWuue0njCUYTx26Dd/9chG0gDOQTFqfwY=
Date:   Tue, 8 Sep 2020 16:14:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        Vinod Koul <vkoul@kernel.org>, srinivas.kandagatla@linaro.org,
        ranjani.sridharan@linux.intel.com, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
Message-ID: <20200908151412.GE5551@sirena.org.uk>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
 <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
 <20200908143312.GC5551@sirena.org.uk>
 <ce68a159-de6d-2d8a-c8a2-3e527cb1239e@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Content-Disposition: inline
In-Reply-To: <ce68a159-de6d-2d8a-c8a2-3e527cb1239e@linux.intel.com>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 09:47:13AM -0500, Pierre-Louis Bossart wrote:
> On 9/8/20 9:33 AM, Mark Brown wrote:
> > On Tue, Sep 08, 2020 at 02:28:48PM +0200, Jaroslav Kysela wrote:
> > > Dne 08. 09. 20 v 14:11 Mark Brown napsal(a):

> > > > I don't have this patch and since I seem to get copied on quite a lot of
> > > > soundwire only serieses I just delete them unread mostly.

> We now try to use the ASoC/SoundWire prefix for cover letters to highlight
> that a patchset changes things across two trees, does this help or do we
> need a different way of flagging these patches?

I think the issue is mainly where the patch itself touches both, if some
of the patches mention ASoC I'll generally notice them but Soundwire is
one of these things I get so many random CCs for I just zone it out so
highlighting the individual patches would help.

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9Xn8MACgkQJNaLcl1U
h9CUUAf+K13VelraWrtnNDSK36472Led55+P+yEMDNm8qcIyEGWD5AbiP5aY2ZSz
S+nwGtGVoamZZpea1eV0bT6KA8iDP0iaQzwd8TiuYYrQs5jcgvs8/HaNKcpr/QcU
mGstshh8rzw7j7aVLJiYULVfljZH7EGZvLubAWhYsTPfFkOBx5uVv3UttaMYdDOv
y4vF26WCaA1lQ7Cf0Uhnqvmm9EGBRShE90plEabxVHA2ny7D6r+n6BZLJYeMojJi
EWJTVtV9Te0dcb5duOSRMOWTEpv1Lj06qU7TrJ9LvKRIbbO64kcY3/h2Rkh4VIH2
buWiqehTcS/h6UufwJb6pHLVAtNdcA==
=FI6R
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
