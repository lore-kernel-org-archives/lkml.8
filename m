Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E98A6C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE70720767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="TRH9dF/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgCSBpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:45:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37527 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:45:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id a32so302286pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 18:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=defp/e8uGf2l7bhewdU6OaL68+EfMO5fZxpJqA0gb44=;
        b=TRH9dF/Bcso2rM5yQA5z7+HWKaf/U9fQXXXiGt+gvIlAl7EBBYtBY4P+uGN6zC0HeM
         ZqLFF52447PgzW427qP+o/M9QSozt8dx0MUmU6xZ2Q41q9XnatKdKLZZ50i/KMy9FOdh
         gOVor3GK9zXWV5MRE1Z6SxblJGjR/+AKkenXZyyAtKG+W0t55wxsxhCIRJ0rCiUYKXdL
         GWi0nm3Iga4ibfBonBAUtYYJvd+kl+FDzXBQF4v7uS0/vKgirOzLgWxcqWg1ii2ZqZNy
         sL5vWndu8SKanEVT9bXtgRrhMRHVl8Az9Q0KwQ0HByoB4oRMVGJ4ZKpYg+8DIDX5qEeR
         SKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=defp/e8uGf2l7bhewdU6OaL68+EfMO5fZxpJqA0gb44=;
        b=SNSlTU4B3wSKuwOm77kCV+Vokj55ma+L/PvSobLBcSa4mC9yEVAuC1T8WSnYvudmw9
         YDcJfHa/fouKXdhU8lHkFleJeE5I2NENmhpN791jLCEFNaTUydozZn5iNGaJvJJu4dXE
         5C3/xn9J0wV8If2hzVky6JMal/XAO6zmJ+OdC515P490MITBWybJC4QYgdEiwE4oV3E0
         L1tZGMFg+KKo8b3aCKo+HLBYp7k3tDHnM/ZQlfwJK9iaSz4lXjp9R4AIvYfvRhFLn0Ar
         lBpyJHoILRQm3MVFJZoYqsMBFq4iId8cWKUhXXGidiT4/DXOBb54OiFVWY8roRKX4NWb
         Robw==
X-Gm-Message-State: ANhLgQ1nbU7Ir95j3uPnAbRQa1wi+iNdmXzTjPThy4g9oKzvTD7dAYVL
        RS3z8C55DUsJn0AWmMHPPm1nGg==
X-Google-Smtp-Source: ADFU+vv85oxDxQAFmm7XMMsICpoRLKqZYdHMoXpDM4rA+wl3SEkqIZ7ih9rz7hyN855EqqkemkO67g==
X-Received: by 2002:a65:44c1:: with SMTP id g1mr722666pgs.362.1584582310663;
        Wed, 18 Mar 2020 18:45:10 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id k17sm249690pfp.194.2020.03.18.18.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 18:45:09 -0700 (PDT)
