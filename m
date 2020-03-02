Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AE9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604C820848
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZF1JAjbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCBPYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:24:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38723 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgCBPYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:24:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id t11so160065wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6/CIkWNCwNaImmXlS8dDLwAcR6sRgPxwGGxRlcKCoVs=;
        b=ZF1JAjbnFfIgiCw6NX8mgzBabbjZJRZ4pT7T3b0Z7AbuYhSseXIOObM0JlCuObWu+Q
         jsc2U3owHmjYwWLA9kG8h9lVtxNutsF4FQA5TPXf6psBmNT7GUs6OM+0kIQv083y0i+a
         yXE70XLBvDPTe+WfDAmBf52LvcXEVoRFkb+AzcOr8/bNEH5GhckOIO4p/nCwvrpeiVIA
         p+mWJyS9xTFDzaV9RmEc2AU1N4+XE97vlAhV3KGI/EBGNILL+WxiS9ZVxxEvzML36cpP
         VHXh2ql3saT3JJyFFAwbcplIvcGUTD/JkVJ68613fQSE55NaDAIl6iHWYGaOHqJOkBv3
         Ik5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6/CIkWNCwNaImmXlS8dDLwAcR6sRgPxwGGxRlcKCoVs=;
        b=FXlSgvFMIQMplUwQ8OS5ycqr+9o/IBIsNlLjXrL3ZllsmyBBqaXHRziitCGeR4DM4u
         CiW35RaCd3qQP7Xv65PpLTkzl9BNopdmxrEREwIKNxJWpascRJ+gnD3ZkmIBpeUhpg0Z
         U2dn67PaiGUxOVYKlX0gARdBYjrm89VudfzzL2cqctfUrqmCnb0tQPWlh9IlmILZ6Yuh
         8PWsiwzS/wukb9EByoFhFAmEtKy5QQbvO176Itu0sYd27/ss4p/02ua8xJkoLdR3b4S2
         ZSA8KJvqYeyA4ymcLlalbNO8Dv9mPeQWtWHVYumO8Kt1A32yS3arUzkLKdjGQlOyalhH
         XazQ==
X-Gm-Message-State: ANhLgQ0WgaYZ6aeymGgOnaQvNvsQczaMyDSOZKwsPs0MiagNIXomzz7J
        6CvwxvBSR+AFlIRT9QQMbcjm/nJRzDcCm0nKlTE3ng==
X-Google-Smtp-Source: ADFU+vvibXAAaRXVSYO3pfwNHCZglN+HZMDcfhsGZWm7NVOMxOJvAA9oxubzIxeaxzXnvUeM97Z2+XnC+/da8ZEZbGk=
X-Received: by 2002:adf:e542:: with SMTP id z2mr160388wrm.150.1583162656640;
 Mon, 02 Mar 2020 07:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20200228165503.18054-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200228165503.18054-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200228165503.18054-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Mon, 2 Mar 2020 15:24:01 +0000
Message-ID: <CAPY8ntBbm2d4b1p__FdyZS52sBV6CtfGKaVrg74Q=3aKeby1nQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: i2c: imx219: Fix power sequence
To:     Lad Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lad.

Thanks again for the patch.

On Fri, 28 Feb 2020 at 16:55, Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> When supporting Rpi Camera v2 Module on the RZ/G2E, found the driver had
> some issues with rcar mipi-csi driver. The sesnosr never entered into LP-11

s/sesnosr/sensor

> state.
>
> The powerup sequence in the datasheet[1] shows the sensor entering into
> LP-11 in streaming mode, so to fix this issue transitions are performed
> from "standby -> streaming -> standby" in the probe().
>
> With this commit the sensor is able to enter LP-11 mode during power up,
> as expected by some CSI-2 controllers.

I guess I'm lucky that the CSI2 receiver I deal with doesn't care on this front.
The datasheet does seem to imply that the line is left in what appears
to be LP-00 after power up, but this feels like a huge amount of stuff
to do.

> [1] https://publiclab.org/system/images/photos/000/023/294/original/
> RASPBERRY_PI_CAMERA_V2_DATASHEET_IMX219PQH5_7.0.0_Datasheet_XXX.PDF
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/media/i2c/imx219.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index f1effb5a5f66..8b48e148f2d0 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -1171,6 +1171,7 @@ static int imx219_check_hwcfg(struct device *dev)
>
>  static int imx219_probe(struct i2c_client *client)
>  {
> +       const struct imx219_reg_list *reg_list;
>         struct device *dev = &client->dev;
>         struct imx219 *imx219;
>         int ret;
> @@ -1224,6 +1225,38 @@ static int imx219_probe(struct i2c_client *client)
>         /* Set default mode to max resolution */
>         imx219->mode = &supported_modes[0];
>
> +       /* sensor doesn't enter to LP-11 state upon power up until and unless

Remove "to"

> +        * streaming is started, so upon power up set the default format and
> +        * switch the modes: standby -> streaming -> standby
> +        */
> +       /* getting sensor out of sleep */
> +       ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
> +                              IMX219_REG_VALUE_08BIT, IMX219_MODE_STANDBY);

The datasheet says the default for IMX219_REG_MODE_SELECT is already 0
/ STANDY, so this should be unnecessary as we've only just powered up.

> +       if (ret < 0)
> +               goto error_power_off;
> +       usleep_range(100, 110);
> +
> +       reg_list = &imx219->mode->reg_list;
> +       ret = imx219_write_regs(imx219, reg_list->regs, reg_list->num_of_regs);
> +       if (ret) {
> +               dev_err(&client->dev, "%s failed to default mode\n", __func__);
> +               goto error_power_off;
> +       }

Seeing as we don't want the images produced, and we're about to power
the sensor back down again, do the default register settings do enough
to allow the shift to LP-11? ie can we drop writing any mode setup
registers here, and just got to STREAMING and back to STANDBY?

> +       /* getting sensor out of sleep */

We already did that above. This is standby->streaming.

> +       ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
> +                              IMX219_REG_VALUE_08BIT, IMX219_MODE_STREAMING);
> +       if (ret < 0)
> +               goto error_power_off;
> +       usleep_range(100, 110);
> +
> +       /* put sensor back to standby mode */
> +       ret = imx219_write_reg(imx219, IMX219_REG_MODE_SELECT,
> +                              IMX219_REG_VALUE_08BIT, IMX219_MODE_STANDBY);
> +       if (ret < 0)
> +               goto error_power_off;
> +       usleep_range(100, 110);
> +
>         ret = imx219_init_controls(imx219);
>         if (ret)
>                 goto error_power_off;
> --
> 2.20.1

Cheers,
  Dave
