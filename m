Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D31FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E978D2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584639307;
	bh=H6+Zt68q6NpwZY74Cv9pAkKGS0V2iIXKJCpMSO5Ui6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+z49nf2U3dk8/derhRPGssVMbUJE2GP6OCLxjA0IzVMevmCXOI30jAoWotIQFEFk
	 3QQ6/7FKlotgeUlsB84DOTibk2ZY0+RIYTxWkqxpslN7g6A4AC9Sjow5757wgVAI81
	 kFOrqs8LVOqQDQHTNpp3j5wQOh8xJwED4X4u9om0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbgCSRfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:35:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbgCSRfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:35:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB94F30E;
        Thu, 19 Mar 2020 10:35:04 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FD7C3F305;
        Thu, 19 Mar 2020 10:35:04 -0700 (PDT)
Date:   Thu, 19 Mar 2020 17:35:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        kuninori.morimoto.gx@renesas.com,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200319173502.GC3983@sirena.org.uk>
References: <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
Content-Disposition: inline
In-Reply-To: <eef45d20-3bce-184a-842c-216c15252014@linux.intel.com>
X-Cookie: Captain's Log, star date 21:34.5...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2020 at 12:21:47PM -0500, Pierre-Louis Bossart wrote:
> On 3/19/20 11:51 AM, Dominik Brodowski wrote:

> > That patch fixes the issue(s). I didn't even need to revert 64df6afa0dab
> > ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
> > on top of that. But you can assess better whether that patch needs care for
> > other reasons; for me, this one-liner you have suggested is perfect.

Good news!

> .ignore_suspend is set for bdw-rt5677.c and bdw-rt5650.c as well. I don't
> know if that was intentional.

The intended use case is for applications doing audio during suspend
like telephony audio between the modem and CODEC on a phone or
compressed audio playback.  I guess the compressed audio playback case
could possibly apply with these systems though x86 suspend/resume is
usually sufficiently heavyweight that it's surprising.

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5zrUYACgkQJNaLcl1U
h9DIEwf9FLcdiU91qM0+JTKeKiJu3mL1vlW6iLHqYEhaCUw36glNuoopk/9psyqr
hB6DFa3EJketJQe9qh1VdB6kmTVNYALb6XL8xnXG0S5vbviIFlm/cZjCFm+ZJMCK
ugGjuCb6oqwAjWL/0WVtgA+v7Vw7RQYVpiz+3rq3IdXIFKhTvvN/F804ZgMWkCv8
Qu+s/2EZg3gfln2oPzbKfJiL/5rV8ksQf0kptl5oe4PRRrdaGdlHnuSqYem/da5W
c/i3ub8sriBXvmEEgyDh7J8H0qywfe0w/awxnWoagYyZevMIazW8qI3o5oCU3m/J
o2EEEyz0OhGHeadxs4nmhxCASV4xyw==
=IDeG
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