Date:   Wed, 18 Mar 2020 18:45:09 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Mar 2020 16:19:33 PDT (-0700)
Subject:     Re: [PATCH 1/2] riscv: uaccess should be used in nommu mode
In-Reply-To: <20200303093418.9180-1-greentime.hu@sifive.com>
CC:     green.hu@gmail.com, greentime@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        greentime.hu@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-c8144bd2-e457-4949-90bc-c05113a6c954@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Mar 2020 01:34:17 PST (-0800), greentime.hu@sifive.com wrote:
> It might have the unaligned access exception when trying to exchange data
> with user space program. In this case, it failed in tty_ioctl(). Therefore
> we should enable uaccess.S for NOMMU mode since the generic code doesn't
> handle the unaligned access cases.
>
>    0x8013a212 <tty_ioctl+462>:  ld      a5,460(s1)
>
> [    0.115279] Oops - load address misaligned [#1]
> [    0.115284] CPU: 0 PID: 29 Comm: sh Not tainted 5.4.0-rc5-00020-gb4c27160d562-dirty #36
> [    0.115294] epc: 000000008013a212 ra : 000000008013a212 sp : 000000008f48dd50
> [    0.115303]  gp : 00000000801cac28 tp : 000000008fb80000 t0 : 00000000000000e8
> [    0.115312]  t1 : 000000008f58f108 t2 : 0000000000000009 s0 : 000000008f48ddf0
> [    0.115321]  s1 : 000000008f8c6220 a0 : 0000000000000001 a1 : 000000008f48dd28
> [    0.115330]  a2 : 000000008fb80000 a3 : 00000000801a7398 a4 : 0000000000000000
> [    0.115339]  a5 : 0000000000000000 a6 : 000000008f58f0c6 a7 : 000000000000001d
> [    0.115348]  s2 : 000000008f8c6308 s3 : 000000008f78b7c8 s4 : 000000008fb834c0
> [    0.115357]  s5 : 0000000000005413 s6 : 0000000000000000 s7 : 000000008f58f2b0
> [    0.115366]  s8 : 000000008f858008 s9 : 000000008f776818 s10: 000000008f776830
> [    0.115375]  s11: 000000008fb840a8 t3 : 1999999999999999 t4 : 000000008f78704c
> [    0.115384]  t5 : 0000000000000005 t6 : 0000000000000002
> [    0.115391] status: 0000000200001880 badaddr: 000000008f8c63ec cause: 0000000000000004
> [    0.115401] ---[ end trace 00d490c6a8b6c9ac ]---
>
> This failure could be fixed after this patch applied.
>
> [    0.002282] Run /init as init process
> Initializing random number generator... [    0.005573] random: dd: uninitialized urandom read (512 bytes read)
> done.
>
> Welcome to Buildroot
> buildroot login: root
> Password:
> Jan  1 00:00:00 login[62]: root login on 'ttySIF0'
> ~ #
>
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/Kconfig               |  1 -
>  arch/riscv/include/asm/uaccess.h | 36 ++++++++++++++++----------------
>  arch/riscv/lib/Makefile          |  2 +-
>  3 files changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 73f029eae0cc..92d63a63aec8 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -50,7 +50,6 @@ config RISCV
>  	select PCI_DOMAINS_GENERIC if PCI
>  	select PCI_MSI if PCI
>  	select RISCV_TIMER
> -	select UACCESS_MEMCPY if !MMU
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select GENERIC_ARCH_TOPOLOGY if SMP
>  	select ARCH_HAS_PTE_SPECIAL
> diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
> index f462a183a9c2..8ce9d607b53d 100644
> --- a/arch/riscv/include/asm/uaccess.h
> +++ b/arch/riscv/include/asm/uaccess.h
> @@ -11,6 +11,24 @@
>  /*
>   * User space memory access functions
>   */
> +
> +extern unsigned long __must_check __asm_copy_to_user(void __user *to,
> +	const void *from, unsigned long n);
> +extern unsigned long __must_check __asm_copy_from_user(void *to,
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
>  #ifdef CONFIG_MMU
>  #include <linux/errno.h>
>  #include <linux/compiler.h>
> @@ -367,24 +385,6 @@ do {								\
>  		-EFAULT;					\
>  })
>
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
>  extern long strncpy_from_user(char *dest, const char __user *src, long count);
>
>  extern long __must_check strlen_user(const char __user *str);
> diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
> index 47e7a8204460..0d0db80800c4 100644
> --- a/arch/riscv/lib/Makefile
> +++ b/arch/riscv/lib/Makefile
> @@ -2,5 +2,5 @@
>  lib-y			+= delay.o
>  lib-y			+= memcpy.o
>  lib-y			+= memset.o
> -lib-$(CONFIG_MMU)	+= uaccess.o
> +lib-y			+= uaccess.o
>  lib-$(CONFIG_64BIT)	+= tishift.o

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
