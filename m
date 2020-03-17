Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57675C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C49220735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584463003;
	bh=WWrSnX03rWKs4UYsGvn2UrJZv6jABKt7ucAm8ArZ3VA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QuKjHbodLE63xD0A2pfVTIvON/cI5ag+dS6F8ko4twERtyTN18hDsTv/P/8iZ598a
	 3grm8uBTNXGapj/xm1/7AsovxA9qnGcQbdvi/QzuwwERUzP6w3a55KRWreMKKdPCig
	 uBd2Ul90L1CiCyg2oRURrHqdtU8E3Zkxjwn/Rxxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgCQQgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:36:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbgCQQgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:36:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F221030E;
        Tue, 17 Mar 2020 09:36:40 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7559A3F52E;
        Tue, 17 Mar 2020 09:36:40 -0700 (PDT)
Date:   Tue, 17 Mar 2020 16:36:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200317163638.GI3971@sirena.org.uk>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
 <20200317135719.GH3971@sirena.org.uk>
 <20200317151813.GA16579@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <20200317151813.GA16579@willie-the-truck>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 03:18:14PM +0000, Will Deacon wrote:
> On Tue, Mar 17, 2020 at 01:57:19PM +0000, Mark Brown wrote:
> > On Tue, Mar 17, 2020 at 12:43:24PM +0000, Will Deacon wrote:
> > > On Tue, Mar 17, 2020 at 12:10:51PM +0000, Mark Rutland wrote:
> > > > On Tue, Mar 17, 2020 at 07:47:08PM +0800, Hongbo Yao wrote:

> > > > > -	return arm64_use_ng_mappings;
> > > > > +	return arm64_use_ng_mappings &&
> > > > > +		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);

> > > This probably isn't the right fix, since this will mean that early mappings
> > > will be global and we'll have to go through the painful page-table rewrite
> > > logic when the cap gets enabled for KASLR-enabled kernels.

> > Aren't we looking for a rewrite from non-global to global here (disable
> > KPTI where we would otherwise have it), which we don't currently have
> > code for?

> What I mean is that cpus_have_const_cap() will be false initially, so we'll
> put down global mappings early on because PTE_MAYBE_NG will be 0, which
> means that we'll have to invoke the rewriting code if we then realise we
> want non-global mappings after the caps are finalised.

Ah, I see - a different case to the one originally reported but also an
issue.

> > That is probably a good idea but I think that runs too late to affect
> > the early mappings, they're done based on kaslr_requires_kpti() well
> > before we start secondaries.  My first pass not having paged everything
> > back in yet is that there needs to be command line parsing in
> > kaslr_requires_kpti() but as things stand the command line isn't
> > actually ready then...

> Yeah, and I think you probably run into chicken and egg problems mapping

The whole area is just a mess.

> the thing. With the change above, it's true that /some/ mappings will
> still be nG if you pass kpti=off, but I was hoping that didn't really matter
> :)

> What was the behaviour prior to your patch? If it used to work without
> any nG mappings, then I suppose we should try to restore that behaviour.

I'd need to go back and retest to confirm but it looks like always had
the issue that we'd install some nG mappings early even with KPTI
disabled on the command line so your change is just restoring the
previous behaviour and we're no worse than we were before.

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5w/JYACgkQJNaLcl1U
h9Dl1wf9GX3p/adfELLXBzUuhsdtD5YuF5wPbqLNWia/xE1GxwQwLTICvYRzF5UH
oQ4z9xdwIxtBDXMcOre3yio7NphtC3i0zLTE0TBK5yj2xidtONZkV2hFh/gMFkO1
AJ798O5jj5gL/oaHIYEA/iuKHi9wj2qA7iXiBIpq8v5z9MkDHz1CFAXYrLKAdcaU
0mEhWJrh5xTycRkTY55/+Hegou21QfcXvqcEQq+p2zxJ+dLpt+kQ9C2SsK7/sxkj
buyhcuLV7tUtaW5IrwfyypOpwBR57PTpecCkYGEmPgY51BpHtR9Gp1LBNsC7LbbP
+Ct5O9PmEr9d6wur0BxoHlrKlz+MeQ==
=vYFK
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
