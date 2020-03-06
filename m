Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0443C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B70132084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="h1wRygVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCFOrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:47:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41868 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFOrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:47:37 -0500
Received: by mail-wr1-f68.google.com with SMTP id v4so2674084wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZmRC/N2ckJqEm1pBTImhJ1/ZTJbIyevuERQcpQPPkHg=;
        b=h1wRygVr/++xKK0PhRWtU9PREVeo2ayHMR63B1Q3qEb0c065ocBuc8HiwdrloplBdw
         QPzu0ac+FfoqjBdnRwhj6wxLr5uPU0JaSO32MqnZyR/QSBLs4d3+QOJlltmXlWavNrU0
         dwvlMICfEACqL74IIZE5zasZTh7azljI9aU1XsDufE+fCBrNdXswE4GXvZswIKHuvURx
         K2V5LokUNEN3SJGOI9bpcqBkM1vTwQY7ZO4FRwY5URMdpaCTHY4ZX7NPAaCwfj8PsSCE
         6Ex4LFXWDP3pTH+Tem5CDo3DJkVy5sQrPVaQbOx+Ri9stdO137ibNysr9Wi0aDbg8JDp
         TJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZmRC/N2ckJqEm1pBTImhJ1/ZTJbIyevuERQcpQPPkHg=;
        b=h33aHWQo3iCOptdqMw7ZPlGDk9aeqGBWsFlqs7hZzvEEjbbTsURElPnKwDzgDUMSb1
         j9JF10grRZok6EUmb22sv2OjCelP8zcsYkPE3BRibpj619Wl22rQ7jKEW7kE16GQNpVs
         UqWJohrju7pX6qZ0YWkiGXcKtufguD8L2lXX1qyzgArgqKKbjbgoID+dRF4+e8FwXYf8
         YvdH09r7DVrtP84wLIdakIDniLQDsk0SvM70Ewq/+/VbpdJZOY8XLiBT6SfvCayn0wuI
         bvwqxg2oJuGLYqdec7NcC+B9xz/aqzf9BqZGAU+RbFcGXO8jrRd1NmW7GCJqM7SoNyM6
         slNg==
X-Gm-Message-State: ANhLgQ2W+X9JkDFA3m7071aeqGD3o1G713AqiG0P6L81uKFVdnjwpMKF
        zAfCAJvwgmFDle0t5+wY+zjeMi3UKuTn1NW6cUmpj0nJIa0=
X-Google-Smtp-Source: ADFU+vuBGr0bbFfHhOsjL97WZnhR9NLT215RcLNRAO7J/UBZTreFv3F8tQaLNzE17XnXgl+kjCWtqu97MKvnZfKD9pM=
X-Received: by 2002:a5d:638a:: with SMTP id p10mr4342071wru.42.1583506054904;
 Fri, 06 Mar 2020 06:47:34 -0800 (PST)
MIME-Version: 1.0
References: <20200306103246.22213-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200306103246.22213-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200306103246.22213-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 6 Mar 2020 14:47:18 +0000
Message-ID: <CAPY8ntCuXgzQTi2=d_sd_t1ucnCgfGM64E3aNR_MuGonnHnifA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] media: i2c: imx219: Add support for cropped
 640x480 resolution
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pabhakar

Thanks for the update. One very minor nit-pick.

On Fri, 6 Mar 2020 at 10:33, Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> This patch adds mode table entry for capturing cropped 640x480 resolution
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/media/i2c/imx219.c | 72 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index f96f3ce9fd85..6a86f500ec48 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -54,6 +54,7 @@
>  #define IMX219_VTS_15FPS               0x0dc6
>  #define IMX219_VTS_30FPS_1080P         0x06e3
>  #define IMX219_VTS_30FPS_BINNED                0x06e3
> +#define IMX219_VTS_30FPS_640x480       0x06e3

Thanks on updating this - I can confirm the default is now 30fps
rather than the 90 I was seeing before.
Reducing vertical blanking down to the minimum 4 lines give me
109.3fps and all still working properly :-)

