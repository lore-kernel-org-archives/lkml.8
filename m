Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE58C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BE82168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atishpatra.org header.i=@atishpatra.org header.b="KzuOXwP/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgBLTyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:54:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43923 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBLTyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:54:46 -0500
Received: by mail-wr1-f65.google.com with SMTP id r11so3865579wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8h+Be9OF2MK5Ytpf2Np0wQ3iq3A9mioBHD0VRufyqqs=;
        b=KzuOXwP/+AczoDterQIfUoyyRVd1T5q06m9N7yXg/EIcJV0Hg3BaneqpiZueDOUbyf
         75kWFFgECPDmtsVJQJ48OhX86KUkkFf2uZg79Z8OUMSZNQi8x1RuKASjzxVa4QcOjghS
         B/I6RdenX/vbGwlu17ITtB78+UKMhqHkQoCGGc/DK3XMcm9ioKNWINQdqh38ob0CIDcW
         iltBuYbPUQ/BKQx6kO+d+REfDu+cqjkhCrFJhMjs6O596hgVZAtLzHgDo5okHe2oL2Y8
         PdO6aXdLs9/HrGK9DN3NqQzASfiX0Zxx6WM/r9clWgMsZQzru9w2K27ey3K23bRWpk43
         41yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8h+Be9OF2MK5Ytpf2Np0wQ3iq3A9mioBHD0VRufyqqs=;
        b=k4TR7Tu1wcLyUywLcq1iXueOUCP1yXngWdCjfrYFUeJUtOt7KVFvHk3mcFwKyxwOFM
         6fPJ3q0m7IqtiwShLjV4Ew1Yoe6l/bWkQmKeXDkteDheBkS16UCXtrW9tsAF9qTWXJMG
         Yg1lxCceP3cgMV4H6PAJ8HP0HwGeLLBFI/JkatYf757Ud1YchFXtVJZw14B45R6bSjwA
         S2HcdhTFkkaVollTz+qor12PomqXm4amsjnmGVLZ4Ix3hX1mZwbRTqAFmfPf+C4DWfTz
         /dnnVO7dsc+Quo4seIKs+8wmZQI7KCc79sKkDoIhy1JUdeAOwofj8VezewnMPm73XOiK
         IL0A==
X-Gm-Message-State: APjAAAUe6KxInf8jeE5aNVHGCpsmaE7waOOfuNkycRC+I1I4y5/gZrWI
        35djrrNVHdplvjxVcAqN4QVMYsvM21+mldy7z/IH
X-Google-Smtp-Source: APXvYqyO39GcuK0lCZrVW17R51sCLoUFtXVAQVtueys2KeFSpTcHV0AgMs8QzVnkGVgZlqfP1GXQFpbkp3llvduOqU0=
X-Received: by 2002:a5d:534d:: with SMTP id t13mr17667438wrv.77.1581537283865;
 Wed, 12 Feb 2020 11:54:43 -0800 (PST)
MIME-Version: 1.0
References: <20200212014822.28684-1-atish.patra@wdc.com> <20200212014822.28684-9-atish.patra@wdc.com>
 <CAAhSdy1BB=-FR_hx2mObDeWD+z2WzaVdZeiO9inmGPXasMcCTg@mail.gmail.com>
In-Reply-To: <CAAhSdy1BB=-FR_hx2mObDeWD+z2WzaVdZeiO9inmGPXasMcCTg@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 12 Feb 2020 11:54:32 -0800
Message-ID: <CAOnJCUJif_njbXAbZcAtzaBiEugL1Qb=_HrB3CtsebvRGd2kJA@mail.gmail.com>
Subject: Re: [PATCH v8 08/11] RISC-V: Add SBI HSM extension
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Mao Han <han_mao@c-sky.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 8:53 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Wed, Feb 12, 2020 at 7:22 AM Atish Patra <atish.patra@wdc.com> wrote:
> >
> > SBI specification defines HSM extension that allows to start/stop a hart
> > by a supervisor anytime. The specification is available at
> >
> > https://github.com/riscv/riscv-sbi-doc/blob/master/riscv-sbi.adoc
> >
> > Implement SBI HSM extension.
>
> I think this PATCH needs to be further broken down.
>
> There are three distinct changes here:
> 1. Exporting sbi_err_map_linux_errno() function
>     arch/riscv/kernel/sbi.c
>     arch/riscv/include/asm/sbi.h
> 2. SBI HSM defines
>     arch/riscv/include/asm/sbi.h
> 3. SBI HSM helper functions (which are mostly static functions)
>     arch/riscv/kernel/Makefile
>     arch/riscv/kernel/cpu_ops_sbi.c
>
> We need separate patches for point1 and point2 above.
>
> Also, point3 can be part of current PATCH9.
>

Done.

