Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4C206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="s2jK0jBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbgGAJnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgGAJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:43:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC5BC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:43:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so21704519wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdyUrV+bTJIaY0sG31UbOvAajCIjEmGoEa/DOEF2qa4=;
        b=s2jK0jBce/oIAI7bMEtgccP/NqgDTzSOOzPG1S39Zo2X7GdPIUErBYqTsfK4ddrRiy
         v31eavfu4x3ESB49rOhyPnj/tuZzQ4wZz6fbPOlL52Rl2Nxt5MS9o5+1ELPyYGAXhAR/
         ivRa4k0llQ0a3XXPhsG+ZkX0f8Jy9gjsijlEnxYtwvCm+ztFSMtRXCcEQmozzqJ8dp+O
         XVQQ0NXvT8S4KyHn8bRF157DufApzBF0NmLsh3LvkgaXvq8/xJcgLdGjOU25f1WwgPEE
         ouhp/ZsPVXpXg8ovd+ckCeKVNqcDpwvgtM54U/r6PkcV4VScuL+p5dUUW1V5qDYKFtCj
         PFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdyUrV+bTJIaY0sG31UbOvAajCIjEmGoEa/DOEF2qa4=;
        b=Z7i1GTvdhbTzOrDSWb2PjymXjZsvboeTN8hCAhEB/z3uYi1q3SGOQkKEyJmb97OKBG
         8zD8nkHDzDy6+p4Y+IcXGyFvRE3i/IPGycOSwxq9A6DhDH5vUXf+kAbcrTnXQs49rWv8
         /mwsCi4UmFT/DAJUFgiEX+Ll3eIQOeEGFIswo9sMgLjmBLKUgtArVqeS9sJ/3mwSmB40
         QSjKWuPSjAPPYJxtBnVT2G66dbV4DIEOlkVFHNU7GlJb2PrMvDVXgNmck/X8JXQ/I/l1
         MCrxvusQYP8W5bCaq8Hv5y3qlFp27rFOM/wVRV4GkwXT/sI2zKL871/Qugb/HDwu5Vy4
         K95w==
X-Gm-Message-State: AOAM533XiMKuQ440bIw9NrXDMdicpMTVApPeFXaLuKu1D/YQgWzM3XYw
        A0eRRhihLKEvhTi9Q+Qs/YTaUoP93OJMTmQmj4h5Ow==
X-Google-Smtp-Source: ABdhPJxXORy1QXy5FeDNDmgrjnggGoixcd1hTxn3l9tCpKV6l0heg9SwEQ2XKt9HeQh3KtFfZOH1I7vYZH/VkYUR12Q=
X-Received: by 2002:a1c:a3c5:: with SMTP id m188mr25181747wme.152.1593596623526;
 Wed, 01 Jul 2020 02:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn> <1593569786-11500-13-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1593569786-11500-13-git-send-email-yangtiezhu@loongson.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 Jul 2020 15:13:31 +0530
Message-ID: <CAAhSdy3e-qHSqQkVtps-D2Qz+GK28XyNVFbXAqKDWvxcioYCuw@mail.gmail.com>
Subject: Re: [PATCH v4 12/14] irqchip/riscv-intc: Fix potential resource leak
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:47 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> In the function riscv_intc_init(), system resource "intc_domain"
> was not released in the error case, fix it.
>
> Fixes: 6b7ce8927b5a ("irqchip: RISC-V per-HART local interrupt controller driver")
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
> index a6f97fa..8d6286c 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -122,6 +122,7 @@ static int __init riscv_intc_init(struct device_node *node,
>         rc = set_handle_irq(&riscv_intc_irq);
>         if (rc) {
>                 pr_err("failed to set irq handler\n");
> +               irq_domain_remove(intc_domain);
>                 return rc;
>         }
>
> --
> 2.1.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
