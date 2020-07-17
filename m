Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32740C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19962080D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594975972;
	bh=eVGjv8woJUWyNNxl+GLmYWkXLWT7ol5zI9Z1lRtZoQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=z8csTo+hDYxXXTcZP5XwtW1BhSHHWycI/FlfUIQOpfZCmXREZC/CH5o6LwaTrEH3e
	 PrqcEHyCWIHsTnarH0kAvjjYelx9zMXQSYAnrc51NROO55nrZJ8pcalTbjSixrDC4x
	 JW8VPFuoCaFLExXefiR7xjAruHJTA+kJ3VjBpSSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgGQIwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:52:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95E232080D;
        Fri, 17 Jul 2020 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594975969;
        bh=eVGjv8woJUWyNNxl+GLmYWkXLWT7ol5zI9Z1lRtZoQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yhwta4gO6ioPIQUHdeAr01Amkbc9Xb+sAP5mloffp4PcnAk082EKbZM+/S48ksUMd
         6t58i4T/XVg4DbyX2b5P95VzYt5voyc65vPYWtyQjPEfxADDBwoglUuhIFTvAg5/HL
         N9Q2ZulXXgqCRMV2luecO4Puv+7LdBDkjlQZAKLs=
Date:   Fri, 17 Jul 2020 17:52:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: Re: [PATCH v4 3/7] vmalloc: Add text_alloc() and text_free()
Message-Id: <20200717175245.54758e3954abd1bcccfe5500@kernel.org>
In-Reply-To: <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
References: <20200717030422.679972-1-jarkko.sakkinen@linux.intel.com>
        <20200717030422.679972-4-jarkko.sakkinen@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 06:04:17 +0300
Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

> Introduce functions for allocating memory for dynamic trampolines, such
> as kprobes. An arch can promote the availability of these functions with
> CONFIG_ARCH_HAS_TEXT_ALLOC. Provide default/fallback implementation
> wrapping module_alloc() and module_memfree().

Doesn't it depend on CONFIG_MODULE?

Thank you,

> 
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/vmalloc.h | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 0221f852a7e1..e981436e30b6 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -9,6 +9,7 @@
>  #include <asm/page.h>		/* pgprot_t */
>  #include <linux/rbtree.h>
>  #include <linux/overflow.h>
> +#include <linux/moduleloader.h>
>  
>  #include <asm/vmalloc.h>
>  
> @@ -249,4 +250,26 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  int register_vmap_purge_notifier(struct notifier_block *nb);
>  int unregister_vmap_purge_notifier(struct notifier_block *nb);
>  
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +/*
> + * Allocate memory to be used for dynamic trampoline code.
> + */
> +void *text_alloc(unsigned long size);
> +
> +/*
> + * Free memory returned from text_alloc().
> + */
> +void text_free(void *region);
> +#else
> +static inline void *text_alloc(unsigned long size)
> +{
> +	return module_alloc(size);
> +}
> +
> +static inline void text_free(void *region)
> +{
> +	module_memfree(region);
> +}
> +#endif
> +
>  #endif /* _LINUX_VMALLOC_H */
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
