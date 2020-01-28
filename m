Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E18C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9207322522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="a5JktWNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgA1TMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:12:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55210 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgA1TMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:12:46 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so3731349wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jA++fwhd2MIQecXKnVEwZm37ajuv4PtXSoXWXLtMM4w=;
        b=a5JktWNC122Fm6B2ZZx8LqwZqeRpkvI3iwvG2M0Jg0ZfE/rudTS7TkJn4M05w4z174
         /zoN4pDtGWf1vQuElSPTJBeDMl1ay5K4kL90yLmMqD/48kIETHPfvBR6cvZfNDkpyl68
         /caYsvI+VsqROpuuImI8aGkg0C/xUNAWfZPQAqUtj8m8ATIZZ+RFSAhVPDQjWl7TN0C3
         uY/bJYQ3pJabtIfoA1ejlgxW5NwqmAM5vbAl+NxdvouEEy1KuDbbPI2Exf7KVznS0OW2
         QEJIJ/43hfqIKFmok/aDr9uOEWrTTqUImMscQBm1oBlwBGF+McpzsR0qjcv+zuzuib/W
         mftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jA++fwhd2MIQecXKnVEwZm37ajuv4PtXSoXWXLtMM4w=;
        b=VDBEaq8g+CGy58c5Vv38cOa69eyjfdFk+2jfLlGsjT2PUD3IeeFdu6QrbVecvPWi3s
         zJ/CVL3VvpLl5+vFddTPpNjb2a40bZxoH2XwAqDfn0+a1B4CF5F2DkYQ6DT3jZoeZ/Ut
         htHMa6Y4+Y22HFVN4N93kTvAUpGOZOnGaS5dzI9+GKCZLOshK87lW+8uzxhVFPQ/j927
         tjhuDPAToN/x9/RwsXwd8V2d8OrL/cyoXjyExCYwDpO6/H9abl5x9jSKjFOdNeyoF0tK
         1nGILdQyYUMHiwTXUKW3lUyzpiRHkNqa7+hCkv9Pv1hMOqWr0C8qAaNVlM3FgiQB0CFl
         /ORQ==
X-Gm-Message-State: APjAAAWjJcihTQfi80OX5xle0FLrZJf2xirokUIXNk9zYPwZg6Qr48JT
        dFb+NccmAzpt8k2mycO2Df4+EldqYYMDQgPyMazU
X-Google-Smtp-Source: APXvYqy+y2quKjXkouXr3R5XlmRrQDl4aE2G6ks+xwWwd8PqYP4mAnJHB4Cxib/spXEEiKmvrIE2B4Xo8YsWYRaGxYU=
X-Received: by 2002:a1c:e388:: with SMTP id a130mr6479308wmh.176.1580238762918;
 Tue, 28 Jan 2020 11:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20200128022737.15371-1-atish.patra@wdc.com> <20200128022737.15371-3-atish.patra@wdc.com>
 <CAAhSdy3J=NSHCAKW+17twGxTFj=JQUcBx8uTXg3GNU9oW8AOTQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3J=NSHCAKW+17twGxTFj=JQUcBx8uTXg3GNU9oW8AOTQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 28 Jan 2020 11:12:31 -0800
Message-ID: <CAOnJCUJTR+gXY1zjUmrryFnWCPMNKmA-xxbrrdr8sfr0Oaq-Zw@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] RISC-V: Add basic support for SBI v0.2
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Abner Chang <abner.chang@hpe.com>, nickhu@andestech.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Chester Lin <clin@suse.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
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

