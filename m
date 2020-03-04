Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05FBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819F621775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583350110;
	bh=cbKeshrW7BI/dDw2hjMfEtgr8prbIHBJLGREJIVzAYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hAoU3ZMeXQcuxYLAa453Un5MGaIwuiyOBogs2Mujb6ibVYdCNDlT7fdZbj4gm1wwl
	 0rKRh55DEt114gokM8qkxwttCJSZcJJugxGJ7Udp+vaAPdrGdGhZg4TyQPnNU2t3pf
	 YQUJ4/Ibh01aa931swJ9icxGu4yE+catjLYZ7K1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgCDT23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:28:29 -0500
Received: from foss.arm.com ([217.140.110.172]:38772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727137AbgCDT23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:28:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B71551FB;
        Wed,  4 Mar 2020 11:28:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 375AF3F6C4;
        Wed,  4 Mar 2020 11:28:28 -0800 (PST)
Date:   Wed, 4 Mar 2020 19:28:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Lars =?iso-8859-1?Q?M=F6llendorf?= <lars.moellendorf@plating.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Question about regmap_range_cfg and regmap_mmio
Message-ID: <20200304192826.GG5646@sirena.org.uk>
References: <d2eb2248-0120-7b0f-9bcf-4f9c71954117@plating.de>
 <20200304120321.GA5646@sirena.org.uk>
 <61cb178b-dc9b-12fb-0443-d38e0c43e046@plating.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <61cb178b-dc9b-12fb-0443-d38e0c43e046@plating.de>
X-Cookie: Tomorrow, you can be anywhere.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2020 at 02:28:25PM +0100, Lars M=F6llendorf wrote:
> On 04.03.20 13:03, Mark Brown wrote:
> > On Wed, Mar 04, 2020 at 12:25:09PM +0100, Lars M=F6llendorf wrote:

> In `__regmap_init()` `_regmap_bus_reg_read()`is assigned to
> `regmap.reg_read()` if there are no `bus->read/write` functions, else
> `_regmap_bus_read()` is assigned.
>=20
> `_regmap_bus_reg_read()` calls the `reg_read` function of the bus
> directly, `_regmap_bus_read()` instead calls `_regmap_raw_read()`.
>=20
> `_regmap_raw_read()` in turn calls `_regmap_range_lookup()` and
> `_regmap_select_page()` which do the paging.
>=20
> `regmap_mmio` does not contain `bus->read/write`, but does contain
> `bus->reg_read/reg_write` only.

This is basically just saying that the paging is done in the bulk I/O
code only (partly for performance, partly since we may need to page in
the middle of a bulk operation), not in the per-register I/O paths.

> >>   - Enhance the current `regmap-mmio` implementation so it does paging
> >> and submit a patch?

> > That's not really possible since MMIO never writes the register address
> > to the bus

> Sorry, but I do not get why this shouldn't work with MMIO? If I
> understood the code correctly in  `_regmap_raw_read` the address is
> checked before it is used anywhere. If
> `_regmap_range_lookup()` returns a range it does the paging, i.e.
> translates the virtual address into the real address
> (`_regmap_select_page`). If so the real address is passed to
> `bus->read/write`, else the given address is used directly. Do I miss
> something here?

The plain read and write operations sit at the bottom of a stack that
(especially in the write path) deals with byte streams rather than
parsed data, they're only differentiated for read since there's a mix of
read and write I/O in a read operation.  Since for MMIO the register is
never part of a byte stream you'd need to contort things to parse the
address back out of the byte stream which is not great for abstraction
and likely to lead to bugs as different parts of the stack get confused
about what is handling endinaness and register size issues.

> >>   - Write my own `better-regmap-mmio` implementation?

> > It's not clear what that would mean.

> Maybe for some reason the current MMIO implementation should not be
> touched, or paging for MMIO is not wanted?

That doesn't really answer the question - what such an implementation
would look like?

> > You could also look into making the paging code not rely on explicit
> > register read and write operations.

> Maybe it is sufficient to implement `bus->read/write` as a wrapper of
> `bus->reg_read/reg_write` in regmap-mmio.c?

For the reasons outlined above that's an abstraction problem.  This is
not something that should be being done in the physical I/O code, that's
not the right layer of abstraction.  Like I say push it up into the
core.

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5gAVkACgkQJNaLcl1U
h9Axzwf+N5C5kFTyf1wTgILDQ5pGMQA4HFn7QDIxvupDAvKvf+h/vTbkOqhbC2hd
cJ6/ae2Z9nz9avL4Tub2gwfQfFfGMUjI+EOtprmTbA3gGuFP52HdDUY14PRW/l0s
F8/vu6WvrgOWjluTqRbPb0+jLewK14RZbSszfZn3A6Wi9DLqIcoQeylk9qJQsLYS
7A2QPHstHPqcldfK9KNIZ5jiIpe6cdgGWvFbgrgFW08ifXugLGou4pqCjYfvIFFn
W66wVq/qkl/fE6dtZre7KT5ev8VKFMvgOczXwbsmifVmkAoNe08Qx6zYeKuBz7bu
QDYF2gBKNJyWjI4n02ImCaIPxx/8fg==
=R7GU
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
