Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6961EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B1B9204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3PdcOBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgHQPEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHQPEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:04:48 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8885BC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:04:47 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id l84so15032804oig.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d6ygu7yB/ujRPicbXyGxxAa8G3qW+b6Pxo9XVrZgMhg=;
        b=k3PdcOBAs8eNGqpjg0cD63uWZU3AZUe2rARWPvRY3xs9ccxnDb0t7T5Qw+DxLpenkb
         Wg/wRdeN1jg6rlfQqD2Vir66HguiwzMHhHd7RwcYid3sKyDJMntXYqGL45bjNGFZmg2O
         mzlF8x5VeXqFDu387q0cmojqYFDcUGNF8oNhaY8D0oojF5s41pvDX5P8X5zEA6q0iSls
         QeYO8ngCULKr4zTUddufWCcNWCNbdYXhaJ4xx4Ib8vXvHREiB1kjH+Mwqxt5bjJQ4fCd
         RtMk5/AgqKL9zZKyjKIKUJq1M++BLwaqiU6ZI/5tGkNGenFPf3fZqTuGrzOroeIB7jI8
         MmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d6ygu7yB/ujRPicbXyGxxAa8G3qW+b6Pxo9XVrZgMhg=;
        b=IbKF05FxCGL9ogANGlboe/CJSeAmFjvRX0lPgIKl3z9NtiUxho7jKFPu9tCsVStNb1
         4cCxndC3vxxgMqUYFEnVX2IlWAY1cwFt+iwR7w6fPG6+zZHusTtcRw3JwSHqTlihMInR
         V8+npF0n4E+2SOgpWy0CVV33OMSCaEEVqrICSXPQTnW4Zx0l9zf6fYDAL5w62LkoW3PW
         KFLlcDmUIr1UDbT1ps0Qn3BTa7m33ESktuLayIQcgzZY9ytBBJ9TcxHWVNeCiRAEZnxQ
         K9XdFLAQSDcSjQ9UX/q7bk3C+TITSxFgpiJTMOWgroOCkaB9Hp1les4TXuJl63++3JoV
         qlpw==
X-Gm-Message-State: AOAM531v81lRHnWskDI1KobEjhHRKk/OOnI4cyjRagRWSxKbdJE9OEh/
        WKl2u6EwI6ZZmKJtLAEgz7KXiPwEKTfCjsLqqQM=
X-Google-Smtp-Source: ABdhPJxmyaXL4AVUuqaFZwCfq5LT8P6R7o1QhehDVn5e7xYBKgetFnuM/8R3EajqK660oaSHsxjuJRRjP/UmpZN8vFA=
X-Received: by 2002:aca:240b:: with SMTP id n11mr10214622oic.47.1597676686009;
 Mon, 17 Aug 2020 08:04:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200817145738.986999-1-linux@fw-web.de>
In-Reply-To: <20200817145738.986999-1-linux@fw-web.de>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 17 Aug 2020 17:04:32 +0200
Message-ID: <CAFqH_53ppxNqhjqpv8z4vz7GPFMxtM8nswx5pgyz5Sx00wGbFA@mail.gmail.com>
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Frank Wunderlich <frank-w@public-files.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

Missatge de Frank Wunderlich <linux@fw-web.de> del dia dl., 17 d=E2=80=99ag=
.
2020 a les 16:58:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> This reverts commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 which
> breaks bootup of arm/arm64 devices like bananapi-r2/mt7623 and
> bananapi-r64/mt7622
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

I already answered your BUG report, but, for the record, I think a
proper fix is following his way [1] and probably will be merged soon.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/c=
ommit/?h=3Dirq/irqchip-next&id=3D7828a3ef8646fb2e69ed45616c8453a037ca7867

Thanks,
 Enric
> ---
>  drivers/irqchip/irq-mtk-sysirq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-s=
ysirq.c
> index 7299c5ab4d10..6ff98b87e5c0 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -231,6 +231,4 @@ static int __init mtk_sysirq_of_init(struct device_no=
de *node,
>         kfree(chip_data);
>         return ret;
>  }
> -IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
> -IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
> -IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
> +IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init=
);
> --
> 2.25.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
