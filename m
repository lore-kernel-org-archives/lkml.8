Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D22C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985992192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HBeVC7g8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEIIb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726214AbgEIIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:31:55 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4996C061A0C;
        Sat,  9 May 2020 01:31:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id y26so4245624ioj.2;
        Sat, 09 May 2020 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oMY/3sjFWC1UpDvzgv1fjSMjjGsRYq6az0tfm/ZfbUs=;
        b=HBeVC7g8EbYmHXyY64+VllupvU5PasK0EAVzLCWhwmChSN+ym06Qg/qJo7wOYZCs7r
         YTYdMhWmw58E22GLc1/hfSql7f9HSW/XbGCSYAWQtqPvSeEePG9HGSog9e+1QVSVDhSZ
         SrKGTjE5/FrIG20xQ7rS84ytqqwQpIWqzWkdB5o9WTpFJ+3shyBq4P6L8TSokfxDfbJo
         yrqHddRFbvkl4OGXjQwGmLkawr0wKP4dAjAn2+xXcs9b16Dio6Gp8i3AJTvq+X3v5On9
         hBxI0syuaSIxMYj7zAf1wUr+FdLhqHtdEfIu4Rsqz3DQOkb/K0mijcGc8UxMicQQ+zF9
         U27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oMY/3sjFWC1UpDvzgv1fjSMjjGsRYq6az0tfm/ZfbUs=;
        b=FPSWhiA751nCKQJV1TMMOJ/z1jHJpBv2AJP1xCB3P5p/7Mnwn+r2uTzCpBGSz0MYvS
         mSDceNkc+9yaDtXFXDB4zXEOPxMECuVPDauqkWGk+7B4v/qNwt6i3l/ZELQjTmY0un44
         71hP/3Z23xlFiOtZcjnIRFL2BHQQUdE9TLgTsi7Ssiv70PD/3k2XjJkkqxkoqIjbR4kK
         NRqjtTHhaUJIeTJAiATbofJ83iaAjAAWtytNETChW8Zo0bSFKhQdnHDe7AbGSkx6sspI
         c/3Mi3/B1Yqf2+ZpYaJeq1alrgBd1DSX6U+kvGonXBmPqaZaQQjB+UKwXagPbvPtM51F
         fogQ==
X-Gm-Message-State: AGi0Pubj+MYkoSCAHhkXvWxxq17if31gnw53l6mS2HU+Ccbovc6Inrrt
        FhKlZHFk2eO3KHcbAGlk1FzWaCRcxxUKL+6Fc40=
X-Google-Smtp-Source: APiQypI2ZCoAh2bIVwu9IePr9OjjxWauYR21rvAWgk9/7RPzvJwK3sLc6kuCNTaD0sjCOCKTGQL1nBviJHt9cKLAoN8=
X-Received: by 2002:a02:a40b:: with SMTP id c11mr6279582jal.62.1589013112824;
 Sat, 09 May 2020 01:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
 <1588911194-12433-6-git-send-email-dillon.minfei@gmail.com>
 <20200508090247.GA11575@ravnborg.org> <CAL9mu0LcT3pPiM6PdJRvAJRMbXY6KACF1wNg8yOS-6D8aq6AeA@mail.gmail.com>
In-Reply-To: <CAL9mu0LcT3pPiM6PdJRvAJRMbXY6KACF1wNg8yOS-6D8aq6AeA@mail.gmail.com>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Sat, 9 May 2020 16:31:40 +0800
Message-ID: <CAL9mu0+OKgJJcS7unqxYzZaE4A+FRtWsReZMoaJyc8gx4zAf2A@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/panel: add panel driver for Ilitek ili9341 panels
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        Alexandre Torgue <alexandre.torgue@st.com>,
        thierry.reding@gmail.com, airlied@linux.ie,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sam, all,

i'm not sure you had receive this mail , as gmail's html encoded
messages blocked by linux arm kernel mailing list.
so, resent it in plain text again. with my name "dillon:  " at left

sorry for trouble.

dillon

best regards

dillon min <dillon.minfei@gmail.com> =E4=BA=8E2020=E5=B9=B45=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:13=E5=86=99=E9=81=93=EF=BC=9A
>
Hi Sam,

   Thanks for your comments, i will rework this panel driver after
l3gd20 patch submission.

> Sam Ravnborg <sam@ravnborg.org> =E4=BA=8E2020=E5=B9=B45=E6=9C=888=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:02=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Hi Dillon.
>>
>> Patch submissions starts to look fine.
>>
>> On Fri, May 08, 2020 at 12:13:14PM +0800, dillon.minfei@gmail.com wrote:
>> > From: dillon min <dillon.minfei@gmail.com>
>> >
>> > This is a driver for 320x240 TFT panels, accepting a rgb input
>> > streams that get adapted and scaled to the panel.
> This driver is, I suppose, prepared to be a driver for ILI9341 based
> panles, and as such not for a fixed resolution.
> I expect (hope) we in the future will see more panels added.
>
dillon:
As i checked ili9341 datasheets, this panel just support 240x320
resolution only.  if i'm wrong , please correct me. thanks
https://cdn-shop.adafruit.com/datasheets/ILI9341.pdf

