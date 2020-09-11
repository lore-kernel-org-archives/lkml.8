Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44875C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF38921D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599827105;
	bh=tbpqiKUFCx55a6qzlTkXyTciBSsbqLNoZ1CcPY+E41E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cCzcYFPQxwkcE0E29b4c1smpyl/snd10KSJU4gL/o2q6EF4F+D3cth+gjNDHoNsNp
	 1vYysGTPrWz/rmcuhAF0rgDS/4vsJcJ7B25LFHYyds3RUVED/lboCy6yb5R0sY1ZvU
	 1SIFPNg5J5I9sx0soWh3WOFyCcyAVTkEEkMA+upM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgIKMYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:60298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgIKMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:18:31 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A58221ED;
        Fri, 11 Sep 2020 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826708;
        bh=tbpqiKUFCx55a6qzlTkXyTciBSsbqLNoZ1CcPY+E41E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTtmqprXCqqNQVeE0T1VHxPtb+EcI/BvDfoVA2bwgYapRcI1DLUwgqmFxVvRPUBHz
         st5vHphCZV2fzydkKS8gyHYKSWIjqXnG0nyv7YUDdhjDhl7fP/ALQReiPbkhm1qb8h
         TpTHarrR1E35NXChiZ6dvFvMNhOtO9DwLtjxLvKU=
Date:   Fri, 11 Sep 2020 13:17:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Paul Yang <Paul.Yang@arm.com>
Subject: Re: [PATCH v2] spi: spi-nxp-fspi: Add ACPI support
Message-ID: <20200911121741.GE4895@sirena.org.uk>
References: <20200911082806.115-1-kuldip.dwivedi@puresoftware.com>
 <20200911110018.GD4895@sirena.org.uk>
 <9a6ce5d0-2f39-eb55-c3a9-cae2a8093fbc@arm.com>
 <01f42ace75808be76c78a4a67b78ec06@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YToU2i3Vx8H2dn7O"
Content-Disposition: inline
In-Reply-To: <01f42ace75808be76c78a4a67b78ec06@mail.gmail.com>
X-Cookie: Only God can make random selections.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YToU2i3Vx8H2dn7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 11, 2020 at 05:32:24PM +0530, Kuldip Dwivedi wrote:

> Here I can think two possible approaches
> 1. Changes in DT to use indexed based lookup

This is not going to be OK, it will break existing users relying on the
naming and makes the DTs less usable.

> 2. We Can check for ACPI fw node to distinguish between DT and ACPI like
> below..
> if (is_acpi_node(f->dev->fwnode))
> 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> else
> 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> "fspi_base");

Yes, this should be good.

--YToU2i3Vx8H2dn7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9bauQACgkQJNaLcl1U
h9BCRgf/aL1RCrVtTo2njbYaoY5i0SRm99fj3cZHlaj3+XVyYLSWPwQbIIp+OqxC
7qgamDvL3xPUFzoCcoGMsrSO6I521jApV4Nr0Px8obDAPelh+1DMiVwoV5ZcjlFf
kdAe13mqJhO9KZrIjv/xKAWuhs84RyoTrrElxMD75M1tC/vrTINpcxx/98fhaPd/
/7QKLCssrtwOiQeRjuEwTLSYHcKDogJkIc6wQqL7UvsjSUVbOS5M9RyHqoTs+Mo1
drpX/v5NiKd4kfBgm5h7nFwrQqvlr9XLRyucJZnPUjNXaBZzi6Vpk4bHna9t67gv
b1HIZ8gxxAlT4im0VtW19gCzrDek3A==
=76Fx
-----END PGP SIGNATURE-----

--YToU2i3Vx8H2dn7O--
