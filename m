Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DA0C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 201152070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340322;
	bh=pBAEbAcPqGFrnj8nhGibaTfeRIck+1c9ppdJsJDT4cQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SN3m5Mx7qXQ5+juT8pTCmQtN5jLZF4XXmbh4jhzFNzNVgbBoEEtHjKp6wG0gMZp/e
	 3f060k6MZ0IUH9/ijZsiQpxMeHrnK1sQN1s26rASTyW3UP1sMQSoerqHP1NoIJP1o+
	 9TVYkUsEcgFREINgQjoZcqvFomF55c9Hxwavx8Q8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgBJNMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:12:01 -0500
Received: from foss.arm.com ([217.140.110.172]:32958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgBJNL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 08:11:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 498531FB;
        Mon, 10 Feb 2020 05:11:59 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C11273F68E;
        Mon, 10 Feb 2020 05:11:58 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:11:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 3/5] regmap: optimize sync() and drop() regcache callbacks
Message-ID: <20200210131157.GE7685@sirena.org.uk>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200207180305.11092-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FEz7ebHBGB6b2e8X"
Content-Disposition: inline
In-Reply-To: <20200207180305.11092-4-dave@stgolabs.net>
X-Cookie: Avoid gunfire in the bathroom tonight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FEz7ebHBGB6b2e8X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 07, 2020 at 10:03:03AM -0800, Davidlohr Bueso wrote:
> At a higher memory footprint (two additional pointers per node) we
> can get branchless O(1) tree iterators which can optimize in-order
> tree walks/traversals. For example, on my laptop looking at the rbtree
> debugfs entries:

It's not clear that this is a good optimization - we're increasing the
memory footprint for a bit of performance but our performance is all
relative to the I2C or SPI I/O we're most likely all in the noise here
whereas for larger maps the size cost looks like it could be quite bad
(but equally your case looks to have a lot of 2 register blocks which is
almost the worst case for overhead so...).

That said the code is fine so from that point of view:

Acked-by: Mark Brown <broonie@kernel.org>

--FEz7ebHBGB6b2e8X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5BVpwACgkQJNaLcl1U
h9D9nQf/UDELw4nM+mVlqjci3E7CLgv2DvqtZdkaYcs/g8i10jrF2mZBquvaUwUX
DpgA8imJ1niA81szUWxxUjbMXLT/FRbVZBHAGDK47n1b6E0j1k1K35eq9nvsgchW
Lg6NaXfqNFgmm4TCwKbS+eQZANklImbERJkdELSFasEwi2I2WETW1T2/TmHxGO3j
orStHxYCiSIobLd+kXwzC/gcFg5H17s9zRpDDNqr+qIK/XMkEzoXckoVCE4bDIS7
k9NX3PD64PKfTSjgsfCbJmhQUCvSqo02zgUkFfHOzBSE4YCTf0CijLV4wwlnaNuM
7SiD49YTlzecyrzgmFA2iQEgp/Jbww==
=utDt
-----END PGP SIGNATURE-----

--FEz7ebHBGB6b2e8X--
