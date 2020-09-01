Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEADC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790FB21D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEMQN9Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgIAOsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgIAOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:15:11 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDFDC06125C
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 07:14:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id u3so1034528qkd.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 07:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=BFo5n9HaRlQNxB7HLMjHORpQ6JwPJVs2FExjjB8oDWM=;
        b=DEMQN9KfmUh5uM3zBJRl3lQDqYom89qxHOq2ebXdd3tjitjgsJQFOmhT7EPQoi1axi
         49hDcvTNjGarxHI13WwKAdCOL6sFIO8AVEBBJh9u9ZhGS0kf/odIjTbVM0Y8dDyh/Gyw
         q8eArrgvvZi6g6EIaqWa3vFouR0+OHqLk/of70PXe23AdoXhMpDUgJdI2INrHjKEHHta
         lk2egh32w656MFJycIjuONVwMHhnKh1igySepYcRBy6W07+99N+CxwUZWeyd+IamiLTa
         /1fDAZ1zKCklS1rvpw0+bK613WV9YEKcOpIoWNyJ4YUu05NPBfKe6QEljJcS0Essp5Xx
         klrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=BFo5n9HaRlQNxB7HLMjHORpQ6JwPJVs2FExjjB8oDWM=;
        b=ULg5DRVEboQhFD3zNJloqPbhI2tKH9+gA8X3lNAllYrgmhteCgBL88MXAowrHq1/kV
         AJ02vx64r+NLgDng/JbhLgTl2w+4k6FPVCfNXONuqZVFDAH+mpKtKFotunrVyP1Kms+Y
         RpaYblYXQebLz6RbKtHTano7URFuH2XHp0OaYATgom8J8FFIaoqf06DJALFKe3p1uOzn
         IexPkqYXjozFGpnbrVl5XsbytErvTRty1b69kj8Wznt8YQ4/RyCfidu41ReLOf/KQC7Y
         QXbJe3nNtJ9bnxinI9nupL6XtBAiB5R9mwijpdx2F5l+jP+tTbRZyAaDHBSN+zoBLcxz
         IqIg==
X-Gm-Message-State: AOAM532GHJI0+BNE/XQsQei2CHWee68af2n9tjE/TkqIErxNJeb9a1g3
        dPcmfoeXblXrG86evmuZ0PY=
X-Google-Smtp-Source: ABdhPJxaraygGwMcMTnE4/+VjNjqPbtNtVbMVT1K44PE+gSiUIY4uEmKIZnwlOpxCRkAsTSF9+88cQ==
X-Received: by 2002:ae9:e814:: with SMTP id a20mr2100888qkg.429.1598969692340;
        Tue, 01 Sep 2020 07:14:52 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id g15sm1461629qtx.57.2020.09.01.07.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 07:14:51 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <geert@linux-m68k.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
Date:   Tue, 01 Sep 2020 10:11:38 -0400
Message-Id: <C5C3DR429J1K.298P4KSJ2UAOX@atris>
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

u8p_replace_bits seemed like a more concise notation.

> Also please drop the u8 casts above, they seem unnecessary here
>

I added the type casts to get rid of compilation warnings.

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
