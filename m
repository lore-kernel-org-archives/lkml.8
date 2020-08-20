Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E89C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C59E2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597923983;
	bh=EmpcpyWUq8w0WNjTx0pP0rrQmAkwNgLkN1Z/MnuebcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTyQHtJ2vT9RXtYQmETJp86JlD80TiuckmKlR2qG0DYst90S4DE75oZeXFf3pykPP
	 f9pFEIRY426dP5UE/s72onbVzivRRrIBKhOIx0YGyevO32M0SdSNQrlUPHTVRWJHbz
	 sYzss7skS0ztb47vy3dLaAl5UwfcCa55dQvOr1u8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgHTLqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbgHTLp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:45:57 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CF12078B;
        Thu, 20 Aug 2020 11:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597923957;
        bh=EmpcpyWUq8w0WNjTx0pP0rrQmAkwNgLkN1Z/MnuebcI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SiXurh7hS5kaPGz83qRaQPFIa3c10EcxMdG7VqJpmcAvQ1Kr2uVTFkz5T+BxZkuGc
         Qud9WfkBlOnTh1eiEAJ+5+R7ke09jeNewuXlamTAN4LdniF9WirwON/WrYfCYGezDu
         yuD0BvTXq5D151EW8HkiDvG8ChfiRGSL50q4s7+k=
Date:   Thu, 20 Aug 2020 12:45:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH v3 1/2] regulator: mt6360: Add support for MT6360
 regulator
Message-ID: <20200820114524.GC5854@sirena.org.uk>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-2-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <1597910022-22617-2-git-send-email-gene.chen.richtek@gmail.com>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 03:53:41PM +0800, Gene Chen wrote:

> +	mrd->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!mrd->regmap) {
> +		dev_err(&pdev->dev, "Failed to get parent regmap\n");
> +		return -ENODEV;
> +	}

> +static const struct of_device_id __maybe_unused mt6360_regulator_of_id[] = {
> +	{ .compatible = "mediatek,mt6360-regulator", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, mt6360_regulator_of_id);

This device only exists in the context of a single parent device, there
should be no need for a compatible string here - this is just a detail
of how Linux does things.  The MFD should just instntiate the platform
device.

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+YlMACgkQJNaLcl1U
h9DIKwf/ev1phumPNeX6i1SQql+DSte48x9dcwfsdVGdcUYYk9q6H6T5tUIKpzF7
htv0KnJWujWXk9eYft25GnJTOdpzdkihP+bqHsc86o+2wfuI/9NGr2z6Al6sFwjf
5neoBb9H3XMIHkkiAk/f8d4q5i9HDJA+5Gqe82/m7TV3qM7AYjeQH8X0BRnlGPTw
+H9wDCDmg/BkT4jq1spi0++fua58EtL58ex8OBPZpxFeG3ZPHZMLknJikpbEj3sG
L2I+4nITn7sB4zrTbIZDcdZYJCcubV/rZ0lO7+K6a1SGDxw98eOOfy21ht4qM6RV
R2n7uxfo+TjXqHqkdBGwQoqJdf2yJA==
=7oEp
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
