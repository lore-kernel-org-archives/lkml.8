Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC3CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF002071B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="TWAFwRac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCJX1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:27:45 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44758 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbgCJX1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:27:44 -0400
Received: by mail-oi1-f194.google.com with SMTP id d62so213oia.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urlu+8TdQXdW80awHG4Zd4J9lzaBBb5vKaOjUvu/Baw=;
        b=TWAFwRacAltjmxOIncTM4pfxUqZ6aLEc6D3plWuBUkMVwBWikAKxmA/+G8h7sSHmyB
         EFPNWTaWMtj0FRPhsXGtXySfrpCA4iGwzXXTLofXfjpLjniSQ7nSic1fLN/FVIo8YxGK
         7xO21xec0DGPZEOGtZJgsTQpe8NiVMsg1y/avSifZrIfD7OMJSPKqaZ8+ks3nvFF13WV
         CzM5IZPb8PFQfnxKuYmDOjUfn7r2idvxonZ8HoisdEs7PBl8lHxYdn9FBn/UtfMfDNSj
         D3dg/R1Kh0wQhAVd6/MHdsYS+o2M9VABsavSoob/Vo9kb7Dhp/L1QMmQyTOhcdmvRygp
         u1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urlu+8TdQXdW80awHG4Zd4J9lzaBBb5vKaOjUvu/Baw=;
        b=FciSRHSLZqLp9loalLCBza9u8WrOl2tYstWxD3enTWH/xOcMD3z4ABxHYeo6giDPJc
         iDbwbeif1KcXP47cVw2Kym+tLOor8c5gNIhJyfFWLGgX+aruhkwwJDJYyBR3RnLRmvP5
         2xf1HQZUWG5Pb6PP3FtAUCVoV0RoI8hY1XBEa9Nxv3CmNEridLrg03xyXDiI8ZD3PITc
         2eS6wxyFugUXGzP6lS45nXKup7nuCPHbjsFxuqJBm8Su4FK9Txr6YLUYu6PeXuEJOA5N
         v/0qVixRAh/p8L6ziAFf9njnlpq81c9qYNIXlLoVpKqnIzLuHfwFSgl4MSMEoOY5GLBM
         1EyA==
X-Gm-Message-State: ANhLgQ0A658y1TaFXJqLQzFu+dF82nwR2nVbi7qtU3PbSrp2alP2R0pZ
        Vp8VUHVwLx1UbM/gFrJiUmBo4aXjWxXYRbCqum5/5g==
X-Google-Smtp-Source: ADFU+vtFw4+uD8Udv5vJx1K7Yd8AiJ1NSDWoUD72RcY9sbbnvgqvHt4vpV9vddaJ49Th3mFrW8Vk6vTPlnaLbkWy0qQ=
X-Received: by 2002:aca:474e:: with SMTP id u75mr86968oia.52.1583882862823;
 Tue, 10 Mar 2020 16:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190430101230.21794-1-lokeshvutla@ti.com> <20190430101230.21794-8-lokeshvutla@ti.com>
In-Reply-To: <20190430101230.21794-8-lokeshvutla@ti.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 10 Mar 2020 16:27:31 -0700
Message-ID: <CAJ+vNU2gnKKxX2YL1JUSnpF7qNqKVAsPhC2emv=Y79HPJbZXzw@mail.gmail.com>
Subject: Re: [PATCH v8 07/14] gpio: thunderx: Use the default parent apis for {request,release}_resources
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 3:14 AM Lokesh Vutla <lokeshvutla@ti.com> wrote:
>
> thunderx_gpio_irq_{request,release}_resources apis are trying to
> {request,release} resources on parent interrupt. There are default
> apis doing the same. Use the default parent apis instead of writing
> the same code snippet.
>
> Cc: linux-gpio@vger.kernel.org
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v7:
> - None
>
>  drivers/gpio/gpio-thunderx.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpio/gpio-thunderx.c b/drivers/gpio/gpio-thunderx.c
> index 1306722faa5a..715371b5102a 100644
> --- a/drivers/gpio/gpio-thunderx.c
> +++ b/drivers/gpio/gpio-thunderx.c
> @@ -363,22 +363,16 @@ static int thunderx_gpio_irq_request_resources(struct irq_data *data)
>  {
>         struct thunderx_line *txline = irq_data_get_irq_chip_data(data);
>         struct thunderx_gpio *txgpio = txline->txgpio;
> -       struct irq_data *parent_data = data->parent_data;
>         int r;
>
>         r = gpiochip_lock_as_irq(&txgpio->chip, txline->line);
>         if (r)
>                 return r;
>
> -       if (parent_data && parent_data->chip->irq_request_resources) {
> -               r = parent_data->chip->irq_request_resources(parent_data);
> -               if (r)
> -                       goto error;
> -       }
> +       r = irq_chip_request_resources_parent(data);
> +       if (r)
> +               gpiochip_unlock_as_irq(&txgpio->chip, txline->line);

Lokesh,

This patch breaks irq resources for thunderx-gpio as
parent_data->chip->irq_request_resources is undefined thus your new
irq_chip_request_resources_parent() returns -ENOSYS causing this
function to return an error where as before it would happily return 0.

Is the following the correct fix or should we qualify
data->parent_data->chip->irq_request_resources before calling
irq_chip_request_resources_parent() in thunderx-gpio?

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index b3fa2d8..b2435ecb 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1525,7 +1525,7 @@ int irq_chip_request_resources_parent(struct
irq_data *data)
        if (data->chip->irq_request_resources)
                return data->chip->irq_request_resources(data);

-       return -ENOSYS;
+       return 0;
 }
 EXPORT_SYMBOL_GPL(irq_chip_request_resources_parent);

Regards,

Tim
