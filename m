Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EFAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928FE20853
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591707015;
	bh=mb5BHpg+BlUVM5LIoAF9EaqEf3JUMMSjWdvZrwmh12o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hh1IsOr+Hm+8rEuVpRu/djUc7mRN21OrSvngOUDt6545r4hmxA4C44f3JZ3cDLbyx
	 iB4uJIBKvK30NCTWp+C14nY2FivIeL6PGdFbqwcyTBdfl9eMJqACOVQbtKeqz2A7Y/
	 Afu/STixDHMcZsbySyIxgwlKOD5XRT7GoL7Ryhs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgFIMuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbgFIMuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:50:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DD05206A4;
        Tue,  9 Jun 2020 12:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591707010;
        bh=mb5BHpg+BlUVM5LIoAF9EaqEf3JUMMSjWdvZrwmh12o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNfcud/2EeiI0vJXbs00wfklZgUQEggKGn7xblQN/w+qUYxzQn5XiaSyx8eXHvzhw
         3LTuY1EMw4fVrZ6VlNlDAH5nT2bHcG4amnTwFNMCbWbgMvM4yHY+Fj4KQqmKNgAKN/
         wlVy9k3mxN67vHj69NPv0LPy2meEp3hoUBoDi+qE=
Date:   Tue, 9 Jun 2020 13:50:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jiri Kosina <trivial@kernel.org>,
        "open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/17] drivers: regulator: Fix trivial spelling
Message-ID: <20200609125007.GD4583@sirena.org.uk>
References: <20200609124610.3445662-1-kieran.bingham+renesas@ideasonboard.com>
 <20200609124610.3445662-10-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Content-Disposition: inline
In-Reply-To: <20200609124610.3445662-10-kieran.bingham+renesas@ideasonboard.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 09, 2020 at 01:46:02PM +0100, Kieran Bingham wrote:
> The word 'descriptor' is misspelled throughout the tree.
>=20
> Fix it up accordingly:
>     decriptors -> descriptors
>=20
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

For changes like these that are a bunch of trivial fixes independent of
each other it's generally better to send them independently rather than
as a series since only having part of the series (as is the case here)
usually begs questions about dependencies.  I'm hoping there aren't any
here and will queue these...

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fhX4ACgkQJNaLcl1U
h9B9nQf9FwzB5vMSW8IRVFyyLTJL2DnPj/ZQNSsCDnVu5DnIAhT15EjuZKPfDy1y
/7mBvH1pdxlrneDLatcc732i4hMWSr0VdypgXYgauc7IV6mL5exIXNZqS7yTe/7X
VL7LxPR97oetlOpjRvwOjme3dwx+RqG1fQ4Wej1aPowIMmTN7eEcmiVhnQwy1l3j
xIj7PTBgVT/B5iSjTNPFbhVxFsfNJjkNwgrbG5TwH/p0g+/uqvVIjmMycaNqlg+i
4cFbtIiHr+hPIvmZoNoD4fyxv8TPbe8OxYTXnfOtYdBiM7E+JXU33n9e9uTVNDK6
Lm9LCoA+9DagbXmca9dfbRi+5tk/VQ==
=NQ5y
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
