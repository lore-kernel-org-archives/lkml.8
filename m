Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EC7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28FF206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DfUNFMfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgHKIkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbgHKIkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:40:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA476C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:40:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 184so2042916wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 01:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=btI/X9SDKoElUv2/KbWFVuLp06+/u9czm/CWpC6NJgM=;
        b=DfUNFMfpPON2NYu/waf/PF+SlGLX8CkQ+mMAndAEpNpx87wEnHfnN27eF7Z/uUP9g3
         yyhUUT27Nr3k/s69a26aPTv+/Z/2/XIOtF9AbKAv8xf6Mypww73jtjjUPINjcrZr00gU
         OLx9q4Oh13ugyvCQbM0jh/RExazmLEbxEbQWwpVfSSnlCKgIxX1xWsk1Eq+JDbjyY5p0
         8kjY9rydu4Fa2yGMvdELdhT7S81m/LyP/BAkCw7CtYuetWlVtiPRCb5U3x1yS+KXQkJO
         9i4OVKk6eUhhiTbAnJhggCiQ41kfcaYmY1+PNoOlLkRUaFZBTODv3iK/YYybBc0jC4oC
         v5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=btI/X9SDKoElUv2/KbWFVuLp06+/u9czm/CWpC6NJgM=;
        b=H5OprcPfkoHMgHqnmQ2V0UOJ9JtRviuYdYYnhRrlgmRFKOSv8uHzo4MKeLXkuS/Qr6
         RDz5rX0hquBtMHfMENaF5RrZnLAQEYPNK65EMUlrA3Qb33KnOIAN9eZW4lFczNvgGko+
         hVmSPJbEwPOEaCOmod8GH0Xes8LMlX2PEr8XWmJ19/jVzK/2g4YSlreFXCT5grcGqJkc
         Mnl4KN9WrQQwmAetLzol5KN45eZHImueBNXVRZXcGGlZ7xa9dokMwTcdXtiecmihLrfS
         ZLFb48prVDsEHm2w66BxI2YH89wIUVK1PTBPSvsUIvCdhy7T53Cp+GQ06Vvr/adlPq2H
         +0Sg==
X-Gm-Message-State: AOAM531Y2yZ+seg+zWtpaccin9luZr3Qj/6CmBlgayN6TxouxoDvWuli
        tz2dEh0oFdSEkcMB6AMgHaBJ3/kbJSoSbObwL0TfhQ==
X-Google-Smtp-Source: ABdhPJwKFe83BF3AQ0z4SV1knXAKNB01wIW69Bz37C/c6uL0TzG5KeLfQwPSwrm/PjyYvIDjGptFuo+U3s5+nw7Kgmk=
X-Received: by 2002:a1c:720e:: with SMTP id n14mr2964859wmc.152.1597135252525;
 Tue, 11 Aug 2020 01:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
In-Reply-To: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 11 Aug 2020 14:10:40 +0530
Message-ID: <CAAhSdy1c=R6aUZ6EOggmJ_Bqm2O0VLKEku=zyFfabExSzOKErA@mail.gmail.com>
Subject: Re: [PATCH] riscv: Setup exception vector for K210 properly
To:     Qiu Wenbo <qiuwenbo@phytium.com.cn>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:07 PM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
>
> Exception vector is missing on nommu platform and it is a big issue.
> This patch is tested in Sipeed MAIX Bit Dev Board.
>
> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> ---
>  arch/riscv/kernel/smpboot.c |  1 +
>  arch/riscv/kernel/traps.c   | 11 ++++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 356825a57551..23cde0ceb39d 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -154,6 +154,7 @@ asmlinkage __visible void smp_callin(void)
>         mmgrab(mm);
>         current->active_mm = mm;
>
> +       trap_init();
>         notify_cpu_starting(curr_cpuid);
>         update_siblings_masks(curr_cpuid);
>         set_cpu_online(curr_cpuid, 1);
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index ad14f4466d92..a390239818ae 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -174,7 +174,16 @@ int is_valid_bugaddr(unsigned long pc)
>  }
>  #endif /* CONFIG_GENERIC_BUG */
>
> -/* stvec & scratch is already set from head.S */
> +/* stvec & scratch is already set from head.S when mmu is enabled */
>  void trap_init(void)
>  {
> +#ifndef CONFIG_MMU
> +       /*
> +        * Set sup0 scratch register to 0, indicating to exception vector
> +        * that we are presently executing in the kernel
> +        */
> +       csr_write(CSR_SCRATCH, 0);
> +       /* Set the exception vector address */
> +       csr_write(CSR_TVEC, &handle_exception);
> +#endif
>  }
> --
> 2.28.0
>

This issue seems to be only on the latest master branch of
Linux stable tree so this fix need not be a stable fix.

For MMU kernel, the CSR_TVEC is setup in relocate() function
called from secondary_start_common() function of head.S

For NoMMU kernel, we should set CSR_TVEC directly in
secondary_start_common() function as "#else" case of the
"#ifdef CONFIG_MMU".

Regards,
Anup