This panel can support 9 different kinds of interface , "3/4-line
Serial Interface" have been supported by tiny/ili9341.c. i was
verified it
but the performance on stm32f4 is very low.

currently, i just have stm32f429-disco in hands, with 18-bit parallel
rgb bus connected on this board. reference to panel-ilitek-ili9322 and
panel-ilitek-ili9881 driver, i have some plan to rewrite this driver.

1 add your below comments in.
2 use dc-gpio, reset-gpio, rgb-interface-bits from dts to config panel
interface.
3 drop regmap, porting drm_mipi_dbi's mipi_dbi_command to config panel
paramter. like tiny/ili9341.c
4 support rgb-16, rgb-18 interface.
5 use optional regulator or power gpio to control panel's power, as
panel power is always on for my board, so i can't test this part.
could i add the code which can't be tested?
6 support rotation in panel config (currently , i rotate the screen by
kernel cmdline paramter)

 if you have any other common panel configuration should be add ,
please inform me.

 thanks.
>>
>>
>> Some things to fix, see comments in the follwoing.
>>
>>         Sam
>>
>> >
>> > Signed-off-by: dillon min <dillon.minfei@gmail.com>
>> > ---
>> >  drivers/gpu/drm/panel/Kconfig                |   8 +
>> >  drivers/gpu/drm/panel/Makefile               |   1 +
>> >  drivers/gpu/drm/panel/panel-ilitek-ili9341.c | 561 ++++++++++++++++++=
+++++++++
>> >  3 files changed, 570 insertions(+)
>> >  create mode 100644 drivers/gpu/drm/panel/panel-ilitek-ili9341.c
>> >
>> > diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kco=
nfig
>> > index a1723c1..e42692c 100644
>> > --- a/drivers/gpu/drm/panel/Kconfig
>> > +++ b/drivers/gpu/drm/panel/Kconfig
>> > @@ -95,6 +95,14 @@ config DRM_PANEL_ILITEK_IL9322
>> >         Say Y here if you want to enable support for Ilitek IL9322
>> >         QVGA (320x240) RGB, YUV and ITU-T BT.656 panels.
>> >
>> > +config DRM_PANEL_ILITEK_IL9341
>> ILI9341 - so the config name matches the name of the driver IC.
>>
>> > +     tristate "Ilitek ILI9341 240x320 QVGA panels"
>> > +     depends on OF && SPI
>> > +     select REGMAP
>> > +     help
>> > +       Say Y here if you want to enable support for Ilitek IL9341
>> > +       QVGA (240x320) RGB panels.
>> See comment to the changelog, the driver is more generic - I assume.
>> So the wording here can be improved to express this.
>>

dillon:  Add support RGB 16bits and RGB 18bits bus only ?

>>
>> > +
>> >  config DRM_PANEL_ILITEK_ILI9881C
>> >       tristate "Ilitek ILI9881C-based panels"
>> >       depends on OF
>> > diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Ma=
kefile
>> > index 96a883c..d123543 100644
>> > --- a/drivers/gpu/drm/panel/Makefile
>> > +++ b/drivers/gpu/drm/panel/Makefile
>> > @@ -8,6 +8,7 @@ obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) +=3D panel-elid=
a-kd35t133.o
>> >  obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) +=3D panel-feixin-k101-im=
2ba02.o
>> >  obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) +=3D panel-feiyang-fy=
07024di26a30d.o
>> >  obj-$(CONFIG_DRM_PANEL_ILITEK_IL9322) +=3D panel-ilitek-ili9322.o
>> > +obj-$(CONFIG_DRM_PANEL_ILITEK_IL9341) +=3D panel-ilitek-ili9341.o
>> >  obj-$(CONFIG_DRM_PANEL_ILITEK_ILI9881C) +=3D panel-ilitek-ili9881c.o
>> >  obj-$(CONFIG_DRM_PANEL_INNOLUX_P079ZCA) +=3D panel-innolux-p079zca.o
>> >  obj-$(CONFIG_DRM_PANEL_JDI_LT070ME05000) +=3D panel-jdi-lt070me05000.=
o
>> > diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gp=
u/drm/panel/panel-ilitek-ili9341.c
>> > new file mode 100644
>> > index 0000000..ec22d80
>> > --- /dev/null
>> > +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
>> > @@ -0,0 +1,561 @@
>> > +// SPDX-License-Identifier: GPL-2.0-only
>> > +/*
>> > + * Ilitek ILI9341 TFT LCD drm_panel driver.
>> > + *
>> > + * This panel can be configured to support:
>> > + * - 16-bit parallel RGB interface
>> The interface to ILI9341 is SPI, and the interface between the ILI9341
>> and the panel is more of an itnernal thing. Or did I get this worng?
>>

dillon: SPI is for register configuration.  RGB parallel for data transfer

>
>> > + *
>> > + * Copyright (C) 2020 Dillon Min <dillon.minfei@gmail.com>
>> > + * Derived from drivers/drm/gpu/panel/panel-ilitek-ili9322.c
>> > + */
>> > +
>> > +#include <linux/bitops.h>
>> > +#include <linux/gpio/consumer.h>
>> > +#include <linux/module.h>
>> > +#include <linux/of_device.h>
>> > +#include <linux/regmap.h>
>> > +#include <linux/regulator/consumer.h>
>> > +#include <linux/spi/spi.h>
>> > +
>> > +#include <video/mipi_display.h>
>> > +#include <video/of_videomode.h>
>> > +#include <video/videomode.h>
>> > +
>> > +#include <drm/drm_modes.h>
>> > +#include <drm/drm_panel.h>
>> > +#include <drm/drm_print.h>
>> > +
>> > +#define DEFAULT_SPI_SPEED    10000000
>> > +
>>
>> Please use same case for hex numbers in the driver.
>> My personal preferences is lower-case.
>>

