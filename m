Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F080EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51D6206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594200625;
	bh=rPde1yrtoaYsrjcQMK0JSsdDmzQWg+KzFioOvIlutmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jo32+Z1Po7fwPKgvbaeOWC0y7zSLlUP99OZ/Ez7Q8ptdRatps2QnrUBuYDyVbSBFv
	 QDQ1w85HtAf4jI8hb42gJbYpOQ6y25q3lBeGla9Xbj5qEJtTplprOyAn5kvjn4nLBj
	 BTsCPXdbp/jIRdM4cc0+uxats384UFDOK0Hgh2yM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGHJaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:30:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbgGHJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:30:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D792067D;
        Wed,  8 Jul 2020 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594200624;
        bh=rPde1yrtoaYsrjcQMK0JSsdDmzQWg+KzFioOvIlutmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sk6tYvQEfMiVVgAqJTvZN0gzFNgeijJ6iBR9KL6jJYQVL3Shb+UhbcJLgK+lU8Wfy
         OGNAhzYKUK5BNUUSedNX10GZR5U5LaWdOJ/M10ismK95wrc5FUaBgNBKhS0BXTuuQE
         dXOXCPPxNh7JFrcIP34MVxHXb3nLWYuTJ978Za7Q=
Date:   Wed, 8 Jul 2020 10:30:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     corbet@lwn.net, ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, Dave Airlie <airlied@redhat.com>,
        torvalds@linux-foundation.org
Subject: Re: [Tech-board-discuss] [PATCH v2] CodingStyle: Inclusive
 Terminology
Message-ID: <20200708093018.GA4655@sirena.org.uk>
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 12:23:59AM -0700, Dan Williams wrote:
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.

Reviwed-by: Mark Brown <broonie@kernel.org>

> +'host/{device,proxy}', or 'leader/{performer,follower}'. Recommended

We could have controller as well as host.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FkikACgkQJNaLcl1U
h9ARbQf/epm0DKg2MJhGxaC8/qYrQcvvk33ZowHtxkiYgMuDA3wdpXst2NAfFJ6Y
OqyNXN/5toHgj3nYn02sfRpYKQaWtYEQlu70nRkaywJ6o44uhk7RBQ3XZ/QKzp4e
AhuENeaoPDICp+h+d5bWrJsPZFbhQ1EoAZ6MS+OG0MzSvXbQ3g4AjSjKQyAtnMXm
m4uI2MOSLrf0IIoo0yPyeds/xVOim1GHZa3IBVaUAu2Aae5HI257nGlkzxO0pVir
QFhO7f9J0OS9efmHAoPuOFk/0ZvUjn0Yspc8o6sKWXoVX0hgXaRU20nVQ82kRgcs
G8azFKoSgB2bhv7pozMVift+8Zt9kw==
=PIk+
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
