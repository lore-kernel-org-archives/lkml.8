Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962E0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C5D206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585568373;
	bh=OFQ9c5MHRq45REPEIsT+s90t0Wzn/ttCQWwUH5pLhZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=df/hRShIq27BHH1qHR5JFVl0rnA6zS2PGUIvNgXwvBhm5hYhRZ1wV+5CUkqgoUuJD
	 WAKJMHfNKYmYH6qRD0PDlqQ1bkVmA3DGr4Qfg9Xv3Jyw3qLOhR38F021MF26WrWFZ4
	 btOVK9pAtVCujYDxk+8eiDSD6gNq7DtYv/jxc/fQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgC3Ljc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:39:32 -0400
Received: from foss.arm.com ([217.140.110.172]:51274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729494AbgC3Ljc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:39:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DE0731B;
        Mon, 30 Mar 2020 04:39:31 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D623F52E;
        Mon, 30 Mar 2020 04:39:30 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:39:29 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200330113929.GF4792@sirena.org.uk>
References: <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <20200330102356.GA16588@light.dominikbrodowski.net>
 <43c098c9-005e-b9f4-2132-ed6e4a65feee@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hK8Uo4Yp55NZU70L"
Content-Disposition: inline
In-Reply-To: <43c098c9-005e-b9f4-2132-ed6e4a65feee@intel.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hK8Uo4Yp55NZU70L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 30, 2020 at 01:10:34PM +0200, Cezary Rojewski wrote:
> On 2020-03-30 12:23, Dominik Brodowski wrote:

> > Seems this patch didn't make it into v5.6 (and neither did the other ones
> > you sent relating to the "dummy" components). Can these patches therefore be
> > marked for stable, please?

I sent my pull request already sorry - once it hits Linus' tree I'd send
a request to stable.

> While one of the series was accepted and merged, there is a delay caused by
> Google/ SOF folks in merging the second one.

> Idk why rt286 aka "broadwell" machine board patch has not been merged yet.
> It's not like we have to merge all (rt5650 + rt5650 + rt286) patches at
> once. Google guys can keep verifying Buddy or whatnot while guys with Dell
> XPS can enjoy smooth audio experience.

My scripting is set up to merge things sent to me as a patch series and
we didn't get positive review from Pierre on any of it with the review
on that one patch seeming to suggest it might also be waiting go go
through a test farm.  TBH I also wasn't expecting it to take quite so
long to get reviewed when it came in, it's been over 2 weeks now...

--hK8Uo4Yp55NZU70L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6B2nAACgkQJNaLcl1U
h9CV2wf/Q5xQ8+z3m3nsFtxyh6rxzmzREsyl9PalMKFUiuKtDDMbT8NcdK8MVX9R
GNOLRjEY6NNV27jQ0mEB+d7VjaDSxUNAkGKx+iQfv2jP/dME2rbqz57GgnFrmNzw
Jj/aGwNhgdHvTVUkSYagDpPOWsV16VcyTDwCdUMjYV5zDmB4S8JRL9uJ0ykoje21
BEaeWvkTfQeEUr7WruNF7cq2jCE0eu/ytauoesMGhQ03uD9QzbszphpZLAhxvUpI
CjCcu4UjmqqXNCtH8m2choviIIbmEJzImaZXKJnMZCObQm4ajxOyoyupL6B+QD2y
ELkwygc8I8AWRlpoOkqtFYDwVm/oGQ==
=wpkO
-----END PGP SIGNATURE-----

--hK8Uo4Yp55NZU70L--
