Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AF0C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FBDC20717
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 21:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388352AbgCDVqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:46:45 -0500
Received: from baldur.buserror.net ([165.227.176.147]:34414 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDVqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 16:46:44 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j9boT-0000Xs-8g; Wed, 04 Mar 2020 15:44:21 -0600
Message-ID: <10913e48efea24c1d217bc5a723d6cd827945de7.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
Date:   Wed, 04 Mar 2020 15:44:19 -0600
In-Reply-To: <20200206025825.22934-4-yanaijie@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com>
         <20200206025825.22934-4-yanaijie@huawei.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: yanaijie@huawei.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com, christophe.leroy@c-s.fr, benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com, keescook@chromium.org, kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v3 3/6] powerpc/fsl_booke/64: implement KASLR for
 fsl_booke64
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-06 at 10:58 +0800, Jason Yan wrote:
> The implementation for Freescale BookE64 is similar as BookE32. One
> difference is that Freescale BookE64 set up a TLB mapping of 1G during
> booting. Another difference is that ppc64 needs the kernel to be
> 64K-aligned. So we can randomize the kernel in this 1G mapping and make
> it 64K-aligned. This can save some code to creat another TLB map at
> early boot. The disadvantage is that we only have about 1G/64K = 16384
> slots to put the kernel in.
> 
> To support secondary cpu boot up, a variable __kaslr_offset was added in
> first_256B section. This can help secondary cpu get the kaslr offset
> before the 1:1 mapping has been setup.

What specifically requires __kaslr_offset instead of using kernstart_virt_addr
like 32-bit does?

>  
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index ad79fddb974d..744624140fb8 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -104,6 +104,13 @@ __secondary_hold_acknowledge:
>  	.8byte	0x0
>  
>  #ifdef CONFIG_RELOCATABLE
> +#ifdef CONFIG_RANDOMIZE_BASE
> +	. = 0x58
> +	.globl	__kaslr_offset
> +__kaslr_offset:
> +DEFINE_FIXED_SYMBOL(__kaslr_offset)
> +	.long	0
> +#endif
>  	/* This flag is set to 1 by a loader if the kernel should run
>  	 * at the loaded address instead of the linked address.  This
>  	 * is used by kexec-tools to keep the the kdump kernel in the

Why does it need to go here at a fixed address?


>  
>  	/* check for a reserved-memory node and record its cell sizes */
>  	regions.reserved_mem = fdt_path_offset(dt_ptr, "/reserved-memory");
> @@ -363,6 +374,17 @@ notrace void __init kaslr_early_init(void *dt_ptr,
> phys_addr_t size)
>  	unsigned long offset;
>  	unsigned long kernel_sz;
>  
> +#ifdef CONFIG_PPC64
> +	unsigned int *__kaslr_offset = (unsigned int *)(KERNELBASE + 0x58);
> +	unsigned int *__run_at_load = (unsigned int *)(KERNELBASE + 0x5c);

Why are you referencing these by magic offset rather than by symbol?


> +	/* Setup flat device-tree pointer */
> +	initial_boot_params = dt_ptr;
> +#endif

Why does 64-bit need this but 32-bit doesn't?

-Scott


