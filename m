Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F25EC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2850A21D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="gt2ptyzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgIIE7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgIIE71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:59:27 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0EAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:59:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w186so1177918pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=lzl1nSqPEjvQ3P6IDrY13pelwMPXHe0DcJfFr0dx4o0=;
        b=gt2ptyzv2ItTIpWBA0/oN6tSIk6OUk6cOoPmRPr9hsur5LdyWRyP//DDdOadHbY0H7
         d6irVWl5BOTFP2ut9oPfBSu7s92umv3jMLa202XMQmXXvWs372sFv+f+BOkZ8WjzVnRt
         jBwS5f27WcP+lbjcRcQlcSpkHTq1R03zDC3GULMg60XPVJEFO9BGBZCgEbvqzOOZyVQY
         GnXDdsHLh04gF598ciKuZ1gtpe7cTbDE3iKO+oNitxCN4Z2FmtyvzhIwLe9jRTLWn3Y0
         4CT5Juyn9k8i0V3dgQVrUIAd9XmzpWRTCS3mqzssOn0xYbBvXVLN7avQcGb2t8R/xa7q
         u0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=lzl1nSqPEjvQ3P6IDrY13pelwMPXHe0DcJfFr0dx4o0=;
        b=gQImh9v+hsqioAEZb+HFVIAuw3YcPEiZY4zuuE8ehRi+ZHj1KuFVH0t+CwuWVwpCF/
         5fltkcQR3BPVvmoSFgteqhUSNEbKi7qZP0FgjzcwTcU+UE5wmIgBUypRbm1KiP14jXxO
         JpjAdjNUaPMrqK3Sce01y0GI+8R085nHTY/xajiVpKNQLD2V7as9oqdGOTK3GLnk5TJe
         L4MOxArrjoMzOYQuhzOCpMdKI3rNxdYE9aR1BJA940RgCCmbnomlCwu/6fNtNnuwa7zQ
         lout60YhoTHCHEdnioz53AfcF5HM3blIOyHpkMJ1Hi1igWUF+BesUGux3dl93/QAm9Nh
         LKmw==
X-Gm-Message-State: AOAM532GgCEK0kcXvi2pxxIZVjYKpcL0yCB2sYLjGu8ZO9q3Z5Z4PgzI
        5crO1u4YRY05iMArammI/7c06w==
X-Google-Smtp-Source: ABdhPJxfdYGYwS7HdGn7Zame0oZeEcDOohwbP50ya7FCE+hsBnnfqPe4WNacmhnhsvI/Absvu7VVdQ==
X-Received: by 2002:a62:ab06:: with SMTP id p6mr2016830pff.131.1599627565164;
        Tue, 08 Sep 2020 21:59:25 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y29sm1115400pfq.207.2020.09.08.21.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 21:59:24 -0700 (PDT)
Date:   Tue, 08 Sep 2020 21:59:24 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Sep 2020 21:42:29 PDT (-0700)
Subject:     Re: [PATCH 5/8] riscv: use memcpy based uaccess for nommu again
In-Reply-To: <20200907055825.1917151-6-hch@lst.de>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>, viro@zeniv.linux.org.uk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-05de1a3d-fcf4-4a1a-949f-a59f91678f58@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Sep 2020 22:58:22 PDT (-0700), Christoph Hellwig wrote:
> This reverts commit adccfb1a805ea84d2db38eb53032533279bdaa97.
>
> Now that the generic uaccess by mempcy code handles unaligned addresses
> the generic code can be used for all RISC-V CPUs.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig               |  1 +
>  arch/riscv/include/asm/uaccess.h | 36 ++++++++++++++++----------------
>  arch/riscv/lib/Makefile          |  2 +-
>  3 files changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 07d53044013ede..460e3971a80fde 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -87,6 +87,7 @@ config RISCV
>  	select SYSCTL_EXCEPTION_TRACE
>  	select THREAD_INFO_IN_TASK
>  	select SET_FS
> +	select UACCESS_MEMCPY if !MMU
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index f56c66b3f5fe21..e8eedf22e90747 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -13,24 +13,6 @@
>  /*
>   * User space memory access functions
>   */
> -
> -extern unsigned long __must_check __asm_copy_to_user(void __user *to,
> -	const void *from, unsigned long n);
> -extern unsigned long __must_check __asm_copy_from_user(void *to,
> -	const void __user *from, unsigned long n);
> -
> -static inline unsigned long
> -raw_copy_from_user(void *to, const void __user *from, unsigned long n)
> -{
> -	return __asm_copy_from_user(to, from, n);
> -}
> -
> -static inline unsigned long
> -raw_copy_to_user(void __user *to, const void *from, unsigned long n)
> -{
> -	return __asm_copy_to_user(to, from, n);
> -}
> -
>  #ifdef CONFIG_MMU
>  #include <linux/errno.h>
>  #include <linux/compiler.h>
> @@ -385,6 +367,24 @@ do {								\
>  		-EFAULT;					\
>  })
>
> +
> +unsigned long __must_check __asm_copy_to_user(void __user *to,
> +	const void *from, unsigned long n);
> +unsigned long __must_check __asm_copy_from_user(void *to,
> +	const void __user *from, unsigned long n);
> +
> +static inline unsigned long
> +raw_copy_from_user(void *to, const void __user *from, unsigned long n)
> +{
> +	return __asm_copy_from_user(to, from, n);
> +}
> +
> +static inline unsigned long
> +raw_copy_to_user(void __user *to, const void *from, unsigned long n)
> +{
> +	return __asm_copy_to_user(to, from, n);
> +}
> +
>  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>
>  extern long __must_check strlen_user(const char __user *str);
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 0d0db80800c4ed..47e7a82044608d 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -2,5 +2,5 @@
>  lib-y			+= delay.o
>  lib-y			+= memcpy.o
>  lib-y			+= memset.o
> -lib-y			+= uaccess.o
> +lib-$(CONFIG_MMU)	+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
