Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A44C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA52072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="2SQTFpXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFQi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:38:57 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34965 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgCFQi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:38:57 -0500
Received: by mail-vs1-f66.google.com with SMTP id u26so1923547vsg.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 08:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qx3A/IQVNW7fzT3DwYvCqbENQb/6yvNaKEnyDu7jQZY=;
        b=2SQTFpXFJ0ik4M9EvISuXCVD3a7NNwmMo805wmtt408kV/i1HIwGDl8LwDBMYvNIiJ
         RZIqPk0VF9ZuvoGBqwqep2ipEY4NNQEGAJAcXLT3sTjK8Btj6AqWQMdrrc9wr3RZ8Ong
         Tx5DVRr103eEnHPfHk2FVvCmMXrQft2kBHl8eHNMAdHVmSAa1m10QUmchvkNvIH5p5x4
         QyY2aDHx8tgT0gAQRbJ6Ydu7Z2fVpO7X5qeVcbuAIyu3bCXqcASZHZKJ8ZljOPtXPP9G
         BGcqbEU/rAoQFHtk6bXIZVXtoXXnpy3xfrTgbAopTUrcF3bTgjcdk0D9UDJs5wmaQeW7
         k0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qx3A/IQVNW7fzT3DwYvCqbENQb/6yvNaKEnyDu7jQZY=;
        b=X/AZdfp8oYFjFM03aphWZGse2UC9fdfkCqlW3TG5ClpoypDOVlvu6I3PAOXxMQunBn
         +tSjnoKd7GiXETTVDe5GIfQPTUvneSkjnMowxiN7+nXBwGGGcNhhID5iDK/31AgETSdN
         FPPayhYRH7cHtn+c/ZKvf2EIDiIyv1YfHw4ouulHYld3H9+fYAcuP/ZdnEMey3QqRQCP
         wDnya16BKfpYqxJdEgxY1Wa1eRXmbQOSSnNNGUoN59FsKpMg5SKKAB51+R7YV/hLyUEo
         B6W418BlX9ES420U4mns4iBxjXAfy0sdTCcIPKWvk6yiJSOBLx8jOGPFQsQLjbhQJmML
         EY+w==
X-Gm-Message-State: ANhLgQ0U3XM1CxSBThq+P+d/dc4b+MW0ihSp4eLSFp35AWrLTcNvii/o
        yGnQ0WMLcuHQEJaSaVcz2OxzJi3FUzoK68m3AN69HA==
X-Google-Smtp-Source: ADFU+vsgrX3M9ZUTt8zNbjVtAO9AoVvwrrtdDDH13N7+Fbkq+KCJfEoKR4CXqN5VR9tlf56RJTCEgxF3RkYjr11VXSc=
X-Received: by 2002:a67:e195:: with SMTP id e21mr2608876vsl.159.1583512735838;
 Fri, 06 Mar 2020 08:38:55 -0800 (PST)
MIME-Version: 1.0
References: <1583509356-8265-1-git-send-email-Anson.Huang@nxp.com> <1583509356-8265-5-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583509356-8265-5-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 6 Mar 2020 22:08:44 +0530
Message-ID: <CAHLCerPXZD_qpacWuQ51Fu5RGgq1NG-FUhzgKdxND7-t460Kfg@mail.gmail.com>
Subject: Re: [PATCH 5/5] thermal: add COMPILE_TEST support for IMX_SC_THERMAL
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
        Fabio Estevam <festevam@gmail.com>, dmitry.torokhov@gmail.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        wim@linux-watchdog.org, linux@roeck-us.net, daniel.baluta@nxp.com,
        linux@rempel-privat.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, m.felsch@pengutronix.de,
        andriy.shevchenko@linux.intel.com, Arnd Bergmann <arnd@arndb.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        ronald@innovation.ch, Krzysztof Kozlowski <krzk@kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org,
        linux-rtc@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-watchdog@vger.kernel.org, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:19 PM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Add COMPILE_TEST support to i.MX SC thermal driver for better compile
> testing coverage.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index 91af271..55c7641 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -254,7 +254,7 @@ config IMX_THERMAL
>
>  config IMX_SC_THERMAL
>         tristate "Temperature sensor driver for NXP i.MX SoCs with System Controller"
> -       depends on IMX_SCU
> +       depends on IMX_SCU || COMPILE_TEST
>         depends on OF
>         help
>           Support for Temperature Monitor (TEMPMON) found on NXP i.MX SoCs with
> --
> 2.7.4
>
