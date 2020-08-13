Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE720C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5C2120771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Ad03R5Sa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHMIt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgHMIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:49:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA87C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:49:57 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so4489519wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gA5BB/+6xQCvX9+gmlnfVRPEcDMzoMSPM6EjTizB38A=;
        b=Ad03R5Saypn6P9X1Gr8J7GfoCKcFVoej6TsnRSjGxd8U5Rb4uTQzTPkd2xMUsQ4B/4
         cGfkleKDShOLTjij8QNOz6l/eTLDiOW7q4MbS9NzEHqQrVMO3jxSN9d2FnZPmTH18HHt
         PoYaCyaGChM2zHe9Mrt2JYvs18uJTD0vQm3dsVJg2+7lZ2g7DH1XwAf53jE8TJS6OXZ5
         mRL7xgMNinPPWL8xTtd7Pu9+Gl4xBZvBp+eZ2HSI9Twh1TtF2EYflORFuhGTi1ucT4LZ
         jpxhIWNex1+8aKVw/jNtVKafF1ogzF/Yg08k9X7fa0SAS85DxQggL5YeaHvmG0DnwRxj
         Rmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gA5BB/+6xQCvX9+gmlnfVRPEcDMzoMSPM6EjTizB38A=;
        b=i5A1q/uPZ/YS19cZShSg4UmDtdpCoRlE8Y4LiLUmEkqOHqNMKlyQxKckAv+0xGP0fz
         T/1pYBY9xCAMdnsXR7krQQxdsvWkEjPy9TVtJgivAaOqh98yBtbQITLg3EiX/SIU3NAV
         vlsERzeLePpUsoySiDflv647oe/9qutR7HlbtDl97utLB2ZhZQKB5h5T+BHZALcrNUzA
         R5oDZc2zFFftvE2ePQffUTDsOVS1Njekgn01zNbq0yKS9HDvsVYXPUXywnddrQ3C3vNj
         aCY/LkAEOMFfZPWBA0m03SDBdhhig4Ac2DYjDOFl/CGvOSmAoEEHPDthCyQxtAbjJrn2
         duWg==
X-Gm-Message-State: AOAM533L3h/VMq0RTX5y/kO5FPFicC9sTFEKbE6gsdzzzN/exefyPmG7
        Tpmt25hnua8KP67vOl9ijX9EXl0HsivJqNWOtDhjhw==
X-Google-Smtp-Source: ABdhPJxe9m0zrVq6TFy9qvEwk+3us03Rs+PvTuX4Rhtblh9UKM18MT2x1MkvcTf3UnJJL0vy7PaKOK69M0GNn/+fsp8=
X-Received: by 2002:adf:f247:: with SMTP id b7mr3217109wrp.128.1597308596480;
 Thu, 13 Aug 2020 01:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
In-Reply-To: <20200813033807.19556-1-qiuwenbo@phytium.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 13 Aug 2020 14:19:44 +0530
Message-ID: <CAAhSdy1hLAVEHohtuZ6XYxOjWgUmZPXah=tJFrb6tWoRyEiRgA@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Setup exception vector for nommu platform
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atishp@atishpatra.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 9:10 AM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
>
> Exception vector is missing on nommu platform and that is an issue.
> This patch is tested in Sipeed Maix Bit Dev Board.
>
> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
> Suggested-by: Anup Patel <anup@brainfault.org>
> Suggested-by: Atish Patra <atishp@atishpatra.org>
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> ---
>  arch/riscv/kernel/head.S | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index d0c5c316e9bb..0a4e81b8dc79 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -77,16 +77,10 @@ relocate:
>         csrw CSR_SATP, a0
>  .align 2
>  1:
> -       /* Set trap vector to exception handler */
> -       la a0, handle_exception
> +       /* Set trap vector to spin forever to help debug */
> +       la a0, .Lsecondary_park
>         csrw CSR_TVEC, a0
>
> -       /*
> -        * Set sup0 scratch register to 0, indicating to exception vector that
> -        * we are presently executing in kernel.
> -        */
> -       csrw CSR_SCRATCH, zero
> -
>         /* Reload the global pointer */
>  .option push
>  .option norelax
> @@ -144,9 +138,23 @@ secondary_start_common:
>         la a0, swapper_pg_dir
>         call relocate
>  #endif
> +       call setup_trap_vector
>         tail smp_callin
>  #endif /* CONFIG_SMP */
>
> +.align 2
> +setup_trap_vector:
> +       /* Set trap vector to exception handler */
> +       la a0, handle_exception
> +       csrw CSR_TVEC, a0
> +
> +       /*
> +        * Set sup0 scratch register to 0, indicating to exception vector that
> +        * we are presently executing in kernel.
> +        */
> +       csrw CSR_SCRATCH, zero
> +       ret
> +
>  .Lsecondary_park:
>         /* We lack SMP support or have too many harts, so park this hart */
>         wfi
> @@ -240,6 +248,7 @@ clear_bss_done:
>         call relocate
>  #endif /* CONFIG_MMU */
>
> +       call setup_trap_vector
>         /* Restore C environment */
>         la tp, init_task
>         sw zero, TASK_TI_CPU(tp)
> --
> 2.28.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
