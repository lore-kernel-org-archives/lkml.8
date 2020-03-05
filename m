Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82E920848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaYxDEie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgCEKOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:14:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40523 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbgCEKOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:14:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id e26so5040964wme.5;
        Thu, 05 Mar 2020 02:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouu4WXxCaevxlmC9Uhz7tTOBhGUlnzRHTVeHp1aOhiI=;
        b=TaYxDEiehx09bbma3RrgW09W2c0LlA1BkOiJvjGkNPusdexeODgG4SuNhkwsrMwY0o
         4007WMrc/4m39OYw4UUkMcQLVpGdZn4c9jBY2o6By1cbNmG1Z9uVdbmAgVrsqfMxqqmW
         ZMkjrkmS0MwfFDQzyVrGWV3v1HB6q0WnW8LVg+iUXsC7ck7Y1I7myp0Ygg3nNArFQbSn
         v5nJAENj2gi81V077ki2FvmLt82EfVsLTSytj7KqD5d5XejoEzpIyQUFH/QofGhvwzeb
         usDNXUIu2OCq9K9SjznaVah+2+9KoN6CsvNnqeIep32vZvTKQtG2UG4e0mnYpBw9+Yxl
         2Giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouu4WXxCaevxlmC9Uhz7tTOBhGUlnzRHTVeHp1aOhiI=;
        b=JQfX8aV/8oKKKHzpSq+PTdE8RUm8tGnKkDDazAQJVnVzy4fwDvEJe0XICutsq4jB/1
         pyY1Zi8wwttU17/pxu2+pTQbTC7n+EBhu7sCIHQAt3FzFIX0YI0hA+IR0eJ9VCEIxbOy
         oQbTfF0uZSzEhbqrkQVjYbcaek3h0mpt6TR3pK7wPFwxIrOVVLYMTSjMPjVa4Tx9FeDj
         0ZaishPBzdcgZugU+wnnDrOvRsfSyK1ctPFlj0vT5HJoFdbAJ4NRqEoDXpHi0rl5dwAE
         3NMtRdqzYcPgaEcUFaSJtd8RKhcXsMX22sZC6CFJ5ZzxJnQ4Jv3GxAMOrGyJs1iqlQeE
         BCNA==
X-Gm-Message-State: ANhLgQ10fWvLKdUZsa3GiyDrUyFMgeBjatHL/v2Ds9gfpmOAPwDfeehf
        vZ/t7ZTvEKOdojG5BC3HyhedEkpkb69RD96vBz9MqZUZ
X-Google-Smtp-Source: ADFU+vtRnF/dXxex4bMtm9lMXct71zx/beWq0f7tsbHICcoY3Vly/IH9SaaT79t48a+UTI0DbFZr1itud86S+ZPQomM=
X-Received: by 2002:a05:600c:4108:: with SMTP id j8mr8669423wmi.188.1583403257961;
 Thu, 05 Mar 2020 02:14:17 -0800 (PST)
MIME-Version: 1.0
References: <20191223152349.180172-1-chenzhou10@huawei.com> <20191223152349.180172-3-chenzhou10@huawei.com>
In-Reply-To: <20191223152349.180172-3-chenzhou10@huawei.com>
From:   Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date:   Thu, 5 Mar 2020 15:43:40 +0530
Message-ID: <CAJ2QiJ+SQ1orriXJWyhKDcDL9s4Vh5+HQHhWFOKPVmijGpMGvw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] arm64: kdump: reserve crashkenel above 4G for
 crash dump kernel
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>, dyoung@redhat.com,
        Bhupesh Sharma <bhsharma@redhat.com>, xiexiuqi@huawei.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        horms@verge.net.au,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Ganapatrao Prabhakerrao Kulkarni <gkulkarni@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 8:57 PM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Crashkernel=X tries to reserve memory for the crash dump kernel under
