Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85876C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60752222D9
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583771163;
	bh=Oufh7MrQPjXo9lbYsp3qWQvteiioqKO/EGPSF2qFeBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KalJpcEy2sVcIyKoLv2WGGjpbikwOc0wNXXnXhfneZ9cNbjwd+63p3y4FCMumJZaH
	 /MallKLe3WInAt8/ugHkk02LW8fs+wrxw0gk7SULyCxwwjqEKM3C/uXDfkf2qDmsNR
	 ynwebSREkBDE3yx/S3Yw9Afq7nm/zQvekBoiHWmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCIQ0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:26:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgCIQ0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:26:02 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B247227BF;
        Mon,  9 Mar 2020 16:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583771161;
        bh=Oufh7MrQPjXo9lbYsp3qWQvteiioqKO/EGPSF2qFeBo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WSQZahaxTQSMDiV2kIuXICnK4TWpj3HS3+x9d6T8gFH3ZZoSfLvTEHw4Hi1O5q6RA
         R7VS//IYFN4OQ6jLw2so+oiCEKt0V+T00ucYfwrYhljZCKPqaR4cmoQF/Jx6ECNm0E
         uGMZjp3m5CnUbyvIoP4/4IgnEuyW3CK4STRDSB4w=
Received: by mail-qk1-f176.google.com with SMTP id c145so4002783qke.12;
        Mon, 09 Mar 2020 09:26:01 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0TGRkztmj6+FE+3N9Bx/R+XiCHZMSViVOLnqI/1p3BSME05GHn
        MD2ZSNRlBL5Gim2Yu4FzdvTWbFUEXgH1DtLrPA==
X-Google-Smtp-Source: ADFU+vvixMGurwQ+Y+ORKkEGc9gr3ZpwxMARQ8Q4TNyr445pL5cPgVGTC43iI5nbEau/Eu6+ardKHSm3ZVBnmSRoZ0o=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr16056405qkg.152.1583771160417;
 Mon, 09 Mar 2020 09:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190822092643.593488-1-lkundrak@v3.sk> <20190822092643.593488-7-lkundrak@v3.sk>
In-Reply-To: <20190822092643.593488-7-lkundrak@v3.sk>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 9 Mar 2020 11:25:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLpDa0viedjBVDGGa9p1ytpRizw9hE3m1FE8_xVv6+FmQ@mail.gmail.com>
Message-ID: <CAL_JsqLpDa0viedjBVDGGa9p1ytpRizw9hE3m1FE8_xVv6+FmQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/20] irqchip/mmp: do not use of_address_to_resource()
 to get mux regs
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 4:34 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> The "regs" property of the "mrvl,mmp2-mux-intc" devices are silly. They
> are offsets from intc's base, not addresses on the parent bus. At this
> point it probably can't be fixed.

Another option is for platform code to fixup the live DT and just add
'ranges' to make this work.

> On an OLPC XO-1.75 machine, the muxes are children of the intc, not the
> axi bus, and thus of_address_to_resource() won't work. We should treat
> the values as mere integers as opposed to bus addresses.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> ---
> Changes since v4 of "MMP platform fixes" set:
> - Add a comment, as suggested by Pavel
>
> Changes since v1:
> - Fix up typoes in the comment
> - Do not allow the regs property be larger than the bindings document.
>
>  drivers/irqchip/irq-mmp.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
> index 14618dc0bd396..e41e47ab71d3b 100644
> --- a/drivers/irqchip/irq-mmp.c
> +++ b/drivers/irqchip/irq-mmp.c
> @@ -424,9 +424,9 @@ IRQCHIP_DECLARE(mmp2_intc, "mrvl,mmp2-intc", mmp2_of_init);
>  static int __init mmp2_mux_of_init(struct device_node *node,
>                                    struct device_node *parent)
>  {
> -       struct resource res;
>         int i, ret, irq, j = 0;
>         u32 nr_irqs, mfp_irq;
> +       u32 reg[4];
>
>         if (!parent)
>                 return -ENODEV;
> @@ -438,18 +438,22 @@ static int __init mmp2_mux_of_init(struct device_node *node,
>                 pr_err("Not found mrvl,intc-nr-irqs property\n");
>                 return -EINVAL;
>         }
> -       ret = of_address_to_resource(node, 0, &res);
> +
> +       /*
> +        * For historical reasons, the "regs" property of the
> +        * mrvl,mmp2-mux-intc is not a regular "regs" property containing
> +        * addresses on the parent bus, but offsets from the intc's base.
> +        * That is why we can't use of_address_to_resource() here.
> +        */
> +       ret = of_property_read_variable_u32_array(node, "reg", reg,
> +                                                 ARRAY_SIZE(reg),
> +                                                 ARRAY_SIZE(reg));
>         if (ret < 0) {
>                 pr_err("Not found reg property\n");
>                 return -EINVAL;
>         }
> -       icu_data[i].reg_status = mmp_icu_base + res.start;

Seems like it was treated as an offset already?

> -       ret = of_address_to_resource(node, 1, &res);
> -       if (ret < 0) {
> -               pr_err("Not found reg property\n");
> -               return -EINVAL;
> -       }
> -       icu_data[i].reg_mask = mmp_icu_base + res.start;
> +       icu_data[i].reg_status = mmp_icu_base + reg[0];
> +       icu_data[i].reg_mask = mmp_icu_base + reg[2];

This is a bit fragile as it's hard coding the cell sizes. Are they the
same for all the platforms? I'd be more comfortable doing that in
platform specific fixup code than here.

Rob
