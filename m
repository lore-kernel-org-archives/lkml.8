Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF493C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0582253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 17:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579542400;
	bh=8/17QWYrx9IAjC5T1/TZY+b3d23qd5HapWk0cYUUKaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BzwSCPTYiyGWvgPp96MT3391462cCipru5+r9RlmbKcxHWwhrU69dC7t2g3DqSHQI
	 sckk79iYUCJOB4RVHSLZfZFfnOOq1kX/OdsmUaCeAWhVeCGjdwkMQ+PXctmryv1TTI
	 O0JcAfPhh477uRhc5U6kLutFFuCCbtEdlxHIRRYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgATRqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 12:46:39 -0500
Received: from foss.arm.com ([217.140.110.172]:35144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATRqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 12:46:39 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20BF531B;
        Mon, 20 Jan 2020 09:46:39 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9349F3F68E;
        Mon, 20 Jan 2020 09:46:38 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:46:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 8/9] ASoC: rt5645: Switch DMI table match to a test of
 variable
Message-ID: <20200120174636.GI6852@sirena.org.uk>
References: <20200120160801.53089-1-andriy.shevchenko@linux.intel.com>
 <20200120160801.53089-9-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Content-Disposition: inline
In-Reply-To: <20200120160801.53089-9-andriy.shevchenko@linux.intel.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 20, 2020 at 06:08:00PM +0200, Andy Shevchenko wrote:
> Since we have a common x86 quirk that provides an exported variable,
> use it instead of local DMI table match.

Acked-by: Mark Brown <broonie@kernel.org>

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l53wACgkQJNaLcl1U
h9DIrwf6AsprEx6YCK24bZdaV78Npclx27lelAxU1lZFUxtb9LDQpSeDKlfMxwS6
y6Onh8a4whYq1rRKC5VhhhIxlmRnZStNOPj67ZAguIOGYudh3gLGdptGDbfYJ4uP
iCqZM8VCvStSlRUBEhrrBXjgXooJSX3YbarO8bt2Z7IAxi9yitgXW69aAHqy5j51
PxWPDL5AyAVxnBCWUdxbeb3h3NRE6q5DdaCZGbNrAjxky0tAXKPfWHQ/7MfqQlYa
ET8Z6S4iEt0JMiTQot8TIHKoTlv6mhQpfnciriNDxxt9bIAnUFv0Qxqw4+Y1tdE5
SwoeSenvdt67uSM6SFXKP+Nj8vrneQ==
=OzLd
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
