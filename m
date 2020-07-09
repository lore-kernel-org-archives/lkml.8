Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794A9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A5A20775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 20:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="bpm55zll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgGIUIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgGIUIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 16:08:11 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7380CC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 13:08:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j19so1430596pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 13:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=pLBedoQfpK2DgMyeYFLuVKUfBSYZwpag97/6iT786IQ=;
        b=bpm55zllAw8nlwKFmlpsqohQxm+EGW1RynZKF6buhnF4wFWwIploavQVBhMNxTThgZ
         pPIXgo28wYGMXRTU+PACEPxc+h26RmY8IWB+OHozzHXYyhBiF1S7hDaudJ04X41mqHli
         liIixSh/td8GVnVZNWIXKRxB5ag9lLKr2aWWAZsW+qbiQKT+s+lxPq1boL27HeCEjFzh
         vVvOZodoVauBt2UCj1TCW2+4bqGEDwtbNv7Gy/okhNRVvEe4prOUZm8sKf274iuMS/+Y
         fs0GYwPVAMwzla5KWSAK5Q2E45oh8HWiJpEpt5FffbTzC4otOb2Qu4h1ixxJZMG3Zh1w
         dL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=pLBedoQfpK2DgMyeYFLuVKUfBSYZwpag97/6iT786IQ=;
        b=UtnHYCKCqzr/7T++tBR0KVvRQIuHry6Ej1Q/Zbno9ZRve1GH0gZ/K0650E3V32f+JL
         fTmZ9riXu4CgDOdiwU95EeVkDnfQsH5jM0OoSDJ/KucgFfWwpyV6KrUfYYdQBZGgecSi
         214lLwaR85jqp+OYxCnStRAjqAj9cXAwpN3ajbmVVjWZM7JfPPPz9fTIjixxmEuK5I2U
         Jbu48hJvjvyT0G4r3STgyd2f2FjEHzsAODvI1lp0ztq0DvtnAOATW9hSyhwOB0beitiZ
         IzV3O1YtAzBfi2ct7GfymAIi5Nfmow9rIU13f280sk6KAEmjiBzgh5enOhV57eUSleWt
         ddlg==
X-Gm-Message-State: AOAM531iO5p/2Yt5gJgtuDClqSiqXCOifOr1Ru1joDTH7MoQ2kBlgjy+
        oNPGPWokyWd385DLT85qlqXisVnkHTcsHw==
X-Google-Smtp-Source: ABdhPJwH2yZXuMK1v2nxYBAcKR39mYEbzR2YVH8DdjjrdNSd3OZRm+a651q/IpIL/WcPFQJKnzhu0Q==
X-Received: by 2002:a05:6a00:2bb:: with SMTP id q27mr58904437pfs.176.1594325290692;
        Thu, 09 Jul 2020 13:08:10 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id b18sm3467144pju.10.2020.07.09.13.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 13:08:10 -0700 (PDT)
Date:   Thu, 09 Jul 2020 13:08:10 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Jul 2020 12:31:05 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: Support CONFIG_STRICT_DEVMEM
In-Reply-To: <7faa60aa4a606b5c5c1ae374d82a7eee6c764b38.1592292685.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-d4637494-2072-41f6-9a8a-1b222d89d6c4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 00:45:47 PDT (-0700), zong.li@sifive.com wrote:
> Implement the 'devmem_is_allowed()' interface for RISC-V, like some of
> other architectures have done. It will be called from range_is_allowed()
> when userpsace attempts to access /dev/mem.

In fact, it's exactly the same (down to a few words of the comment) to the
others that I checked.  I'm going to put a generic version in lib/ instead,
I've sent out the patches.

> Access to exclusive IOMEM and kernel RAM is denied unless
> CONFIG_STRICT_DEVMEM is set to 'n'.
>
> Test it by devmem, the result as follows:
>
>  - CONFIG_STRICT_DEVMEM=y
> 	$ devmem 0x10010000
> 	0x00000000
> 	$ devmem 0x80200000
> 	0x0000106F
>
>  - CONFIG_STRICT_DEVMEM is not set
> 	$ devmem 0x10010000
> 	devmem: mmap: Operation not permitted
> 	$ devmem 0x80200000
> 	devmem: mmap: Operation not permitted
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig          |  1 +
>  arch/riscv/include/asm/io.h |  2 ++
>  arch/riscv/mm/init.c        | 19 +++++++++++++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 128192e14ff2..ffd7841ede4c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -16,6 +16,7 @@ config RISCV
>  	select ARCH_HAS_BINFMT_FLAT
>  	select ARCH_HAS_DEBUG_VIRTUAL if MMU
>  	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
>  	select ARCH_HAS_MMIOWB
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 3835c3295dc5..04ac65ab93ce 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -147,4 +147,6 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
>
>  #include <asm-generic/io.h>
>
> +extern int devmem_is_allowed(unsigned long pfn);
> +
>  #endif /* _ASM_RISCV_IO_H */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index bbe816e03b2f..5e7e61519acc 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -517,6 +517,25 @@ void mark_rodata_ro(void)
>  }
>  #endif
>
> +#ifdef CONFIG_STRICT_DEVMEM
> +#include <linux/ioport.h>
> +/*
> + * devmem_is_allowed() checks to see if /dev/mem access to a certain address
> + * is valid. The argument is a physical page number.
> + *
> + * Disallow access to system RAM as well as device-exclusive MMIO regions.
> + * This effectively disable read()/write() on /dev/mem.
> + */
> +int devmem_is_allowed(unsigned long pfn)
> +{
> +	if (iomem_is_exclusive(pfn << PAGE_SHIFT))
> +		return 0;
> +	if (!page_is_ram(pfn))
> +		return 1;
> +	return 0;
> +}
> +#endif
> +
>  void __init resource_init(void)
>  {
>  	struct memblock_region *region;
