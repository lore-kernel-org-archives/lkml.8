Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E89CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 322E52070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZCyClEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgCFDct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:32:49 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40970 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFDcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:32:48 -0500
Received: by mail-yw1-f67.google.com with SMTP id p124so984451ywc.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 19:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wHaCOyqP2WWjD8mfCv3YCZLYmNbyCJpMXSFySbHb144=;
        b=FZCyClEkILXJtjPwL5CSf2dtrY8c4ImGIQ/3j9lq+y9O1DbCZjjdc62j4ndbnrSQQt
         xyRFRzn0i9UYv3YxD4C+BLuxsek7aHlOi1JW1slWQIHI2/CLmoQISATML7f/If9uxxxx
         Hssye2wCPwrcwn0dmHi6o9cMFJ0542xG1/n8V2YBcE8RdFZpkJhTY4eTQKbWQBJeBI6r
         45qOnwYISNeigZ6laog+yt6oHcU58hEM/vKS3VgeIwlrmtGqCJDJx7sFdi6QBaaPQnC4
         8z3KwdXqge3PrNNCSFGvljlvU2KSDOvmWeiY/2vOnZmYoMr8VYQXmZLbK8SMlxaaCfEe
         DXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wHaCOyqP2WWjD8mfCv3YCZLYmNbyCJpMXSFySbHb144=;
        b=iQIfiaG/8gy9/6E/txRw+kscpGHrRt4tl4UiStXRwnakMDdZVk1Cb1du6utMuCWK0W
         VzHeatIKHATB0zmJbxk1u22E5Cfjy7dIcWdjxsd7cooSCDHrHykoMCAUeEDcXBBJPYTs
         UXsz0FhGOS2VG7JyLK90a2ott6U4SwA5TZ6R27+oxn9EvxbWCyP1mEUF0t9wSfvndhfv
         YAlU4TtHLn3S0xRnxpQNtDOJSfeUfyBVKJTKCn5ByUKNECbZm00cWlEHQ73MTBtstHkG
         Mmd7nmDOmHOJV75TAgQ//LVdvTukCyqy674JcNXG0ux5imTPVvcZ8VGVCUKewHXNbbeU
         JVgw==
X-Gm-Message-State: ANhLgQ0I43G9D5rDWr6VfsLZtgP2wICI/yLc3JxSLRFF0OnSx+Vsu3wS
        eoReQJfEueSLfGHzUCCT4vhS3rkzvwzqzUYIJcU=
X-Google-Smtp-Source: ADFU+vu1LIATmaD+zA7Z2GpCD+Eoo6JMw+w9RdOwO4k3qpEvMp6gaxrgoYzrb+hN/hkNLk97BezeQf4lXoqGN0Slj/o=
X-Received: by 2002:a0d:ca8e:: with SMTP id m136mr1839136ywd.349.1583465566396;
 Thu, 05 Mar 2020 19:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20200128022737.15371-1-atish.patra@wdc.com> <20200128022737.15371-2-atish.patra@wdc.com>
In-Reply-To: <20200128022737.15371-2-atish.patra@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 6 Mar 2020 11:32:34 +0800
Message-ID: <CAEUhbmXO1pQjtd=4gqxxM8V=6=7zQu=7Hx2rAQefK_JC5azRww@mail.gmail.com>
Subject: Re: [PATCH v7 01/10] RISC-V: Mark existing SBI as 0.1 SBI.
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        "Chang, Abner (HPS SW/FW Technologist)" <abner.chang@hpe.com>,
        Vincent Chen <vincent.chen@sifive.com>, nickhu@andestech.com,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mike Rapoport <rppt@linux.ibm.com>, clin@suse.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Mao Han <han_mao@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:28 AM Atish Patra <atish.patra@wdc.com> wrote:
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
> index 2570c1e683d3..b38bc36f7429 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
>   * Copyright (C) 2015 Regents of the University of California
> + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
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
