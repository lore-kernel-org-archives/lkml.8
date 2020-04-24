Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A38C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B83220767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="mrPonUye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgDXFRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:17:23 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:46856 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgDXFRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:17:23 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 497j8w4XjRzB09ZM;
        Fri, 24 Apr 2020 07:17:20 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=mrPonUye; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id v305KuRG_Mok; Fri, 24 Apr 2020 07:17:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 497j8w2q7czB09ZL;
        Fri, 24 Apr 2020 07:17:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587705440; bh=++Ny41IFNLTue5qM5LUZ2+tvZQZ82gblN7S6VqtUqJY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mrPonUyeyqqdhKl+VLWfaNIg1q1pf2a1m6WBCddK9KAFnfa8wPHQQpfJl5GDPFdvG
         iFuufG/+9phDPac9TAiGjP8TOmvUOHuY0PP+6ZjuOrj31mTrsiK9XSclKHWnlGpOvu
         ZZR80+iKdm+63ln1IPCk8aVzQxdY/GbE/IeRODkQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3141B8B775;
        Fri, 24 Apr 2020 07:17:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6s-IckGNVvmj; Fri, 24 Apr 2020 07:17:21 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 258FD8B75E;
        Fri, 24 Apr 2020 07:17:17 +0200 (CEST)
Subject: Re: [PATCH v3,4/5] misc: sram_dynamic for user level SRAM access
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     oss@buserror.net, kernel@vivo.com, robh@kernel.org,
        benh@kernel.crashing.org, paulus@samba.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20200424024554.30709-1-wenhu.wang@vivo.com>
 <20200424024554.30709-5-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <6675dd9d-43be-6451-88a9-02d2c52c7d3a@c-s.fr>
Date:   Fri, 24 Apr 2020 07:17:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424024554.30709-5-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/04/2020 à 04:45, Wang Wenhu a écrit :
> A generic User-Kernel interface module that allows a misc device created
> when a backend SRAM hardware device driver registers its APIs to support
> file operations of ioctl and mmap for user space applications to allocate
> SRAM memory, mmap it to process address space and free it then after.
> 
> It is extremely helpful for the user space applications that require
> high performance memory accesses, such as embedded networking devices
> that would process data in user space, and PowerPC e500 is one case.
> 
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
> Changes since v1: addressed comments from Arnd
>   * Changed the ioctl cmd definitions using _IO micros
>   * Export interfaces for HW-SRAM drivers to register apis to available list
>   * Modified allocation alignment to PAGE_SIZE
>   * Use phys_addr_t as type of SRAM resource size and offset
>   * Support compat_ioctl
>   * Misc device name:sram
>   * Use tristate for SRAM_UAPI
>   * Use postcore_initcall
> 
> Changes since v2: addressed comments from Arnd, greg and Scott
>   * Name the module with sram_dynamic in comparing with drivers/misc/sram.c
> 
>      I tried to tie the sram_dynamic with the abstractions in sram.c as
>      Arnd suggested, and actually sram.c probes SRAM devices from devicetree
>      and manages them with different partitions and create memory pools which
>      are managed with genalloc functions.
> 
>      Here sram_dynamic acts only as a interface to user space. A SRAM memory
>      pool is managed by the module that registers APIs to us, such as the
>      backend hardware driver of Freescale 85xx Cache-SRAM.
> 
>   * Create one sram_device for each backend SRAM device(from Scott)
>   * Allow only one block of SRAM memory allocated to a file descriptor(from Scott)
>   * Add sysfs files for every allocated SRAM memory block
>   * More documentations(As Greg commented)
>   * Make uapi and non-uapi components apart(from Arnd and Greg)
> 
> Links:
> v1: https://lore.kernel.org/lkml/20200418162157.50428-5-wenhu.wang@vivo.com/
> v2: https://lore.kernel.org/lkml/20200420030538.101696-1-wenhu.wang@vivo.com/
> UIO version:
> v5: https://lore.kernel.org/lkml/20200417071616.44598-5-wenhu.wang@vivo.com/
> ---
>   drivers/misc/Kconfig         |  11 +
>   drivers/misc/Makefile        |   1 +
>   drivers/misc/sram_dynamic.c  | 580 +++++++++++++++++++++++++++++++++++
>   drivers/misc/sram_uapi.c     | 351 +++++++++++++++++++++
>   include/linux/sram_dynamic.h |  23 ++
>   include/uapi/linux/sram.h    |  11 +
>   6 files changed, 977 insertions(+)
>   create mode 100644 drivers/misc/sram_dynamic.c
>   create mode 100644 drivers/misc/sram_uapi.c
>   create mode 100644 include/linux/sram_dynamic.h
>   create mode 100644 include/uapi/linux/sram.h
> 

> diff --git a/include/linux/sram_dynamic.h b/include/linux/sram_dynamic.h
> new file mode 100644
> index 000000000000..c77e9e7b1151
> --- /dev/null
> +++ b/include/linux/sram_dynamic.h
> @@ -0,0 +1,23 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SRAM_DYNAMIC_H
> +#define __SRAM_DYNAMIC_H
> +
> +struct sram_api {
> +	const char	*name;
> +	struct sram_device *sdev;
> +	void *(*alloc)(__u32 size, phys_addr_t *phys, __u32 align);
> +	void (*free)(void *ptr);
> +};
> +
> +extern int __must_check
> +	__sram_register_device(struct module *owner,
> +			       struct device *parent,
> +			       struct sram_api *sa);

'extern' keyword is useless here, remove it (checkpatch --strict will 
likely tell you the same)

> +
> +/* Use a define to avoid include chaining to get THIS_MODULE */
> +#define sram_register_device(parent, sa) \
> +	__sram_register_device(THIS_MODULE, parent, sa)
> +
> +extern void sram_unregister_device(struct sram_api *sa);

Same, no 'extern' please.

> +
> +#endif /* __SRAM_DYNAMIC_H */
> diff --git a/include/uapi/linux/sram.h b/include/uapi/linux/sram.h
> new file mode 100644
> index 000000000000..9b4a2615dbfe
> --- /dev/null
> +++ b/include/uapi/linux/sram.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SRAM_H
> +#define __SRAM_H
> +
> +/* Allocate memory resource from SRAM */
> +#define SRAM_UAPI_IOC_ALLOC	_IOWR('S', 0, __be64)
> +
> +/* Free allocated memory resource to SRAM */
> +#define SRAM_UAPI_IOC_FREE	_IO('S', 1)
> +
> +#endif /* __SRAM_H */
> 

Christophe
