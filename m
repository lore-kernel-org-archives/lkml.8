Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF5D20885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592477853;
	bh=vY2sHSYgz3FSMcrfG9KrkW9kDXXo8NuTjtpQOy2E/lU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TYv1H25pbPUJIXoBTGizpF4/ZnBvgSRpAwU+/RHoy2iz7NwE+plNtxVTPz7Yr1ODB
	 wBdstsHTgt4s9TUo3t2wOhBaHuo6aGAeKxc9XjwRhevGXwejyE6ocHOpQU0DQWjeqf
	 snqznucDsvocjY4vwzig4tXr+o2Sft5a59NzqjIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgFRK5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 06:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgFRK5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 06:57:25 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 365632085B;
        Thu, 18 Jun 2020 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592477844;
        bh=vY2sHSYgz3FSMcrfG9KrkW9kDXXo8NuTjtpQOy2E/lU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hG3hPcg1C8sz2kAMaDAVmjGxfJ54TyooiyfBeTKxdTtslrW228ozcyIgBnZ6XLaSX
         A4wJXR8wKV47rxN0Fgyz+fIuqydSZMcXM2xat4fEJ+jNjzq1KbqrIKLOSpgpvRuQ/1
         6MGpBbPkMZnN9J3urbv1bFZtfrvHjGPznDLmeMfw=
Date:   Thu, 18 Jun 2020 11:57:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Dan Murphy <dmurphy@ti.com>, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: tas2562: Add firmware support for
 tas2563
Message-ID: <20200618105722.GA5789@sirena.org.uk>
References: <20200609172841.22541-2-dmurphy@ti.com>
 <20200609173143.GN4583@sirena.org.uk>
 <bb7cff87-f814-1b37-c9eb-e68919e3c077@ti.com>
 <20200609175852.GQ4583@sirena.org.uk>
 <414a2d73-6d09-1e76-59c8-4943c0e8f720@ti.com>
 <20200609184734.GS4583@sirena.org.uk>
 <014b85b5-677b-569a-4eb2-74526d3f00bc@ti.com>
 <20200610102920.GC5005@sirena.org.uk>
 <84a6dd5f-cc3e-adb4-ae94-b4fe389adfd9@ti.com>
 <20200617220459.GA2884884@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20200617220459.GA2884884@bogus>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 04:04:59PM -0600, Rob Herring wrote:

> Given bus numbering may not be constant, that seems like not the best=20
> way to match up devices. I'd assume that userspace needs some way to=20
> identify which instance is which already, so maybe there's other data=20
> you can use already.

There isn't really, you're putting stuff in the DT for that - usually as
part of the card binding.  I guess we could use that string rather than
the dev_name().

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rSJEACgkQJNaLcl1U
h9AibAf/ZmP/R1X+W0rdK+oILKnjLxOdozk0Sprm6q6LHFutWUM6iachMjh1+7jW
N/B9nHZSkHAjtocF5Xlfzt/K1jS/mNa4c0DVBmnBALam88CbZshWAG7lwMZhkf40
DgLtkfZfyNCxFgd5/bTBcOZXnxLcWm1YHj45Pv/iOHtEhRDJ3UNmE5jry4DwjwSV
YVl4a1Jjaoth+Xgy3THO6M8DAv5PXlHT3ysJSOLY4rkrXlqQPdu8ylpqe8tymPng
Jv2FZWels3v9S+wWYj3OPbs2TkiTQE+Y34YaaxkTtz3FA4YktesN3F9mGUjE81jW
yEMbgNDVy1xaeFNm7q9geJCHfGdyvQ==
=DzpG
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