On Mon, Jan 27, 2020 at 8:25 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Tue, Jan 28, 2020 at 7:58 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > The SBI v0.2 introduces a base extension which is backward compatible
> > with v0.1. Implement all helper functions and minimum required SBI
> > calls from v0.2 for now. All other base extension function will be
> > added later as per need.
> > As v0.2 calling convention is backward compatible with v0.1, remove
> > the v0.1 helper functions and just use v0.2 calling convention.
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> > Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  arch/riscv/include/asm/sbi.h | 140 ++++++++++----------
> >  arch/riscv/kernel/sbi.c      | 243 ++++++++++++++++++++++++++++++++++-
> >  arch/riscv/kernel/setup.c    |   4 +
> >  3 files changed, 313 insertions(+), 74 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index b38bc36f7429..fbdb7443784a 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -10,93 +10,88 @@
> >  #include <linux/types.h>
> >
> >  #ifdef CONFIG_RISCV_SBI
> > -#define SBI_EXT_0_1_SET_TIMER 0x0
> > -#define SBI_EXT_0_1_CONSOLE_PUTCHAR 0x1
> > -#define SBI_EXT_0_1_CONSOLE_GETCHAR 0x2
> > -#define SBI_EXT_0_1_CLEAR_IPI 0x3
> > -#define SBI_EXT_0_1_SEND_IPI 0x4
> > -#define SBI_EXT_0_1_REMOTE_FENCE_I 0x5
> > -#define SBI_EXT_0_1_REMOTE_SFENCE_VMA 0x6
> > -#define SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID 0x7
> > -#define SBI_EXT_0_1_SHUTDOWN 0x8
> > +enum sbi_ext_id {
> > +       SBI_EXT_0_1_SET_TIMER = 0x0,
> > +       SBI_EXT_0_1_CONSOLE_PUTCHAR = 0x1,
> > +       SBI_EXT_0_1_CONSOLE_GETCHAR = 0x2,
> > +       SBI_EXT_0_1_CLEAR_IPI = 0x3,
> > +       SBI_EXT_0_1_SEND_IPI = 0x4,
> > +       SBI_EXT_0_1_REMOTE_FENCE_I = 0x5,
> > +       SBI_EXT_0_1_REMOTE_SFENCE_VMA = 0x6,
> > +       SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID = 0x7,
> > +       SBI_EXT_0_1_SHUTDOWN = 0x8,
> > +       SBI_EXT_BASE = 0x10,
> > +};
> >
> > -#define SBI_CALL(which, arg0, arg1, arg2, arg3) ({             \
> > -       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);   \
> > -       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);   \
> > -       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);   \
> > -       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);   \
> > -       register uintptr_t a7 asm ("a7") = (uintptr_t)(which);  \
> > -       asm volatile ("ecall"                                   \
> > -                     : "+r" (a0)                               \
> > -                     : "r" (a1), "r" (a2), "r" (a3), "r" (a7)  \
> > -                     : "memory");                              \
> > -       a0;                                                     \
> > -})
> > +enum sbi_ext_base_fid {
> > +       SBI_EXT_BASE_GET_SPEC_VERSION = 0,
> > +       SBI_EXT_BASE_GET_IMP_ID,
> > +       SBI_EXT_BASE_GET_IMP_VERSION,
> > +       SBI_EXT_BASE_PROBE_EXT,
> > +       SBI_EXT_BASE_GET_MVENDORID,
> > +       SBI_EXT_BASE_GET_MARCHID,
> > +       SBI_EXT_BASE_GET_MIMPID,
> > +};
> >
> > -/* Lazy implementations until SBI is finalized */
> > -#define SBI_CALL_0(which) SBI_CALL(which, 0, 0, 0, 0)
> > -#define SBI_CALL_1(which, arg0) SBI_CALL(which, arg0, 0, 0, 0)
> > -#define SBI_CALL_2(which, arg0, arg1) SBI_CALL(which, arg0, arg1, 0, 0)
> > -#define SBI_CALL_3(which, arg0, arg1, arg2) \
> > -               SBI_CALL(which, arg0, arg1, arg2, 0)
> > -#define SBI_CALL_4(which, arg0, arg1, arg2, arg3) \
> > -               SBI_CALL(which, arg0, arg1, arg2, arg3)
> > +#define SBI_SPEC_VERSION_DEFAULT       0x1
> > +#define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> > +#define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> > +#define SBI_SPEC_VERSION_MINOR_MASK    0xffffff
> >
> > -static inline void sbi_console_putchar(int ch)
> > -{
> > -       SBI_CALL_1(SBI_EXT_0_1_CONSOLE_PUTCHAR, ch);
> > -}
> > +/* SBI return error codes */
> > +#define SBI_SUCCESS            0
> > +#define SBI_ERR_FAILURE                -1
> > +#define SBI_ERR_NOT_SUPPORTED  -2
> > +#define SBI_ERR_INVALID_PARAM   -3
> > +#define SBI_ERR_DENIED         -4
> > +#define SBI_ERR_INVALID_ADDRESS -5
> >
> > -static inline int sbi_console_getchar(void)
> > -{
> > -       return SBI_CALL_0(SBI_EXT_0_1_CONSOLE_GETCHAR);
> > -}
> > +extern unsigned long sbi_spec_version;
> > +struct sbiret {
> > +       long error;
> > +       long value;
> > +};
> >
> > -static inline void sbi_set_timer(uint64_t stime_value)
> > -{
> > -#if __riscv_xlen == 32
> > -       SBI_CALL_2(SBI_EXT_0_1_SET_TIMER, stime_value,
> > -                         stime_value >> 32);
> > -#else
> > -       SBI_CALL_1(SBI_EXT_0_1_SET_TIMER, stime_value);
> > -#endif
> > -}
> > -
> > -static inline void sbi_shutdown(void)
> > -{
> > -       SBI_CALL_0(SBI_EXT_0_1_SHUTDOWN);
> > -}
> > +int sbi_init(void);
> > +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> > +                       unsigned long arg1, unsigned long arg2,
> > +                       unsigned long arg3, unsigned long arg4,
> > +                       unsigned long arg5);
> >
> > -static inline void sbi_clear_ipi(void)
> > -{
> > -       SBI_CALL_0(SBI_EXT_0_1_CLEAR_IPI);
> > -}
> > +void sbi_console_putchar(int ch);
> > +int sbi_console_getchar(void);
> > +void sbi_set_timer(uint64_t stime_value);
> > +void sbi_shutdown(void);
> > +void sbi_clear_ipi(void);
> > +void sbi_send_ipi(const unsigned long *hart_mask);
> > +void sbi_remote_fence_i(const unsigned long *hart_mask);
> > +void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> > +                          unsigned long start,
> > +                          unsigned long size);
> >
> > -static inline void sbi_send_ipi(const unsigned long *hart_mask)
> > -{
> > -       SBI_CALL_1(SBI_EXT_0_1_SEND_IPI, hart_mask);
> > -}
> > +void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> > +                               unsigned long start,
> > +                               unsigned long size,
> > +                               unsigned long asid);
> > +int sbi_probe_extension(int ext);
> >
> > -static inline void sbi_remote_fence_i(const unsigned long *hart_mask)
> > +/* Check if current SBI specification version is 0.1 or not */
> > +static inline int sbi_spec_is_0_1(void)
> >  {
> > -       SBI_CALL_1(SBI_EXT_0_1_REMOTE_FENCE_I, hart_mask);
> > +       return (sbi_spec_version == SBI_SPEC_VERSION_DEFAULT) ? 1 : 0;
> >  }
> >
> > -static inline void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> > -                                        unsigned long start,
> > -                                        unsigned long size)
> > +/* Get the major version of SBI */
> > +static inline unsigned long sbi_major_version(void)
> >  {
> > -       SBI_CALL_3(SBI_EXT_0_1_REMOTE_SFENCE_VMA, hart_mask,
> > -                         start, size);
> > +       return (sbi_spec_version >> SBI_SPEC_VERSION_MAJOR_SHIFT) &
> > +               SBI_SPEC_VERSION_MAJOR_MASK;
> >  }
> >
> > -static inline void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> > -                                             unsigned long start,
> > -                                             unsigned long size,
> > -                                             unsigned long asid)
> > +/* Get the minor version of SBI */
> > +static inline unsigned long sbi_minor_version(void)
> >  {
> > -       SBI_CALL_4(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, hart_mask,
> > -                         start, size, asid);
> > +       return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
> >  }
> >  #else /* CONFIG_RISCV_SBI */
> >  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> > @@ -104,5 +99,6 @@ void sbi_set_timer(uint64_t stime_value);
> >  void sbi_clear_ipi(void);
> >  void sbi_send_ipi(const unsigned long *hart_mask);
> >  void sbi_remote_fence_i(const unsigned long *hart_mask);
> > +void sbi_init(void);
> >  #endif /* CONFIG_RISCV_SBI */
> >  #endif /* _ASM_RISCV_SBI_H */
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index f6c7c3e82d28..33632e7f91da 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -1,17 +1,256 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * SBI initialilization and all extension implementation.
> > + *
> > + * Copyright (c) 2019 Western Digital Corporation or its affiliates.
> > + */
> >
> >  #include <linux/init.h>
> >  #include <linux/pm.h>
> >  #include <asm/sbi.h>
> >
> > +/* default SBI version is 0.1 */
> > +unsigned long sbi_spec_version = SBI_SPEC_VERSION_DEFAULT;
> > +EXPORT_SYMBOL(sbi_spec_version);
> > +
> > +struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> > +                       unsigned long arg1, unsigned long arg2,
> > +                       unsigned long arg3, unsigned long arg4,
> > +                       unsigned long arg5)
> > +{
> > +       struct sbiret ret;
> > +
> > +       register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
> > +       register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
> > +       register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
> > +       register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
> > +       register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
> > +       register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
> > +       register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
> > +       register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
> > +       asm volatile ("ecall"
> > +                     : "+r" (a0), "+r" (a1)
> > +                     : "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
> > +                     : "memory");
> > +       ret.error = a0;
> > +       ret.value = a1;
> > +
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL(sbi_ecall);
> > +
> > +static int sbi_err_map_linux_errno(int err)
> > +{
> > +       switch (err) {
> > +       case SBI_SUCCESS:
> > +               return 0;
> > +       case SBI_ERR_DENIED:
> > +               return -EPERM;
> > +       case SBI_ERR_INVALID_PARAM:
> > +               return -EINVAL;
> > +       case SBI_ERR_INVALID_ADDRESS:
> > +               return -EFAULT;
> > +       case SBI_ERR_NOT_SUPPORTED:
> > +       case SBI_ERR_FAILURE:
> > +       default:
> > +               return -ENOTSUPP;
> > +       };
> > +}
> > +
> > +/**
> > + * sbi_console_putchar() - Writes given character to the console device.
> > + * @ch: The data to be written to the console.
> > + *
> > + * Return: None
> > + */
> > +void sbi_console_putchar(int ch)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_CONSOLE_PUTCHAR, 0, ch, 0, 0, 0, 0, 0);
> > +}
> > +EXPORT_SYMBOL(sbi_console_putchar);
> > +
> > +/**
> > + * sbi_console_getchar() - Reads a byte from console device.
> > + *
> > + * Returns the value read from console.
> > + */
> > +int sbi_console_getchar(void)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_0_1_CONSOLE_GETCHAR, 0, 0, 0, 0, 0, 0, 0);
> > +
> > +       return ret.error;
> > +}
> > +EXPORT_SYMBOL(sbi_console_getchar);
> > +
> > +/**
> > + * sbi_set_timer() - Program the timer for next timer event.
> > + * @stime_value: The value after which next timer event should fire.
> > + *
> > + * Return: None
> > + */
> > +void sbi_set_timer(uint64_t stime_value)
> > +{
> > +#if __riscv_xlen == 32
> > +       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value,
> > +                         stime_value >> 32, 0, 0, 0, 0);
> > +#else
> > +       sbi_ecall(SBI_EXT_0_1_SET_TIMER, 0, stime_value, 0, 0, 0, 0, 0);
> > +#endif
> > +}
> > +EXPORT_SYMBOL(sbi_set_timer);
> > +
> > +/**
> > + * sbi_shutdown() - Remove all the harts from executing supervisor code.
> > + *
> > + * Return: None
> > + */
> > +void sbi_shutdown(void)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_SHUTDOWN, 0, 0, 0, 0, 0, 0, 0);
> > +}
> > +EXPORT_SYMBOL(sbi_shutdown);
> > +
> > +/**
> > + * sbi_clear_ipi() - Clear any pending IPIs for the calling hart.
> > + *
> > + * Return: None
> > + */
> > +void sbi_clear_ipi(void)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_CLEAR_IPI, 0, 0, 0, 0, 0, 0, 0);
> > +}
> > +
> > +/**
> > + * sbi_send_ipi() - Send an IPI to any hart.
> > + * @hart_mask: A cpu mask containing all the target harts.
> > + *
> > + * Return: None
> > + */
> > +void sbi_send_ipi(const unsigned long *hart_mask)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_SEND_IPI, 0, (unsigned long)hart_mask,
> > +                       0, 0, 0, 0, 0);
> > +}
> > +EXPORT_SYMBOL(sbi_send_ipi);
> > +
> > +/**
> > + * sbi_remote_fence_i() - Execute FENCE.I instruction on given remote harts.
> > + * @hart_mask: A cpu mask containing all the target harts.
> > + *
> > + * Return: None
> > + */
> > +void sbi_remote_fence_i(const unsigned long *hart_mask)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_REMOTE_FENCE_I, 0, (unsigned long)hart_mask,
> > +                       0, 0, 0, 0, 0);
> > +}
> > +EXPORT_SYMBOL(sbi_remote_fence_i);
> > +
> > +/**
> > + * sbi_remote_sfence_vma() - Execute SFENCE.VMA instructions on given remote
> > + *                          harts for the specified virtual address range.
> > + * @hart_mask: A cpu mask containing all the target harts.
> > + * @start: Start of the virtual address
> > + * @size: Total size of the virtual address range.
> > + *
> > + * Return: None
> > + */
> > +void sbi_remote_sfence_vma(const unsigned long *hart_mask,
> > +                                        unsigned long start,
> > +                                        unsigned long size)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA, 0,
> > +                       (unsigned long)hart_mask, start, size, 0, 0, 0);
> > +}
> > +EXPORT_SYMBOL(sbi_remote_sfence_vma);
> > +
> > +/**
> > + * sbi_remote_sfence_vma_asid() - Execute SFENCE.VMA instructions on given
> > + * remote harts for a virtual address range belonging to a specific ASID.
> > + *
> > + * @hart_mask: A cpu mask containing all the target harts.
> > + * @start: Start of the virtual address
> > + * @size: Total size of the virtual address range.
> > + * @asid: The value of address space identifier (ASID).
> > + *
> > + * Return: None
> > + */
> > +void sbi_remote_sfence_vma_asid(const unsigned long *hart_mask,
> > +                                             unsigned long start,
> > +                                             unsigned long size,
> > +                                             unsigned long asid)
> > +{
> > +       sbi_ecall(SBI_EXT_0_1_REMOTE_SFENCE_VMA_ASID, 0,
> > +                       (unsigned long)hart_mask, start, size, asid, 0, 0);
> > +}
> > +EXPORT_SYMBOL(sbi_remote_sfence_vma_asid);
> > +
> > +/**
> > + * sbi_probe_extension() - Check if an SBI extension ID is supported or not.
> > + * @extid: The extension ID to be probed.
> > + *
> > + * Return: Extension specific nonzero value f yes, -ENOTSUPP otherwise.
> > + */
> > +int sbi_probe_extension(int extid)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_BASE, SBI_EXT_BASE_PROBE_EXT, extid,
> > +                       0, 0, 0, 0, 0);
> > +       if (!ret.error)
> > +               if (ret.value)
> > +                       return ret.value;
> > +
> > +       return -ENOTSUPP;
> > +}
> > +EXPORT_SYMBOL(sbi_probe_extension);
> > +
> > +static long __sbi_base_ecall(int fid)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_BASE, fid, 0, 0, 0, 0, 0, 0);
> > +       if (!ret.error)
> > +               return ret.value;
> > +       else
> > +               return sbi_err_map_linux_errno(ret.error);
> > +}
> > +
> > +static inline long sbi_get_spec_version(void)
> > +{
> > +       return __sbi_base_ecall(SBI_EXT_BASE_GET_SPEC_VERSION);
> > +}
> > +
> > +static inline long sbi_get_firmware_id(void)
> > +{
> > +       return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_ID);
> > +}
> > +
> > +static inline long sbi_get_firmware_version(void)
> > +{
> > +       return __sbi_base_ecall(SBI_EXT_BASE_GET_IMP_VERSION);
> > +}
> > +
> >  static void sbi_power_off(void)
> >  {
> >         sbi_shutdown();
> >  }
> >
> > -static int __init sbi_init(void)
> > +int __init sbi_init(void)
> >  {
> > +       int ret;
> > +
> >         pm_power_off = sbi_power_off;
> > +       ret = sbi_get_spec_version();
> > +       if (ret > 0)
> > +               sbi_spec_version = ret;
> > +
> > +       pr_info("SBI specification v%lu.%lu detected\n",
> > +               sbi_major_version(), sbi_minor_version());
> > +       if (!sbi_spec_is_0_1())
> > +               pr_info("SBI implementation ID=0x%lx Version=0x%lx\n",
> > +                       sbi_get_firmware_id(), sbi_get_firmware_version());
> >         return 0;
> >  }
> > -early_initcall(sbi_init);
> > diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
> > index 365ff8420bfe..de3e65dae83a 100644
> > --- a/arch/riscv/kernel/setup.c
> > +++ b/arch/riscv/kernel/setup.c
> > @@ -22,6 +22,7 @@
> >  #include <asm/sections.h>
> >  #include <asm/pgtable.h>
> >  #include <asm/smp.h>
> > +#include <asm/sbi.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/thread_info.h>
> >
> > @@ -74,6 +75,9 @@ void __init setup_arch(char **cmdline_p)
> >         swiotlb_init(1);
> >  #endif
> >
> > +       if (IS_ENABLED(CONFIG_RISCV_SBI))
> > +               sbi_init();
> > +
>
> This has to "#if IS_ENABLED(CONFIG_RISCV_SBI)" instead of
> "if ()".
>
I am using it as a conditional statement. So I think usage is correct.
Do you mean #if IS_ENABLED preferred over if() ?

> Regards,
> Anup
>
> >  #ifdef CONFIG_SMP
> >         setup_smp();
> >  #endif
> > --
> > 2.24.0
> >
>


-- 
Regards,
Atish
