Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B2FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E75208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595586478;
	bh=rTxGRGk7C2mffWe9YQ5WA7WqwJtcr2BteH9NQ77nZv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fPglyYtv5cQEegG+A2anEI6htOH9BjTFgJzENybJVYVV07XQc/eoabufDu+PnLnPd
	 G7Eirzw+90d2NnnoGKvKd1Zucf34Kr6Y6AWpIxHPII7ZkelaR3L/nZGM+DhKn+mUi/
	 hzgZmJBFKKGen6Q5n6As/POjmC4ftS86sDmguV/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGXK15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:27:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgGXK15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:27:57 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C42C72065C;
        Fri, 24 Jul 2020 10:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595586476;
        bh=rTxGRGk7C2mffWe9YQ5WA7WqwJtcr2BteH9NQ77nZv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vihE7SOo3lD4LC4+CIPQCOoOudzMuHnNuJbbTSv86K3VmmOoshAkXr/uxwxKzvfIU
         KToD3j1GADq0268CJz4CmRLe0JbPbLqZb2itF7bI7BkVi+lkxrhdYW+HmqLDrMb+8K
         OkBeauy5MurtdVDrclLFQxjJ+BEbo0lOnCQe1VMQ=
Date:   Fri, 24 Jul 2020 13:27:48 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-ID: <20200724102748.GD2831654@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-6-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:05:52AM +0300, Jarkko Sakkinen wrote:
> Use text_alloc() and text_free() instead of module_alloc() and
> module_memfree() when an arch provides them.
> 
> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  kernel/kprobes.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4e46d96d4e16..611fcda9f6bf 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -40,6 +40,7 @@
>  #include <asm/cacheflush.h>
>  #include <asm/errno.h>
>  #include <linux/uaccess.h>
> +#include <linux/vmalloc.h>
>  
>  #define KPROBE_HASH_BITS 6
>  #define KPROBE_TABLE_SIZE (1 << KPROBE_HASH_BITS)
> @@ -111,12 +112,20 @@ enum kprobe_slot_state {
>  
>  void __weak *alloc_insn_page(void)
>  {
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	return text_alloc(PAGE_SIZE);
> +#else
>  	return module_alloc(PAGE_SIZE);
> +#endif
>  }
>  
>  void __weak free_insn_page(void *page)
>  {
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +	text_free(page);
> +#else
>  	module_memfree(page);
> +#endif
>  }

Both alloc_insn_page() and free_insn_page() are __weak and can be simple
overriden in arch/x86 code.
  
>  struct kprobe_insn_cache kprobe_insn_slots = {
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
