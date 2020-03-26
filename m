Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10F8C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746E92078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="bcSpSKxP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgCZHBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:01:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38409 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:01:50 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so6385566wrv.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jofCgVIHQ01SmLvuORxlj/SeIQqWtEau+/mAl/qksKc=;
        b=bcSpSKxPVEFvA3e83gc9piZG/avwTjWX9CPl9XOB1c6n0Ldk7d4t6xtIWfmiNiR19u
         0SEPQodiQ2SEVXgFtvYF/b31l6kAm4VxQpVAKfFpsn5iTRQc9fKupgAX3gF6vUTZtug8
         tEcG1DON4PidJ8Es38iq+6RB8gD7PTI/ilJ8RN33vhSmqHY2L8f1iZg5sZXq5/M8aPCX
         uMb5yzhFe3S2/2n3btGG0V9R+iRzS0USFqBBZRXW83vOVhvm+O7xs0H8N3OQZHryJTdQ
         0AEYngAaD+hL9yN1/c1ANSsRBQaY7d+5WdkNTK3YsZXTTHqOiHB1NzUGfT6Zc5mn9UHz
         N/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jofCgVIHQ01SmLvuORxlj/SeIQqWtEau+/mAl/qksKc=;
        b=Ue6zjxR/nrA900pE1vm5F1tJmVguwKEyPt465+Pxe47lrjdIjyVhK9U4PkzNFLp1je
         zlrlkB76NO36W96RM/jjMfBqycv/ddRTOTlrCDAjHAT5H1LIOiSzXJBPHs1QiGF6qAq8
         uTg/v9a2QBB+tz6s6UgYehTeTekp2LQPYLmgZqaCDE2A+jqj3hIBf1TJaHwF+wHsnDwR
         lmFcgREEEolKZtgS+OZkK6Q2FJq6JN84j9IKLs8QrNj7Vi0FCmLqi4dXcGSeomauJVCi
         vc7Xaet9FAGPSvHI8lRAqs+JQBueKomHhaBmHyq8j6DUZpMU/xYtA7I6Wc35mxkhMaL4
         /GWg==
X-Gm-Message-State: ANhLgQ0ZUFbQs1ZB/5KUuBLMYis9Xc4ZLIGPfxvfh2dHiZIpCy424QHn
        jqpLQX2C17EyX7FeR11I+WVrGT5a0stW5ZUXoj73CA==
X-Google-Smtp-Source: ADFU+vsbROIUoA90FStIEmYD0FITWzGap+V5Xr2S+KQyHdoQESAi373eDUqAUZe8sPw3C/qJn1CIrZEetGQs1GmcRv0=
X-Received: by 2002:a5d:4acd:: with SMTP id y13mr7573260wrs.61.1585206106903;
 Thu, 26 Mar 2020 00:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200322110028.18279-1-alex@ghiti.fr> <20200322110028.18279-6-alex@ghiti.fr>
In-Reply-To: <20200322110028.18279-6-alex@ghiti.fr>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 26 Mar 2020 12:31:35 +0530
Message-ID: <CAAhSdy19xsOew+4OhNndUpjzFQtu7gX2VZn-4fczVxuJinP-OA@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] riscv: Use pgtable_l4_enabled to output mmu type
 in cpuinfo
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Christoph Hellwig <hch@lst.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 4:35 PM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Now that the mmu type is determined at runtime using SATP
> characteristic, use the global variable pgtable_l4_enabled to output
> mmu type of the processor through /proc/cpuinfo instead of relying on
> device tree infos.
>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
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

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
