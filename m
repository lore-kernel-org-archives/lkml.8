Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7832E208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gd5v0fpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgE1DSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgE1DSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:18:39 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2998AC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:18:39 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b13so5538864vsm.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P08I4zE8K6u9H+J6vCBj42y9SdfxKpWel+GAURaf55w=;
        b=Gd5v0fpc/RFo1Ol6DaU34Ei/B53PMuWccibMO+SiIRAsMklYODgeub7I1ybVBAtl83
         C2GZm0bqmHCqTQGRKsC7QBYB9cI6OxJUYpYspoBcW7PgrkZsYHtMEtLHvYzVmEIS6Wcz
         ZnryfEXgbfi0ZB+Tqog2Dn9yKwEdRwlaR1d4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P08I4zE8K6u9H+J6vCBj42y9SdfxKpWel+GAURaf55w=;
        b=K4rqw5aNll3oY1Cq+BtmPMtWa4qn5TbUXCIGT2/3+KwfAEhWwbDNFp+A+sD0BJRR1e
         9hQSs6v9AmcuyDrEdNnGOJucVpQIcxyR2gQXDqeIhGF9CAfbog8WmviR/J5udE9gIPJh
         KFUL2HpNhwFhZnYQYctSHCMOa9ZtklI0Dy68sxTHcJrdMtpKhQPUaXYiCmHNTnloGPR0
         H8N/MWfCxOouX2922Hwh5tT0DHUmw9Jwp81/gUoSZqDjTWx93YlQHelN8pfqqbDm77L/
         5fUjmNbIj8W44GGF6ZMsuMppXoByW4A0pBRVqJn+N2s51l+frs7clh+gKNvMFIzQLBJt
         4IkA==
X-Gm-Message-State: AOAM530BfEWNS/QxHcWXvMR5Puc32YGBgIB2UTxaXIdvlP3IQmivm2k0
        46hePKF6kCSF0NJK0LWrZIB0aS8v5pb4gPTYQeRGfg==
X-Google-Smtp-Source: ABdhPJyafa1Y72O3e35J2AfGiJYhGkInFgYvxBjxjENSmn59akurnb83CPrUP7sxd4ACZgLhsri2ry65RkRI/k11er8=
X-Received: by 2002:a67:2e11:: with SMTP id u17mr582429vsu.1.1590635918188;
 Wed, 27 May 2020 20:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200528025503.24003-1-wuxy@bitland.com.cn> <CANMq1KDWp7ztviO+ZoXeEqek3uCzPDKjteahO32C3b-=OxerUQ@mail.gmail.com>
 <tencent_353523967C92024E04C83463@qq.com>
In-Reply-To: <tencent_353523967C92024E04C83463@qq.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 28 May 2020 11:18:27 +0800
Message-ID: <CANMq1KBvUMWj_gySA27WuxAOW3dT2-vGaKc=yn3ztR94WO-Gxw@mail.gmail.com>
Subject: Re: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
To:     =?UTF-8?B?5ZC05YW06IKyQjAxNzc5?= <wuxy@bitland.com.cn>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        stlin2 <stlin2@winbond.com>,
        wuxy <wuxy@bitland.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:16 AM =E5=90=B4=E5=85=B4=E8=82=B2B01779 <wuxy@bi=
tland.com.cn> wrote:
>
>
> >
> > This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
> > The original patch is invalid,so re-submit a new patch for this.
>
> This belongs below the ---, but I guess the maintainer can help you with =
that.
> --->This --- is automatically generated, it looks like I can't move it to=
 below  ---

Sure, but you can always edit the message before you send it
(--annotate parameter of git send-email).

>
> ------------------ Original ------------------
> From:  "Nicolas Boichat"<drinkcat@chromium.org>;
> Date:  Thu, May 28, 2020 11:06 AM
> To:  "wuxy"<wuxy@bitland.com.cn>;
> Cc:  "lkml"<linux-kernel@vger.kernel.org>; "linux-mtd"<linux-mtd@lists.in=
fradead.org>; "stlin2"<stlin2@winbond.com>; "wuxy"<wuxy@bitland.corp-partne=
r.google.com>;
> Subject:  Re: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash I=
Ds
>
> On Thu, May 28, 2020 at 10:55 AM <wuxy@bitland.com.cn> wrote:
> >
> > From: wuxy <wuxy@bitland.corp-partner.google.com>
> >
> > Winbond has new 1.8V SPI NOR Flash IDs,we need to use the SPI
> > flash IDs in kukui series,this patch can support the new flash IDs.
> >
> > TEST=3Dboot to shell,get the spi information from 'dmesg'.
>
> TEST=3D is Chromium OS specific, you can drop this line.
>
> >
> > Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
> > Signed-off-by: ST Lin <stlin2@winbond.com>
>
> Tested-by: Nicolas Boichat <drinkcat@chromium.org>
>
> >
> > This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
> > The original patch is invalid,so re-submit a new patch for this.
>
> This belongs below the ---, but I guess the maintainer can help you with =
that.
>
> > ---
> >  drivers/mtd/spi-nor/winbond.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbon=
d.c
> > index 17deabad57e1..cda4f8847bd6 100644
> > --- a/drivers/mtd/spi-nor/winbond.c
> > +++ b/drivers/mtd/spi-nor/winbond.c
> > @@ -61,6 +61,15 @@ static const struct flash_info winbond_parts[] =3D {
> >                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD=
_READ) },
> >         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
> >                             SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_=
READ) },
> > +       { "w25q64jwxxIM", INFO(0xef8017, 0, 64 * 1024, 128,
> > +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_=
READ |
> > +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> > +       { "w25q128jwxxIM", INFO(0xef8018, 0, 64 * 1024, 256,
> > +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_=
READ |
> > +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> > +       { "w25q256jwxxIM", INFO(0xef8019, 0, 64 * 1024, 512,
> > +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_=
READ |
> > +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> >  };
> >
> >  /**
> > --
> > 2.20.1
> >
> >
> >
