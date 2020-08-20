Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405A7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134742076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="SAFahshs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgHTUpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgHTUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:45:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E2C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:45:00 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so1586554pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=Sfg9PlPqpzSttQj2qjkOKfxj0w4fdfsckZ9fgydryZo=;
        b=SAFahshsfFcs8fb/b075RRH+4iW0ZbwS2W/BoXJyGPIxcl19f4ddfqrwtU/Db2ynFY
         /pXW1LOJ5y37w6gu6645WCyV7d+/JPgrgI9uBuv6gui1hbvWpW5p96Q74xRclz4Pp1N6
         C69WqIlNTpWE1uF/tBwCNrbvWCL77hn+3dOgrLJUBJ+zHwKkTE1HH4iUsWKJpziRmfbf
         mEJMk2AT1MyTFfCrtyQnAo7ZzSxY+/ptUHCQiypWUpJVutulCaYvdrgtulwXWPdRy5JL
         6QzlcHSWZtNwYJgr6Ct9uMf7wTqYjG4DMmVYdFYBNrWy8Ixx8YFw0BqAV1Q9IqIlzC2A
         hfUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Sfg9PlPqpzSttQj2qjkOKfxj0w4fdfsckZ9fgydryZo=;
        b=tW6i/WrtL2UXiZIB5BB9UovT1v3hCxO03UKfEKY4KJUSYwD1G9dMW089VFk0Zm0NZf
         jGTiQPZ0SI7v2l0JRWyRTj40Y+8uu/fVf7Jio/wap9YlQlYNFJ/W/fe583gHLBUEfopK
         OuWJoWXGqHFD8qlzIOncIe5fn+Uhn37mJcJKCou+Youv9AFtiQ0yhT6i4UhtRFDCLgtZ
         5VezwNo2U8CV4RqtrtHCGM1CZ+pQBrAVsW7kAC+VzY74WDSKz0MyaBhdFW+9w4qj04Q/
         HCi2qb+C94MLHvb2l8rnz13a4Z7yxDZGwF70fiY/AfB4XshNYjooEyeyIIKyO08ghBXb
         lWjQ==
X-Gm-Message-State: AOAM5337THRfefIIo/Zz2RCOk1PdU+ANIgDYJLTdUsLLOGesq4/QVDZY
        UwJ+7gWWnUCkQg9i+mMZpmw/PQ==
X-Google-Smtp-Source: ABdhPJxmW3nmPwzJ0K3beOFI2kflSpsGyHgrI8AYCHRSMjcjaJfYYpODukCbL5GhmQ3vYyDNSxD2ww==
X-Received: by 2002:a17:90b:1287:: with SMTP id fw7mr64950pjb.218.1597956299419;
        Thu, 20 Aug 2020 13:44:59 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 8sm3015207pjx.14.2020.08.20.13.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:44:58 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:44:58 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Aug 2020 13:44:14 PDT (-0700)
