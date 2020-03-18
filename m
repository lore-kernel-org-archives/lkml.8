Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19795C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E15A42076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584531141;
	bh=DCwLDa9CMREm98nGSUNIFZACfzg/R0N7QTZ9y32qucw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X4k6oeURBSGmBhkFxKmYFz2AHKkf6zU8Se3yMEdYDyGVtk8aM+aNOT4Qxfn8p1h0u
	 FJkCySwAoL1WeCsjG0h+OrfUyh+IxAjAUeb1rr173VOcAbk0Cm6LoyxgqfOuoKBHlw
	 sp3JbtwI/Otq4GoJAACqN2rrO/UrDjDYMsEsovK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgCRLcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:32:20 -0400
Received: from foss.arm.com ([217.140.110.172]:48692 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbgCRLcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:32:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DC101FB;
        Wed, 18 Mar 2020 04:32:19 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2D853F534;
        Wed, 18 Mar 2020 04:32:18 -0700 (PDT)
Date:   Wed, 18 Mar 2020 11:32:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200318113217.GA4553@sirena.org.uk>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
 <20200317135719.GH3971@sirena.org.uk>
 <20200317151813.GA16579@willie-the-truck>
 <20200317163638.GI3971@sirena.org.uk>
 <20200317210154.GA19752@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20200317210154.GA19752@willie-the-truck>
X-Cookie: Oh no, not again.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 09:01:54PM +0000, Will Deacon wrote:
> On Tue, Mar 17, 2020 at 04:36:38PM +0000, Mark Brown wrote:

> > I'd need to go back and retest to confirm but it looks like always had
> > the issue that we'd install some nG mappings early even with KPTI
> > disabled on the command line so your change is just restoring the
> > previous behaviour and we're no worse than we were before.

> Urgh, this code brings back really bad memories :( :( :(

Tell me about it.

> So I've hacked the following, which appears to work but damn I'd like
> somebody else to look at this. I also have a nagging feeling that you
> implemented it like this at some point, but we tried to consolidate things
> during review.

> Thoughts?

I don't think I did *exactly* this but it's familiar yeah.  It looks
sensible and I can't think of any problems but that doesn't mean there
aren't any.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5yBrwACgkQJNaLcl1U
h9AbqAf/evqpddBA32ry7tRUmR0UzfLjJnQcOzDZJA22veN9vfzgRpCHNAbcKIwd
Fe0Su8ymJM2h26R94qkUOhy0ZZR3hyVx/4N8DPtKYQMGkj9iixI4zxNbk3DMKyng
e+6+4+zC2+O+ee2+R7zU081sM9Fw1oAovKckQZ+MQsfF79MUm9d3SaWvI7yIGPau
VkPkKHpc2Lz355RKv1bxi4hsJ6fIR3ktHCNY3VjZxdVLkjf01OcFmWruzEcoQgRo
bRZloTMy+lFes2YRJTZMoGElW4rPcC8pJm/b7qLWQJz8L5i3w291N/h6eqd5yGfb
+X5Pa0pOsZPnZ+ec+gNO8IQLywTehQ==
=Aee1
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
