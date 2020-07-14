Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B50EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1697D223AB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGw7hbF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgGNQ2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgGNQ2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:28:37 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F25DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:28:37 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so7756607qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:in-reply-to:date:subject:from:to:cc
         :message-id;
        bh=JE/9mxvl5sque/itISrZcO8tc5vQZFTyOpHVUavX1xU=;
        b=mGw7hbF3ASrdOJSzbT8JGlVle3an+aFxNkwH4EVByeQGUG2IpEulVFHZDdhfZf7SD7
         QNdxbF3BquaG1xvA7IhWbV4e6p8L7Z0x6iignQ+1QKBSK2vDOrPyFCLjRx0upDWZPqr/
         3T6xViiJ14jDOv/BNLdf6oRrfnDLfnF7MTiHAgRtpOInF4mgD2tkzYUp4NKvQ7XHpPDr
         PHyrvuLa4hWcct+qt7V7uam9IEn76RgxQYqQIt8FhEiU4fJ7Gto1vA62PvbVtxK716Zx
         jlg59CXTOaQTEcqdKoZJjyxugTJGXB2PE/tjqmYI3FWq0gbvwDsLnLR2dSRABrkn6EOZ
         eYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:in-reply-to:date
         :subject:from:to:cc:message-id;
        bh=JE/9mxvl5sque/itISrZcO8tc5vQZFTyOpHVUavX1xU=;
        b=O8ZR8yFwZoHU21k6bheJIx7NoKfmUYA/MTAIZlrQrxqv3rwZ5GuspBbmXcbIxNd/v8
         K6jQNO3wHsouXwbEdLMOF/sUwzOkGUfGCebpq/poEMuSFVMC9LYrT6LU2Gu+xYGEMiv6
         61hXkeVTBGOV4iJ4lM0iWF+ivsh/HpQxn4+jhYy5hVfSG2xeYMua22VAflLoUHtAo1tn
         4I9+mAbqYUUGym6EJZzKHFEVTT5r/f8yGfxZxraysS//xXIkrPTy0DA+JXS7CNT4rVod
         ZqB9pgHW2jhXPopOFnzqScdlUIr9DAWeK/YxtvbZc6NsjBI01FgUye2dmqUgynqri5+a
         wzyg==
X-Gm-Message-State: AOAM532oYRlcZdnps0npQTaRO4C/kUEZ9x77kU/VjmILgsUHFSEVWdL2
        DiD8CmxqyuxTopubgqxapvEqyEcE
X-Google-Smtp-Source: ABdhPJzypw6RRZ3dMRpl9mft+Pk5UEzORtbiTyLFqXlLXCpN5wbhtyz4uSt8hmoFRnZ/CzoUQ0zLHQ==
X-Received: by 2002:a0c:b791:: with SMTP id l17mr5627398qve.44.1594744116153;
        Tue, 14 Jul 2020 09:28:36 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q189sm23371167qke.21.2020.07.14.09.28.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2020 09:28:35 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20200713050839.GS34333@vkoul-mobl>
Date:   Tue, 14 Jul 2020 12:28:34 -0400
Subject: Re: [PATCH v1 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
Cc:     <kishon@ti.com>, <linux-kernel@vger.kernel.org>
Message-Id: <C46HLW9JFSYI.2YB0NSAHXDI3A@atris>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Mon Jul 13, 2020 at 10:38 AM Vinod Koul wrote:
> On 01-07-20, 21:06, Liam Beguin wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >=20
> > Start by reading the content of the VENDOR_SPECIFIC2 register and updat=
e
> > each bit field based on device properties when defined.
> >=20
> > The use of bit masks prevents fields from overriding each other and
> > enables users to clear bits which are set by default, like datapolarity
> > in this instance.
> >=20
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> >  drivers/phy/ti/phy-tusb1210.c | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb121=
0.c
> > index d8d0cc11d187..a957655ebd36 100644
> > --- a/drivers/phy/ti/phy-tusb1210.c
> > +++ b/drivers/phy/ti/phy-tusb1210.c
> > @@ -13,9 +13,9 @@
> >  #include <linux/phy/ulpi_phy.h>
> > =20
> >  #define TUSB1210_VENDOR_SPECIFIC2		0x80
> > -#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
> > -#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
> > -#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
> > +#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	0x0f
> > +#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	0x30
>=20
> Why not be better and use GENMASK(3, 0) and GENMASK(5, 4) for these
>=20

Will update, I didn't know about GENMASK.

> > +#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
> > =20
> >  struct tusb1210 {
> >  	struct ulpi *ulpi;
> > @@ -118,22 +118,25 @@ static int tusb1210_probe(struct ulpi *ulpi)
> >  	 * diagram optimization and DP/DM swap.
> >  	 */
> > =20
> > +	reg =3D ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> > +
> >  	/* High speed output drive strength configuration */
> > -	device_property_read_u8(&ulpi->dev, "ihstx", &val);
> > -	reg =3D val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> > +	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> > +		reg =3D (reg & ~TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK) |
> > +			(val & TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK);
>=20
> It would be better to use a helper to do this
>=20

I found set_mask_bits(), will use that instead.

> > =20
> >  	/* High speed output impedance configuration */
> > -	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
> > -	reg |=3D val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
> > +	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
> > +		reg =3D (reg & ~TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK) |
> > +			(val & TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK);
> > =20
> >  	/* DP/DM swap control */
> > -	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
> > -	reg |=3D val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
> > +	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
> > +		reg =3D (reg & ~TUSB1210_VENDOR_SPECIFIC2_DP_MASK) |
> > +			(val & TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
> > =20
> > -	if (reg) {
> > -		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
> > -		tusb->vendor_specific2 =3D reg;
> > -	}
> > +	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
> > +	tusb->vendor_specific2 =3D reg;
> > =20
> >  	tusb->phy =3D ulpi_phy_create(ulpi, &phy_ops);
> >  	if (IS_ERR(tusb->phy))
> >=20
> > base-commit: cd77006e01b3198c75fb7819b3d0ff89709539bb
>=20
> fatal: bad object cd77006e01b3198c75fb7819b3d0ff89709539bb in
> linux-phy.git
>=20

Sorry about that, I'll rebase on the latest linux-phy.git

Thanks for your time,
Liam

> --=20
> ~Vinod
