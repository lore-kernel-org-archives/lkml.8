Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2298C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B105220828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 01:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="W6GcWPFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgCEBoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 20:44:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38868 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEBoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 20:44:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id p7so1903659pli.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 17:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZCBiwhfYbwT07+gQh2hkOJW3ijGWSXtedJjMGZE1sv0=;
        b=W6GcWPFa3XmpBhYJ4vPpzGy7P33m7xfiyOVd5u7Ycgp0LJuJ94lRGU0UHiEBjgDECN
         ma/I/kPzsNvDCvvHrUVQGcq3drXIjQtPiyu4vQDPqyPeQ/c016GURwumfilhW4BHzqNs
         nfFr4dEPpi/If9AIhqYUEhZPXag9kuIsqQ0XZEghBR8yzq/zjfa4WTajApNwswX3IyWb
         PZ2XTkdZEij6LVTcPnceFQ6yMLzcS2mtEZ9aV14MuDrqqpkeHD0JMpULH7wqSv07pPNp
         0QSKJ4LCQxz14jsP8eBLqQFI2zOPsyk2AkEO43SzBj42WHWPtT4HIjxMzfv1FSnv/frx
         MD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZCBiwhfYbwT07+gQh2hkOJW3ijGWSXtedJjMGZE1sv0=;
        b=llGZ7N/WyT4rlEZclNqM4p482m5vZKHcKD2qy0NOd1CCYHqDLDPaeuZmOV9or2CV8V
         NWt6dEKbdoi46IP4p5QJ6J2JKx3QDBvxy823p6g2HsqFeksAmKfSMeh+EeCQok2AUpNv
         XyYKNNgH0/6v0shuEwVQz7SW2Hqi2TklCi7mZOyG4aWLC6WqLMbTZQyWx8zYC836GWxV
         aLx3UsjZHHdIIvMtoM83b8aRafQFDzSSLnWjJWSNU+kyQ9CA8wyv1JThqApOPQOBXzwt
         jkgneOhif5OVJI1IjywaXWMvoS3D0WxSbHgiWoe0nDzmTsCUaLLO/E4EB4foXcRF4EvV
         hlOg==
X-Gm-Message-State: ANhLgQ1PcGqdbpmDGUvtRJqc5204ZjYikzYqeREPjhuXinQ98DpLAGvB
        +RHJcUSiIF2TGLuyrFckQBVQVw==
X-Google-Smtp-Source: ADFU+vsVwGRRZL8/xPvoIQeX4Id9BJUz0oqqBnXiv+gDJ9DFU1ODsprhp1aKqUKF/XgbgIXjfjG1Lw==
X-Received: by 2002:a17:90a:bb86:: with SMTP id v6mr5895779pjr.168.1583372658911;
        Wed, 04 Mar 2020 17:44:18 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id e30sm29879473pga.6.2020.03.04.17.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 17:44:18 -0800 (PST)
Date:   Wed, 04 Mar 2020 17:44:18 -0800 (PST)
X-Google-Original-Date: Wed, 04 Mar 2020 17:27:07 PST (-0800)
Subject:     Re: [PATCH 7/8] riscv: add DEBUG_WX support
In-Reply-To: <20200217083223.2011-8-zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-0d866567-f710-4d27-8ae9-1f78454d7d85@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 00:32:22 PST (-0800), zong.li@sifive.com wrote:
> Support DEBUG_WX to check whether there are mapping with write and
> execute permission at the same time.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig.debug        | 30 ++++++++++++++++++++++++++++++
>  arch/riscv/include/asm/ptdump.h |  6 ++++++
>  arch/riscv/mm/init.c            |  2 ++
>  3 files changed, 38 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
> index e69de29bb2d1..2bcd88e75626 100644
> --- a/arch/riscv/Kconfig.debug
> +++ b/arch/riscv/Kconfig.debug
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +config DEBUG_WX
> +	bool "Warn on W+X mappings at boot"
> +	select PTDUMP_CORE
> +	help
> +	  Generate a warning if any W+X mappings are found at boot.
> +
> +	  This is useful for discovering cases where the kernel is leaving
> +	  W+X mappings after applying NX, as such mappings are a security risk.
> +	  This check also includes UXN, which should be set on all kernel
> +	  mappings.
> +
> +	  Look for a message in dmesg output like this:
> +
> +	    riscv/mm: Checked W+X mappings: passed, no W+X pages found.
> +
> +	  or like this, if the check failed:
> +
> +	    riscv/mm: Checked W+X mappings: FAILED, <N> W+X pages found.
> +
> +	  Note that even if the check fails, your kernel is possibly
> +	  still fine, as W+X mappings are not a security hole in
> +	  themselves, what they do is that they make the exploitation
> +	  of other unfixed kernel bugs easier.
> +
> +	  There is no runtime or memory usage effect of this option
> +	  once the kernel has booted up - it's a one time check.
> +
> +	  If in doubt, say "Y".

It looks like this comes verbatim from the arm64 port, at least.  I think we
should just refactor this to some sort of ARCH_HAS_DEBUG_WX so we can share the
code.  I usually do this by adding the shared support, using it for RISC-V, and
then converting the other ports over.

> diff --git a/arch/riscv/include/asm/ptdump.h b/arch/riscv/include/asm/ptdump.h
> index e29af7191909..eb2a1cc5f22c 100644
> --- a/arch/riscv/include/asm/ptdump.h
> +++ b/arch/riscv/include/asm/ptdump.h
> @@ -8,4 +8,10 @@
>
>  void ptdump_check_wx(void);
>
> +#ifdef CONFIG_DEBUG_WX
> +#define debug_checkwx() ptdump_check_wx()
> +#else
> +#define debug_checkwx() do { } while (0)
> +#endif
> +
>  #endif /* _ASM_RISCV_PTDUMP_H */
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 09fa643e079c..a05d76e5fefe 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -509,6 +509,8 @@ void mark_rodata_ro(void)
>  	set_memory_ro(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>  	set_memory_nx(rodata_start, (data_start - rodata_start) >> PAGE_SHIFT);
>  	set_memory_nx(data_start, (max_low - data_start) >> PAGE_SHIFT);
> +
> +	debug_checkwx();
>  }
>  #endif
