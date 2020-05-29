Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3A8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 844BD20888
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 01:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="U2si59Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390679AbgE2BhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 21:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2BhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:37:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248C8C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:37:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id z15so2608778pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 18:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=54DCvOoLnizb5obZMAZVVx9Mv/OX4h8r+9BZvz/kgMQ=;
        b=U2si59PcIwQdRP0198eEg3UKKcFQdWu8G73ty3feD5zJQpYCYj5PLyrOUg0YGSDynP
         P8AsxWwvi5pS1/nJJtZ0mqi7TWudIvpOoyQnIRoPvx5KddTY8p6bdLagjsYzylno5x8Y
         zmrLZkQ4MBXMesRFgXzD25d3j0ErwigZPva0SYRkW17R55/DEhlcLbjPGIjgfyXzMCKs
         0SkWYT3MNGHYZ4sygKUKr44YZ0dqysBAcJ4nuTAe7g75P3rQ0QUte6/AU765BBBOp2s/
         sUm3CKglPkD1sI6ldoRIut3RumVNfaq2qaDohHBkswKy0g7WG029y1e+ReK3/aoV5fHp
         TsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=54DCvOoLnizb5obZMAZVVx9Mv/OX4h8r+9BZvz/kgMQ=;
        b=G4PNasWQqAIvjky+aMb97HkqvCff5ZjQD2cd2wTePoz7Is/JTyQ3oLGdYPeUk01ZBo
         0pLjhJhMBzQt4KHcdvAOm2TWjUZY+ciWEkPQnWB5nptHdmzxLabJCRBPaltJhg7Nr86t
         kdiU2GTTSZ1d9KbHLGqgByLrvB2xyVfpKIZOIQojgUltnlh4gXRukBlexE2EbfH2cSq9
         vpr9zBotFV5G3U6z0q0NyaRXnUYlhPEAVdv7bD6Oil4nfDecy9BUPd1TTfsp1Ij2Wobm
         Bx7rMvRqBrO4eiPvcDfb6cQr3ZKZ89I/KQAN4XyEV8pEbLI5L0lYPwZjm3SDnygUqj1z
         fGnA==
X-Gm-Message-State: AOAM530D1+zA1/0wFKO9WV1V0gBLl3L7g7Z/ls1pEDr0LsPSOcYx0FZe
        XZJKg1yT9chpWVc1RUSASDLvVw==
X-Google-Smtp-Source: ABdhPJxlWIJRdZOM13t5KHV4l2LKIM6WzweKTrtfFnHnk2Innr77blSbNP+HyURHeOuLSfvcYJZMBQ==
X-Received: by 2002:a17:90a:ad86:: with SMTP id s6mr4592794pjq.193.1590716240544;
        Thu, 28 May 2020 18:37:20 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w73sm5969863pfd.113.2020.05.28.18.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 18:37:19 -0700 (PDT)
Date:   Thu, 28 May 2020 18:37:19 -0700 (PDT)
X-Google-Original-Date: Thu, 28 May 2020 18:28:08 PDT (-0700)
Subject:     Re: [PATCH v5 2/6] RISC-V: Rename and move plic_find_hart_id() to arch directory
In-Reply-To: <20200521133301.816665-3-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-6df8942f-32e6-4334-82c4-1721e571ab1b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:32:57 PDT (-0700), Anup Patel wrote:
> The plic_find_hart_id() can be useful to other interrupt controller
> drivers (such as RISC-V local interrupt driver) so we rename this
> function to riscv_of_parent_hartid() and place it in arch directory
> along with riscv_of_processor_hartid().
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  arch/riscv/include/asm/processor.h |  1 +
>  arch/riscv/kernel/cpu.c            | 16 ++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c  | 16 +---------------
>  3 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 3ddb798264f1..b1efd840003c 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -75,6 +75,7 @@ static inline void wait_for_interrupt(void)
>
>  struct device_node;
>  int riscv_of_processor_hartid(struct device_node *node);
> +int riscv_of_parent_hartid(struct device_node *node);
>
>  extern void riscv_fill_hwcap(void);
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 40a3c442ac5f..6d59e6906fdd 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -44,6 +44,22 @@ int riscv_of_processor_hartid(struct device_node *node)
>  	return hart;
>  }
>
> +/*
> + * Find hart ID of the CPU DT node under which given DT node falls.
> + *
> + * To achieve this, we walk up the DT tree until we find an active
> + * RISC-V core (HART) node and extract the cpuid from it.
> + */
> +int riscv_of_parent_hartid(struct device_node *node)
> +{
> +	for (; node; node = node->parent) {
> +		if (of_device_is_compatible(node, "riscv"))
> +			return riscv_of_processor_hartid(node);
> +	}
> +
> +	return -1;
> +}
> +
>  #ifdef CONFIG_PROC_FS
>
>  static void print_isa(struct seq_file *f, const char *isa)
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index d9c53f85a68e..16d31d114c30 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -240,20 +240,6 @@ static void plic_handle_irq(struct pt_regs *regs)
>  	csr_set(CSR_IE, IE_EIE);
>  }
>
> -/*
> - * Walk up the DT tree until we find an active RISC-V core (HART) node and
> - * extract the cpuid from it.
> - */
> -static int plic_find_hart_id(struct device_node *node)
> -{
> -	for (; node; node = node->parent) {
> -		if (of_device_is_compatible(node, "riscv"))
> -			return riscv_of_processor_hartid(node);
> -	}
> -
> -	return -1;
> -}
> -
>  static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
>  {
>  	/* priority must be > threshold to trigger an interrupt */
> @@ -330,7 +316,7 @@ static int __init plic_init(struct device_node *node,
>  		if (parent.args[0] != RV_IRQ_EXT)
>  			continue;
>
> -		hartid = plic_find_hart_id(parent.np);
> +		hartid = riscv_of_parent_hartid(parent.np);
>  		if (hartid < 0) {
>  			pr_warn("failed to parse hart ID for context %d.\n", i);
>  			continue;

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