> Regards,
> Anup
>
> >
> > Signed-off-by: Atish Patra <atish.patra@wdc.com>
> > ---
> >  arch/riscv/include/asm/sbi.h    | 15 +++++++++++
> >  arch/riscv/kernel/Makefile      |  3 +++
> >  arch/riscv/kernel/cpu_ops_sbi.c | 48 +++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/sbi.c         |  3 ++-
> >  4 files changed, 68 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/kernel/cpu_ops_sbi.c
> >
> > diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> > index d55d8090ab5c..0981a0c97eda 100644
> > --- a/arch/riscv/include/asm/sbi.h
> > +++ b/arch/riscv/include/asm/sbi.h
> > @@ -26,6 +26,7 @@ enum sbi_ext_id {
> >         SBI_EXT_TIME = 0x54494D45,
> >         SBI_EXT_IPI = 0x735049,
> >         SBI_EXT_RFENCE = 0x52464E43,
> > +       SBI_EXT_HSM = 0x48534D,
> >  };
> >
> >  enum sbi_ext_base_fid {
> > @@ -56,6 +57,19 @@ enum sbi_ext_rfence_fid {
> >         SBI_EXT_RFENCE_REMOTE_HFENCE_VVMA_ASID,
> >  };
> >
> > +enum sbi_ext_hsm_fid {
> > +       SBI_EXT_HSM_HART_START = 0,
> > +       SBI_EXT_HSM_HART_STOP,
> > +       SBI_EXT_HSM_HART_STATUS,
> > +};
> > +
> > +enum sbi_hsm_hart_status {
> > +       SBI_HSM_HART_STATUS_AVAILABLE = 0,
> > +       SBI_HSM_HART_STATUS_NOT_AVAILABLE,
> > +       SBI_HSM_HART_STATUS_START_PENDING,
> > +       SBI_HSM_HART_STATUS_STOP_PENDING,
> > +};
> > +
> >  #define SBI_SPEC_VERSION_DEFAULT       0x1
> >  #define SBI_SPEC_VERSION_MAJOR_SHIFT   24
> >  #define SBI_SPEC_VERSION_MAJOR_MASK    0x7f
> > @@ -130,6 +144,7 @@ static inline unsigned long sbi_minor_version(void)
> >  {
> >         return sbi_spec_version & SBI_SPEC_VERSION_MINOR_MASK;
> >  }
> > +int sbi_err_map_linux_errno(int err);
> >  #else /* CONFIG_RISCV_SBI */
> >  /* stubs for code that is only reachable under IS_ENABLED(CONFIG_RISCV_SBI): */
> >  void sbi_set_timer(uint64_t stime_value);
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index f81a6ff88005..a0be34b96846 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -44,5 +44,8 @@ obj-$(CONFIG_PERF_EVENTS)     += perf_event.o
> >  obj-$(CONFIG_PERF_EVENTS)      += perf_callchain.o
> >  obj-$(CONFIG_HAVE_PERF_REGS)   += perf_regs.o
> >  obj-$(CONFIG_RISCV_SBI)                += sbi.o
> > +ifeq ($(CONFIG_RISCV_SBI), y)
> > +obj-$(CONFIG_SMP) += cpu_ops_sbi.o
> > +endif
> >
> >  clean:
> > diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
> > new file mode 100644
> > index 000000000000..9bdb60e0a4df
> > --- /dev/null
> > +++ b/arch/riscv/kernel/cpu_ops_sbi.c
> > @@ -0,0 +1,48 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * HSM extension and cpu_ops implementation.
> > + *
> > + * Copyright (c) 2020 Western Digital Corporation or its affiliates.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/mm.h>
> > +#include <asm/sbi.h>
> > +#include <asm/smp.h>
> > +
> > +static int sbi_hsm_hart_stop(void)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STOP, 0, 0, 0, 0, 0, 0);
> > +
> > +       if (ret.error)
> > +               return sbi_err_map_linux_errno(ret.error);
> > +       else
> > +               return 0;
> > +}
> > +
> > +static int sbi_hsm_hart_start(unsigned long hartid, unsigned long saddr,
> > +                      unsigned long priv)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_START,
> > +                             hartid, saddr, priv, 0, 0, 0);
> > +       if (ret.error)
> > +               return sbi_err_map_linux_errno(ret.error);
> > +       else
> > +               return 0;
> > +}
> > +
> > +static int sbi_hsm_hart_get_status(unsigned long hartid)
> > +{
> > +       struct sbiret ret;
> > +
> > +       ret = sbi_ecall(SBI_EXT_HSM, SBI_EXT_HSM_HART_STATUS,
> > +                             hartid, 0, 0, 0, 0, 0);
> > +       if (ret.error)
> > +               return sbi_err_map_linux_errno(ret.error);
> > +       else
> > +               return ret.value;
> > +}
> > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > index cd0f68aeac70..45ad49269f2c 100644
> > --- a/arch/riscv/kernel/sbi.c
> > +++ b/arch/riscv/kernel/sbi.c
> > @@ -47,7 +47,7 @@ struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
> >  }
> >  EXPORT_SYMBOL(sbi_ecall);
> >
> > -static int sbi_err_map_linux_errno(int err)
> > +int sbi_err_map_linux_errno(int err)
> >  {
> >         switch (err) {
> >         case SBI_SUCCESS:
> > @@ -64,6 +64,7 @@ static int sbi_err_map_linux_errno(int err)
> >                 return -ENOTSUPP;
> >         };
> >  }
> > +EXPORT_SYMBOL(sbi_err_map_linux_errno);
> >
> >  #ifdef CONFIG_RISCV_SBI_V01
> >  /**
> > --
> > 2.24.0
> >
>


-- 
Regards,
Atish