>  #define IMX219_VTS_MAX                 0xffff
>
>  #define IMX219_VBLANK_MIN              4
> @@ -142,8 +143,8 @@ struct imx219_mode {
>
>  /*
>   * Register sets lifted off the i2C interface from the Raspberry Pi firmware
> - * driver.
> - * 3280x2464 = mode 2, 1920x1080 = mode 1, and 1640x1232 = mode 4.
> + * driver for resolutions 3280x2464, 1920x1080 and 1640x1232.
> + * 3280x2464 = mode 2, 1920x1080 = mode 1, 1640x1232 = mode 4, 640x480 = mode 1.

640x480 has come from mode 1 of the firmware? mode 1 is the 1080p mode.

Having checked through the register settings they are identical to
those used by the Pi firmware for mode 7, see [1]. You could quote
that rather than stating that they were derived by yourself.

One of Sony's concerns when I discussed upstreaming this driver with
them was that people might add modes with random register settings. If
the image quality was then sub-standard they'd unjustly look bad. They
validated and blessed the register sets that we were using in the Pi
firmware, so retaining that parentage will make them happy.

[1] https://github.com/6by9/raspiraw/blob/master/imx219_modes.h#L506

>   */
>  static const struct imx219_reg mode_3280x2464_regs[] = {
>         {0x0100, 0x00},
> @@ -318,6 +319,63 @@ static const struct imx219_reg mode_1640_1232_regs[] = {
>         {0x0163, 0x78},
>  };
>
> +static const struct imx219_reg mode_640_480_regs[] = {
> +       {0x0100, 0x00},
> +       {0x30eb, 0x05},
> +       {0x30eb, 0x0c},
> +       {0x300a, 0xff},
> +       {0x300b, 0xff},
> +       {0x30eb, 0x05},
> +       {0x30eb, 0x09},
> +       {0x0114, 0x01},
> +       {0x0128, 0x00},
> +       {0x012a, 0x18},
> +       {0x012b, 0x00},
> +       {0x0162, 0x0d},
> +       {0x0163, 0x78},
> +       {0x0164, 0x03},
> +       {0x0165, 0xe8},
> +       {0x0166, 0x08},
> +       {0x0167, 0xe7},
> +       {0x0168, 0x02},
> +       {0x0169, 0xf0},
> +       {0x016a, 0x06},
> +       {0x016b, 0xaf},
> +       {0x016c, 0x02},
> +       {0x016d, 0x80},
> +       {0x016e, 0x01},
> +       {0x016f, 0xe0},
> +       {0x0170, 0x01},
> +       {0x0171, 0x01},
> +       {0x0174, 0x03},
> +       {0x0175, 0x03},
> +       {0x0301, 0x05},
> +       {0x0303, 0x01},
> +       {0x0304, 0x03},
> +       {0x0305, 0x03},
> +       {0x0306, 0x00},
> +       {0x0307, 0x39},
> +       {0x030b, 0x01},
> +       {0x030c, 0x00},
> +       {0x030d, 0x72},
> +       {0x0624, 0x06},
> +       {0x0625, 0x68},
> +       {0x0626, 0x04},
> +       {0x0627, 0xd0},
> +       {0x455e, 0x00},
> +       {0x471e, 0x4b},
> +       {0x4767, 0x0f},
> +       {0x4750, 0x14},
> +       {0x4540, 0x00},
> +       {0x47b4, 0x14},
> +       {0x4713, 0x30},
> +       {0x478b, 0x10},
> +       {0x478f, 0x10},
> +       {0x4793, 0x10},
> +       {0x4797, 0x0e},
> +       {0x479b, 0x0e},
> +};
> +
>  static const char * const imx219_test_pattern_menu[] = {
>         "Disabled",
>         "Color Bars",
> @@ -424,6 +482,16 @@ static const struct imx219_mode supported_modes[] = {
>                         .regs = mode_1640_1232_regs,
>                 },
>         },
> +       {
> +               /* 640x480 30fps mode */
> +               .width = 640,
> +               .height = 480,
> +               .vts_def = IMX219_VTS_30FPS_640x480,
> +               .reg_list = {
> +                       .num_of_regs = ARRAY_SIZE(mode_640_480_regs),
> +                       .regs = mode_640_480_regs,
> +               },
> +       },
>  };
>
>  struct imx219 {
> --
> 2.20.1
>
