Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A335CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B68A20661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 19:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EKGknQz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgA2TX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 14:23:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41636 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgA2TX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:23:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so829432wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 11:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=5dpkdxJKo0D3Co0IYX0+FJAqVgwjrCjxGckzFnAFk30=;
        b=EKGknQz/CJF9qnizztY4apE1qf9rCi/BQDgUenjew4SIgrWKi7BReyO8h+UGAdhrYw
         +Om6yZO4ovjeY9v67bWESViU+IsvZ8HyaEaE8cVc+0BIMVUAo6pRQ55FStSyd/BYDqlU
         bUiC48/ZBmkbs0+KJiByUylNXnmiD6il31j5JkS0xOP0E68ZexmQ1DU1dQ3ge5fmfnTs
         FfqUMgb/Wl2QkE7kw+/tzmAk3en+eyjpfzbkAnhQVStl8SCKgcHwtN41oP/eL63zwKXW
         3IW5aRzfYkSSU5o5k2PlTeY8fsX1S1uYyffVSKAzLcWGB+NEbRmVrKXsd+aG2W0Fd2GN
         ti3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=5dpkdxJKo0D3Co0IYX0+FJAqVgwjrCjxGckzFnAFk30=;
        b=CL9uaJO/EcDk3B/GhwBFZ8xPiCjPO/9dWZNAzbAA2LNX1d2sU+jpD6Yh1TXpDLj1+z
         Whn13musbH8MUcsJl06ijqpetCX3BXF5YRiV9Hpbz+XqkAhyGBYNNKxGSHpjGxioUNrU
         58EjOCn57CTB7pH4mYl2HZl8y+MbninHEk2XNUjAJ0GJu62SdbeZ6QojDyJ5P+kbXcpR
         13VToIh+e52ysAXXVS5mbKJVm3swGLwzwlTUQF3GAfIWYSIWb+a7yHrL+E27KRXTRnLh
         IX3fBqys/I+ogKuEfy7RCqjv0mosIVgfzd/OdEIfQmxxZIAE6w8Mkp1GGGM8FuUz1k/0
         UnRg==
X-Gm-Message-State: APjAAAWYx2Vx2+YcDXTXubD5+obUieMFuO5z5nlrIGbWhDVSuSr8iUg5
        w40hQSp59Ty+xflH4JYZ4Kt3ZQ==
X-Google-Smtp-Source: APXvYqyPxZfY79rDY0CdM/7Pe4WDEsuLtRhNBJTLA0YXCmXAaPAu1HUWfiq3TvDqQkUxmZLK6AejwQ==
X-Received: by 2002:adf:e78a:: with SMTP id n10mr400841wrm.62.1580325806962;
        Wed, 29 Jan 2020 11:23:26 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
        by smtp.gmail.com with ESMTPSA id r6sm970807wrp.95.2020.01.29.11.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 11:23:26 -0800 (PST)
Date:   Wed, 29 Jan 2020 11:23:26 -0800 (PST)
X-Google-Original-Date: Wed, 29 Jan 2020 19:23:14 GMT (+0000)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] riscv: set pmp configuration if kernel is running in M-mode
CC:     green.hu@gmail.com, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime.hu@sifive.com
To:     greentime.hu@sifive.com
In-Reply-To: <20200109031740.29717-1-greentime.hu@sifive.com>
References: <20200109031740.29717-1-greentime.hu@sifive.com>
Message-ID: <mhng-f4b42a19-22f3-43f3-9750-58b994e23246@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jan 2020 03:17:40 GMT (+0000), greentime.hu@sifive.com wrote:
> When the kernel is running in S-mode, the expectation is that the
> bootloader or SBI layer will configure the PMP to allow the kernel to
> access physical memory.  But, when the kernel is running in M-mode and is
> started with the ELF "loader", there's probably no bootloader or SBI layer
> involved to configure the PMP.  Thus, we need to configure the PMP
> ourselves to enable the kernel to access all regions.
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/include/asm/csr.h | 12 ++++++++++++
>  arch/riscv/kernel/head.S     |  6 ++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 0a62d2d68455..0f25e6c4e45c 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -72,6 +72,16 @@
>  #define EXC_LOAD_PAGE_FAULT	13
>  #define EXC_STORE_PAGE_FAULT	15
>
> +/* PMP configuration */
> +#define PMP_R			0x01
> +#define PMP_W			0x02
> +#define PMP_X			0x04
> +#define PMP_A			0x18
> +#define PMP_A_TOR		0x08
> +#define PMP_A_NA4		0x10
> +#define PMP_A_NAPOT		0x18
> +#define PMP_L			0x80
> +
>  /* symbolic CSR names: */
>  #define CSR_CYCLE		0xc00
>  #define CSR_TIME		0xc01
> @@ -100,6 +110,8 @@
>  #define CSR_MCAUSE		0x342
>  #define CSR_MTVAL		0x343
>  #define CSR_MIP			0x344
> +#define CSR_PMPCFG0		0x3a0
> +#define CSR_PMPADDR0		0x3b0
>  #define CSR_MHARTID		0xf14
>
>  #ifdef CONFIG_RISCV_M_MODE
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 5c8b24bf4e4e..f8f996916c5b 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -60,6 +60,12 @@ _start_kernel:
>  	/* Reset all registers except ra, a0, a1 */
>  	call reset_regs
>
> +	/* Setup a PMP to permit access to all of memory. */
> +	li a0, -1
> +	csrw CSR_PMPADDR0, a0
> +	li a0, (PMP_A_NAPOT | PMP_R | PMP_W | PMP_X)
> +	csrw CSR_PMPCFG0, a0

These should be guarded by some sort of #ifdef CONFIG_M_MODE, as they're not
part of S mode.

> +
>  	/*
>  	 * The hartid in a0 is expected later on, and we have no firmware
>  	 * to hand it to us.
