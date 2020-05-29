Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D22F2208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590793359;
	bh=n6ke17m7zdty2XbznaUf/ImP7/BQ3BkiDpHS+eIcMCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=00vD6PWNj5z8ARQC4qRp9Y5YGj49zI2Opgpi14phHi9QViV435P7YVyvzuBwRvfR5
	 2DVRHnQaSeTDG+ELoGQUkyFA+a69VAxpfTaiNKfITTrhcE8Ymu1D37tsGivmoSsANa
	 E9dwwmXlmxbvCcKb0JEhnie1NYAv8lyTSwjQin4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgE2XCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726898AbgE2XCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:02:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C987820897;
        Fri, 29 May 2020 23:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590793358;
        bh=n6ke17m7zdty2XbznaUf/ImP7/BQ3BkiDpHS+eIcMCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1BS4OVeiGDlr/H54DvJ7vBi6oNU5RfNNAOxReGvn0xII0B8BNWF35D+LZ80Ov9ah
         HUamGoO9AKV20Z5Vb/D7CFZYdSG0we65B7EAyvlmPPydqCRHIHy5WhmRriFExGGiLM
         VmpmUU8UjQ6xcls3wIVKYxZ1jjBoVWVtBfD5ljzs=
Date:   Sat, 30 May 2020 00:02:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: Intel: byt: fix unused-function warnings
Message-ID: <20200529230234.GZ4610@sirena.org.uk>
References: <20200529200433.19068-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NJ3GtppTlf/130kA"
Content-Disposition: inline
In-Reply-To: <20200529200433.19068-1-arnd@arndb.de>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NJ3GtppTlf/130kA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 10:04:17PM +0200, Arnd Bergmann wrote:

> Several functions in this driver are only referenced for baytrail-class
> configurations and building configurations with only merrifield enabled
> causes a warning:

Pierre fixed this earlier today.

--NJ3GtppTlf/130kA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RlIoACgkQJNaLcl1U
h9C0egf/S/FcGFYqxnk1QAy8ZfP+uCdN65yW0o7yJJ92rF4YUb7W8lUJvhS+8IHr
Kwjwa8+hIOUAUGSOol/q3HsK6rG7NtKXwa//CnX9oXdHAz0hwXEMwx+eVFBSb322
Nt2T3F6786OaYc10Yd30HrNzJHlOk7hJxJ5APKFrjvjX/21sgbt1f6aAEY2FEo9h
ngZcmmzAANLl6rhMkrgLax97gckP84jE1hr4Y4iKJTSa7mUQ+jDk3znz12IOu/Rr
6PTjhlapK/GjaODdubROW6i4QCxK3z2S/yaVP34NM/r8aZW+BZ5/NEfdviO/5NsI
ewCdBudt31j34yevaZDZNVWLZy2P2Q==
=dPCM
-----END PGP SIGNATURE-----

--NJ3GtppTlf/130kA--
