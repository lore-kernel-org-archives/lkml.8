Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923AFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACB421927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 03:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="xSUjBlOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgGNDuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 23:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgGNDuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 23:50:11 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2E4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:50:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so19500632wrj.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2pU/oRXe8zSH98/qlLNnZqVfljdKaiKGd5Djyh/EW4=;
        b=xSUjBlOytxheMN0Qygh7ElYrmY/6f5sOe3XoReILxBTvS+M/NKh4zZDDmr6WF4A6Ft
         zU/Ghe9q8AOapCe1xcwtRt2f7CkyVqHXMc4q7C7uZqjLywbOOv5Ru/SFE7w08PPgMQ7/
         yyJIXh69rVO4dfbZ+bYhMnPUywUqj1pUJmHYwT16W/PAkASHlCtRov419gtTrAhc+Lz1
         T2GxOF8p6rzAUVzDP64yxNHkjqUEvCckMKaO1qMzxeVsIGDeFDfdw0VbeEQu5t/GauLR
         makvc8Ts0BG2zt2oi+VysQqrk74fGbMeiaJ+7SGSrfRb0dBYR/PkOSsOy8iSR9XEwOwv
         EdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2pU/oRXe8zSH98/qlLNnZqVfljdKaiKGd5Djyh/EW4=;
        b=afOWeRpiXwLnfOih9TA859dUZYo2QAtcgoY27d+jvl1ewMDldtJRf91ICnMDxdNWdS
         eWfb0Pb3F8CxqFAGwfx7PvkJfxn7ebPzCPNAPa73MvBjYtKs1sTi776AItcCkh/pDkQR
         cbGC6VF+5gMXZE2wHiI02BvlkTKSCFSahD8itDxd/oHsGBbNW7pBFDtOUw66+wS5sY0D
         /O/583nhrEiXvu3VLFa6BSpk+9T6+9uHsO01uUJ7RlsxhOkGgevNv5C1PbOikiKjUJgZ
         FAcZ/z4eP8JwzvNWRl4zBLzI5jzDBSHlvZkmujcjjOLsYygCH8n+kNMKdp0sqlu7Bqnp
         4VWw==
X-Gm-Message-State: AOAM5328Q9Hqajt/NExe3YTrXzHKE/yOIvH26sXejiJ7TVEAGtvTNXK4
        Ea7psHcl0iMQkTseoGJvAMFYcmESUYn+ML2CptAe4A==
X-Google-Smtp-Source: ABdhPJyxhhnTBn9Z/d3RQByv+5O7q0RnlhAbpx4mldb52mcVpL0AUfedlXqbhjWWfR/hwCGcWa89EFLWLUtbzxojgNo=
X-Received: by 2002:adf:fcca:: with SMTP id f10mr2671322wrs.325.1594698609842;
 Mon, 13 Jul 2020 20:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200627161957.134376-1-anup.patel@wdc.com> <mhng-4d70be69-ef20-4d38-bda4-ec4101530c0a@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-4d70be69-ef20-4d38-bda4-ec4101530c0a@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 14 Jul 2020 09:19:57 +0530
Message-ID: <CAAhSdy3mHhaKTrhRnNd_gGv7GbmjqxkB28sOw4q7ZTxw4oRd1Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Dedicated CLINT timer driver
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 4:32 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Sat, 27 Jun 2020 09:19:52 PDT (-0700), Anup Patel wrote:
> > The current RISC-V timer driver is convoluted and implements two
> > distinct timers:
> >  1. S-mode timer: This is for Linux RISC-V S-mode with MMU. The
> >     clocksource is implemented using TIME CSR and clockevent device
> >     is implemented using SBI Timer calls.
> >  2. M-mode timer: This is for Linux RISC-V M-mode without MMU. The
> >     clocksource is implemented using CLINT MMIO time register and
> >     clockevent device is implemented using CLINT MMIO timecmp registers.
> >
> > This patchset removes clint related code from RISC-V timer driver and
> > arch/riscv directory. Instead, the series adds a dedicated MMIO based
> > CLINT driver under drivers/clocksource directory which can be used by
> > Linux RISC-V M-mode (i.e NoMMU Linux RISC-V).
> >
> > The patchset is based up Linux-5.8-rc2 and can be found at riscv_clint_v2
> > branch of: https://github.com/avpatel/linux.git
> >
> > This series is tested on:
> >  1. QEMU RV64 virt machine using Linux RISC-V S-mode
> >  2. QEMU RV32 virt machine using Linux RISC-V S-mode
> >  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
> >
> > Changes since v1:
> >  - Rebased series on Linux-5.8-rc2
> >  - Added pr_warn() for case where ipi_ops not available in PATCH1
> >  - Updated ipi_inject() prototype to use "struct cpumask *" in PATCH1
> >  - Updated CLINT_TIMER kconfig option to depend on RISCV_M_MODE in PATCH4
> >  - Added riscv,clint0 compatible string in DT bindings document
> >
> > Anup Patel (5):
> >   RISC-V: Add mechanism to provide custom IPI operations
> >   RISC-V: Remove CLINT related code
> >   clocksource/drivers/timer-riscv: Remove MMIO related stuff
> >   clocksource/drivers: Add CLINT timer driver
> >   dt-bindings: timer: Add CLINT bindings
>
> This all generally LGTM, though I haven't been through the code line-by-line
> yet.  It touches a bunch of trees, so I'd prefer to have some Acks before
> merging -- I'll dig through the RISC-V specific stuff, but the new CLINT driver
> probhably deserves a look from one of the clocksource folks.
>
> I think the only issue is that the port will be broken between patch 2 and 4,
> as at that point we won't have an M-mode timer driver.  I think it shouldn't be
> too much to just reorder these, LMK if you want to do it or you want me to.

Okay, I will try your suggestion to reorder patches. There is another minor
build issue reported by test bots which I will fix as well.

I will send v3 in a couple of days before end-of-week.

Regards,
Anup

>
> Thanks!
>
> >
> >  .../bindings/timer/sifive,clint.txt           |  34 +++
> >  arch/riscv/Kconfig                            |   2 +-
> >  arch/riscv/include/asm/clint.h                |  39 ---
> >  arch/riscv/include/asm/smp.h                  |  11 +
> >  arch/riscv/include/asm/timex.h                |  28 +--
> >  arch/riscv/kernel/Makefile                    |   2 +-
> >  arch/riscv/kernel/clint.c                     |  44 ----
> >  arch/riscv/kernel/sbi.c                       |  14 ++
> >  arch/riscv/kernel/setup.c                     |   2 -
> >  arch/riscv/kernel/smp.c                       |  44 ++--
> >  arch/riscv/kernel/smpboot.c                   |   4 +-
> >  drivers/clocksource/Kconfig                   |  12 +-
> >  drivers/clocksource/Makefile                  |   1 +
> >  drivers/clocksource/timer-clint.c             | 229 ++++++++++++++++++
> >  drivers/clocksource/timer-riscv.c             |  17 +-
> >  include/linux/cpuhotplug.h                    |   1 +
> >  16 files changed, 337 insertions(+), 147 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt
> >  delete mode 100644 arch/riscv/include/asm/clint.h
> >  delete mode 100644 arch/riscv/kernel/clint.c
> >  create mode 100644 drivers/clocksource/timer-clint.c
