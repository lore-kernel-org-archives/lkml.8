Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E101C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CFC12078E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599222953;
	bh=7W+cNWvcKl/b+gwgeRI3Se0zabsimhEqq7Pw7eCFpsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gKU4eQZvqDgZZJg/xHGbWtOGB9jX13RkGhLvLAUPXzWJxFvWMFWZolstZ9o43XuG2
	 hnAiC8G4TSM3+KmoOiFcybe7oRqv6mEQFjbllvbRxdfOzsgLadCQ37KbSgf4vOoqWi
	 QdTSyt/MZAp3jDaZYQTBDDCxsfYppj5+muLwyAJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgIDMfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDMfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:35:36 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A12CC2078E;
        Fri,  4 Sep 2020 12:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599222935;
        bh=7W+cNWvcKl/b+gwgeRI3Se0zabsimhEqq7Pw7eCFpsA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v/ijxmV7dH2pojSHaFTwqz49Mw+QN3n8O8SHYsMAD7LPkZbodJijfeY2CrNV2ujCq
         nThXjtVa+hjvn4jNSV0nG9EFi62yvr4ftOVHgN+reO+OZi6hJEW8Q0oRgHTT+MdcC9
         0Ezig2gEiZq22LTaleLaVt5OqkkQX7hLcy82/bzE=
Date:   Fri, 4 Sep 2020 13:34:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, linuxarm@huawei.com,
        mauro.chehab@huawei.com, John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [RFC 00/10] Add USB support for Hikey 970
Message-ID: <20200904123453.GD4625@sirena.org.uk>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
 <84b7dfcd-05e9-53b2-e0a0-b03105937eb3@arm.com>
 <20200904142849.7d3fed88@coco.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline
In-Reply-To: <20200904142849.7d3fed88@coco.lan>
X-Cookie: Heisenberg might have been here.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 04, 2020 at 02:28:49PM +0200, Mauro Carvalho Chehab wrote:

> It sounds that the only power supply related to USB is for the USB
> hub (ldo17), with sounds unlikely to affect dwc3. Yet, just in case,
> I added a dirty hack at dwc3_probe:

> <snip>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 25c686a752b0..e42be91fe6c2 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1491,6 +1491,11 @@ static int dwc3_probe(struct platform_device *pdev)
> =20
>  	}

> +struct regulator *reg;
> +reg =3D devm_regulator_get(dev, "ldo17");
> +ret =3D PTR_ERR_OR_ZERO(reg);
> +if (ret) return ret;

A regulator_get() is going to do absolutely nothing to the state of the
regulator, if you're trying to enable it you need to do regulator_enable()

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9SNGwACgkQJNaLcl1U
h9BFdgf/aOjLE+Pewcvq3MqXrgRmMJjanuT5WgDG1kiAgGE3JxZIs6JCKgfUpax4
Zzkme/krr3M0d6cMM/6PXSHVdPNph9xH/BPxNdOXbrsyPc/Vsx72uUXxkExIvZp9
XNJxg306T3OqvbjFjKjHw8yyAY5SjQqShF2MqrS5s879ImGNR2lporwY+Ln+wUwr
1ZRsqQ93M305BxKdOffCldeBNIhybF+zwOLrQQGm0t/ND3KCd6PlqHEsvqsA8u6I
axyjLBEc0n/W1QCZ+ZYTuVRjZyrcsxfxn8m+m6RyeBMWY6RvYjfFP5LlYfjAde+Q
bDSGjengZKkyBXGyjnBby0XbnjPAgg==
=xQsP
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--
