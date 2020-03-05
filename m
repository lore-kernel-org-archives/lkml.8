Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002F9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBC8C20842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="GyV8uU9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgCEA5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:57:51 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43793 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgCEA5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:57:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id u12so1864735pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 16:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=r1cjoiRs5yfI/5ZwZNPh4J3Hd5wrkW8j/pkn8QIoYoI=;
        b=GyV8uU9CINptKvdryE//p4TelPw6MzQUvY0bQByDvwZ36sulOY/unL5MnrAv9wv8jp
         dbCtNJhdZqzKmlo0IJ3Ul5yzSPYC8JXWX7j022XR/Tlu2e/kdZZe4XozYLMywRja+sF1
         /3S2SXr8G95/JN7RR0FkKRCfuymTF+nfmrPoYGO5rY+iPCmyiJ0rUGBe9I/CHqjqFV5z
         xDi4kO9e4crpRXoqNb+7p82JDdnwLS1k7ei3KxeLySG8zxUiIF/Smw5JVRePLbGi5L8s
         dLQmYA6DTO7lmSou9AkGpr5T2HqzJ6Sm+hg2fPXh5wXMTasN9sIlzXFIGFL1uSzJPQcZ
         6f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=r1cjoiRs5yfI/5ZwZNPh4J3Hd5wrkW8j/pkn8QIoYoI=;
        b=VcXKKdLXBBLvV553+uELuUNwlZe5H9KuO5y8JV537kD9DHztR2NAjau048nNSbTtJz
         TdzU9E5A0Z9zasUMZphgFPjrjKJl2d5qEcoTh5CaxYx00DUlBCRzuIGgwej1bh01eGjy
         q1ESgVNaaI3f/tNsqAG+zS6R6IhcjW46LD+RBPjHr+EdgXOtakJzhpOBV3hHl21RG+jJ
         /gRJNVMBKmQdgifQw0urF2crBiQ11Lzl/vR2ZxXp5mHmg5zldm2Z0/A0qO1GvioEreTB
         1hlk7UmmqU2u7eRREMGN/a+6pw8mJSofr0RV5JNmMgygEBLWRQHp+QzENBNbHAZ7dpfS
         32ZQ==
X-Gm-Message-State: ANhLgQ3G0WFtsv+Q5FJFU34qnJJ3cGyD0SWm/g8hJfDmBTaBBCIEf1Bq
        Ra7VhH2G7EhDl/CKGI4vEbLOJA==
X-Google-Smtp-Source: ADFU+vsMu+SCwaGiTvNt7q5D3Z8AxBmHq9uvSeqYl34akVxe8tr0UJLcPLA5uAY0m8LsDJcoJulbmA==
X-Received: by 2002:a62:a206:: with SMTP id m6mr5912639pff.254.1583369868705;
        Wed, 04 Mar 2020 16:57:48 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id w17sm24466490pfg.33.2020.03.04.16.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:57:48 -0800 (PST)
Date:   Wed, 04 Mar 2020 16:57:48 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 16:56:49 PST (-0800)
Subject:     Re: [PATCH 4/8] riscv: move exception table immediately after RO_DATA
In-Reply-To: <20200217083223.2011-5-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-6a94c49b-419b-4b5a-a11d-dda1fb0aa896@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:19 PST (-0800), zong.li@sifive.com wrote:
> Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
> attribution of the sections which should be read-only at a time.
> Move .sdata to indicate the start of data section with write permission.
> This patch is prepared for STRICT_KERNEL_RWX support.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 1e0193ded420..4ba8a5397e8b 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -9,6 +9,7 @@
>  #include <asm/page.h>
>  #include <asm/cache.h>
>  #include <asm/thread_info.h>
> +#include <asm/set_memory.h>
>
>  OUTPUT_ARCH(riscv)
>  ENTRY(_start)
> @@ -52,12 +53,15 @@ SECTIONS
>  	}
>
>  	/* Start of data section */
> -	_sdata = .;
>  	RO_DATA(L1_CACHE_BYTES)
>  	.srodata : {
>  		*(.srodata*)
>  	}
>
> +	EXCEPTION_TABLE(0x10)
> +
> +	_sdata = .;
> +
>  	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
>  	.sdata : {
>  		__global_pointer$ = . + 0x800;
> @@ -69,8 +73,6 @@ SECTIONS
>
>  	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
>
> -	EXCEPTION_TABLE(0x10)
> -
>  	.rel.dyn : {
>  		*(.rel.dyn*)
>  	}

As far as I can tell this is OK: core_kernel_data() explicitly says that RODATA
may or may not be between _sdata and _edata.  That said, I think we should add
__start_rodata and __end_rodata atomicly with this change (around RO_DATA and
.srodata).
