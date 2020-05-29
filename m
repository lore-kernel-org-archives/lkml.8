Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF39C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4920E207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 22:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590790858;
	bh=agdD1/H+81Es2zptPz+PFbSQEef+yi1Q2CkkQpaYadw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hzu6yB0QQqo8ga8lSUSBtYUO+HmfLpmy/uENroSk88o83tTSojbqogzfxQIlhvrW+
	 exhLz1I8vbZIzC6/xZku6gnPSgoMjas576PqXVhcJ9OBpiYLfUs23scl+wIhqNmRy9
	 gHJ1sxG5YmikR5465AmF4c2ovonVaHn5ZtHutP7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgE2WU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 18:20:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgE2WUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:20:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF152207BC;
        Fri, 29 May 2020 22:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590790855;
        bh=agdD1/H+81Es2zptPz+PFbSQEef+yi1Q2CkkQpaYadw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d25uxxSvOVTDAEhY2mZzCehPJUn6trRthfWg4110RR+pdJaVsqVuEtVfUDigi+C9e
         jjgiskgtvbLdnFfXvpATI0QhqEhxDkD9VzO0kdZHnW5Hkd53n3N66lzvnGQA4/5h2n
         vvLtujv35PQsKHnqu3ir0u5/slFsUAL1Wi+vwV1I=
Date:   Fri, 29 May 2020 23:20:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jens Thoms Toerring <jt@toerring.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] regmap: fix alignment issue
Message-ID: <20200529222052.GX4610@sirena.org.uk>
References: <20200529192538.GA28402@toerring.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fqQSV+MVmQEkpBtA"
Content-Disposition: inline
In-Reply-To: <20200529192538.GA28402@toerring.de>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqQSV+MVmQEkpBtA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 09:25:38PM +0200, Jens Thoms Toerring wrote:
> The assembly and disassembly of data to be sent to or received from a
> device invoke functions (regmap_format_XXX() and regmap_parse_XXX())
> that extract or insert data items from or into a buffer, using
> assignments. In some cases those functions are called with buffer

This doesn't apply against current code, please check and resend:

HEAD is now at 93b929922dba Merge series "regmap: provide simple bitops and use them in a driver" from Bartosz Golaszewski <brgl@bgdev.pl> Bartosz Golaszewski <bgolaszewski@baylibre.com>:
Applying: regmap: fix alignment issue
Using index info to reconstruct a base tree...
M	drivers/base/regmap/regmap.c
error: patch failed: drivers/base/regmap/regmap.c:261
error: drivers/base/regmap/regmap.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.
Patch failed at 0001 regmap: fix alignment issue

(it also didn't apply against v5.7-rc1 and git didn't know the blobs it
was based on, the most recent change to that code was in 2015 it
seems...).

--fqQSV+MVmQEkpBtA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7RisMACgkQJNaLcl1U
h9C07wf9GRKDw3jvmyLkiZ5fmTbu5x9EkzTvWzOyn5ROc+Xr2SfULwAuhGVwWgcy
QwyBILW6Zi7qiCMkt4r1E7DW5lZPh+cURAAe/lc8lXOKtt9Uz0ERf7HJOhMIWFzE
rEr+RU4s37MGOWyNtAUZ/lbCtJ++gnbPF+KNSOYJuNGzwU+O2l72bpGuZiO7rAVP
7mOrSnhyM2ua9Zmjmh8iDRnlQyvK6It5GrPvPZftMYIZDZd4rIVNwDlhKdL/fifM
AcV8dsqIaCd3u+cVZLrY1FgXBOfgAmlU/0Nz8TL0hXPFTLtELV+5M6M4a2iE1cSJ
z/dRgw/45nOtfnY0tRIHhC2vBpK6Uw==
=Y9kj
-----END PGP SIGNATURE-----

--fqQSV+MVmQEkpBtA--