dillon:
 in next patch, spi speed will be configured by dts, not hardcode here.
 below register address will change to lower-case hex numbers.

>
>>
>> > +#define ILI9341_SLEEP_OUT            0x11   /* Sleep out register */
>> > +#define ILI9341_GAMMA                0x26   /* Gamma register */
>> > +#define ILI9341_DISPLAY_OFF          0x28   /* Display off register *=
/
>> > +#define ILI9341_DISPLAY_ON           0x29   /* Display on register */
>> > +#define ILI9341_COLUMN_ADDR          0x2A   /* Colomn address registe=
r */
>> > +#define ILI9341_PAGE_ADDR            0x2B   /* Page address register =
*/
>> > +#define ILI9341_GRAM                 0x2C   /* GRAM register */
>> > +#define ILI9341_MAC                  0x36   /* Memory Access Control =
register*/
>> > +#define ILI9341_PIXEL_FORMAT         0x3A   /* Pixel Format register =
*/
>> > +#define ILI9341_WDB                  0x51   /* Write Brightness Displ=
ay
>> > +                                          * register
>> > +                                          */
>> > +#define ILI9341_WCD                  0x53   /* Write Control Display
>> > +                                          * register
>> > +                                          */
>> > +#define ILI9341_RGB_INTERFACE        0xB0   /* RGB Interface Signal C=
ontrol */
>> > +#define ILI9341_FRC                  0xB1   /* Frame Rate Control reg=
ister */
>> > +#define ILI9341_BPC                  0xB5   /* Blanking Porch Control
>> > +                                          * register
>> > +                                          */
>> > +#define ILI9341_DFC                  0xB6   /* Display Function Contr=
ol
>> > +                                          * register
>> > +                                          */
>> > +#define ILI9341_POWER1               0xC0   /* Power Control 1 regist=
er */
>> > +#define ILI9341_POWER2               0xC1   /* Power Control 2 regist=
er */
>> > +#define ILI9341_VCOM1                0xC5   /* VCOM Control 1 registe=
r */
>> > +#define ILI9341_VCOM2                0xC7   /* VCOM Control 2 registe=
r */
>> > +#define ILI9341_POWERA               0xCB   /* Power control A regist=
er */
>> > +#define ILI9341_POWERB               0xCF   /* Power control B regist=
er */
>> > +#define ILI9341_PGAMMA               0xE0   /* Positive Gamma Correct=
ion
>> > +                                          * register
>> > +                                          */
>> > +#define ILI9341_NGAMMA               0xE1   /* Negative Gamma Correct=
ion
>> > +                                          * register
>> > +                                          */
>> > +#define ILI9341_DTCA                 0xE8   /* Driver timing control =
A */
>> > +#define ILI9341_DTCB                 0xEA   /* Driver timing control =
B */
>> > +#define ILI9341_POWER_SEQ            0xED   /* Power on sequence regi=
ster */
>> > +#define ILI9341_3GAMMA_EN            0xF2   /* 3 Gamma enable registe=
r */
>> > +#define ILI9341_INTERFACE            0xF6   /* Interface control regi=
ster */
>> > +#define ILI9341_PRC                  0xF7   /* Pump ratio control reg=
ister */
>> > +
>>
>> All the following should be const.
>

dillon: ok

