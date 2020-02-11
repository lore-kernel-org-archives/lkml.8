Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E4C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCDA20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581420018;
	bh=KLk785w6bL5g+iuSGugC9ybh793dOVnMReV5MwvF7gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=veRQdO41oseTGqgmPI3QDuB5kHGGGCBwJH1YaIk/hgPZokhwzxFq7JqEsHcdlIhrS
	 yggcjbn1TQbuQOvrfaEDRyV7ctwQM/vmndLGKKcsBqiAooSFS5t5RCojupV6ZcDjXf
	 JDn1xLCCUPgix9TbZ2eJD0K0hhPT92JDp6jM/Ltk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBKLUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:20:18 -0500
Received: from foss.arm.com ([217.140.110.172]:44266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727728AbgBKLUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:20:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A62C431B;
        Tue, 11 Feb 2020 03:20:17 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9D73F6CF;
        Tue, 11 Feb 2020 03:20:17 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:20:15 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-ID: <20200211112015.GA4543@sirena.org.uk>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
 <20200210155611.lfrddnolsyzktqne@linux-p48b>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <20200210155611.lfrddnolsyzktqne@linux-p48b>
X-Cookie: Hire the morally handicapped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 10, 2020 at 07:56:11AM -0800, Davidlohr Bueso wrote:
> On Sun, 09 Feb 2020, Andrew Morton wrote:

> > And...  are these patches really worth merging?  Complexity is added,
> > but what end-user benefit can we expect?

> Yes they are worth merging, imo (which of course is biased :)

> I don't think there is too much added complexity overall, particularly
> considering that the user conversions are rather trivial. And even for
> small trees (ie 100 nodes) we still benefit in a measurable way from
> these optimizations.

As I said in reply to the regmap patch I'm really unconvinced that any
benefit will outweigh the increased memory costs for that usage.

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5Cje4ACgkQJNaLcl1U
h9BI3wf/RM/7hz/NcSo1FY7gwc9ios3UpRitKEzeTHBNDzL3Moju+iJr4Jxf0sPc
BpvuaCegd/t8SRMrCvPkkqOrb4fk837cA/TS4rMykS85IbZzxU6peH9CeFz2d0Lb
HNlXKgjrLurotci9uZEdt7tMQG0R5x4LLYe9QWz6qsAe5MzPJC2fc+6vedv3iXpq
vHZz+VwLYtJdaLV71J2sRLDIdla9Y2jItZZp5zUc+e8AG3usbcGxIMZ9lQw6UfhA
v610j9wj5GzHbJoixRliOUSI0pGWh5co1h6Q3XIzmItnclRHEssKG+5FrtVFyPoN
7B96qQt/upVFFEBozb4IxbB53+8ExQ==
=cavX
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
