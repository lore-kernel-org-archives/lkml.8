Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF21AC34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38BC24683
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582128294;
	bh=JgJ/vrMOiRMDUW3ju7uoxCx5v6yF1jGNqosrYOSOeIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uUgJfzRzAvmEd9Hl2Ok0uS/PbAi3P7BsLZPhgOr7buctUO22N8PJtJniSu53YacU3
	 nWq2PulCtPfTV+a/Ayr0he5GpcejebAWWP8ouxWsu6GhWLxJRUfCqrj9TII5sbqMio
	 mD+qH3sfH5G+uFJ3KOB0ZP5c5mLH2BIyxarZcmyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgBSQEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:04:53 -0500
Received: from foss.arm.com ([217.140.110.172]:51850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSQEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:04:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4B71FB;
        Wed, 19 Feb 2020 08:04:52 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D7A3F6CF;
        Wed, 19 Feb 2020 08:04:51 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:04:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: simple-card: switch to yaml base
 Documentation
Message-ID: <20200219160450.GE4488@sirena.org.uk>
References: <87blq1zr8n.wl-kuninori.morimoto.gx@renesas.com>
 <20200219155808.GA25095@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline
In-Reply-To: <20200219155808.GA25095@bogus>
X-Cookie: FORTH IF HONK THEN
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 09:58:08AM -0600, Rob Herring wrote:
> On Fri, Feb 14, 2020 at 02:13:05PM +0900, Kuninori Morimoto wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >=20
> > This patch switches from .txt base to .yaml base Document.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > +  dai-tdm-slot-num:
> > +    description: see tdm-slot.txt.
> > +    $ref: /schemas/types.yaml#/definitions/uint32

> Is there a max?

No.

> > +    description: see tdm-slot.txt.
> > +    $ref: /schemas/types.yaml#/definitions/uint32

> max is 32 or something much less than 2^32?

It'll be much less than 2^32 but could potentially be fairly large in a
big telephony system.

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5NXKEACgkQJNaLcl1U
h9DkIgf+PId+cf44wocBGhUhG5MM+TGNp2SLlvXDPC9TiWLqmdmtPLAYKVQQehxq
v5dH0QMF9b3zI4zcMLX/LjT6UJGptws3jGlVQWTpxdl/4evXXgmYIJ/6F9PFClfl
4qw6j/8DgmnFT4/Z3a/H4bXOjdooxbsU8YQ45xqHjwqlEhIkwWuWVvUCiVUt3wR1
ds7xrNP2XUvckeC90M/OVmv9TDVzjkDEp5MrWRCUIK+ptKWtMDJNKlv5uF+Sh/FU
ICjgBBiL82lrk9eRccdIVjjeXDFOwQMfx4KXW1IwfrbW+ZvAL9gP/UCQo5+pqVnq
fHt1FURjfodweBdVzejev4FDZCWbAA==
=MTvU
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