Subject:     Re: [PATCH 3/3] riscv: Add cache information in AUX vector
In-Reply-To: <aa7675dda78d3d595617d8d56b7fdd7f279a884f.1593766028.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-de0c1096-4f7f-45eb-b956-2d28188576e2@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 01:57:55 PDT (-0700), zong.li@sifive.com wrote:
> There are no standard CSR registers to provide cache information, the
> way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
> AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
> could use them to get information of cache through AUX vector.
>
> The result of 'getconf -a' as follows:
> LEVEL1_ICACHE_SIZE                 32768
> LEVEL1_ICACHE_ASSOC                8
> LEVEL1_ICACHE_LINESIZE             64
> LEVEL1_DCACHE_SIZE                 32768
> LEVEL1_DCACHE_ASSOC                8
> LEVEL1_DCACHE_LINESIZE             64
> LEVEL2_CACHE_SIZE                  2097152
> LEVEL2_CACHE_ASSOC                 32
> LEVEL2_CACHE_LINESIZE              64
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/asm/cacheinfo.h   | 14 ++++++++++++
>  arch/riscv/include/asm/elf.h         | 13 +++++++++++
>  arch/riscv/include/uapi/asm/auxvec.h | 23 ++++++++++++++++++-
>  arch/riscv/kernel/cacheinfo.c        | 33 +++++++++++++++++++++++++++-
>  4 files changed, 81 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/cacheinfo.h
>
> diff --git a/arch/riscv/include/asm/cacheinfo.h b/arch/riscv/include/asm/cacheinfo.h
> new file mode 100644
> index 000000000000..ba179cd198b9
> --- /dev/null
> +++ b/arch/riscv/include/asm/cacheinfo.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 SiFive
> + */
> +
> +#ifndef _ASM_RISCV_CACHEINFO_H
> +#define _ASM_RISCV_CACHEINFO_H
> +
> +#include <linux/cacheinfo.h>
> +
> +uintptr_t get_cache_size(u32 level, enum cache_type type);
> +uintptr_t get_cache_geometry(u32 level, enum cache_type type);
> +
> +#endif /* _ASM_RISCV_CACHEINFO_H */
> diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
> index d83a4efd052b..5c725e1df58b 100644
> --- a/arch/riscv/include/asm/elf.h
> +++ b/arch/riscv/include/asm/elf.h
> @@ -11,6 +11,7 @@
>  #include <uapi/asm/elf.h>
>  #include <asm/auxvec.h>
>  #include <asm/byteorder.h>
> +#include <asm/cacheinfo.h>
>
>  /*
>   * These are used to set parameters in the core dumps.
> @@ -61,6 +62,18 @@ extern unsigned long elf_hwcap;
>  do {								\
>  	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
>  		(elf_addr_t)current->mm->context.vdso);		\
> +	NEW_AUX_ENT(AT_L1I_CACHESIZE,				\
> +		get_cache_size(1, CACHE_TYPE_INST));		\
> +	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,			\
> +		get_cache_geometry(1, CACHE_TYPE_INST));	\
> +	NEW_AUX_ENT(AT_L1D_CACHESIZE,				\
> +		get_cache_size(1, CACHE_TYPE_DATA));		\
> +	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY,			\
> +		get_cache_geometry(1, CACHE_TYPE_DATA));	\
> +	NEW_AUX_ENT(AT_L2_CACHESIZE,				\
> +		get_cache_size(2, CACHE_TYPE_UNIFIED));		\
> +	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			\
> +		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	\
>  } while (0)
>  #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
>  struct linux_binprm;
> diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
> index 22e0ae888406..32c73ba1d531 100644
> --- a/arch/riscv/include/uapi/asm/auxvec.h
> +++ b/arch/riscv/include/uapi/asm/auxvec.h
> @@ -10,7 +10,28 @@
>  /* vDSO location */
>  #define AT_SYSINFO_EHDR 33
>
> +/*
> + * The set of entries below represent more extensive information
> + * about the caches, in the form of two entry per cache type,
> + * one entry containing the cache size in bytes, and the other
> + * containing the cache line size in bytes in the bottom 16 bits
> + * and the cache associativity in the next 16 bits.
> + *
> + * The associativity is such that if N is the 16-bit value, the
> + * cache is N way set associative. A value if 0xffff means fully
> + * associative, a value of 1 means directly mapped.
> + *
> + * For all these fields, a value of 0 means that the information
> + * is not known.
> + */
> +#define AT_L1I_CACHESIZE	40
> +#define AT_L1I_CACHEGEOMETRY	41
> +#define AT_L1D_CACHESIZE	42
> +#define AT_L1D_CACHEGEOMETRY	43
> +#define AT_L2_CACHESIZE		44
> +#define AT_L2_CACHEGEOMETRY	45
> +
>  /* entries in ARCH_DLINFO */
> -#define AT_VECTOR_SIZE_ARCH	1
> +#define AT_VECTOR_SIZE_ARCH	7
>
>  #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index cdd35e53fd98..263335def44b 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -3,10 +3,41 @@
>   * Copyright (C) 2017 SiFive
>   */
>
> -#include <linux/cacheinfo.h>
>  #include <linux/cpu.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <asm/cacheinfo.h>
> +
> +static struct cacheinfo *get_cacheinfo(u32 level, enum cache_type type)
> +{
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(smp_processor_id());
> +	struct cacheinfo *this_leaf;
> +	int index;
> +
> +	for (index = 0; index < this_cpu_ci->num_leaves; index++) {
> +		this_leaf = this_cpu_ci->info_list + index;
> +		if (this_leaf->level == level && this_leaf->type == type)
> +			return this_leaf;
> +	}
> +
> +	return 0;
> +}
> +
> +uintptr_t get_cache_size(u32 level, enum cache_type type)
> +{
> +	struct cacheinfo *this_leaf = get_cacheinfo(level, type);
> +
> +	return this_leaf ? this_leaf->size : 0;
> +}
> +
> +uintptr_t get_cache_geometry(u32 level, enum cache_type type)
> +{
> +	struct cacheinfo *this_leaf = get_cacheinfo(level, type);
> +	uintptr_t ret = (this_leaf->ways_of_associativity << 16 |
> +			 this_leaf->coherency_line_size);
> +
> +	return this_leaf ? ret : 0;
> +}
>
>  static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
>  			 unsigned int level, unsigned int size,

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
