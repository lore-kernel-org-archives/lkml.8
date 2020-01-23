Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016E3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2FD2253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579781372;
	bh=4/4x2zrhD5Be7XKo3o6zGgq7CvPSF24+91f7wKdOObM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rBjhlPl5EVHEUz+YMR1/bVS+EBIS0fUk1U9R6sh94UEfj7TYCAP1W8yJWLVJXwIXv
	 UgOvkWuz5i72inS+4PD/L+lirOp28lkqN1z4zuTl/hIX6TeYeK1GeTET0/lbFnwXaE
	 p4yZ7BtgyNI9yMLQetyA/4Cpi8SAVMJteDD/71Eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgAWMJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:09:31 -0500
Received: from foss.arm.com ([217.140.110.172]:38672 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWMJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:09:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4BBC5328;
        Thu, 23 Jan 2020 04:09:31 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01673F6C4;
        Thu, 23 Jan 2020 04:09:30 -0800 (PST)
Date:   Thu, 23 Jan 2020 12:09:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH RESEND 1/2] regulator: arizona-ldo1: Improve handling of
 regulator unbinding
Message-ID: <20200123120929.GB5440@sirena.org.uk>
References: <20200122110842.10702-1-ckeepax@opensource.cirrus.com>
 <20200122131149.GE3833@sirena.org.uk>
 <20200123092639.GC4098@ediswmail.ad.cirrus.com>
 <20200123114805.GA5440@sirena.org.uk>
 <20200123120240.GD4098@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20200123120240.GD4098@ediswmail.ad.cirrus.com>
X-Cookie: ((lambda (foo) (bar foo)) (baz))
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 23, 2020 at 12:02:40PM +0000, Charles Keepax wrote:

> I am more than happy to do the leg work if we really don't like
> this solution. Do either you or Lee have any thoughts on my
> selective MFD remove helpers? That seemed like the most promising
> alternative solution to me.

That's my first thought if you need to control removal order which is
basically what's going on here.

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4pjPgACgkQJNaLcl1U
h9Di+wf/QzyKud67CmftD46xQMkjZjkU2gbmqkitDbuJOuipbmsdSUHDVq5cNPkz
u4ziJUNrR73n6DTevWU4mslN0TaSJM6kFrd0DWWn6+uZpcUTB7fNITZv3K85H9Tj
tIHFqy07S/fOxJjdVUZab2sBkh8d3q6BbbDubAN+EZOHghg0pA3horGAOOLMg3aA
mR5Wlawv7VJDSfgOuFCG4J2fTohNC6zxwuczacO/SjOtxssUJkvRZHscIC6CqBmG
xsN9mRn/qZIzw6BDI8r8YhCRYcvslOnFQKCg0TiM3ejwog2uof0OYHpxo4WzTBVL
074WnIkvGca7/WuEj4ICJ32K5Bn16Q==
=L8iY
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
