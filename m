Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34081C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B4E206F2
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tnykoHw2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgC0REt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:04:49 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41542 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0REt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:04:49 -0400
Received: by mail-io1-f67.google.com with SMTP id y24so10535632ioa.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKLY8TX9PBKTkw1igDhhrZ1fVl9lcNMkwfQ7KL1HIxA=;
        b=tnykoHw2n3S9fOwdLtVZZtlKip0gSPE8cylLNt1heu7ggdMFbgkq0l6Rk38A4P5oEV
         dCcoDTC+hU/tx629HLHBQCYAxl6VGpA/uNEh2PpSn/oiTcfjcjAk0kfEXmKDAW2lv8I/
         wAs6rsd1FHtjpCji0GVFM3CNkd2t0UoBL+SksWwmXdmTY9iyHD/thM94OJPDqU2GU4us
         4gP8AdM3EOMI9h9skNjoXuLMgUz58KBzgXI96mG4pWNy/YY4TSGi7zG8XICNDOEh80/x
         vIjleBpy3FKkpgV8JpqwBqKZVRBEvkgptJg0midoZRfhf91sOUWXJm89KTuzAb184Dlb
         iVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKLY8TX9PBKTkw1igDhhrZ1fVl9lcNMkwfQ7KL1HIxA=;
        b=MkgzZkZmhUS2FnExFDojFX3DO89KrVF5XhD3Tqim/outmwcyAXdyXXfR5dMyQxiiCM
         OWoT6QJ7BxhsCPMRzVfdmhCRgj4dAa/UNFSiAMl1LTcV6TzIXMO7QMo3E+SltY+ubG3i
         sl+A+v9RGTQYSdAPZOuRDB7FTvMeqZ3sI4JGQBxGLc/81jfcSddYYUZI6iuIcVhLXrQL
         urBLpeW/0QVZYV2DS3bVB1VHwBGxSM7Q13OQg2yw7ua2s/MB9dawyWp/YQGpcH/jQzdT
         nl02qO2GqKAymXiPnAo98FzhA8P46auw4RrgxI4tejDVGENxyrYv9tSGElp2VswL46DZ
         bOEA==
X-Gm-Message-State: ANhLgQ0xxwCnC6cS+mDFme5Cw20A/p3E/bCHxNpJAiLcHb+4eidClXDU
        HXA7Fq0sjR8vueqyRy8bPkvETX66S1/vvPNlH08=
X-Google-Smtp-Source: ADFU+vufDyKMFwwgw+tNEwPgAyzzk95ZFgAPEIGMIb4IOXudF480dQIrfd/lzv15If/QLPsNwfVOpTL5L6O/X8Yozx4=
X-Received: by 2002:a5d:954c:: with SMTP id a12mr6842138ios.25.1585328686840;
 Fri, 27 Mar 2020 10:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200326174232.23365-1-andrew.smirnov@gmail.com>
In-Reply-To: <20200326174232.23365-1-andrew.smirnov@gmail.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Fri, 27 Mar 2020 10:04:37 -0700
Message-ID: <CAFXsbZou9DJn2dwVkXYBCqu2vU4TOD0xiW-h=zF15tgbWzBNTg@mail.gmail.com>
Subject: Re: [PATCH] ARM: vf610: report soc info via soc device
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a VF610 Vybrid:

Tested-by: Chris Healy <cphealy@gmail.com>

