Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303E3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F9620771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 11:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595417539;
	bh=bbNukseyVTD6OF4Enu3SgI2e1xGEt4JiYh8YRpN7oLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WW6QoLONdVhxB4V5K4EyCkVi9d54XiVaTNM8eENAdr3onZu2AZKg+UiixO3evgdFn
	 d2qGz0uOIdCM/VaTNe/MBYWIFGdf6xgIrv/Bej1NYGL3M1yT7dkbLpycsS6IGoXBDO
	 YIK+U8oFFvSaUWGV4O5Ge3VMO26oSYAV5+e2xRc8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731763AbgGVLcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 07:32:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:41926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVLcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:32:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD57020771;
        Wed, 22 Jul 2020 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595417536;
        bh=bbNukseyVTD6OF4Enu3SgI2e1xGEt4JiYh8YRpN7oLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HHskUkU+6ZNbYiVWBPqjWFS/QK9QNdqTVWA28+FzJHrwVDIEggjLKhci4A+MRvJnw
         nPYtVooBNahU0MbT1ndiPi8tBTaXJ7P7RI+eSXJMr3PL76yoKnC0iwMSosFN/clPjo
         nn/DKRuBkW95kVPryy/Cn1Vyd9Iyper1hI9mFHpI=
Date:   Wed, 22 Jul 2020 12:32:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 1/3] regmap: add Intel SPI Slave to AVMM Bus Bridge
 support
Message-ID: <20200722113202.GK4845@sirena.org.uk>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-2-git-send-email-yilun.xu@intel.com>
 <20200717181508.GA905@sirena.org.uk>
 <20200720171131.GA18829@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
Content-Disposition: inline
In-Reply-To: <20200720171131.GA18829@yilunxu-OptiPlex-7050>
X-Cookie: I'm also against BODY-SURFING!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 21, 2020 at 01:11:31AM +0800, Xu Yilun wrote:
> On Fri, Jul 17, 2020 at 07:15:08PM +0100, Mark Brown wrote:

> > there looks to be a lot of abstraction layers simply within the software
> > here which make things hard to follow.  At the very least there doesn't

> We need to follow the 3 layers protocol for register accessing. On SPI
> slave side, spi-avmm HW finishes the whole protocol encoding/decoding
> work. But on host side, no dedicated IP block is designed. So host need
> to handle all the protocol work by SW. This introduces the complexity of
> the driver.

> We don't introduce any extra software layers, just follows the
> definition of 3 layers in HW spec. But I know reviewing the detail of the
> protocol is tedious. Maybe I should put more comments about what part of
> SPEC should be referenced for some piece of code. Hope this makes the
> review work easier.

You don't need to reflect all the layers that the system has in the
software, if some of the layers are always used together with no
possibility of replacing them then it can make sense to collapse them in
software.  That did seem to be the case here.

> > > +config REGMAP_SPI_AVMM
> > > +	tristate
> > > +	depends on SPI

> > Note that for selected symbols dependencies don't take effect.

> I see. So should I change something here? I see the same case for other
> regmap options.

It's fine, just be aware that you still need to have appropriate
dependencies and selects in the user.

> > > +/* The input is a trans stream in trans_buf, format a phy stream in phy_buf. */
> > > +static void pkt_phy_tx_prepare(char *trans_buf, unsigned int trans_len,
> > > +			       char *phy_buf, unsigned int *phy_len)
> > > +{
> > > +	unsigned int i;
> > > +	char *b, *p;
> > > +
> > > +	b = trans_buf;
> > > +	p = phy_buf;

> > I'm not seeing any bounds checking on the size of an operation in this
> > function and I think I'd expect some, similarly for a lot of the other
> > I/O operations.

> I have caculated and allocated 2 buffers that are large enough to
> contain any possible data stream for regmap_bus.max_raw_read/write. See
> the definition of TRANS_BUF_SIZE & PHY_BUF_SIZE.

> So maybe we don't have to check the length?

This isn't at all clear looking at the code, perhaps it would be clearer
with fewer layers of abstraction but at the minute it's a lot of effort
to confirm if it's safe.

> > > +	if (spi->bits_per_word != 8 && spi->bits_per_word != 32)
> > > +		return ERR_PTR(-EINVAL);

> > Most controllers support configurable bits per word (and modes) - you
> > shouldn't be rejecting things based on whatever the default happens to
> > be.

> I'm not sure if it is good that the spi_avmm_regmap_init changes the
> configuration of spi devices silently.

That's the expected usage.

> In my current implementation, the spi device driver should be aware and
> choose the right spi setup before trying to init the regmap. Would it be
> too hard for other drivers to use it?

It'd be duplicated effort in all the users, if the only way to use the
bus is with this configuration then simply saying that they're using the
bus should be enough.

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8YI7IACgkQJNaLcl1U
h9AZTggAhkccdpqjqFdXRJhp679SkftzAGf2j1i3VnRXIfFsHj8fGMEHxdSOGeek
cukF+F8r/VgIyK8AT6WqVBr3vETWDi8ox3/Bpv9BTjZ2gNemQ/aa/ejsMxuWbo/D
nH1eSBj/MWDmasFTsnTKsORehmHJ6aa/wWTPm08+kC6dMiscq8eD0Dyem8yQFXqZ
V5cZYnNMXbZhq1Nhe8iT051D+p6ADoCImoyIllavfoikfeN5ighTWQPtEoXBp/tJ
iukqMRTsSFCZIP+ke8Y6U7kRiHwZoQoVcH49GsKjVmuRBW8ftIhcMyjegyUPkqrN
6mx5ZDGP1j9MNzh+IgJ0L7w9p84MbQ==
=adP/
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
