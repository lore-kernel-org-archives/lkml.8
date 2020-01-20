Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A7FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0627821835
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579543791;
	bh=k6FV0nRUFzUgcornDiEGHpX+J6A1//o1o1RPNObqfz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0xtP9KE7+7ZZsZrB69OlEiqPJPD2tGRpXtLCJBRz9LNpAprEPH7hG52gJM0J4v8mr
	 fdNZjdRgVgDMc6V3aMs1L+oYm3XBkMO19JL3vI8eDrcxLQfEjdR6duevJ/DqB7x/qr
	 vp4jCWjmvMsFcc/O8joMimdnj+1iJkAUdZorSbFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgATSJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:09:50 -0500
Received: from foss.arm.com ([217.140.110.172]:35374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATSJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:09:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DBE031B;
        Mon, 20 Jan 2020 10:09:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEFD43F68E;
        Mon, 20 Jan 2020 10:09:46 -0800 (PST)
Date:   Mon, 20 Jan 2020 18:09:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ben Whitten <ben.whitten@gmail.com>
Cc:     linux-kernel@vger.kernel.org, afaerber@suse.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] regmap: stop splitting writes to non incrementing
 registers
Message-ID: <20200120180945.GL6852@sirena.org.uk>
References: <20200118205625.14532-1-ben.whitten@gmail.com>
 <20200118205625.14532-2-ben.whitten@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B92bTrfKjyax39gr"
Content-Disposition: inline
In-Reply-To: <20200118205625.14532-2-ben.whitten@gmail.com>
X-Cookie: I invented skydiving in 1989!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B92bTrfKjyax39gr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 18, 2020 at 08:56:25PM +0000, Ben Whitten wrote:
> When writing to non incrementing registers we should not split
> the writes in any way, writing in one transaction.

That's not an obviously true statement.  If the user is intentionally
writing to a non-incrementing register and intends to stuff a block of
data into that one register via regmap_noinc_write() then sure but if
we've come in through a path that isn't specifically for the device or
is using one of the generic APIs then it's going to expect that the
framework will hide the unfortunate choices of the chip implementors and
split the I/O up.

--B92bTrfKjyax39gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4l7OgACgkQJNaLcl1U
h9B15Qf/eSKG10E4bNRPd6i40jrJnX38xv0NgOBdEXse9NCOM4GO/nOlN8181OPu
I4WJUiOUbsUCvfe355DjI717UgUCfUk3e85UpfOl3DS2/wT0tFzhGb2KHhsUXvWW
/CRk+Wft/YX107oEBhTitJW7AaUfN2p5qwFCFvIEBi3eUPDdqbblpDbDfXrlzzfX
61v73NlEeQPRWv1yELBpdrOG9vM/8mJP3tMLLjxOSmdexYODKW6vbkVsRBHpef5/
LgkDTAFcFawODctD/TiZBY6vYGul30E7e9jGjZUOWhE+mH0JjJkWi6z6NAWMAJt1
jNFXHMKT2h4LZgepfx53dc+xGdsOZw==
=MhbO
-----END PGP SIGNATURE-----

--B92bTrfKjyax39gr--
