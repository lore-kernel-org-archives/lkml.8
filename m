Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28842C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0401322AB0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594754959;
	bh=lMK7C6ng+T9UttAEHw5V+tYjQ5/2JkOgzpqo9X6mc6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bRElaZdwYEqtTHYC6mcXCPoKRyYpEmPY0edskaKzLqcwTAY0gOvKrvhbXiBIdsu5L
	 o7hSpmBAvrw/X8yW8Y+ZFcbE5b7/GVGeGl6c622GGaIe8bJ8ivQKmpYSOJVoNucdEQ
	 m+P8nMvjSViTWiJLoiHK662qI0NDGrxSIqcMJf9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgGNT3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgGNT3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:29:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3212D225AB;
        Tue, 14 Jul 2020 19:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594754956;
        bh=lMK7C6ng+T9UttAEHw5V+tYjQ5/2JkOgzpqo9X6mc6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z9B7j3NbUZSWppYeDQAoliZQLbE9Iujz+KijRvU37A58urcaPZIpzOIt7+gDmPr7C
         K8TQT2GWYlKq8154QaHk0XB8nBlOUD26VsMo4nVy95veZI0Bal7PAiSwlZ+sApFtdn
         fF/kC/KafxtVLpBBTRspGYZTFwUuf1JcYRlMwM8E=
Date:   Tue, 14 Jul 2020 20:29:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Frieder Schrempf <frieder.schrempf@kontron.de>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: spidev: Add compatible for external SPI ports on
 Kontron boards
Message-ID: <20200714192907.GJ4900@sirena.org.uk>
References: <20200702141846.7752-1-frieder.schrempf@kontron.de>
 <20200702142511.GF4483@sirena.org.uk>
 <24ec4eed-de01-28df-ee1f-f7bcfc80051a@kontron.de>
 <20200702150725.GI4483@sirena.org.uk>
 <479d566a-213f-4e33-8ac7-7637ae88e31c@kontron.de>
 <a5b88ad9-3884-1d9c-c4ad-057266f84261@kontron.de>
 <20200713151108.GB4420@sirena.org.uk>
 <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibvzjYYg+QDzMCy1"
Content-Disposition: inline
In-Reply-To: <2eb6971b-7ea4-c9c8-5452-6f4b17e8860a@kontron.de>
X-Cookie: Your password is pitifully obvious.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibvzjYYg+QDzMCy1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2020 at 10:54:15AM +0200, Frieder Schrempf wrote:

> It would still be quite nice to benefit from the flexibility of DT overlays
> not only for the SPI use case. But before I come up with any custom
> solution, for now I will rather have the device in the DT statically.

> I just wonder if I need to keep the DT node for the device in a separate
> patch in our own tree, or if a node with a custom compatible string like for
> example "kontron,user-spi" would be accepted upstream, without a matching
> driver?

I'm having a hard time getting enthusiastic about it TBH - can you not
just use spidev and live with the warning?

--ibvzjYYg+QDzMCy1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8OB4IACgkQJNaLcl1U
h9DpaQf7BBqueEOqSjOvjtORDyHTDzwMyXjqzEizOxoc3v+nwMk+G90WhXg0aEM5
VPv8HBBGSPnQlzkc6qHJFYZ5axm4lNsQsED/KDm2nZ5pHYVHvg+S/+JOkAJXqaYx
JI/gqdu+JFZYqUcV4i5/BwGO00zR3OntARea/24y/atTbxqB9Lm/vGrTs/Qw8FUR
oflKzZdlg+s5aUiQvl7Gwa+9O2oJLM5EwpFjfGJ967GtKJfkMjHEKhwVqEvJgfeM
6unCikuBQrE4/w7S0xjlm/M+2fT2ussP0nr8yZmzsEN+q7AtHkyorPsvWiPnI9i2
HaD2ydvutHJVTqX5P2RYDtYromP/WA==
=O3jF
-----END PGP SIGNATURE-----

--ibvzjYYg+QDzMCy1--
