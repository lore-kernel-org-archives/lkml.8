Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F16FC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3244D2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581508759;
	bh=IVTsnwcPvRGMFvND6nmMakxl63Cdn8QdhLHDV3yh2Po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ycwOK+S1bBBMk1/t2cyxvCK76NMHfWV/QI8zaMR/0wjrCnVpmCy709FRn+fRxzpCF
	 KMxn8RikdLjFw7P+W8ROGuirMa4U7hO1Dx8iSlO874dNcdzKn7E7KYD9pBABYK3Y/w
	 TIVAL/GhnUZ9DFT+OYVKRul/LJob9Jpr/JdHYMgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgBLL7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:59:18 -0500
Received: from foss.arm.com ([217.140.110.172]:60078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgBLL7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:59:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B358A30E;
        Wed, 12 Feb 2020 03:59:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37AB13F6CF;
        Wed, 12 Feb 2020 03:59:17 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:59:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Sridharan, Ranjani" <ranjani.sridharan@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chiang, Mac" <mac.chiang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        "Lu, Brent" <brent.lu@intel.com>,
        "cychiang@google.com" <cychiang@google.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: da7219: check SRM lock in trigger
 callback
Message-ID: <20200212115915.GC4028@sirena.org.uk>
References: <1581322611-25695-1-git-send-email-brent.lu@intel.com>
 <AM6PR10MB2263F302A86B17C95B16361280190@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <SN6PR11MB26702B2E7E5F705425517F4897180@SN6PR11MB2670.namprd11.prod.outlook.com>
 <855c88fb-4438-aefb-ac9b-a9a5a2dc8caa@linux.intel.com>
 <CAFQqKeWHDyyd_YBBaD6P2sCL5OCNEsiUU6B7eUwtiLv8GZU0yg@mail.gmail.com>
 <2eeca7fe-aec9-c680-5d61-930de18b952b@linux.intel.com>
 <CAFQqKeXK3OG7KXaHGUuC75sxWrdf11xJooC7XsDCOyd6KUgPTQ@mail.gmail.com>
 <c9dbcdd8-b943-94a6-581f-7bbebe8c6d25@linux.intel.com>
 <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Content-Disposition: inline
In-Reply-To: <AM6PR10MB22630C79D08CE74878A6A096801B0@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2020 at 10:16:54AM +0000, Adam Thomson wrote:

> So far I've not found a way in the codec driver to be able to get around this.
> I spent a very long time with Sathya in the early days (Apollo Lake) looking at
> options but nothing would fit which is why I have the solution that's in place
> right now. We could probably reduce the number of rechecks before timeout in the
> driver but that's really just papering over the crack and there's still the
> possibility of noise later when SRM finally does lock.

This really needs the componentisation refactoring I think, that way we
can annotate individual devices and links with what they need rather
than essentially guessing about what works most of the time which is
more or less what we do at the minute.  Like you say as things are at
the minute there's a lot of crack papering going on.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6JMACgkQJNaLcl1U
h9DlEAf/fBK6srxM34hrUWp+RSB46rzwi3VulG9ye6DrZYE18FThapihpLCSCPw5
UUFuOf2G/w+8hcwf22J0gh7LZky8ReBsMWiFahKijYInxiEB6ioRdgKj6o+XoSR3
K5f7JP8QGkbkclgTpjytuIFWw6C32pGyojS2pL82ZUbbhRXPik9NWAp+UOXTWp4Y
7nAT+kvot9ixAECLYwT3mhXYRtouMUU1jXD9nlDMoViI5AC5+OKfItlBpL/Pu1+k
5a8bFXfRuhRqXN0zubbL7gfS81FyYS1PLZ2dWFWR9hEFSHJrblGW5dFLQw1hiie/
1U75ZlU+4ns6rHFlV8jHNTRK3XUH+w==
=V8px
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
