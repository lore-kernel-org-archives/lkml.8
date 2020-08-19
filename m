Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F752C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE376207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597826397;
	bh=oiGIg81VImFLaBXc+cjJbsFLkNWQ4a2+eNPozbjMNs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jg+y35wwwy/gkYV/TMoXuJFH/4i7YMgfJ37RXx8xrLAnxsIrI5HagEgWsjz1CBarw
	 MdXfQNDheNBbeaXSPDqtfVvDInlV4J8HhNVKkPIINfxmmDgGzIxmc0nOHbFM4nxSu6
	 RRQpnk+bVN3rg7WzqJAY6QEleGOPNkBy9/3HAvQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgHSIj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgHSIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:39:54 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86EFF20772;
        Wed, 19 Aug 2020 08:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597826394;
        bh=oiGIg81VImFLaBXc+cjJbsFLkNWQ4a2+eNPozbjMNs0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuJtQTGs58CXLAJMLZ8pgnSh2VWCkb3w7SO2zNVqYME2heHqQBAdUXf3ESGjO2B/6
         xUoPiAwOFkGWmVehvT+VdFAJ3X8t+kemlzLWGbaAj3hywx1jDz7FW/AONNgQwvRErH
         1bK1J9/WkBEAOs4f8yq02klrNUkgZTGC0LaZ/xZc=
Date:   Wed, 19 Aug 2020 09:39:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 5/7] ASoC: codecs: realtek-soundwire: ignore initial
 PARITY errors
Message-ID: <20200819083922.GA5441@sirena.org.uk>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-6-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20200818140656.29014-6-yung-chuan.liao@linux.intel.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 10:06:54PM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> The parity calculation is not reset on a Severe Reset, which leads to
> misleading/harmless errors reported on startup. The addition of a
> quirk helps filter out such errors while leaving the error checks on
> in steady-state.

Acked-by: Mark Brown <broonie@kernel.org>

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl885TkACgkQJNaLcl1U
h9DBLwf/X2tM2iGHP4+gucIFYm9A9Gdk+fe1Yy+Ss1aBXB9wkEgWc6QwWyg8Xaq0
PZKtoyOzZBfv844U00D+j0oXTpqb8YihMsCGCXuaIOrWiqsOXHZrPDPFMTGGuQJ5
evXAq95XxtSJpfX2Pin6a224dn8bHsyMkIjNThCrdAgeOdkU6hyvLm0K8iTEuTpS
yVdPSD+tUqU2jVmJh4c2DCZu0gi4qlD4p7VH93m57Qamp74bWFLwNUZ346D96Zqa
uXQQNmveYbH4lZ7dMx4ga87b/teuMCbebq+OQ2On6FP5dEJlK7Yoq8MUcKwp2IUa
EEgkYPeK0Qyr4ynMP+Kyy/F841BCpQ==
=nWw4
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
