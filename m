Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F85C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28D521775
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597987135;
	bh=mmhRfihkzkkhMIK7A3ZIDER3eFubJHpxbN8wAHHp6gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZVqR/pb7+KaPaNXagTmvbQLMCfChvHba3hutsIMVJSlIZAN8XD4OiB898XYsPUvEl
	 RI0RxmH+PikJoB91aaEmzcpfDxt690Sc9vQDl4iOHqCqVfdM4Ma5NO5r/JwBakKaIR
	 /Cx6yYDBkt0V3TG2VsSv87OTF5jOnNR2Zk3qX5EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHUFSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:18:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHUFSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:18:53 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A2121734;
        Fri, 21 Aug 2020 05:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597987132;
        bh=mmhRfihkzkkhMIK7A3ZIDER3eFubJHpxbN8wAHHp6gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zLz1Atbcda2iiVJiXgF7Jfx3Hx+M5Nw7LRvhTNtH2Tnhknz8MoVRSAW1J4IZPoK/R
         koj0jhejhLL+SgxFb8CSD3bP7QlKATqjzkq2goZz7gwDoMe10pSd9ov6Mmi5pxlD/3
         H0WeyOEH5yS/Ljji6UohaP1jgFX88MYW5pjRJYw0=
Date:   Fri, 21 Aug 2020 10:48:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
Message-ID: <20200821051848.GM2639@vkoul-mobl>
References: <20200817163152.13468-1-liambeguin@gmail.com>
 <CAMuHMdUGu+pqZs5YoiBnZ2j7Yx86VDU9oKr4C15c1Jc9GjQuNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGu+pqZs5YoiBnZ2j7Yx86VDU9oKr4C15c1Jc9GjQuNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-08-20, 15:57, Geert Uytterhoeven wrote:
> Hi Liam,
> 
> 
> On Mon, Aug 17, 2020 at 7:38 PM Liam Beguin <liambeguin@gmail.com> wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > Start by reading the content of the VENDOR_SPECIFIC2 register and update
> > each bit field based on device properties when defined.
> >
> > The use of bit masks prevents fields from overriding each other and
> > enables users to clear bits which are set by default, like datapolarity
> > in this instance.
> >
> > Signed-off-by: Liam Beguin <lvb@xiphos.com>
> > ---
> > Changes since v1:
> > - use set_mask_bits
> >
> > Changes since v2:
> > - fix missing bit shift dropped in v2
> > - rebase on 5.9-rc1
> >
> >  drivers/phy/ti/phy-tusb1210.c | 27 +++++++++++++++++----------
> >  1 file changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
> > index d8d0cc11d187..358842b5790f 100644
> > --- a/drivers/phy/ti/phy-tusb1210.c
> > +++ b/drivers/phy/ti/phy-tusb1210.c
> > @@ -14,8 +14,11 @@
> >
> >  #define TUSB1210_VENDOR_SPECIFIC2              0x80
> >  #define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT  0
> > +#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK   GENMASK(3, 0)
> >  #define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT 4
> > +#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK  GENMASK(5, 4)
> >  #define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT     6
> > +#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK      BIT(6)
> >
> >  struct tusb1210 {
> >         struct ulpi *ulpi;
> > @@ -118,23 +121,27 @@ static int tusb1210_probe(struct ulpi *ulpi)
> >          * diagram optimization and DP/DM swap.
> >          */
> >
> > +       reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> > +
> >         /* High speed output drive strength configuration */
> > -       device_property_read_u8(&ulpi->dev, "ihstx", &val);
> > -       reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> > +       if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> > +               reg = set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK,
> > +                                   val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT);
> 
> Triggered by your patches to add support for cmpxchg on u8 pointers to
> various architectures (which is a valuable goal in itself ;-), I decided
> to have a look at the underlying problem you were facing.
> 
> IMHO, using set_mask_bits() is overkill here.  That helper is meant to
> update individual bits in a variable that may be accessed concurrently,
> hence its use of cmpxchg().
> 
> In this driver, you just want to modify a local variable, by clearing a
> field, and setting some bits. No concurrency is involved.
> Perhaps using FIELD_PREP() from include/linux/bitfield.h is more
> appropriate?

Yeah i discovered the include/linux/bitfield.h and yes that looks more
apt here. u32_encode_bits() would make sense here and get rid of mask
and shift stuff too.

-- 
~Vinod
