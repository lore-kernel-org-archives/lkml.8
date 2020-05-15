Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AE3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1273820727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589566886;
	bh=ckBVg1MJiVxCyn1jj47za/KaV60o81y+aY8hdhxTv+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NQsz8cgPgV7RCN9o40846YcDrlaREDCyjeqo3JR2yQsoF3Ce7Eke9FZg2bc9A2snz
	 XBnodyEEigCdOCc8hnDE+z+gmEnuE55mj8vW4MezHu9NszVeENzRfTELFpXey/BmPh
	 sft0FcPtiuub4uQdWWcFAj+jl3nYKickhrSFeuEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgEOSVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:21:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEOSVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:21:24 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C75420728;
        Fri, 15 May 2020 18:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589566884;
        bh=ckBVg1MJiVxCyn1jj47za/KaV60o81y+aY8hdhxTv+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SUFZPl9QG+I4sO2uHgaBRWO0H+NYBBemyg2JiqEHfu24RGQA70mbOne0B1OJdHGHS
         xLZS7vxraN97lS4WEorIVxzbq69D68YIEDapFNN6Zr50BpVoR+wtpTRMPNEGwzmoGf
         sfpUPlq3KwdhOB6PUcLXJun7s1kgOTM696A25Th4=
Date:   Fri, 15 May 2020 19:21:21 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Allison Randal <allison@lohutok.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/19] spi: dw: Add generic DW DMA controller support
Message-ID: <20200515182121.GP5066@sirena.org.uk>
References: <20200508132943.9826-1-Sergey.Semin@baikalelectronics.ru>
 <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o41d8xLWOaLD8vYh"
Content-Disposition: inline
In-Reply-To: <20200515104758.6934-1-Sergey.Semin@baikalelectronics.ru>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--o41d8xLWOaLD8vYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 15, 2020 at 01:47:39PM +0300, Serge Semin wrote:

Appled:

>   dt-bindings: spi: dw: Add Tx/Rx DMA properties
>   spi: dw: Clear DMAC register when done or stopped
>   spi: dw: Fix native CS being unset
>   spi: dw: Initialize paddr in DW SPI MMIO private data

Thanks.  No issues from me with the other patches.

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

--o41d8xLWOaLD8vYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6+3aAACgkQJNaLcl1U
h9AGPAf/VsoxJ5zaBMEYFMY7L9rknyrkpX4QpC4b+7Dqn/k9fDezq5tQfvzsSRT+
c53PKsNYEJmdWAa06UJpLHroHf4Tgu/SythyLU5ad2eUg2hHqrtoy2pFDtn4qFKp
deRuFD01wqSKVe8zgyJ3kVRNOwosZiNYY2odh3t09vp7Xhsm0IBhlus6uRJH7szG
YkHF44v54fVuQvm5FD5QxTIMLN8inIJk+4oC5Xx+LQ5qf7hCInCmUgg7x/d9I2mC
HxfMDDegEPXj22WtkOvNlOlnWhL1ddS9VHNXBf7e5QDIoVlwq+9ZyKAKNMWgCYRV
uefRPVN+eOxdTIDgjo4ftLeW9I6E4g==
=tbav
-----END PGP SIGNATURE-----

--o41d8xLWOaLD8vYh--
