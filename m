Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF287C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87ED12078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="JXV7TAi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgEYGVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730341AbgEYGVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:21:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3457C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:21:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u188so15650876wmu.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DsMyEA4KM4Gnma+cblvcga4fhkcOb1KEzJ21AGUhJvw=;
        b=JXV7TAi9280IblsCDbZgmP8mUBhpObgDtujBO6Hm2d2z4KRvy8eonFfjerVTD9nzco
         mglRG12NZltv0/OPJyhrti5E+t4z8xSQPVDa9WVPU7/8HSo7UBh/5BzRetK9GcYAl9oL
         pKhUO9ngnYmtM1ypl7wm+LUJ9Nw86HJwxzoez169eUz1VeR6OWNs0q/q+YuVNvyTw+2E
         nj3Y6jC3hvF66zL/+mln5jbtEW2iM1kr5W2tC0tkScnHYyAXoTQKUDkJMkqlegMhB6KY
         /JGuyOFNXqTiBG/eJDGRh2P6wxmFHjeulUsUo+VqsqBYpLjNKcjZGsWioh67ihSetBKJ
         d7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DsMyEA4KM4Gnma+cblvcga4fhkcOb1KEzJ21AGUhJvw=;
        b=QSOdHtxCKgZmtlTKCsziilgRGt7/Lf2kZPWsrpQsxw5I0s8o0ZWM3ymIMCRtV7Q1en
         Gr871gbasX6nMEGOR4le+kjElvhi5M8Z1tLFyENkYaWztqGlaXRA2JmPSKqxaiBJZlNL
         Ve2ckbpTFnNcuMLmDXfm0PhSS2EHQPHRfXJMUCi1HK27FecLtL+4ONKzL56L0XqgN3h5
         5sitfeOg+AMoguovDYbLl5edGrCUJaa9Og/QvGxEN5gOEO05Q/3WSbfPhjUPDgIQ4aU7
         sb4ckB+KV+pNoknmoKdXunv1JxMd4DDABj0/gV3faNRgyNNj8R4wMRHSNJDF271/Ok1H
         u6TA==
X-Gm-Message-State: AOAM530Tu28m5XpjscUq7rxsi7qZA7NTFsr22XOT3wkKVRDUYlSKzBiH
        K3XGySluTfEuY1LMwBtdV2jCDgJHgtUfFegaGCii5g==
X-Google-Smtp-Source: ABdhPJwqnMo5o9tfGYlaS8t3ylndiNxTunEV9aI2LAmup2/BjBVBeTY38LLOi4mtVvezzXmu7QZS+D2jkJzU4fekjmU=
X-Received: by 2002:a1c:7410:: with SMTP id p16mr25074647wmc.134.1590387702492;
 Sun, 24 May 2020 23:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200524091008.25587-1-alex@ghiti.fr> <20200524091008.25587-8-alex@ghiti.fr>
In-Reply-To: <20200524091008.25587-8-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 25 May 2020 11:51:31 +0530
Message-ID: <CAAhSdy3JU8ae8Gx-4iNiOKbC027-Cgjc_8=BYEp1sO3pW6D5XA@mail.gmail.com>
Subject: Re: [PATCH 7/8] riscv: Use pgtable_l4_enabled to output mmu type in cpuinfo
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 2:47 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Now that the mmu type is determined at runtime using SATP
> characteristic, use the global variable pgtable_l4_enabled to output
> mmu type of the processor through /proc/cpuinfo instead of relying on
> device tree infos.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi |  4 ----
>  arch/riscv/kernel/cpu.c                    | 24 ++++++++++++----------
>  2 files changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> index 7db861053483..6138590a2229 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -50,7 +50,6 @@
>                         i-cache-size = <32768>;
>                         i-tlb-sets = <1>;
>                         i-tlb-size = <32>;
> -                       mmu-type = "riscv,sv39";
>                         reg = <1>;
>                         riscv,isa = "rv64imafdc";
>                         tlb-split;
> @@ -74,7 +73,6 @@
>                         i-cache-size = <32768>;
>                         i-tlb-sets = <1>;
>                         i-tlb-size = <32>;
> -                       mmu-type = "riscv,sv39";
>                         reg = <2>;
>                         riscv,isa = "rv64imafdc";
>                         tlb-split;
> @@ -98,7 +96,6 @@
>                         i-cache-size = <32768>;
>                         i-tlb-sets = <1>;
>                         i-tlb-size = <32>;
> -                       mmu-type = "riscv,sv39";
>                         reg = <3>;
>                         riscv,isa = "rv64imafdc";
>                         tlb-split;
> @@ -122,7 +119,6 @@
>                         i-cache-size = <32768>;
>                         i-tlb-sets = <1>;
>                         i-tlb-size = <32>;
> -                       mmu-type = "riscv,sv39";
>                         reg = <4>;
>                         riscv,isa = "rv64imafdc";
>                         tlb-split;

