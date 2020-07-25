Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416E8C433F8
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16E282074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="ktmEEWGp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGYFMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgGYFMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:12:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D66C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:12:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a23so6355526pfk.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 22:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PcyXn/F49Fqhz4TOynaWt+U5OFlKuzg22AoeOH0QnA0=;
        b=ktmEEWGpMHiP+vgSZ4fYLmAS+aXx6GO1YWFpZX15mUTDxKR3uOTnlQKCjHxyM3wOfM
         Hx+FneH6aBrYNZjL5ZNRYudAWvoyKMzRKK4CZG2UESygEPoEEVHdVeKyet0fOI2povme
         WYZDkntiKH+LoMKj37839Qj08Eyy2si3v9E6G6VhEQOUpriwsUEKxz/9IpSIRPQUEo8X
         s0G0YrBpRxjb7y0HRa5hO/cEku7U3ssAYSzqoqb7sISfkIGBjl8Eja/zugaQI0f/S/SI
         rX5jqD65eKosX/9hJY1Miep0uQ4yTsdMox7T4XAzeooWv8/3YJUM1ru9/haBBdSiSl1I
         h+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PcyXn/F49Fqhz4TOynaWt+U5OFlKuzg22AoeOH0QnA0=;
        b=jRprdOYwH5QAXdg63kJda83CpivCZHOJ936BLnxQzCgo4minbdPRCO7sLwzFGSFD3V
         BVRMmsp/wB0WPh5JBnMx1aOPX/KL1GZ018SoYybfzSEuALDzswp8In0kTIW+NcR07cUe
         Yu8yb5KjwSD+zmP6OpEVxbYSGhOd8SvQ/NunSRQQ9Ww7/9bk6ue3S31i8tUtBBsIkAAf
         28QmUN1EOnDhsSGkTVGgHtYNJVAyLPWbITkR7wwKdQFR9QDXERIO9MdyD5HELtb4uPkD
         f7jyIAz+oQu5xVl6HpoRimO1JymXVzPV3DjLjdk/o4prPs2omAsFgE0S4Fmqax635pi4
         cGDA==
X-Gm-Message-State: AOAM533Znsq4jMiDELLR5FblUEkU/EQwT349cnVwXIMPcQ+on/IWn6IH
        3qyE+87wZrP8lFSScvPp4yJPlCu4krs=
X-Google-Smtp-Source: ABdhPJxkaiVy/YeIQXdACLL0DGaA+9WA17ylQocN96rHcnrOuZmk8/7frgv7Swmg5udIZJ/k/gRq0A==
X-Received: by 2002:a62:3684:: with SMTP id d126mr509500pfa.234.1595653959099;
        Fri, 24 Jul 2020 22:12:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b22sm7107670pju.26.2020.07.24.22.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 22:12:38 -0700 (PDT)
Date:   Fri, 24 Jul 2020 22:12:38 -0700 (PDT)
X-Google-Original-Date: Fri, 24 Jul 2020 18:49:48 PDT (-0700)
Subject:     Re: [PATCH 1/4] RISC-V: Setup exception vector early
In-Reply-To: <20200715233009.27183-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, sudeep.holla@arm.com,
        vincent.chen@sifive.com, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-8ce8d920-4b65-432c-8b51-8d81f55936c0@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 16:30:06 PDT (-0700), Atish Patra wrote:
> The trap vector is set only in trap_init which may be too late in some
> cases. Early ioremap/efi spits many warning messages which may be useful.
>
> Setup the trap vector early so that any warning/bug can be handled before
> generic code invokes trap_init.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/head.S    | 10 ++++++++--
>  arch/riscv/kernel/smpboot.c |  1 -
>  arch/riscv/kernel/traps.c   |  8 +-------
>  3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 7ed1b22950fd..d0c5c316e9bb 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -77,10 +77,16 @@ relocate:
>  	csrw CSR_SATP, a0
>  .align 2
>  1:
> -	/* Set trap vector to spin forever to help debug */
> -	la a0, .Lsecondary_park
> +	/* Set trap vector to exception handler */
> +	la a0, handle_exception
>  	csrw CSR_TVEC, a0
>
> +	/*
> +	 * Set sup0 scratch register to 0, indicating to exception vector that
> +	 * we are presently executing in kernel.
> +	 */
> +	csrw CSR_SCRATCH, zero
> +
>  	/* Reload the global pointer */
>  .option push
>  .option norelax
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 4e9922790f6e..5a9c127a380e 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -154,7 +154,6 @@ asmlinkage __visible void smp_callin(void)
>  	mmgrab(mm);
>  	current->active_mm = mm;
>
> -	trap_init();
>  	notify_cpu_starting(smp_processor_id());
>  	update_siblings_masks(smp_processor_id());
>  	set_cpu_online(smp_processor_id(), 1);
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 7d95cce5e47c..ad14f4466d92 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -174,13 +174,7 @@ int is_valid_bugaddr(unsigned long pc)
>  }
>  #endif /* CONFIG_GENERIC_BUG */
>
> +/* stvec & scratch is already set from head.S */
>  void trap_init(void)
>  {
> -	/*
> -	 * Set sup0 scratch register to 0, indicating to exception vector
> -	 * that we are presently executing in the kernel
> -	 */
> -	csr_write(CSR_SCRATCH, 0);
> -	/* Set the exception vector address */
> -	csr_write(CSR_TVEC, &handle_exception);
>  }

While I think these are all actual fixes, it's pretty late in the cycle here so
I'm going to a bit on the careful side and only take the patches that actually
manifest as bugs in the current port.  Assuming this doesn't manifest until
early_ioremap is enabled (and we don't do that yet), I've put it on for-next.

LMK if I'm wrong about this, or the following ones.

Thanks!
