Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD9C2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D09FB20737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585863983;
	bh=jjK1H/hAvk5yQ4FEwfBH7ucz1rxv/FjvZrwzR0iLZno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ld3lWw/uLKIbIslVaQb1Oh6Y0OGH0WrJ9ifFI+DNEjBELG/4qCJ5t5+AGxxmGUTqC
	 mfclI98kawZC871C5ue4tQOFllwxvs4CD0fD3iDSgNILZZVGIrFmMj+T1dp4PBMbFW
	 7g2Z4p3hnWCTCBwAR171WRrp23LOjHIGSpj/Qdz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389103AbgDBVqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731783AbgDBVqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:46:22 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB9C2080C;
        Thu,  2 Apr 2020 21:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585863981;
        bh=jjK1H/hAvk5yQ4FEwfBH7ucz1rxv/FjvZrwzR0iLZno=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Az1kFmsCyVVEKiSnVTQCQbb7LpDlfNCNq0XOZUq06hOENuK2uipb8iz/cwEEF2XfB
         GKPFw0HWQugSY5NCifihDntuIBEMJq80Obt62Apd9AZCvKDfy3TB2+jPMyE2FiUEZ7
         lqlXr1EpKgaKctxdS8jdZHRbCLaV/NPTjWlUDEig=
Received: by mail-io1-f54.google.com with SMTP id i3so5269274ioo.13;
        Thu, 02 Apr 2020 14:46:21 -0700 (PDT)
X-Gm-Message-State: AGi0PuZn6wLv64N2pF1wLqH15nf3F5LkCorNxTLLFyvaC4G5TemgibvR
        FR7XqkaFm9YewzHS2U1xwhrsuSWpIrr2XqNHBtU=
X-Google-Smtp-Source: APiQypLC6ryaAD8pUnhVXj/E/W7ovtmW8rrj1k7DAualWv4qMHv6pcGlDQqkDbuw1rs+o3K6zcRDIVNKkrssYo0BkUE=
X-Received: by 2002:a02:c792:: with SMTP id n18mr5501365jao.5.1585863980559;
 Thu, 02 Apr 2020 14:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <1585128694-13881-1-git-send-email-hanks.chen@mediatek.com> <1585128694-13881-5-git-send-email-hanks.chen@mediatek.com>
In-Reply-To: <1585128694-13881-5-git-send-email-hanks.chen@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 2 Apr 2020 14:46:10 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzrci=qhU6QXPfGg=-dGtKNq1Xn-rhYWvPp-8Wj6v6oJwA@mail.gmail.com>
Message-ID: <CAGp9Lzrci=qhU6QXPfGg=-dGtKNq1Xn-rhYWvPp-8Wj6v6oJwA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] pinctrl: mediatek: add pinctrl support for MT6779 SoC
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, Mars Cheng <mars.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanks,

On Wed, Mar 25, 2020 at 2:31 AM Hanks Chen <hanks.chen@mediatek.com> wrote:
>
> This adds MT6779 pinctrl driver based on MediaTek pinctrl-paris core.
>

We can add some useful help text about MT6779 pinctrl, especially
about specific parts like virtual gpio and its attributes
Then Acked-by: Sean Wang <sean.wang@kernel.org>

> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig              |    7 +
>  drivers/pinctrl/mediatek/Makefile             |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt6779.c     |  775 +++++++++
>  drivers/pinctrl/mediatek/pinctrl-mtk-mt6779.h | 2085 +++++++++++++++++++++++++
>  4 files changed, 2868 insertions(+)
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6779.c
>  create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6779.h
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
> index 701f9af..f628d01 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -86,6 +86,13 @@ config PINCTRL_MT6765
>         default ARM64 && ARCH_MEDIATEK
>         select PINCTRL_MTK_PARIS
>
> +config PINCTRL_MT6779
> +       bool "Mediatek MT6779 pin control"
> +       depends on OF
> +       depends on ARM64 || COMPILE_TEST
> +       default ARM64 && ARCH_MEDIATEK
> +       select PINCTRL_MTK_PARIS
> +
>  config PINCTRL_MT6797
>         bool "Mediatek MT6797 pin control"
>         depends on OF
> diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
> index a74325a..59c1c60 100644
> --- a/drivers/pinctrl/mediatek/Makefile
> +++ b/drivers/pinctrl/mediatek/Makefile
> @@ -11,6 +11,7 @@ obj-$(CONFIG_PINCTRL_MT2712)  += pinctrl-mt2712.o
>  obj-$(CONFIG_PINCTRL_MT8135)   += pinctrl-mt8135.o
>  obj-$(CONFIG_PINCTRL_MT8127)   += pinctrl-mt8127.o
>  obj-$(CONFIG_PINCTRL_MT6765)   += pinctrl-mt6765.o
> +obj-$(CONFIG_PINCTRL_MT6779)   += pinctrl-mt6779.o
>  obj-$(CONFIG_PINCTRL_MT6797)   += pinctrl-mt6797.o
>  obj-$(CONFIG_PINCTRL_MT7622)   += pinctrl-mt7622.o
>  obj-$(CONFIG_PINCTRL_MT7623)   += pinctrl-mt7623.o
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6779.c b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
> new file mode 100644
> index 0000000..145bf22
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
> @@ -0,0 +1,775 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2019 MediaTek Inc.
> + * Author: Andy Teng <andy.teng@mediatek.com>
> + *
> + */
> +
> +#include "pinctrl-mtk-mt6779.h"
> +#include "pinctrl-paris.h"
> +
> +/* MT6779 have multiple bases to program pin configuration listed as the below:
> + * gpio:0x10005000,     iocfg_rm:0x11C20000, iocfg_br:0x11D10000,
> + * iocfg_lm:0x11E20000, iocfg_lb:0x11E70000, iocfg_rt:0x11EA0000,
> + * iocfg_lt:0x11F20000, iocfg_tl:0x11F30000
> + * _i_based could be used to indicate what base the pin should be mapped into.
> + */
> +
> +#define PIN_FIELD_BASE(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits) \
> +       PIN_FIELD_CALC(s_pin, e_pin, i_base, s_addr, x_addrs, s_bit, x_bits, \
> +                      32, 0)
> +

<snip>