>
>>
>> Can any of the below be replaces by DEFINED constants?
>> > +static u8 ili9341_cmd0[] =3D {0xc3, 0x08, 0x50};
>> > +static u8 ili9341_powerb[] =3D {0x00, 0xc1, 0x30};
>> > +static u8 ili9341_power_seq[] =3D {0x64, 0x03, 0x12, 0x81};
>> > +static u8 ili9341_dtca[] =3D {0x85, 0x00, 0x78};
>> > +static u8 ili9341_powera[] =3D {0x39, 0x2c, 0x00, 0x34, 0x02};
>> > +static u8 ili9341_prc[] =3D {0x20};
>> > +static u8 ili9341_dtcb[] =3D {0x00, 0x00};
>> > +static u8 ili9341_frc[] =3D {0x00, 0x1b};
>> > +static u8 ili9341_dfc1[] =3D {0x0a, 0xa2};
>> > +static u8 ili9341_power1[] =3D {0x10};
>> > +static u8 ili9341_power2[] =3D {0x10};
>> > +static u8 ili9341_vcom1[] =3D {0x45, 0x15};
>> > +static u8 ili9341_vcom2[] =3D {0x90};
>> > +static u8 ili9341_mac[] =3D {0xc8};
>> > +static u8 ili9341_gamma_en[] =3D {0x00};
>> > +static u8 ili9341_rgb_intr[] =3D {0xc2};
>> > +static u8 ili9341_dfc2[] =3D {0x0a, 0xa7, 0x27, 0x04};
>> > +static u8 ili9341_column_addr[] =3D {0x00, 0x00, 0x00, 0xef};
>> > +static u8 ili9341_page_addr[] =3D {0x00, 0x00, 0x01, 0x3f};
>> > +static u8 ili9341_intr[] =3D {0x01, 0x00, 0x06};
>> > +static u8 ili9341_gamma[] =3D {0x01};
>> > +static u8 ili9341_pgamma[] =3D {0x0f, 0x29, 0x24, 0x0c, 0x0e, 0x09, 0=
x4e, 0x78,
>> > +                             0x3c, 0x09, 0x13, 0x05, 0x17, 0x11, 0x00=
};
>> > +static u8 ili9341_ngamma[] =3D {0x00, 0x16, 0x1b, 0x04, 0x11, 0x07, 0=
x31, 0x33,
>> > +                             0x42, 0x05, 0x0c, 0x0a, 0x28, 0x2f, 0x0f=
};
>> > +
>> > +/**
>> > + * enum ili9341_input - the format of the incoming signal to the pane=
l
>> > + *
>> > + * The panel can be connected to various input streams and four of th=
em can
>> > + * be selected by electronic straps on the display. However it is pos=
sible
>> > + * to select another mode or override the electronic default with thi=
s
>> > + * setting.
>> > + */
>> > +enum ili9341_input {
>> > +     ILI9341_INPUT_PRGB_THROUGH =3D 0x0,
>> > +     ILI9341_INPUT_PRGB_ALIGNED =3D 0x1,
>> > +     ILI9341_INPUT_UNKNOWN =3D 0xf,
>> > +};
>> > +
>> > +/**
>> > + * struct ili9341_config - the system specific ILI9341 configuration
>> > + * @width_mm: physical panel width [mm]
>> > + * @height_mm: physical panel height [mm]
>> > + * @input: the input/entry type used in this system, if this is set t=
o
>> > + * ILI9341_INPUT_UNKNOWN the driver will try to figure it out by prob=
ing
>> > + * the hardware
>> > + * @dclk_active_high: data/pixel clock active high, data will be cloc=
ked
>> > + * in on the rising edge of the DCLK (this is usually the case).
>> > + * @de_active_high: DE (data entry) is active high
>> > + * @hsync_active_high: HSYNC is active high
>> > + * @vsync_active_high: VSYNC is active high
>> > + */
>> > +struct ili9341_config {
>> > +     u32 width_mm;
>> > +     u32 height_mm;
>> > +     enum ili9341_input input;
>> > +     bool dclk_active_high;
>> > +     bool de_active_high;
>> > +     bool hsync_active_high;
>> > +     bool vsync_active_high;
>> > +};
>> > +
>> > +struct ili9341 {
>> > +     struct device *dev;
>> > +     const struct ili9341_config *conf;
>> > +     struct drm_panel panel;
>> > +     struct regmap *regmap;
>> > +     struct gpio_desc *reset_gpio;
>> > +     struct gpio_desc *dc_gpio;
>> > +     enum ili9341_input input;
>>
>> > +     struct videomode vm;
>> videomode is not used. So drop this field and drop the include files
>> that are no logner needed.
>>

dillon: ok

>>
>> > +};
>> > +
>> > +static inline struct ili9341 *panel_to_ili9341(struct drm_panel *pane=
l)
>> > +{
>> > +     return container_of(panel, struct ili9341, panel);
>> > +}
>> > +
>> > +int ili9341_spi_transfer(struct spi_device *spi, u32 speed_hz,
>> > +                       u8 bpw, const void *buf, size_t len)
>> > +{
>> > +     size_t max_chunk =3D spi_max_transfer_size(spi);
>> > +     struct spi_transfer tr =3D {
>> const?
>>

dillon: ok

>>
>> > +             .bits_per_word =3D bpw,
>> > +             .speed_hz =3D speed_hz,
>> > +             .len =3D len,
>> > +     };
>> > +     struct spi_message m;
>> > +     size_t chunk;
>> > +     int ret;
>> > +
>> > +     spi_message_init_with_transfers(&m, &tr, 1);
>> > +
>> > +     while (len) {
>> > +             chunk =3D min(len, max_chunk);
>> > +
>> > +             tr.tx_buf =3D buf;
>> > +             tr.len =3D chunk;
>> > +             buf +=3D chunk;
>> > +             len -=3D chunk;
>> > +
>> > +             ret =3D spi_sync(spi, &m);
>> > +             if (ret)
>> > +                     return ret;
>> > +     }
>> > +     return 0;
>> > +}
>> > +static int ili9341_regmap_spi_write(void *context, const void *data,
>> > +                                 size_t count)
>> > +{
>> > +     struct device *dev =3D context;
>> > +     struct spi_device *spi =3D to_spi_device(dev);
>> > +     struct ili9341 *ili =3D spi_get_drvdata(spi);
>> > +     int ret =3D 0;
>> > +
>> > +     gpiod_set_value_cansleep(ili->dc_gpio, 0);
>> > +
>> > +     ret =3D ili9341_spi_transfer(spi, DEFAULT_SPI_SPEED, 8, data+0, =
1);
>> > +     if (ret || count =3D=3D 1 ||
>> > +                     ((u8 *)data)[0] =3D=3D ILI9341_GRAM ||
>> > +                     ((u8 *)data)[0] =3D=3D ILI9341_DISPLAY_ON ||
>> > +                     ((u8 *)data)[0] =3D=3D ILI9341_SLEEP_OUT ||
>> > +                     ((u8 *)data)[0] =3D=3D ILI9341_DISPLAY_OFF)
>> > +             return ret;
>> > +
>> > +     gpiod_set_value_cansleep(ili->dc_gpio, 1);
>> > +
>> > +     return ili9341_spi_transfer(spi, DEFAULT_SPI_SPEED, 8, data+1, c=
ount-1);
>> > +}
>> > +
>> > +static int ili9341_regmap_spi_read(void *context, const void *reg,
>> > +                                size_t reg_size, void *val, size_t va=
l_size)
>> > +{
>> > +     return 0;
>> > +}
>> Is this function really needed? If not delete it.
>>
> regmap will be drop in next patch.
>>
>> > +
>> > +static struct regmap_bus ili9341_regmap_bus =3D {
>> > +     .write =3D ili9341_regmap_spi_write,
>> > +     .read =3D ili9341_regmap_spi_read,
>> > +     .reg_format_endian_default =3D REGMAP_ENDIAN_BIG,
>> > +     .val_format_endian_default =3D REGMAP_ENDIAN_BIG,
>> > +};
>> > +
>> > +static bool ili9341_volatile_reg(struct device *dev, unsigned int reg=
)
>> > +{
>> > +     return false;
>> > +}
>> Is this function really nedded? If not delete it.
>>
>> > +
>> > +static bool ili9341_writeable_reg(struct device *dev, unsigned int re=
g)
>> > +{
>> > +     /* Just register 0 is read-only */
>> > +     if (reg =3D=3D 0x00)
>> > +             return false;
>> > +     return true;
>> > +}
>> > +
>> > +static const struct regmap_config ili9341_regmap_config =3D {
>> > +     .reg_bits =3D 8,
>> > +     .val_bits =3D 8,
>> > +     .max_register =3D 0xff,
>> > +     .cache_type =3D REGCACHE_RBTREE,
>> > +     .volatile_reg =3D ili9341_volatile_reg,
>> > +     .writeable_reg =3D ili9341_writeable_reg,
>> > +};
>> > +
>>
>> No error checks - consider something like:
>>
>> static int bulk_write(struct ili9341 *ili, u8 reg, const u8[] data, int =
len)
>> {
>>         int err =3D ili->err;
>>
>>         if (!err) {
>>                 err =3D regmap_bulk_write(ili->regmap, reg, data, len);
>>                 if (err) {
>>                         dev_err(...);
>>                         ili->err =3D err;
>>                 }
>>         }
>>
>>         return err;
>> }
>>
>> Then you can use this in the following, and make this more readable.
>>

