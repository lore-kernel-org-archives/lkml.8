Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D497C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A4D2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="BMtYlKzJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgCFNB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:01:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45290 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCFNB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:01:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id v2so2232074wrp.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X5TastwJnrVeQNVKcB2ayuhPbdTnWUMfIHdacFVQq3Q=;
        b=BMtYlKzJjRuyW8XSL9YB+oMlM9yQuU5vNYIAowLfzpYb749vtpM9fnQXSnZq3d45nP
         8W7BgfYBAby0seDVDrYWzGvY9FdBcnbIRkDX39pgULNpQpKn4xNVioydBPlYTaGgPdIl
         hE+EBWzV8I9Wm/mU8k4WNSaO38XFafy8sKj2hnWSbJKQhIDaFpnM1ycw3hvdq+UdI8o5
         ZrRIU6HasJI4D8ZQuczRe8/xxrLYW44/C4g1GGWgxLVYtCgG+xhqQzFCRRkecsgd4Rq3
         i0KgZHXXS30Hk2Yu9YVnPo4zrKnr55g5H/Br1gHt4lfBtaO8v4kDtApGYMFQVYGrrb8g
         kr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X5TastwJnrVeQNVKcB2ayuhPbdTnWUMfIHdacFVQq3Q=;
        b=HnTzDZtgXTExybSnNEIVouzExjX1AtOre5iM+01PrN7MWfGPsXrm4rUDveCFGHm/zk
         LL033kR9xe4sdVuDx4sGPuwcI+7CFQP3uZa+KSaT0F5mmpotoe+8x2vE21KluSX/8RM1
         xiC2+sXcmCeIHFqaZ7rqFXMHbkNIXPphF3XgiNsFkN6DrSYYyOszlTE7P7kEkjBTAj2b
         TZx73MNx/+gp49muPOYj/nRD9SQ16Kohdovtac09+jF9JBztH/lZDch0Gj2z7r6963j1
         wJIPcCqrFA9CyGXug8QoofivToUONQePVPn7x/OR8PSbT0AWw0MbM1u/Sh3WffuLzfez
         rCzg==
X-Gm-Message-State: ANhLgQ0ypcE/q2RVZetcBA0LKzYJVeFYgSzNf8GB8nJBdySxkSWnzVxt
        PWwlAjJ5MySy8YsrY3r6fqefKW1rUaRnGzBII1+qMw==
X-Google-Smtp-Source: ADFU+vtl+p570kweIo5VQ3bsmM9UD6KKBA83iypObT0OERUf4+HZHp03L79qps26qb8khNhLiXjkOnPCuIN8/1D/K3s=
X-Received: by 2002:a5d:69cb:: with SMTP id s11mr3830315wrw.47.1583499716386;
 Fri, 06 Mar 2020 05:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20200306103246.22213-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20200306103246.22213-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200306103246.22213-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Dave Stevenson <dave.stevenson@raspberrypi.com>
Date:   Fri, 6 Mar 2020 13:01:39 +0000
Message-ID: <CAPY8ntD38sM0SXvOEyr2gRCM7WeAY4CjAKcrVfd6MCHB+Ejv0A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] media: i2c: imx219: Fix power sequence
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

Hi Prabhakar.

Thanks for the update.

On Fri, 6 Mar 2020 at 10:32, Lad Prabhakar <prabhakar.csengg@gmail.com> wrote:
>
> When supporting Rpi Camera v2 Module on the RZ/G2E, found the driver had
> some issues with rcar mipi-csi driver. The sensor never entered into LP-11
> state.
>
> The powerup sequence in the datasheet[1] shows the sensor entering into
> LP-11 in streaming mode, so to fix this issue transitions are performed
> from "streaming -> standby" in the probe() after power up.
>
> With this commit the sensor is able to enter LP-11 mode during power up,
> as expected by some CSI-2 controllers.
>
> [1] https://publiclab.org/system/images/photos/000/023/294/original/
> RASPBERRY_PI_CAMERA_V2_DATASHEET_IMX219PQH5_7.0.0_Datasheet_XXX.PDF
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Dave Stevenson <dave.stevenson@raspberrypi.com>


> ---
>  drivers/media/i2c/imx219.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
> index f1effb5a5f66..16010ca1781a 100644
> --- a/drivers/media/i2c/imx219.c
> +++ b/drivers/media/i2c/imx219.c
> @@ -1224,6 +1224,23 @@ static int imx219_probe(struct i2c_client *client)
>         /* Set default mode to max resolution */
>         imx219->mode = &supported_modes[0];
>
> +       /* sensor doesn't enter LP-11 state upon power up until and unless
> +        * streaming is started, so upon power up switch the modes to:
> +        * streaming -> standby
> +        */
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
>
