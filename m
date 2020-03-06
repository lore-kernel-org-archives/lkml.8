Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C81C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2602073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 05:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giWXsPFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgCFFoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 00:44:10 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34609 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgCFFoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 00:44:10 -0500
Received: by mail-yw1-f65.google.com with SMTP id o186so1242644ywc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 21:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3IwrZUQqiYpQ05+xHGqOPIrMQ1etdqNiNuQYl6eEQ9g=;
        b=giWXsPFX5woLiGAB3l2jac5/y8o0/8m49T081i55sOFOy47cjegPQdgCs6tVLLOzte
         P4lhyXl9ns0pyAv6Ww3E0yS+74T72iLhsKRcdK4zRpStqudRtFBL17QDVDTtBRuDC084
         ipODmbjGnlWoGnljRyuoAsJk8Y0kDAy775IAAeNQZoTRWo5XQbQbLerMeJVeBqn4O6ro
         CjqUeO5Yrq4bm1HMvf7ji485y4w/zpZvtyFMXMQ2nYoaywyZSXGPwHAwIBbKtTQddr+4
         5bCujO2+ZW0An7Ifl0Som0RF/uu62D3dq4lEz1Sn8bG92wglLmJAZ8QM2VTIgH/FQV95
         u7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3IwrZUQqiYpQ05+xHGqOPIrMQ1etdqNiNuQYl6eEQ9g=;
        b=Cwgs8x7/C5iOffLXag5TIaApFxM/EKjBV6v9kY/1HlX3jlKAMoVQu/xX0jPSRx6TAz
         Rw5YUgkT7YFjSjHMy1GVlvj+KXVVC1qy4tu5BLnrihRQvJrM3nHoFA+fS59d3tmWDeAf
         224t//uhwyf2jEefSr9jMGl+/cbhTK9NW1OdYVwZO4E4TmE6hlDqWb8If2UHDZK8S9h3
         MEf/dEAk2cMk/UMSE90rl+ct3JXJwCWZSoVpnrqTY9B9a4QfZ+PqJEvnHnesR8uPy7Qe
         ezZyo3Z8oAQXYH5oKC9ofgkqGkXt+w9wMMyCO9o3MfBNwAZgg+7jKZpLos3bdx0pArgb
         +6KQ==
X-Gm-Message-State: ANhLgQ3sRx10EKirLqE26OGiVFb0hbTkP9a5Ov0mnkkZ6GCRtcEOntBJ
        mmjQQHtY1Il6upwsBe7Wc0zf1EtOafujCrQw+pA=
X-Google-Smtp-Source: ADFU+vuZE0WLRV4tvglz4GLNzhX9eTqHGAMs5qnxho7fo2tWIzDuNWtzaI++klugU76CQiYD6PIKktR8w/+P9KNmDjI=
X-Received: by 2002:a25:614b:: with SMTP id v72mr2002674ybb.154.1583473448978;
 Thu, 05 Mar 2020 21:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20200226220213.27423-1-atish.patra@wdc.com> <20200226220213.27423-2-atish.patra@wdc.com>
In-Reply-To: <20200226220213.27423-2-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 6 Mar 2020 13:43:57 +0800
Message-ID: <CAEUhbmWLNi+vAFjjHLNKQ-PfMUusEEorVN7S8sK0yZhEAUk3Fg@mail.gmail.com>
Subject: Re: [PATCH v10 01/12] RISC-V: Mark existing SBI as 0.1 SBI.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Gary Guo <gary@garyguo.net>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Borislav Petkov <bp@suse.de>, Mao Han <han_mao@c-sky.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Hu <nickhu@andestech.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Chen <vincent.chen@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Anup Patel <anup@brainfault.org>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 6:02 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> As per the new SBI specification, current SBI implementation version
> is defined as 0.1 and will be removed/replaced in future. Each of the
> function call in 0.1 is defined as a separate extension which makes
> easier to replace them one at a time.
>
> Rename existing implementation to reflect that. This patch is just
> a preparatory patch for SBI v0.2 and doesn't introduce any functional
> changes.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/include/asm/sbi.h | 44 ++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 2570c1e683d3..3db30e739c8f 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (C) 2015 Regents of the University of California
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
>   */
>
>  #ifndef _ASM_RISCV_SBI_H
> @@ -9,17 +10,17 @@
>  #include <linux/types.h>
>
>  #ifdef CONFIG_RISCV_SBI
> -#define SBI_SET_TIMER 0
> -#define SBI_CONSOLE_PUTCHAR 1
> -#define SBI_CONSOLE_GETCHAR 2
> -#define SBI_CLEAR_IPI 3
> -#define SBI_SEND_IPI 4
> -#define SBI_REMOTE_FENCE_I 5
> -#define SBI_REMOTE_SFENCE_VMA 6
> -#define SBI_REMOTE_SFENCE_VMA_ASID 7
> -#define SBI_SHUTDOWN 8
> +#define SBI_EXT_0_1_SET_TIMER 0x0
> +#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
> +#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
> +#define SBI_EXT_0_1_CLEAR_IPI 0x3
> +#define SBI_EXT_0_1_SEND_IPI 0x4
> +#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
> +#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
> +#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
> +#define SBI_EXT_0_1_SHUTDOWN 0x8
>
> -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
> +#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \

nits: this line should not be changed

>         register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
>         register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
>         register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
> @@ -43,48 +44,50 @@
>

[snip]

Regards,
Bin
