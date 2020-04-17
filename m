Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CB7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82AB206E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fo9jdYtU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgDQS6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726432AbgDQS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:58:17 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BFEC061A0C;
        Fri, 17 Apr 2020 11:58:16 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id pg17so2324357ejb.9;
        Fri, 17 Apr 2020 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlMFBx94GCBfheLIsuK5jE2jfZjb/ff2QESeWVLDTaA=;
        b=fo9jdYtU3T1u7shVeHbNWBxaUnvCMAs51p7ITTnBk0XK8aZFdpqwimCEkoVfVdHnX+
         eRId7zN/unfZUtKp6jDQ3FZ9fokbx6h5lUxmOw9/lr69K4+EobBDQUq9Zlu/AWzommVO
         i/b6Dd5ugZi29Y9v+q6rBQ+t0RVhn4RK02KBZnkgad3jJTc7X4TBZ/AQBwwQNtTon9rH
         0tL3tUAXoIIVvkjz6Hdj6ERZCugZet/uwre/IkgFV32UXzCVmhjF0v1hQMoDGsUB8+SC
         YV5lJYrq9j8rQCxT0faPnqY4mBz38lt7LNyPO+Gq70AhqrDKJXnyKYe8LU2mjkwTjfY+
         L7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlMFBx94GCBfheLIsuK5jE2jfZjb/ff2QESeWVLDTaA=;
        b=Pl4rPnKiLU3bVb8rB0j+9mZgjah8V8q9Hbx6Ntrp1V7mSXXtAmtWoxOEHPzsT8q1LV
         /YQESFmhPXpWhaJDGD9ctAZloeyIs71YQceo22ztCO2Pky/UV7KxW1RQwuh54wVyC7w5
         y+E8HDWo17UZUiho95S0pLWk8xmnyKiSY8DAUGvMp+sEM7OOCGzhZnipXZW7hSp3XNLw
         yPJfnMk+X6i26Evmt5WfUa3hvxS13EaaCcuMMUOw+XElDvtiRkkudkW1/ORc6s/M+3zR
         v0mi2cudPtzU8XSTI5BvIK78gWRiWNpUpI0dgTDpVQa2cvoPwZrGPTYWl91dMa7Z6LGJ
         ClSA==
X-Gm-Message-State: AGi0PubUorTE2k1+bgVxs90BIAf1f4xgW30uaK9OKpEzPsoLxcYO5CzA
        SunA2ysqVDME8S7QXf7gOLPuboKwVQqQ4gCz5CFhZooRhJA=
X-Google-Smtp-Source: APiQypJDTAOAKuxrm7soIeXoSsvXePAMrOLicPlcfUvzaZAHE61vBhTuJxahrdb1K9VgXzzNto7Uz3Fvb31Q2ubZeVk=
X-Received: by 2002:a17:906:4048:: with SMTP id y8mr4465506ejj.258.1587149895198;
 Fri, 17 Apr 2020 11:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200416121910.12723-1-narmstrong@baylibre.com> <20200416121910.12723-3-narmstrong@baylibre.com>
In-Reply-To: <20200416121910.12723-3-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 17 Apr 2020 20:58:04 +0200
Message-ID: <CAFBinCCUM1Ht1_yRcbG=exJBign=YBX1+xUr8kz=3pJy2PxsnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] usb: dwc3: meson-g12a: support the GXL/GXM DWC3
 host phy disconnect
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, balbi@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On the Amlogic GXL/GXM SoCs, the OTG PHY status signals are always
> connected to the DWC3 controller, thus crashing the controller when
> switching to OTG mode when port is not populated with a device/cable to
> Host.
>
> Amlogic added a bit to disconnect the OTG PHY status signals from the DWC3
> to be used when switching the OTG PHY as Device to the DWC2 controller.
>
> The drawback is that it makes the DWC3 port state machine stall and needs
> a full reset of the DWC3 controller to get connect status to the port
> connected to the OTG PHY, but not the other one.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
one nit-pick below. apart from that:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
>         if (mode == PHY_MODE_USB_DEVICE) {
> +               if (priv->otg_mode != USB_DR_MODE_OTG &&
> +                   priv->drvdata->otg_phy_host_port_disable)
> +                       /* Isolate the OTG PHY port from the Host Controller */
> +                       regmap_update_bits(priv->usb_glue_regmap, USB_R1,
> +                               USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK,
> +                               FIELD_PREP(USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK,
> +                                          BIT(USB2_OTG_PHY)));
if you have to re-send for whatever reason then I would like an empty
line here to make the code easier to read

>                 regmap_update_bits(priv->usb_glue_regmap, USB_R0,
>                                 USB_R0_U2D_ACT, USB_R0_U2D_ACT);
>                 regmap_update_bits(priv->usb_glue_regmap, USB_R0,
> @@ -297,6 +318,12 @@ static void dwc3_meson_g12a_usb_otg_apply_mode(struct dwc3_meson_g12a *priv,
>                 regmap_update_bits(priv->usb_glue_regmap, USB_R4,
>                                 USB_R4_P21_SLEEP_M0, USB_R4_P21_SLEEP_M0);
>         } else {
> +               if (priv->otg_mode != USB_DR_MODE_OTG &&
> +                   priv->drvdata->otg_phy_host_port_disable) {
> +                       regmap_update_bits(priv->usb_glue_regmap, USB_R1,
> +                               USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK, 0);
> +                       msleep(500);
> +               }
same as above - if you have to re-send for whatever reason then please
add an empty line here
