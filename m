Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68062C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E57420855
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpAUKHHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgHVUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgHVUEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:04:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DBDC061575
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:04:13 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id u3so4276367qkd.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:cc:subject:from:to:date
         :message-id:in-reply-to;
        bh=UE2JwjfsuVo0MWoKDr7qXxd/qt2fnX4/3fsOyt0RJ5g=;
        b=qpAUKHHDbeAxrmOZPJCM9u+F9Uqf3yurXrUX0xpttZ82v4bQBMZCBj1ZVw9kL8Vvpn
         cpfPDTIJr2zmKQSpETHS5wUx4WKUmBF8xbMMfuWT035KuPE4S0R8wU+qPGBkTXfHbjy1
         Ov1zR32px4MqdTkFLu6v3ogvaF40hctB4SFeU4n3/7amNWoqyTV45z1/vYFcXN8dVd7i
         Fp4/TMNkGgxS8VMtZiLkSJgrpey7/A+GojQ65jGI8zbM0us4ug8Fx4wcqu5QeMghyDhR
         /3Ndv9XxB7wyNIsc6FyMSZBdNlTcf/ma4sZX+mHlYV52rb2+Ik/iHPcFqUbXg1ibp59k
         OJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding:cc
         :subject:from:to:date:message-id:in-reply-to;
        bh=UE2JwjfsuVo0MWoKDr7qXxd/qt2fnX4/3fsOyt0RJ5g=;
        b=QCHOn3+WT0wgK1pqL9h4wa4Bz+Ty1iseJQVPmTrKjrCHBemPBVTu7x3nGBrbjEWKlY
         XtWvhdQcdx8CcZg/V0NjD2a4VDQ4CcDwpk6ukAfm0IfcdTe6iUHbOlkdSdzqakQPr1Ba
         oOk4GOgKA05aj8EWOvj95vHTmWMv55fJe329m3K3XvEHF8O8j96aMKdbBqR1yD0ehMI4
         jnZdP/l/RZh25s01k/swa84C7Qtf6H7AsQSMZJjg8bR6bZi5YQ6AjyLWAXS2xsPydETT
         71Xdh82pJo8j5Cb/hfGyEFgv1LswfE0faNIqrYXuQ0D0nppFF8TXOf51OkzxAfBXffDJ
         5ZKQ==
X-Gm-Message-State: AOAM5314A7IDx6pkLyEIpj9HcBpBocGvfVlNgOdJn9yRvx+I+nTnF2Tm
        WNYDINMykbgNNXhU6YqH3Rc=
X-Google-Smtp-Source: ABdhPJw2zpzAa0NyWYkICLWYLfDIVUKnFseS2eY99F0al027/dk028/EMdpPq8prt3PPzg+vv3xT9A==
X-Received: by 2002:a05:620a:21d1:: with SMTP id h17mr7619491qka.292.1598126648091;
        Sat, 22 Aug 2020 13:04:08 -0700 (PDT)
Received: from localhost (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id h125sm2750940qkf.90.2020.08.22.13.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 13:04:07 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Vinod" <vkoul@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] phy: tusb1210: use bitmasks to set
 VENDOR_SPECIFIC2
From:   "Liam Beguin" <liambeguin@gmail.com>
To:     "Geert Uytterhoeven" <geert@linux-m68k.org>
Date:   Sat, 22 Aug 2020 15:59:23 -0400
Message-Id: <C53SIK03FQTU.192BHHIVG7II9@atris>
In-Reply-To: <CAMuHMdUGu+pqZs5YoiBnZ2j7Yx86VDU9oKr4C15c1Jc9GjQuNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Wed Aug 19, 2020 at 9:57 AM EDT, Geert Uytterhoeven wrote:
> Hi Liam,
>
>
> On Mon, Aug 17, 2020 at 7:38 PM Liam Beguin <liambeguin@gmail.com>
> wrote:
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > Start by reading the content of the VENDOR_SPECIFIC2 register and updat=
e
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
> > diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb121=
0.c
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
> > +       reg =3D ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
> > +
> >         /* High speed output drive strength configuration */
> > -       device_property_read_u8(&ulpi->dev, "ihstx", &val);
> > -       reg =3D val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
> > +       if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
> > +               reg =3D set_mask_bits(&reg, TUSB1210_VENDOR_SPECIFIC2_I=
HSTX_MASK,
> > +                                   val << TUSB1210_VENDOR_SPECIFIC2_IH=
STX_SHIFT);
>
> Triggered by your patches to add support for cmpxchg on u8 pointers to
> various architectures (which is a valuable goal in itself ;-), I decided
> to have a look at the underlying problem you were facing.
>

Thanks for taking the time to look at this, I'll still give the SuperH
patch a try if I can test it properly :-).

> IMHO, using set_mask_bits() is overkill here. That helper is meant to
> update individual bits in a variable that may be accessed concurrently,
> hence its use of cmpxchg().
>
> In this driver, you just want to modify a local variable, by clearing a
> field, and setting some bits. No concurrency is involved.
> Perhaps using FIELD_PREP() from include/linux/bitfield.h is more
> appropriate?
>

Using set_mask_bits() does seem overkill seeing that it triggers all
these kbot warnings...
I'll prepare a patch using functions from bitfield.h instead.
Thanks again,

Liam

> Gr{oetje,eeting}s,
>
> Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 --
> geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker.
> But
> when I'm talking to journalists I just say "programmer" or something
> like that.
> -- Linus Torvalds