On Thu, Mar 26, 2020 at 10:42 AM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> The patch adds plumbing to soc device info code necessary to support
> Vybrid devices. Use case in mind for this is CAAM driver, which
> utilizes said API.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-imx@nxp.com
> ---
>  arch/arm/mach-imx/cpu.c        | 16 ++++++++++
>  arch/arm/mach-imx/mach-vf610.c | 53 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-imx/mxc.h        |  6 ++++
>  3 files changed, 75 insertions(+)
>
> diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
> index 06f8d64b65af..e3d12b21d6f6 100644
> --- a/arch/arm/mach-imx/cpu.c
> +++ b/arch/arm/mach-imx/cpu.c
> @@ -172,6 +172,22 @@ struct device * __init imx_soc_device_init(void)
>                 ocotp_compat = "fsl,imx7ulp-ocotp";
>                 soc_id = "i.MX7ULP";
>                 break;
> +       case MXC_CPU_VF500:
> +               ocotp_compat = "fsl,vf610-ocotp";
> +               soc_id = "VF500";
> +               break;
> +       case MXC_CPU_VF510:
> +               ocotp_compat = "fsl,vf610-ocotp";
> +               soc_id = "VF510";
> +               break;
> +       case MXC_CPU_VF600:
> +               ocotp_compat = "fsl,vf610-ocotp";
> +               soc_id = "VF600";
> +               break;
> +       case MXC_CPU_VF610:
> +               ocotp_compat = "fsl,vf610-ocotp";
> +               soc_id = "VF610";
> +               break;
>         default:
>                 soc_id = "Unknown";
>         }
> diff --git a/arch/arm/mach-imx/mach-vf610.c b/arch/arm/mach-imx/mach-vf610.c
> index 9c929b09310c..565dc08412a2 100644
> --- a/arch/arm/mach-imx/mach-vf610.c
> +++ b/arch/arm/mach-imx/mach-vf610.c
> @@ -3,11 +3,63 @@
>   * Copyright 2012-2013 Freescale Semiconductor, Inc.
>   */
>
> +#include <linux/of_address.h>
>  #include <linux/of_platform.h>
> +#include <linux/io.h>
> +
>  #include <linux/irqchip.h>
>  #include <asm/mach/arch.h>
>  #include <asm/hardware/cache-l2x0.h>
>
> +#include "common.h"
> +#include "hardware.h"
> +
> +#define MSCM_CPxCOUNT          0x00c
> +#define MSCM_CPxCFG1           0x014
> +
> +static void __init vf610_detect_cpu(void)
> +{
> +       struct device_node *np;
> +       u32 cpxcount, cpxcfg1;
> +       unsigned int cpu_type;
> +       void __iomem *mscm;
> +
> +       np = of_find_compatible_node(NULL, NULL, "fsl,vf610-mscm-cpucfg");
> +       if (WARN_ON(!np))
> +               return;
> +
> +       mscm = of_iomap(np, 0);
> +       of_node_put(np);
> +
> +       if (WARN_ON(!mscm))
> +               return;
> +
> +       cpxcount = readl_relaxed(mscm + MSCM_CPxCOUNT);
> +       cpxcfg1  = readl_relaxed(mscm + MSCM_CPxCFG1);
> +
> +       iounmap(mscm);
> +
> +       cpu_type = cpxcount ? MXC_CPU_VF600 : MXC_CPU_VF500;
> +
> +       if (cpxcfg1)
> +               cpu_type |= MXC_CPU_VFx10;
> +
> +       mxc_set_cpu_type(cpu_type);
> +}
> +
> +static void __init vf610_init_machine(void)
> +{
> +       struct device *parent;
> +
> +       vf610_detect_cpu();
> +
> +       parent = imx_soc_device_init();
> +       if (parent == NULL)
> +               pr_warn("failed to initialize soc device\n");
> +
> +       of_platform_default_populate(NULL, NULL, parent);
> +}
> +
>  static const char * const vf610_dt_compat[] __initconst = {
>         "fsl,vf500",
>         "fsl,vf510",
> @@ -20,5 +72,6 @@ static const char * const vf610_dt_compat[] __initconst = {
>  DT_MACHINE_START(VYBRID_VF610, "Freescale Vybrid VF5xx/VF6xx (Device Tree)")
>         .l2c_aux_val    = 0,
>         .l2c_aux_mask   = ~0,
> +       .init_machine   = vf610_init_machine,
>         .dt_compat      = vf610_dt_compat,
>  MACHINE_END
> diff --git a/arch/arm/mach-imx/mxc.h b/arch/arm/mach-imx/mxc.h
> index 2bfd2d59b4a6..48e6d781f15b 100644
> --- a/arch/arm/mach-imx/mxc.h
> +++ b/arch/arm/mach-imx/mxc.h
> @@ -33,6 +33,12 @@
>  #define MXC_CPU_IMX7D          0x72
>  #define MXC_CPU_IMX7ULP                0xff
>
> +#define MXC_CPU_VFx10          0x010
> +#define MXC_CPU_VF500          0x500
> +#define MXC_CPU_VF510          (MXC_CPU_VF500 | MXC_CPU_VFx10)
> +#define MXC_CPU_VF600          0x600
> +#define MXC_CPU_VF610          (MXC_CPU_VF600 | MXC_CPU_VFx10)
> +
>  #define IMX_DDR_TYPE_LPDDR2            1
>
>  #ifndef __ASSEMBLY__
> --
> 2.21.0