> 4G. If crashkernel=X,low is specified simultaneously, reserve spcified
> size low memory for crash kdump kernel devices firstly and then reserve
> memory above 4G.
>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>  arch/arm64/kernel/setup.c |  8 +++++++-
>  arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 56f6645..04d1c87 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
>                     kernel_data.end <= res->end)
>                         request_resource(res, &kernel_data);
>  #ifdef CONFIG_KEXEC_CORE
> -               /* Userspace will find "Crash kernel" region in /proc/iomem. */
> +               /*
> +                * Userspace will find "Crash kernel" region in /proc/iomem.
> +                * Note: the low region is renamed as Crash kernel (low).
> +                */
> +               if (crashk_low_res.end && crashk_low_res.start >= res->start &&
> +                               crashk_low_res.end <= res->end)
> +                       request_resource(res, &crashk_low_res);
>                 if (crashk_res.end && crashk_res.start >= res->start &&
>                     crashk_res.end <= res->end)
>                         request_resource(res, &crashk_res);
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index b65dffd..0d7afd5 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -80,6 +80,7 @@ static void __init reserve_crashkernel(void)
>  {
>         unsigned long long crash_base, crash_size;
>         int ret;
> +       phys_addr_t crash_max = arm64_dma32_phys_limit;
>
>         ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
>                                 &crash_size, &crash_base);
> @@ -87,12 +88,38 @@ static void __init reserve_crashkernel(void)
>         if (ret || !crash_size)
>                 return;
>
> +       ret = reserve_crashkernel_low();
> +       if (!ret && crashk_low_res.end) {
> +               /*
> +                * If crashkernel=X,low specified, there may be two regions,
> +                * we need to make some changes as follows:
> +                *
> +                * 1. rename the low region as "Crash kernel (low)"
> +                * In order to distinct from the high region and make no effect
> +                * to the use of existing kexec-tools, rename the low region as
> +                * "Crash kernel (low)".
> +                *
> +                * 2. change the upper bound for crash memory
> +                * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
> +                *
> +                * 3. mark the low region as "nomap"
> +                * The low region is intended to be used for crash dump kernel
> +                * devices, just mark the low region as "nomap" simply.
> +                */
> +               const char *rename = "Crash kernel (low)";
> +
> +               crashk_low_res.name = rename;
> +               crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
> +               memblock_mark_nomap(crashk_low_res.start,
> +                                   resource_size(&crashk_low_res));
> +       }
> +
>         crash_size = PAGE_ALIGN(crash_size);
>
>         if (crash_base == 0) {
>                 /* Current arm64 boot protocol requires 2MB alignment */
> -               crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
> -                               crash_size, SZ_2M);
> +               crash_base = memblock_find_in_range(0, crash_max, crash_size,
> +                               SZ_2M);
>                 if (crash_base == 0) {
>                         pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
>                                 crash_size);
> --

I tested this patch series on ARM64-ThunderX2 with no issue with
bootargs crashkenel=X@Y crashkernel=250M,low

$ dmesg | grep crash
[    0.000000] crashkernel reserved: 0x0000000b81200000 -
0x0000000c81200000 (4096 MB)
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro
crashkernel=4G@0xb81200000 crashkernel=250M,low nowatchdog earlycon
[   29.310209]     crashkernel=250M,low

$  kexec -p -i /boot/vmlinuz-`uname -r`
--initrd=/boot/initrd.img-`uname -r` --reuse-cmdline
$ echo 1 > /proc/sys/kernel/sysrq ; echo c > /proc/sysrq-trigger

But when i tried with crashkernel=4G crashkernel=250M,low as bootargs.
Kernel is not able to allocate memory.
[    0.000000] cannot allocate crashkernel (size:0x100000000)
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc4+
root=UUID=866b8df3-14f4-4e11-95a1-74a90ee9b694 ro crashkernel=4G
crashkernel=250M,low nowatchdog
[   29.332081]     crashkernel=250M,low

does crashkernel=X@Y mandatory to get allocated beyond 4G?
am I missing something?

--pk
