Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D3EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA0B207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 07:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GQgPmWr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgESHOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 03:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbgESHOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 03:14:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5ACBC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:14:43 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b6so12565785ljj.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 00:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKNlGol6DBFYqZKexL8X9ujk+FaMe6F7pQLwjgxF+/8=;
        b=GQgPmWr/VcTNDS7mUVGbQUcMpBKNw/lMnnjYi9ttlDvmYJGJZKxt+otmgdUruoIRBb
         ymCkieHo1aTWQfiCC8hf9W0GK+YYVj1f6GWAhiK0lZ9No2/ErAAvhTdPxh+N8vhsE/7a
         BbQkVn51SK4OyPO+6IyHgcUj5nJHvaMn5Hz0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKNlGol6DBFYqZKexL8X9ujk+FaMe6F7pQLwjgxF+/8=;
        b=GVBGOv2a7eK2ZAmyAXv1LJvNV2JRpo/9zivP3TgxFdxLMutBukqDiwMA2ePLoWrwtb
         RLZ3WI5fXadTAJhxf1mkhr9kb7dPkV/mY2bZddSfTNofqjL/CMfvCiPqJ3WWHGKPAm0F
         TNUCZZf2avJAC2qp/os5v/O2C1XVM8VbMKk+EXUNwksMXP5JZWohPYdFNhy46Fx7zS3V
         mBYj7Uqv7l12CvhwovRaAEHDhU6qSzlbggiHBK1Cdshlst1FF9vQc/K3yK2zZlYAsdnc
         afXRMXlJ9kXPEQI4fMrvJU5rhb2d4sLALXaCYjHYPFxuMlxzVmLBK56mQ4Dzymuvdqcv
         M2+g==
X-Gm-Message-State: AOAM53054AMZH00t9hq+8efTMfQrXJ/Z9MACfE43JAEPj3yo2Vg2I8vX
        +QNyn3eZmTbGQC1L90BBFrq2JC++XU1FPqVQrBWNMQ==
X-Google-Smtp-Source: ABdhPJyH9c66Y6hSMDygoqz+6QuZ2opi1wEff4BNBwqlNzjjcogQxubGNhquFQHWt3w1liAtvAIWnygVggM4mPA6f54=
X-Received: by 2002:a2e:8681:: with SMTP id l1mr11966978lji.264.1589872482058;
 Tue, 19 May 2020 00:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200513173947.10919-1-rayagonda.kokatanur@broadcom.com> <20200519065251.GK374218@vkoul-mobl.Dlink>
In-Reply-To: <20200519065251.GK374218@vkoul-mobl.Dlink>
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Date:   Tue, 19 May 2020 12:44:30 +0530
Message-ID: <CAHO=5PG5m3_i+B_=uondJ=6NOqDxJnDCeds1YNTUMYKv5a9tTg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] drivers: phy: sr-usb: do not use internal fsm for
 USB2 phy init
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bharat Gooty <bharat.gooty@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Tue, May 19, 2020 at 12:22 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 13-05-20, 23:09, Rayagonda Kokatanur wrote:
> > From: Bharat Gooty <bharat.gooty@broadcom.com>
> >
> > During different reboot cycles, USB PHY PLL may not always lock
> > during initialization and therefore can cause USB to be not usable.
>
> Ok
>
> > Hence do not use internal FSM programming sequence for the USB
> > PHY initialization.
>
> And what is the impact of not using FSM programming sequence? If not
> impact why was it added in the first place ?

We have two methods for PHY bring-up. One is the current method and
the other is the FSM programming sequence. As we have observed PHY pll
lock is not happening after long reboots, we need to use the other
method. Using current method we have tested for 500,000 reboot
iterations and always USB PHY pll lock has happened. Connected USB
devices are detected and enumerated.

