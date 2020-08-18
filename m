Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D01AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541E52067C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597770646;
	bh=J7IMCR9VGxvuNnH4wgPg8mBRpRL4cmvMOZY0WSvKWms=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uH3oTPzLtIR6TBvoL1nUyhMqBOs/M2fh0YEBPqoqOsbbQV70ZlLVvl62RnLoyPLW8
	 4q81iXCjMU+GSDWEqcCUuXt6gNWDYxWD34eWIzMJcbchgN7etpZ4As0rIa5LnFZlPZ
	 cw7I+ivzJQi8Bvf6Uc0vDAb+hEa3dGvqTUfU+5rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgHRRKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:10:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgHRRKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:10:42 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E6B2063A;
        Tue, 18 Aug 2020 17:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597770642;
        bh=J7IMCR9VGxvuNnH4wgPg8mBRpRL4cmvMOZY0WSvKWms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysoXPfr6h0TtHWQDqxjEXV3OXUQHVeGbdvyGy0t+gk0na63mYj7r8eFeo/OoDKS1r
         HqU+rtl72t9ovmdK3W/1bRJ1ARPib1kT3jCg4uEdloCECPGU8fMCuyUmPy8b6SiQWI
         O7h0pr9c4OiAVosG4cURUGfNoDcrJzpmV4EeeNZk=
Date:   Tue, 18 Aug 2020 18:10:11 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Lu, Brent" <brent.lu@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] ASoC: hdac_hdmi: support 'ELD' mixer
Message-ID: <20200818171011.GE5337@sirena.org.uk>
References: <20200818004413.12852-1-brent.lu@intel.com>
 <20200818143632.16539-1-brent.lu@intel.com>
 <20200818150225.GC5337@sirena.org.uk>
 <DM6PR11MB36421674C19320503D26DABC975C0@DM6PR11MB3642.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3O1VwFp74L81IIeR"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB36421674C19320503D26DABC975C0@DM6PR11MB3642.namprd11.prod.outlook.com>
X-Cookie: You're at Witt's End.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3O1VwFp74L81IIeR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 18, 2020 at 03:22:03PM +0000, Lu, Brent wrote:

> > Please don't send new patches in the middle of existing threads, it makes it
> > hard to keep track fo what is going on.

> Sorry for the problem. Does it mean I should avoid using " --in-reply-to=" when
> sending new patch set?

Yes, please.

--3O1VwFp74L81IIeR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl88C3IACgkQJNaLcl1U
h9BiEQf/ShKme+ABfZ554O96jaOy/4SG+HMYbjm8COsRqE0J48jxiWSVdjX8N7zA
1biJiI3NRqPYVkZ34K6SXTF5tVrbogM5W2SVsyUBHTATywi+4xmY2vNq9gTup5dt
tXsPXtV4jeaeDyVwkk9GnoIylgAx9BHJ7YytytwRZ/d1vok+iZrfWdRALuLpc2F2
dIFwFIeJL0HNB2ClK3lhpyEjbYvXplo8asRpnC19YD6A43r3M/ZL1m0HRyiD18eL
zWBEk9fSHqphMLDQEkPhJ27Dycc5I5BRXL3nKqmyc8jcniXUvII/U3GZ+uyR4Ntf
XPR14ygpAbeMY13F6HmTDnSlCqkPgQ==
=zVQK
-----END PGP SIGNATURE-----

--3O1VwFp74L81IIeR--