Your PATCH6 is already doing the right thing by skipping CPU DT
nodes that don't have "mmu-type" DT property.

The "mmu-type" DT property is very critical for RUNTIME M-mode
firmware (OpenSBI) because it tells whether a given CPU has MMU
(or not). This is also in agreement with the current DT bindings
document for RISC-V CPUs.

I suggest to drop the change in sifive/fu540-c000.dtsi and rest of
the patch is fine so my Reviewed-by still holds.

Regards,
Anup

> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 40a3c442ac5f..38a699b997a8 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -8,6 +8,8 @@
>  #include <linux/of.h>
>  #include <asm/smp.h>
>
> +extern bool pgtable_l4_enabled;
> +
>  /*
>   * Returns the hart ID of the given device tree node, or -ENODEV if the node
>   * isn't an enabled and valid RISC-V hart node.
> @@ -54,18 +56,19 @@ static void print_isa(struct seq_file *f, const char *isa)
>         seq_puts(f, "\n");
>  }
>
> -static void print_mmu(struct seq_file *f, const char *mmu_type)
> +static void print_mmu(struct seq_file *f)
>  {
> +       char sv_type[16];
> +
>  #if defined(CONFIG_32BIT)
> -       if (strcmp(mmu_type, "riscv,sv32") != 0)
> -               return;
> +       strncpy(sv_type, "sv32", 5);
>  #elif defined(CONFIG_64BIT)
> -       if (strcmp(mmu_type, "riscv,sv39") != 0 &&
> -           strcmp(mmu_type, "riscv,sv48") != 0)
> -               return;
> +       if (pgtable_l4_enabled)
> +               strncpy(sv_type, "sv48", 5);
> +       else
> +               strncpy(sv_type, "sv39", 5);
>  #endif
> -
> -       seq_printf(f, "mmu\t\t: %s\n", mmu_type+6);
> +       seq_printf(f, "mmu\t\t: %s\n", sv_type);
>  }
>
>  static void *c_start(struct seq_file *m, loff_t *pos)
> @@ -90,14 +93,13 @@ static int c_show(struct seq_file *m, void *v)
>  {
>         unsigned long cpu_id = (unsigned long)v - 1;
>         struct device_node *node = of_get_cpu_node(cpu_id, NULL);
> -       const char *compat, *isa, *mmu;
> +       const char *compat, *isa;
>
>         seq_printf(m, "processor\t: %lu\n", cpu_id);
>         seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
>         if (!of_property_read_string(node, "riscv,isa", &isa))
>                 print_isa(m, isa);
> -       if (!of_property_read_string(node, "mmu-type", &mmu))
> -               print_mmu(m, mmu);
> +       print_mmu(m);
>         if (!of_property_read_string(node, "compatible", &compat)
>             && strcmp(compat, "riscv"))
>                 seq_printf(m, "uarch\t\t: %s\n", compat);
> --
> 2.20.1
>
