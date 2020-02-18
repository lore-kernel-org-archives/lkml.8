Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF3FC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D750C21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055242;
	bh=NWb+gXUnBvpclOL5PBkpmOH+QE4UlaypuXop/MhDIHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Hs9VDxX5LSD+YgLLtFLJD7GuJ5Z/C7ebi6bZyOvwGuihJYGACAtM/dhX/c2ZTPMKT
	 tPiIIlyo0OIr8zOOKMdw9jdju9N3b/+jDS5+0iGOncfk7C87vdmp8Yf1xKrGAB8DvD
	 kHawF6Y0p0X2W1ck2Qb6EuwBBvMAkvsdvRIOqGB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBRTrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:47:21 -0500
Received: from foss.arm.com ([217.140.110.172]:60190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726346AbgBRTrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:47:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EEB3631B;
        Tue, 18 Feb 2020 11:47:20 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7148A3F68F;
        Tue, 18 Feb 2020 11:47:20 -0800 (PST)
Date:   Tue, 18 Feb 2020 19:47:18 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ASoC: tlv320adcx140: Add the tlv320adcx140 codec
 driver family
Message-ID: <20200218194718.GO4232@sirena.org.uk>
References: <20200218172140.23740-1-dmurphy@ti.com>
 <20200218172140.23740-3-dmurphy@ti.com>
 <20200218192321.GN4232@sirena.org.uk>
 <0faf0bfe-6186-59d0-e800-8523a33044dc@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jozmn01XJZjDjM3N"
Content-Disposition: inline
In-Reply-To: <0faf0bfe-6186-59d0-e800-8523a33044dc@ti.com>
X-Cookie: No alcohol, dogs or horses.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jozmn01XJZjDjM3N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2020 at 01:32:05PM -0600, Dan Murphy wrote:
> On 2/18/20 1:23 PM, Mark Brown wrote:
> > On Tue, Feb 18, 2020 at 11:21:40AM -0600, Dan Murphy wrote:

> > > +	if (unlikely(!tx_mask)) {
> > > +		dev_err(component->dev, "tx and rx masks need to be non 0\n");
> > > +		return -EINVAL;
> > > +	}

> > Do you really need the unlikely() annotation here?  This is *hopefully*
> > not a hot path.

> I was copying the code from tlv320aic3x.c as suggested by one our audio guys
> here in TI.

> I can remove it if you desire

It'd be better, they don't really help anything outside of fast paths.

--jozmn01XJZjDjM3N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5MP0YACgkQJNaLcl1U
h9Dh9wf+J9qWfmd4wHvZLky/0BGP7rVl7P7KEKh++MFibZHsmMtZTT3Tct5YwT6Z
8+a1xAo5dmAz7jbvKvdmJ0+umNHxa0fOwgJusV0p5jU+BwFNNYLUsr3yTf+LRMly
AUaJ7EsuGPdyA5Z3D7KNyaiOrqiy2SCRcJdOwiJky3tIErrbDQ4b7M1ZLSnR4jW1
qyPVAXVlf9Qfy5op5Rb2auSX50TPj5jHwo2wD2ui6/jr0jFs3p1Y/DrLVBNCjeXM
sY22Sz39dw6Dtts+fpWBC+HHl4CTpMWxYah+ZIYLliMzvViKExRYy1ZWPcn1K51Q
q6y+lLbamcgW3ylYxn1BK4BJEhzMGg==
=YobV
-----END PGP SIGNATURE-----

--jozmn01XJZjDjM3N--
