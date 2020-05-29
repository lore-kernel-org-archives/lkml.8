Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAF5C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E984D207F9
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="AVIwTbPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgE2Adw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgE2Adu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:33:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0C5C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:33:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e1so1397973wrt.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 17:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPcVtJdyE2AYwAhGRH6VQ5jDi/96X6c2mJkTgrsC7yI=;
        b=AVIwTbPm1ox7N3P4+ADUQymgyvb83Na+tVpSR19McEIJAuWV/ngmhQ63MElQqZLO6A
         /JzzB47Rj8u4EjlrPav6qUuTLl7l83e7gQahB8miSxNae71iMvhus3BJpjBNyU0TkauQ
         vHbLDsv7Ykg+mXB951uwqWxtQTzyLr7Upjw1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPcVtJdyE2AYwAhGRH6VQ5jDi/96X6c2mJkTgrsC7yI=;
        b=MhiBlqlz6bvJUITXn0uoV9sfOXU02Q7GkAXGXRcGOi28oWOnzPDfWrLXhqwQWzSETU
         qIPh1mktbe5+lKIwk+YQ9R/KYLBpY902nF9plOfHSXNEP3mG3go19gQUChMKJOrTAdiR
         0eKYcsNkNAhL7jeoTpWrAhRi/eTrsFE24T9CqMNAew7sx2PWgDVXPb94VWx/ePzzokGO
         o7eT3iEeXy75QnauIjdRGgt/U/rRgchdNaRoMgHr6Ow7wmGOcEuSiUu0LiBlXQ5DXWgB
         nVLeKD8nDcFcMFynKWd1HUhrpUuLySv5o4wqjktvN87ENbASSIrP/WoqDheb2uISXwWI
         xqLw==
X-Gm-Message-State: AOAM5336TENYOqB6chQIyjG25MeVp+rGobFvQpzsjwcOqPERtU0zp2rQ
        AeL/THw//MjXR8ARayamEXDsp+7WyCZ8sFha0tpfuck=
X-Google-Smtp-Source: ABdhPJzqmxeAGA7wTIx1KRRqA0Q/MyC0G6n009aKF+yeH9+jWtsSpTvdDRpC7ou312ux20wgCKKOWiCG5nUb2+g2SM4=
X-Received: by 2002:a05:6000:10c3:: with SMTP id b3mr6337909wrx.53.1590712428527;
 Thu, 28 May 2020 17:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <20200521133301.816665-7-anup.patel@wdc.com>
In-Reply-To: <20200521133301.816665-7-anup.patel@wdc.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Thu, 28 May 2020 17:33:37 -0700
Message-ID: <CAOnJCUJKjgYq5Gii6iVYCUGELShpCaPjG4F0N9CFkgxk_rZG2Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] RISC-V: Force select RISCV_INTC for CONFIG_RISCV
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:34 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The RISC-V per-HART local interrupt controller driver is mandatory
> for all RISC-V system (with/without MMU) hence we force select it
> for CONFIG_RISCV (just like RISCV_TIMER).
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 822cb0e1a380..2cf0c83c1a47 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -51,6 +51,7 @@ config RISCV
>         select THREAD_INFO_IN_TASK
>         select PCI_DOMAINS_GENERIC if PCI
>         select PCI_MSI if PCI
> +       select RISCV_INTC
>         select RISCV_TIMER
>         select GENERIC_IRQ_MULTI_HANDLER
>         select GENERIC_ARCH_TOPOLOGY if SMP
> --
> 2.25.1
>
>

Reviewed-by: Atish Patra <atish.patra@wdc.com>

-- 
Regards,
Atish