Best regards,
Rayagonda
>
> > Fixes: 4dcddbb38b64 ("phy: sr-usb: Add Stingray USB PHY driver")
> > Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
> > Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> > ---
> >  drivers/phy/broadcom/phy-bcm-sr-usb.c | 55 +--------------------------
> >  1 file changed, 2 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/phy/broadcom/phy-bcm-sr-usb.c b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> > index fe6c58910e4c..7c7862b4f41f 100644
> > --- a/drivers/phy/broadcom/phy-bcm-sr-usb.c
> > +++ b/drivers/phy/broadcom/phy-bcm-sr-usb.c
> > @@ -16,8 +16,6 @@ enum bcm_usb_phy_version {
> >  };
> >
> >  enum bcm_usb_phy_reg {
> > -     PLL_NDIV_FRAC,
> > -     PLL_NDIV_INT,
> >       PLL_CTRL,
> >       PHY_CTRL,
> >       PHY_PLL_CTRL,
> > @@ -31,18 +29,11 @@ static const u8 bcm_usb_combo_phy_ss[] = {
> >  };
> >
> >  static const u8 bcm_usb_combo_phy_hs[] = {
> > -     [PLL_NDIV_FRAC] = 0x04,
> > -     [PLL_NDIV_INT]  = 0x08,
> >       [PLL_CTRL]      = 0x0c,
> >       [PHY_CTRL]      = 0x10,
> >  };
> >
> > -#define HSPLL_NDIV_INT_VAL   0x13
> > -#define HSPLL_NDIV_FRAC_VAL  0x1005
> > -
> >  static const u8 bcm_usb_hs_phy[] = {
> > -     [PLL_NDIV_FRAC] = 0x0,
> > -     [PLL_NDIV_INT]  = 0x4,
> >       [PLL_CTRL]      = 0x8,
> >       [PHY_CTRL]      = 0xc,
> >  };
> > @@ -52,7 +43,6 @@ enum pll_ctrl_bits {
> >       SSPLL_SUSPEND_EN,
> >       PLL_SEQ_START,
> >       PLL_LOCK,
> > -     PLL_PDIV,
> >  };
> >
> >  static const u8 u3pll_ctrl[] = {
> > @@ -66,29 +56,17 @@ static const u8 u3pll_ctrl[] = {
> >  #define HSPLL_PDIV_VAL               0x1
> >
> >  static const u8 u2pll_ctrl[] = {
> > -     [PLL_PDIV]      = 1,
> >       [PLL_RESETB]    = 5,
> >       [PLL_LOCK]      = 6,
> >  };
> >
> >  enum bcm_usb_phy_ctrl_bits {
> >       CORERDY,
> > -     AFE_LDO_PWRDWNB,
> > -     AFE_PLL_PWRDWNB,
> > -     AFE_BG_PWRDWNB,
> > -     PHY_ISO,
> >       PHY_RESETB,
> >       PHY_PCTL,
> >  };
> >
> >  #define PHY_PCTL_MASK        0xffff
> > -/*
> > - * 0x0806 of PCTL_VAL has below bits set
> > - * BIT-8 : refclk divider 1
> > - * BIT-3:2: device mode; mode is not effect
> > - * BIT-1: soft reset active low
> > - */
> > -#define HSPHY_PCTL_VAL       0x0806
> >  #define SSPHY_PCTL_VAL       0x0006
> >
> >  static const u8 u3phy_ctrl[] = {
> > @@ -98,10 +76,6 @@ static const u8 u3phy_ctrl[] = {
> >
> >  static const u8 u2phy_ctrl[] = {
> >       [CORERDY]               = 0,
> > -     [AFE_LDO_PWRDWNB]       = 1,
> > -     [AFE_PLL_PWRDWNB]       = 2,
> > -     [AFE_BG_PWRDWNB]        = 3,
> > -     [PHY_ISO]               = 4,
> >       [PHY_RESETB]            = 5,
> >       [PHY_PCTL]              = 6,
> >  };
> > @@ -186,38 +160,13 @@ static int bcm_usb_hs_phy_init(struct bcm_usb_phy_cfg *phy_cfg)
> >       int ret = 0;
> >       void __iomem *regs = phy_cfg->regs;
> >       const u8 *offset;
> > -     u32 rd_data;
> >
> >       offset = phy_cfg->offset;
> >
> > -     writel(HSPLL_NDIV_INT_VAL, regs + offset[PLL_NDIV_INT]);
> > -     writel(HSPLL_NDIV_FRAC_VAL, regs + offset[PLL_NDIV_FRAC]);
> > -
> > -     rd_data = readl(regs + offset[PLL_CTRL]);
> > -     rd_data &= ~(HSPLL_PDIV_MASK << u2pll_ctrl[PLL_PDIV]);
> > -     rd_data |= (HSPLL_PDIV_VAL << u2pll_ctrl[PLL_PDIV]);
> > -     writel(rd_data, regs + offset[PLL_CTRL]);
> > -
> > -     /* Set Core Ready high */
> > -     bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> > -                           BIT(u2phy_ctrl[CORERDY]));
> > -
> > -     /* Maximum timeout for Core Ready done */
> > -     msleep(30);
> > -
> > +     bcm_usb_reg32_clrbits(regs + offset[PLL_CTRL],
> > +                           BIT(u2pll_ctrl[PLL_RESETB]));
> >       bcm_usb_reg32_setbits(regs + offset[PLL_CTRL],
> >                             BIT(u2pll_ctrl[PLL_RESETB]));
> > -     bcm_usb_reg32_setbits(regs + offset[PHY_CTRL],
> > -                           BIT(u2phy_ctrl[PHY_RESETB]));
> > -
> > -
> > -     rd_data = readl(regs + offset[PHY_CTRL]);
> > -     rd_data &= ~(PHY_PCTL_MASK << u2phy_ctrl[PHY_PCTL]);
> > -     rd_data |= (HSPHY_PCTL_VAL << u2phy_ctrl[PHY_PCTL]);
> > -     writel(rd_data, regs + offset[PHY_CTRL]);
> > -
> > -     /* Maximum timeout for PLL reset done */
> > -     msleep(30);
> >
> >       ret = bcm_usb_pll_lock_check(regs + offset[PLL_CTRL],
> >                                    BIT(u2pll_ctrl[PLL_LOCK]));
> > --
> > 2.17.1
>
> --
> ~Vinod