dillon: ok, thanks for detail guide.

>
>>
>> > +static int ili9341_init(struct drm_panel *panel, struct ili9341 *ili)
>> > +{
>> > +     regmap_bulk_write(ili->regmap, 0xca,
>> > +                                     ili9341_cmd0, sizeof(ili9341_cmd=
0));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_POWERB,
>> > +                             ili9341_powerb, sizeof(ili9341_powerb));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_POWER_SEQ,
>> > +                             ili9341_power_seq, sizeof(ili9341_power_=
seq));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_DTCA,
>> > +                             ili9341_dtca, sizeof(ili9341_dtca));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_POWERA,
>> > +                             ili9341_powera, sizeof(ili9341_powera));
>> > +     regmap_write(ili->regmap, ILI9341_PRC, ili9341_prc[0]);
>> > +     regmap_bulk_write(ili->regmap, ILI9341_DTCB,
>> > +                             ili9341_dtcb, sizeof(ili9341_dtcb));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_FRC,
>> > +                             ili9341_frc, sizeof(ili9341_frc));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_DFC,
>> > +                             ili9341_dfc1, sizeof(ili9341_dfc1));
>> > +     regmap_write(ili->regmap, ILI9341_POWER1, ili9341_power1[0]);
>> > +     regmap_write(ili->regmap, ILI9341_POWER2, ili9341_power2[0]);
>> > +     regmap_bulk_write(ili->regmap, ILI9341_VCOM1,
>> > +                             ili9341_vcom1, sizeof(ili9341_vcom1));
>> > +     regmap_write(ili->regmap, ILI9341_VCOM2, ili9341_vcom2[0]);
>> > +     regmap_write(ili->regmap, ILI9341_MAC, ili9341_mac[0]);
>> > +     regmap_write(ili->regmap, ILI9341_3GAMMA_EN, ili9341_gamma_en[0]=
);
>> > +     regmap_write(ili->regmap, ILI9341_RGB_INTERFACE, ili9341_rgb_int=
r[0]);
>> > +     regmap_bulk_write(ili->regmap, ILI9341_DFC,
>> > +                             ili9341_dfc2, sizeof(ili9341_dfc2));
>> > +
>> > +     /* colomn address set */
>> > +     regmap_bulk_write(ili->regmap, ILI9341_COLUMN_ADDR,
>> > +                     ili9341_column_addr, sizeof(ili9341_column_addr)=
);
>> > +
>> > +     /* Page Address Set */
>> > +     regmap_bulk_write(ili->regmap, ILI9341_PAGE_ADDR,
>> > +                             ili9341_page_addr, sizeof(ili9341_page_a=
ddr));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_INTERFACE,
>> > +                             ili9341_intr, sizeof(ili9341_intr));
>> > +     regmap_write(ili->regmap, ILI9341_GRAM, 0);
>> > +     msleep(200);
>> > +
>> > +     regmap_write(ili->regmap, ILI9341_GAMMA, ili9341_gamma[0]);
>> > +     regmap_bulk_write(ili->regmap, ILI9341_PGAMMA,
>> > +                             ili9341_pgamma, sizeof(ili9341_pgamma));
>> > +     regmap_bulk_write(ili->regmap, ILI9341_NGAMMA,
>> > +                             ili9341_ngamma, sizeof(ili9341_ngamma));
>> > +     regmap_write(ili->regmap, ILI9341_SLEEP_OUT, 0);
>> > +     msleep(200);
>> > +
>> > +     regmap_write(ili->regmap, ILI9341_DISPLAY_ON, 0);
>> > +
>> > +     /* GRAM start writing */
>> > +     regmap_write(ili->regmap, ILI9341_GRAM, 0);
>> > +
>> > +     dev_info(ili->dev, "initialized display\n");
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +/*
>> > + * This power-on sequence if from the datasheet, page 57.
>> > + */
>> > +static int ili9341_power_on(struct ili9341 *ili)
>> > +{
>> > +     /* Assert RESET */
>> > +     gpiod_set_value(ili->reset_gpio, 1);
>> > +
>> > +     msleep(20);
>> > +
>> > +     /* De-assert RESET */
>> > +     gpiod_set_value(ili->reset_gpio, 0);
>> > +
>> > +     msleep(10);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int ili9341_power_off(struct ili9341 *ili)
>> > +{
>>
>>         Assert reset?

dillon: will add reset-pin control here.

>
>
>>
>> > +     return 0;
>> > +}
>> > +
>> > +static int ili9341_disable(struct drm_panel *panel)
>> > +{
>> > +     struct ili9341 *ili =3D panel_to_ili9341(panel);
>> > +     int ret;
>> > +
>> > +     ret =3D regmap_write(ili->regmap, ILI9341_DISPLAY_OFF, 0);
>> > +     if (ret) {
>> > +             dev_err(ili->dev, "unable to go to standby mode\n");
>> > +             return ret;
>> > +     }
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int ili9341_unprepare(struct drm_panel *panel)
>> > +{
>> > +     struct ili9341 *ili =3D panel_to_ili9341(panel);
>> > +
>> > +     return ili9341_power_off(ili);
>> > +}
>> > +
>> > +static int ili9341_prepare(struct drm_panel *panel)
>> > +{
>> > +     struct ili9341 *ili =3D panel_to_ili9341(panel);
>> > +     int ret;
>> > +
>> > +     ret =3D ili9341_power_on(ili);
>> > +     if (ret < 0)
>> > +             return ret;
>> > +
>> > +     ret =3D ili9341_init(panel, ili);
>> > +     if (ret < 0)
>> > +             ili9341_unprepare(panel);
>> > +
>> > +     return ret;
>> > +}
>> > +
>> > +static int ili9341_enable(struct drm_panel *panel)
>> > +{
>> > +     struct ili9341 *ili =3D panel_to_ili9341(panel);
>> > +     int ret;
>> > +
>> > +     ret =3D regmap_write(ili->regmap, ILI9341_DISPLAY_ON, 0);
>> > +     if (ret) {
>> > +             dev_err(ili->dev, "unable to enable panel\n");
>> > +             return ret;
>> > +     }
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +/* This is the only mode listed for parallel RGB in the datasheet */
>> > +static const struct drm_display_mode prgb_320x240_mode =3D {
>> > +     .clock =3D 6100,
>> > +     .hdisplay =3D 240,
>> > +     .hsync_start =3D 240 + 10,
>> > +     .hsync_end =3D 240 + 10 + 10,
>> > +     .htotal =3D 280,
>> > +     .vdisplay =3D 320,
>> > +     .vsync_start =3D 320 + 4,
>> > +     .vsync_end =3D 320 + 4 + 2,
>> > +     .vtotal =3D 328,
>> > +     .vrefresh =3D 60,
>> > +     .flags =3D 0,
>> > +};
>> > +
>> > +static int ili9341_get_modes(struct drm_panel *panel,
>> > +                             struct drm_connector *connector)
>> > +{
>> > +     struct ili9341 *ili =3D panel_to_ili9341(panel);
>> > +     struct drm_device *drm =3D connector->dev;
>> > +     struct drm_display_mode *mode;
>> > +     struct drm_display_info *info;
>> > +
>> > +     info =3D &connector->display_info;
>> > +     info->width_mm =3D ili->conf->width_mm;
>> > +     info->height_mm =3D ili->conf->height_mm;
>> > +     if (ili->conf->dclk_active_high)
>> > +             info->bus_flags |=3D DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
>> > +     else
>> > +             info->bus_flags |=3D DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE;
>> > +
>> > +     if (ili->conf->de_active_high)
>> > +             info->bus_flags |=3D DRM_BUS_FLAG_DE_HIGH;
>> > +     else
>> > +             info->bus_flags |=3D DRM_BUS_FLAG_DE_LOW;
>> > +
>> > +     switch (ili->input) {
>> > +     case ILI9341_INPUT_PRGB_THROUGH:
>> > +     case ILI9341_INPUT_PRGB_ALIGNED:
>> > +             mode =3D drm_mode_duplicate(drm, &prgb_320x240_mode);
>> > +             break;
>> > +     default:
>> > +             mode =3D NULL;
>> > +             break;
>> > +     }
>> > +     if (!mode) {
>> > +             DRM_ERROR("bad mode or failed to add mode\n");
>> > +             return -EINVAL;
>> > +     }
>> > +     drm_mode_set_name(mode);
>> > +     /*
>> > +      * This is the preferred mode because most people are going
>> > +      * to want to use the display with VGA type graphics.
>> > +      */
>> > +     mode->type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED;
>> > +
>> > +     /* Set up the polarity */
>> > +     if (ili->conf->hsync_active_high)
>> > +             mode->flags |=3D DRM_MODE_FLAG_PHSYNC;
>> > +     else
>> > +             mode->flags |=3D DRM_MODE_FLAG_NHSYNC;
>> > +     if (ili->conf->vsync_active_high)
>> > +             mode->flags |=3D DRM_MODE_FLAG_PVSYNC;
>> > +     else
>> > +             mode->flags |=3D DRM_MODE_FLAG_NVSYNC;
>> > +
>> > +     mode->width_mm =3D ili->conf->width_mm;
>> > +     mode->height_mm =3D ili->conf->height_mm;
>> > +     drm_mode_probed_add(connector, mode);
>> > +
>> > +     return 1; /* Number of modes */
>> > +}
>> > +
>> > +static const struct drm_panel_funcs ili9341_drm_funcs =3D {
>> > +     .disable =3D ili9341_disable,
>> > +     .unprepare =3D ili9341_unprepare,
>> > +     .prepare =3D ili9341_prepare,
>> > +     .enable =3D ili9341_enable,
>> > +     .get_modes =3D ili9341_get_modes,
>> > +};
>> > +
>> > +static int ili9341_probe(struct spi_device *spi)
>> > +{
>> > +     struct device *dev =3D &spi->dev;
>> > +     struct ili9341 *ili;
>> > +     const struct regmap_config *regmap_config;
>> > +     int ret;
>> > +
>> > +     ili =3D devm_kzalloc(dev, sizeof(struct ili9341), GFP_KERNEL);
>> > +     if (!ili)
>> > +             return -ENOMEM;
>> > +
>> > +     spi_set_drvdata(spi, ili);
>> > +
>> > +     ili->dev =3D dev;
>> > +     /*
>> > +      * Every new incarnation of this display must have a unique
>> > +      * data entry for the system in this driver.
>> > +      */
>> > +     ili->conf =3D of_device_get_match_data(dev);
>> > +     if (!ili->conf) {
>> > +             dev_err(dev, "missing device configuration\n");
>> > +             return -ENODEV;
>> > +     }
>> > +
>> > +     ili->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_=
OUT_HIGH);
>> > +     if (IS_ERR(ili->reset_gpio)) {
>> > +             dev_err(dev, "failed to get RESET GPIO\n");
>> > +             return PTR_ERR(ili->reset_gpio);
>> > +     }
>> > +
>> > +     ili->dc_gpio =3D devm_gpiod_get_optional(dev, "dc", GPIOD_OUT_LO=
W);
>> > +     if (IS_ERR(ili->dc_gpio)) {
>> > +             dev_err(dev, "failed to get DC GPIO\n");
>> > +             return PTR_ERR(ili->dc_gpio);
>> > +     }
>> > +
>> > +     spi->bits_per_word =3D 8;
>> > +     ret =3D spi_setup(spi);
>> > +     if (ret < 0) {
>> > +             dev_err(dev, "spi setup failed.\n");
>> > +             return ret;
>> > +     }
>> > +
>> > +     regmap_config =3D &ili9341_regmap_config;
>> > +
>> > +     ili->regmap =3D devm_regmap_init(dev, &ili9341_regmap_bus, dev,
>> > +                                    regmap_config);
>> > +     if (IS_ERR(ili->regmap)) {
>> > +             dev_err(dev, "failed to allocate register map\n");
>> > +             return PTR_ERR(ili->regmap);
>> > +     }
>> > +
>> > +     ili->input =3D ili->conf->input;
>> > +
>> > +     drm_panel_init(&ili->panel, dev, &ili9341_drm_funcs,
>> > +                    DRM_MODE_CONNECTOR_DPI);
>> > +
>> > +     return drm_panel_add(&ili->panel);
>> > +}
>> > +
>> > +static int ili9341_remove(struct spi_device *spi)
>> > +{
>> > +     struct ili9341 *ili =3D spi_get_drvdata(spi);
>> > +
>> > +     ili9341_power_off(ili);
>> > +     drm_panel_remove(&ili->panel);
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +/*
>> > + * The Stm32f429-disco board has a panel ili9341 connected to ltdc co=
ntroller
>> > + */
>> > +static const struct ili9341_config ili9341_data =3D {
>> This should be named "disco" something as this is m32f429-disco
>> specific.
>>

dillon: ok

>>
>> > +     .width_mm =3D 65,
>> > +     .height_mm =3D 50,
>> > +     .input =3D ILI9341_INPUT_PRGB_THROUGH,
>> > +     .dclk_active_high =3D true,
>> > +     .de_active_high =3D false,
>> > +     .hsync_active_high =3D false,
>> > +     .vsync_active_high =3D false,
>> > +};
>> > +
>> > +static const struct of_device_id ili9341_of_match[] =3D {
>> > +     {
>> > +             .compatible =3D "stm32f429,ltdc-panel",
>> > +             .data =3D &ili9341_data,
>> > +     },
>>
>>
>> > +     {
>> > +             .compatible =3D "ilitek,ili9341",
>> > +             .data =3D NULL,
>> This part is wrong, as ilitek,ili9341 is just the generic part.
>> Only the first entry is relevant.
>>
>>

dillon: ok

>>
>> > +     },
>> > +     { }
>> > +};
>> > +MODULE_DEVICE_TABLE(of, ili9341_of_match);
>> > +
>> > +static struct spi_driver ili9341_driver =3D {
>> > +     .probe =3D ili9341_probe,
>> > +     .remove =3D ili9341_remove,
>> > +     .driver =3D {
>> > +             .name =3D "panel-ilitek-ili9341",
>> > +             .of_match_table =3D ili9341_of_match,
>> > +     },
>> > +};
>> > +module_spi_driver(ili9341_driver);
>> > +
>> > +MODULE_AUTHOR("Dillon Min <dillon.minfei@gmail.com>");
>> > +MODULE_DESCRIPTION("ILI9341 LCD panel driver");
>> > +MODULE_LICENSE("GPL v2");
>> > --
>> > 2.7.4
