Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B887C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70645208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtGglfrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgIAOl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgIAOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:16:46 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31CEC061251
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 07:07:39 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so1019187qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=+c7gUM4M1NG54PZN7hYz3O1VCdsfHKYvNA1RcLxjRT4=;
        b=DtGglfrVkajnixQQs92D4Z0K2684L1xRNQx6ROkO6nL5ByavpK+z7lGv2Cj6qIVlli
         tivZ9xsZnEX7sLIbciNgwJSu4trMy6XhwZXTI14WxS2mR6KrA6clkgacrsmnIBGHRvHp
         Vdy+oFh2uQbBRobIDRo81RCTxaMMIE0B6EhjSeNt00LGQ95FAzJGP1Aa4IaR8HaTW1XS
         /tq9s4WiENbGx7GoGSaRe1DX8WDy8jo8dOniiKviBzPhQVxo2pTpIDWQ34Huy8qRElfy
         LQwPyJOTok+HG4mw0V6qHwOtJFfJVobOzD2X6sKH7Ia7ydvgiME1lIT/t2Bhahr2ioJ3
         ZD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=+c7gUM4M1NG54PZN7hYz3O1VCdsfHKYvNA1RcLxjRT4=;
        b=O+OddR6EataWoUEi0L5K2ZwhxMT8/82Cv+3ONCy9+6BPU838dVFHhu/9dWfXs4LhuS
         5ZS2gKG7LwUIuh4FMVtu9erD+i+9HxpQjkD3eRSo8j8UpFCYI7QaPjb7DTFbSTwH+g0h
         pnQZKXEmIBNTzSv9IWfJTvTy2VJz38BxmSSfv8N3GRYubB6l5lqsxeRk89RtwkUJFdUo
         8TbmDKOl4T5d4OLo+pUT+CRr5n5Y70B1SVXM7uXvYp2ubGuRhqRtJwmqlUzj+aFf/pQn
         SIZTjdhty8wM+cLPkyp0TcGNwX2K3jmiw6Eova/Vakacpg5Q+lore6v6A91Ew+f3EaIJ
         3Ktw==
X-Gm-Message-State: AOAM5321H3GYpa3i4aYZqKWdFV2I2cbSaWkefGWPRRdomX/QX/hHZPj4
        qoTpyH2M2kbuqUUFNOQUEnsfdm3zReQ=
X-Google-Smtp-Source: ABdhPJySP7qnv73ndy+4kJiIaZROYfwZkec0hTAOuXjwxulZXTMbdceuSrDBTJex1URL8ZO7Mwvv0Q==
X-Received: by 2002:a37:8f04:: with SMTP id r4mr2015273qkd.495.1598969259038;
        Tue, 01 Sep 2020 07:07:39 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id 192sm1429688qkm.110.2020.09.01.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:07:37 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <geert@linux-m68k.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
Date:   Mon, 31 Aug 2020 12:10:18 -0400
Message-Id: <C5BBA21WKTPB.3H0L7E96UPHZ9@atris>
In-Reply-To: <20200831110852.GO2639@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Mon Aug 31, 2020 at 7:08 AM EDT, Vinod Koul wrote:
> Hi Liam,
>
> On 22-08-20, 16:53, Liam Beguin wrote:
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
> > Changes since v1:
> > - use set_mask_bits
> >=20
> > Changes since v2:
> > - fix missing bit shift dropped in v2
> > - rebase on 5.9-rc1
> >=20
> > Changes since v3:
> > - switch to u8p_replace_bits() since there's little reason to protect
> >   against concurrent access
> >=20
> >  drivers/phy/ti/phy-tusb1210.c | 27 ++++++++++++++-------------
> >  1 file changed, 14 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb121=
0.c
> > index d8d0cc11d187..a63213f5972a 100644
> > --- a/drivers/phy/ti/phy-tusb1210.c
> > +++ b/drivers/phy/ti/phy-tusb1210.c
> > @@ -7,15 +7,16 @@
> >   * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >   */
> >  #include <linux/module.h>
> > +#include <linux/bitfield.h>
> >  #include <linux/ulpi/driver.h>
> >  #include <linux/ulpi/regs.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/phy/ulpi_phy.h>
> > =20
> >  #define TUSB1210_VENDOR_SPECIFIC2		0x80
> > -#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
> > -#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
> > -#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
> > +#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	GENMASK(3, 0)
> > +#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	GENMASK(5, 4)
> > +#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
> > =20
> >  struct tusb1210 {
> >  	struct ulpi *ulpi;
> > @@ -118,22 +119,22 @@ static int tusb1210_probe(struct ulpi *ulpi)
> >  	 * diagram optimization and DP/DM swap.
> >  	 */
> > =20
> > +	reg =3D ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> > +
> >  	/* High speed output drive strength configuration */
> > -	device_property_read_u8(&ulpi->dev, "ihstx", &val);
> > -	reg =3D val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> > +	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> > +		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK=
);
>
> Any reason for using u8p_replace_bits and not u8_replace_bits?
>

u8p_replace_bits seems like a more concise notation.

> Also please drop the u8 casts above, they seem unnecessary here
>

I added the casts to get rid of compilation warnings.

> > =20
> >  	/* High speed output impedance configuration */
> > -	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
> > -	reg |=3D val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
> > +	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
> > +		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MAS=
K);
> > =20
> >  	/* DP/DM swap control */
> > -	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
> > -	reg |=3D val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
> > +	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
> > +		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
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
> > base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
> > --=20
> > 2.27.0
>
> --
> ~Vinod

Thanks,
Liam
