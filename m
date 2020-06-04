Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6A3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF9D20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 10:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591266845;
	bh=ml0TSme6cwPJFcsMzPbSkhZNqOuWYZXZIbIdkDTqu0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oZD+CPq/HlpxLttycYBo+L0OT8K50CBLarcpgWwSjHNRrlZaN4IaaifIFBVj3Vbse
	 9srxSQzeQp8V+E5QIWn8DEEEEnyeXy/mNZtn+jEIzCT+WK4u5F4eSQc3OBV/4r8r+r
	 gvArQ1Tv4y5laVoyDL4NaqQtoSxwswi7/ZerUXcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgFDKeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 06:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgFDKeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 06:34:01 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 835622074B;
        Thu,  4 Jun 2020 10:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591266841;
        bh=ml0TSme6cwPJFcsMzPbSkhZNqOuWYZXZIbIdkDTqu0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ib7SHA56hnoNxXEB3RVG+tQ4oeiz2yi+hrv6ZKVV+AWSJx+cpfoz+WeKC4o4na5LR
         ZT4TZ+MzCY2GnYNX1KDwgvV+6vBj5/QnFBLwnHEmU5vxPKOwVWU+lfdl7dqqa317dq
         4k6cEBdwgIjmijZ6EdTn8Rk2Joecbln7Eg2V3q1g=
Date:   Thu, 4 Jun 2020 11:33:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        steves.lee@maximintegrated.com, alex.huangjianhui@huawei.com,
        dylix.dailei@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98390: fix build warning detected by -Wformat
Message-ID: <20200604103358.GA6644@sirena.org.uk>
References: <1591260574-12717-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <1591260574-12717-1-git-send-email-nixiaoming@huawei.com>
X-Cookie: VMS version 2.0 ==>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 04, 2020 at 04:49:34PM +0800, Xiaoming Ni wrote:
> Fix build warning:
> 	sound/soc/codecs/max98390.c:781:3: warning: format '%ld' expects
> 	argument of type 'long int', but argument 4 has type 'size_t {aka
> 	const unsigned int}' [-Wformat=]

Thanks but this was already fixed.

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7YzhMACgkQJNaLcl1U
h9A53wf8DLWNHAYxxJtyck1M+jV6nQK+GVYUrVtteiTM0qIor6RzV2EFpLde1I1P
gWa5qE5gs36x9WZRwUVfqrRyxATRWNDBDXVGr1yi1Nr1uRiMxRa2OBH6AIUeeKVQ
Py5pUwDCLokOkWu5OoMraUubXIBC7mMTDO639djf4TLUdN3iVo7ZvNZuzYPWzLPd
siuQIuJR0slgTIRVrv4ILKKQnFUvfoGZ7E1n/h0327qhZsSDzofHO1E2b/h5vKuE
jJ7raMnK1kS6tzy0ekKYAOHb8xR+B7hBUDlPox83eAKbIKJk+6J/kFFtE6VOr+Jy
ypnhcWmJymrH7PP7xd7tbJfD0zCn5w==
=mHCk
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
