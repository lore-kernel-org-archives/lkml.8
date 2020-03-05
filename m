Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95728C3F2CE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B06214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="Aq2qqLvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgCEA6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:58:47 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35627 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgCEA6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:58:47 -0500
Received: by mail-pg1-f196.google.com with SMTP id 7so1881078pgr.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 16:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=HhIcP1OmX7KCJe/LzPGyLrrs+To5FwKg4wadhbBvhh0=;
        b=Aq2qqLvbqlU5Kjj4F0+/BOA9infgEg+KgkHaarF5Qd364tds3v0rBe1kM6S1n+VRFQ
         KMbfEg959bSsq+g+BpJ+T5+0ObvEBeIPAd68I1k5uwjBYzsS1RX/pM6xaA4Wlf0etwy9
         z0ZF3cd9owkVC8se+XXBMIhOnUaUIEbNAptYSZMYxA+LoO4r04W9v8y8hw5xP2vV2fSd
         QB2nUS0hM9b3vsJeSeCh6VUmJcY2DSKkaubpIE1gdKZOmxvydMTwAUx5NWgbQSgfUfBs
         B39SyxjVf2MrSiaU02IvghnrbuCMuy2SW3FUPjkTeMYflYtZC8xIAFCvW3aTW2GnVUjm
         JFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=HhIcP1OmX7KCJe/LzPGyLrrs+To5FwKg4wadhbBvhh0=;
        b=EQ7A2CkcqvQ8sYUsAczIXp7BvIu7qcfId5/26uh4ppKsZGaq202OXppg8Yi3Ue2CdM
         FkxAo0ToHUcNI6qdSwJKtxuBVDBtbI1m5Nvuk0y5ZDYyI8ftlDIFrJmftQv1lnuW3Zqr
         SqQQQmDOPX8kV7fKXjJErm8FFgMSXDXAurhLRknbyqCMZtLTO4PuJLmpzxprMd/Pjyvz
         KX/PG4UXLBl2Ac6/oWwjDz5O811OftWtQUYfFqw7ouE887QyZHZm8fi/HD8CLNb1Yfi1
         tfhrALnVUKXuQQ9LUOpCz3cRYnsHqG3X0nGpEpV9UZR9qJk9OWO9hPEnI0e4P7xmGO/M
         FXRA==
X-Gm-Message-State: ANhLgQ0zFaasH7Xxz50xTbT2ZZeI9VUPywvUgM0SIj+CYPVeUImjmZB2
        HwvwiGoOvwFJdMsW8Iyzr8KZVg==
X-Google-Smtp-Source: ADFU+vvZlYvK0bH3igAzK6gimmXeABOtAKPRA5V8gdnRj1XWlcgdFrUaO6kH5XRHYEs1TUASkniV5g==
X-Received: by 2002:aa7:8687:: with SMTP id d7mr5703217pfo.164.1583369925861;
        Wed, 04 Mar 2020 16:58:45 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id e9sm3910889pjt.16.2020.03.04.16.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:58:45 -0800 (PST)
Date:   Wed, 04 Mar 2020 16:58:45 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 16:58:05 PST (-0800)
Subject:     Re: [PATCH 5/8] riscv: add alignment for text, rodata and data sections
In-Reply-To: <20200217083223.2011-6-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-fa489ba7-f1c7-459c-aae0-0dc68c826635@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:20 PST (-0800), zong.li@sifive.com wrote:
> The kernel mapping will tried to optimize its mapping by using bigger
> size. In rv64, it tries to use PMD_SIZE, and tryies to use PGDIR_SIZE in
> rv32. To ensure that the start address of these sections could fit the
> mapping entry size, make them align to the biggest alignment.
>
> Define a macro SECTION_ALIGN because the HPAGE_SIZE or PMD_SIZE, etc.,
> are invisible in linker script.
>
> This patch is prepared for STRICT_KERNEL_RWX support.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/asm/set_memory.h | 13 +++++++++++++
>  arch/riscv/kernel/vmlinux.lds.S     |  4 +++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/set_memory.h b/arch/riscv/include/asm/set_memory.h
> index a9783a878dca..a91f192063c2 100644
> --- a/arch/riscv/include/asm/set_memory.h
> +++ b/arch/riscv/include/asm/set_memory.h
> @@ -6,6 +6,7 @@
>  #ifndef _ASM_RISCV_SET_MEMORY_H
>  #define _ASM_RISCV_SET_MEMORY_H
>
> +#ifndef __ASSEMBLY__
>  /*
>   * Functions to change memory attributes.
>   */
> @@ -17,4 +18,16 @@ int set_memory_nx(unsigned long addr, int numpages);
>  int set_direct_map_invalid_noflush(struct page *page);
>  int set_direct_map_default_noflush(struct page *page);
>
> +#endif /* __ASSEMBLY__ */
> +
> +#ifdef CONFIG_ARCH_HAS_STRICT_KERNEL_RWX
> +#ifdef CONFIG_64BIT
> +#define SECTION_ALIGN (1 << 21)
> +#else
> +#define SECTION_ALIGN (1 << 22)
> +#endif
> +#else /* !CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
> +#define SECTION_ALIGN L1_CACHE_BYTES
> +#endif /* CONFIG_ARCH_HAS_STRICT_KERNEL_RWX */
> +
>  #endif /* _ASM_RISCV_SET_MEMORY_H */
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 4ba8a5397e8b..0b145b9c1778 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -37,6 +37,7 @@ SECTIONS
>  	PERCPU_SECTION(L1_CACHE_BYTES)
>  	__init_end = .;
>
> +	. = ALIGN(SECTION_ALIGN);
>  	.text : {
>  		_text = .;
>  		_stext = .;
> @@ -53,13 +54,14 @@ SECTIONS
>  	}
>
>  	/* Start of data section */
> -	RO_DATA(L1_CACHE_BYTES)
> +	RO_DATA(SECTION_ALIGN)
>  	.srodata : {
>  		*(.srodata*)
>  	}
>
>  	EXCEPTION_TABLE(0x10)
>
> +	. = ALIGN(SECTION_ALIGN);
>  	_sdata = .;
>
>  	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
