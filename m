Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E76C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6C624673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582224353;
	bh=if96Mc/y1YmJUZ3lpkYFyxgKXgKYudO9S+kOERoBIyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p2s/dDd3NAI3k3VgKQbN6ef/Wqm3aUF/Q+Fzja0wXBAL18p5wRdHOQ38ZWCzdWbkk
	 a8nRv4cg+PBKpnbAo97iCdVi1QlOuYV887VnhJSp8eZv1Q39ooVicWxM7nPBEbXRIz
	 7fbSgGVGCOrg7S/KXJMmFKuZzC2jmwC4LfsXDUzI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBTSpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:45:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTSpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:45:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB1D230E;
        Thu, 20 Feb 2020 10:45:46 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4263F3F6CF;
        Thu, 20 Feb 2020 10:45:46 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:45:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound: Replace zero-length array with flexible-array
 member
Message-ID: <20200220184544.GG3926@sirena.org.uk>
References: <20200220132420.GA29765@embeddedor>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Content-Disposition: inline
In-Reply-To: <20200220132420.GA29765@embeddedor>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 07:24:20AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:

Acked-by: Mark Brown <broonie@kernel.org>

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O09cACgkQJNaLcl1U
h9DNEgf7BrKTKxuld5LZ1ebYWQJO+bT5mSr17NAdXnhaLEAAeUHxhfI5Ly6MIjJm
Ljf8W2CHdYozlV3dzreRlVvjGdalVC8VGeF9HN1RXX2MTezDOQ5ub12AGbyLohp1
sNU6Ha8v/4P6XulizOdBNUbFmRCN1nVYSiRlxClmcU6rx0gvqt6V3ESYe5EGOUr8
EtuCOc7oHDe3neSdQwxZZgM0xWkmATg9k0HHF7b2lr9iR5GMKBdZWOAxl83kX9ac
a8kUwJMR+e8YOTbzY+8WCmjf7QSlmu5GOSS/AtM02zpADdHfcqfi649gelkmP4YR
y9AUYhYmxJcLsSK2z58Gms5JyYOLrQ==
=x8F5
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
