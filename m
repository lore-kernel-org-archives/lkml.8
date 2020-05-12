Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DB8C54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B8CB206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3m+V+H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgELINn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgELINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:13:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB0BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:13:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id k110so9825616otc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+/M7ttbizVNgiq3E6e56DHlLpnfL10dXQ3P0u57oqQo=;
        b=B3m+V+H5gTjtrCKtwwO492HjhFTr38Y7VLdRIx8Tr0JsnUUVuJfvLNFpAjkYVRe/MU
         OGhuxIOgscPAJlStLNeONC5jnNM98kozL2u0pPS16qB774cjwhRApsJJSSoWukr1lnGH
         ndMSRfj/B/LQ6dcNI82uqbQkLohbgmAyXx7d4L3tgQ3l3nihXM9IjQ28IC8EK2tj/GD9
         iHnOYCeOgJr/UT9aaWtYgPY3TJC7SJd+g13SZ9TH5FPj9pe98IZSRDzO8BHktwFWhKDd
         X1cRshj6SP1m+RsHrtI3l2vN5q2jx7wmf8L2tcm6zsUJnPybnwRmro6/JKHf/oSS9sVT
         GmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+/M7ttbizVNgiq3E6e56DHlLpnfL10dXQ3P0u57oqQo=;
        b=AYNOqittPQfv0MaYL5hjBJ2ur5mNq6rmzMwVIHxy92VNPAsavO8MVJuLo84mPCQE4H
         yl2QN94mJQAJ5NO9XlxbO4snRdyZrKkVdatqVq6/3DTI2+EHJJMmtGkOhQIj7JC0sX+N
         g/fRYJ2lns0v5Tdw3z0/otpI/sqbjoc3rAWTTNC0r8JyRSrlXriedf6hx4qQ11vUBzMA
         j2XdA364QCVnIubilHmjgnxcwrtHtkhWALsDAWf12XQlx6w+9geu9uhR5mpUlfYQDDfH
         JIK2h7bnI5mlw6CjMcBKaxxTooLkt9QcOCs4+G5itZLsU6PFNzlAmf8EFuir3XRQLEsZ
         ffsg==
X-Gm-Message-State: AGi0PuZU80RzB9hDjkzA9H9ot8X3f8KgwB4HcuAoZURg4XKiD4e4fxJS
        aYK4aEdzHr4+UPP3wXGspf8G/xsiTZ/I4JGBU+p9Qw==
X-Google-Smtp-Source: APiQypLADIaeTtFDiDZj0oHRCnE87JDFcA3KKjn9my/GbFnCnkWw5321wESGx5JUU0FJwwNUrkgSoNw73WHvEVtCGSA=
X-Received: by 2002:a9d:3462:: with SMTP id v89mr15637311otb.68.1589271222321;
 Tue, 12 May 2020 01:13:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200511110350.11565-1-robert.foss@linaro.org>
 <20200511110350.11565-3-robert.foss@linaro.org> <20200512002518.GX867@valkosipuli.retiisi.org.uk>
In-Reply-To: <20200512002518.GX867@valkosipuli.retiisi.org.uk>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 12 May 2020 10:13:31 +0200
Message-ID: <CAG3jFytw+GH4bXsUpS-=En52F67_1iPmOtOTo36ujE69j-9h3g@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] media: ov8856: Add devicetree support
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>, Ben Kao <ben.kao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 02:26, Sakari Ailus <sakari.ailus@iki.fi> wrote:
>
> Hi Robert,
>
> On Mon, May 11, 2020 at 01:03:49PM +0200, Robert Foss wrote:
> > Add match table, enable ov8856_probe() to support
> > both ACPI and DT modes.
> >
> > ACPI and DT modes are primarily distinguished from
> > by checking for ACPI mode and by having resource like
> > be NULL.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
>
> Applied with this small diff --- please check with checkpatch.pl on the
> next time. Thanks!

Thanks Sakari, I appreciate it!

>
> diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> index 1657e03d9a9d..4ca27675cc5a 100644
> --- a/drivers/media/i2c/ov8856.c
> +++ b/drivers/media/i2c/ov8856.c
> @@ -1226,8 +1226,7 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856, struct device *dev)
>         if (!fwnode)
>                 return -ENXIO;
>
> -       ret = fwnode_property_read_u32(fwnode, "clock-frequency",
> -               &xvclk_rate);
> +       ret = fwnode_property_read_u32(fwnode, "clock-frequency", &xvclk_rate);
>         if (ret)
>                 return ret;
>
> @@ -1244,10 +1243,11 @@ static int ov8856_get_hwcfg(struct ov8856 *ov8856, struct device *dev)
>         }
>
>         if (xvclk_rate != OV8856_XVCLK_19_2)
> -               dev_warn(dev, "external clock rate %d is unsupported", xvclk_rate);
> +               dev_warn(dev, "external clock rate %u is unsupported",
> +                        xvclk_rate);
>
>         ov8856->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> -               GPIOD_OUT_LOW);
> +                                                    GPIOD_OUT_LOW);
>         if (IS_ERR(ov8856->reset_gpio))
>                 return PTR_ERR(ov8856->reset_gpio);
>
> --
> Kind regards,
>
> Sakari Ailus
