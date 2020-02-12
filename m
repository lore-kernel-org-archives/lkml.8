Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B40C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C61D20656
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="c7m6T8T5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBLExp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:53:45 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55732 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgBLExp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:53:45 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so528697wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 20:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3I87EH+GVaQ1tMMhv9dMZ3J2ca6jz68b2jHRtZzzGrE=;
        b=c7m6T8T5rmy0mHF1oAmaFmrtVteMYQJdBz4blG6xOf87l4Dlwh+YCoY/P0OXA6m+0A
         wtN9AHvBOpZ1i32ivvOZj9CxRXqtVEye69+8eiV1i20engxcxplRtqJNPJvuwYxzAii7
         UdspKJHx0ExgkFGPc14M5u5ENSp3j30turGWKWiZG6O4ejUo7Xj/RbjfKtjznStD1nmF
         ItCtm/01ke0+ajqRw03RcfLRdEuOAlTc8kPAoKXZPiScaT3m3+mawj37iG2TJ5tlldBk
         urMKG4fnw39kp+q90SyDw0yENv6vb+2z868FmQRmuEfd4u81hwLJaGT0fZ6+hyscYpzK
         fojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3I87EH+GVaQ1tMMhv9dMZ3J2ca6jz68b2jHRtZzzGrE=;
        b=P+OZ2x8nqNkmePc5yFxa9eL5uQ3vCdyiMrg3ue/Rizs+t+8enoK6hGJRkVpiZtoI74
         eDG7UpuYqCojr+ZttfIkx0ivd/EYHxrkgEVvHcVdHfkNx95lNx/N2gXWM4dM5LmwEKXR
         8edgO1zGl9f9MPFnWq7rwvy9qZ9sSma5p1bqwHL4L8519LPQued0eD7KixyiOofIFFqj
         nSZNiwoH/6esPmlN6Ne5voGSqT+5QdrKDjQ01JU7IoszSivyOLP/KPQoyvmIWm+DmzLA
         VTYtnoK57N3Lb1fYW0xtUpZUiOBG0VqcSpkSYPwr7/fe6KdknHy76DRG9OiQXecr51kQ
         riwg==
X-Gm-Message-State: APjAAAU1hiZw796/57wvwiBfdqm+N2a02CJpLW+t5eDwPqd88ar6hIx/
        xS+HJCWDUc/YvS/m5H1NzqTNMW6CsNn3P8pye0EJNQ==
X-Google-Smtp-Source: APXvYqwCXw2uLBV+Qtq2e1xTQCaBzWwqzFm2Nk54/DQ46VVW052ulmWJERF3UW0vJ6ZHZ018IbGAgNSFi4PkwkaVGgA=
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr10400816wmf.102.1581483222225;
 Tue, 11 Feb 2020 20:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-9-atish.patra@wdc.com>
In-Reply-To: <20200212014822.28684-9-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 12 Feb 2020 10:23:30 +0530
Message-ID: <CAAhSdy1BB=-FR_hx2mObDeWD+z2WzaVdZeiO9inmGPXasMcCTg@mail.gmail.com>
Subject: Re: [PATCH v8 08/11] RISC-V: Add SBI HSM extension
To:     Atish Patra <atish.patra@wdc.com>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Allison Randal <allison@lohutok.net>,
        Borislav Petkov <bp@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mao Han <han_mao@c-sky.com>, Marc Zyngier <maz@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <vincent.chen@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 7:22 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> SBI specification defines HSM extension that allows to start/stop a hart
> by a supervisor anytime. The specification is available at
>
> https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
>
> Implement SBI HSM extension.

I think this PATCH needs to be further broken down.

There are three distinct changes here:
1. Exporting sbi_err_map_linux_errno() function
    arch/riscv/kernel/sbi.c
    arch/riscv/include/asm/sbi.h
2. SBI HSM defines
    arch/riscv/include/asm/sbi.h
3. SBI HSM helper functions (which are mostly static functions)
    arch/riscv/kernel/Makefile
    arch/riscv/kernel/cpu_ops_sbi.c

We need separate patches for point1 and point2 above.

Also, point3 can be part of current PATCH9.

Regards,
Anup

>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/include/asm/sbi.h    | 15 +++++++++++
>  arch/riscv/kernel/Makefile      |  3 +++
>  arch/riscv/kernel/cpu_ops_sbi.c | 48 +++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/sbi.c         |  3 ++-
>  4 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
>
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index d55d8090ab5c..0981a0c97eda 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -26,6 +26,7 @@ enum sbi_ext_id {
>         SBI_EXT_TIME = 0x54494D45,
>         SBI_EXT_IPI = 0x735049,
>         SBI_EXT_RFENCE = 0x52464E43,
> +       SBI_EXT_HSM = 0x48534D,
>  };
>
>  enum sbi_ext_base_fid {
> @@ -56,6 +57,19 @@ enum sbi_ext_rfence_fid {
>         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
>  };
>
> +enum sbi_ext_hsm_fid {
> +       SBI_EXT_HSM_HART_START = 0,
> +       SBI_EXT_HSM_HART_STOP,
> +       SBI_EXT_HSM_HART_STATUS,
> +};
> +
> +enum sbi_hsm_hart_status {
> +       SBI_HSM_HART_STATUS_AVAILABLE = 0,
> +       SBI_HSM_HART_STATUS_NOT_AVAILABLE,
> +       SBI_HSM_HART_STATUS_START_PENDING,
> +       SBI_HSM_HART_STATUS_STOP_PENDING,
> +};
> +
>  #define SBI_SPEC_VERSION_DEFAULT       0x1
>  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
>  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> @@ -130,6 +144,7 @@ static inline unsigned long sbi_minor_version(void)
>  {
>         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
>  }
> +int sbi_err_map_linux_errno(int err);
>  #else /* CONFIG_RISCV_SBI */
>  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
>  void sbi_set_timer(uint64_t stime_value);
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f81a6ff88005..a0be34b96846 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -44,5 +44,8 @@ obj-$(CONFIG_PERF_EVENTS)     += perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)                += sbi.o
> +ifeq ($(CONFIG_RISCV_SBI), y)
> +obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> +endif
>
>  clean:
> diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> new file mode 100644
> index 000000000000..9bdb60e0a4df
> --- /dev/null
> +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> @@ -0,0 +1,48 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * HSM extension and cpu_ops implementation.
> + *
> + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <asm/sbi.h>
> +#include <asm/smp.h>
> +
> +static int sbi_hsm_hart_stop(void)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STOP, 0, 0, 0, 0, 0, 0);
> +
> +       if (ret.error)
> +               return sbi_err_map_linux_errno(ret.error);
> +       else
> +               return 0;
> +}
> +
> +static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
> +                      unsigned long priv)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_START,
> +                             hartid, saddr, priv, 0, 0, 0);
> +       if (ret.error)
> +               return sbi_err_map_linux_errno(ret.error);
> +       else
> +               return 0;
> +}
> +
> +static int sbi_hsm_hart_get_status(unsigned long hartid)
> +{
> +       struct sbiret ret;
> +
> +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STATUS,
> +                             hartid, 0, 0, 0, 0, 0);
> +       if (ret.error)
> +               return sbi_err_map_linux_errno(ret.error);
> +       else
> +               return ret.value;
> +}
> diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> index cd0f68aeac70..45ad49269f2c 100644
> --- a/arch/riscv/kernel/sbi.c
> +++ b/arch/riscv/kernel/sbi.c
> @@ -47,7 +47,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
>  }
>  EXPORT_SYMBOL(sbi_ecall);
>
> -static int sbi_err_map_linux_errno(int err)
> +int sbi_err_map_linux_errno(int err)
>  {
>         switch (err) {
>         case SBI_SUCCESS:
> @@ -64,6 +64,7 @@ static int sbi_err_map_linux_errno(int err)
>                 return -ENOTSUPP;
>         };
>  }
> +EXPORT_SYMBOL(sbi_err_map_linux_errno);
>
>  #ifdef CONFIG_RISCV_SBI_V01
>  /**
> --
> 2.24.0
>
