Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D80AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF0E2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595586172;
	bh=UvxGq6yX6XuuylfuSDP/iXKMmYlEzY1kzhP4GwXlgVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tbggBqERSmxMcfWxEUjlkvh5rT7yI40RRuxjaHBbTq3Irt985IJPFL4XghDdcegKs
	 PF0dMGLmeP/DjW1J7eR8lsWuhSmQv+CeEX4oZItSSXllPbe98rck15V/dHoVCTM1kZ
	 CXLRRUlwAylrG7PKp/k8JkqM2ui6t6I00rIkTyEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXKWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 06:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgGXKWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 06:22:50 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85B212065C;
        Fri, 24 Jul 2020 10:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595586170;
        bh=UvxGq6yX6XuuylfuSDP/iXKMmYlEzY1kzhP4GwXlgVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZKLPTe70/iq4UW4IJk8j7elpMr31458tZGyatUwi1KDyMq2meB2t/me1S8bgupPHD
         zSTgOW6xXP8dh6/A9Tgqec3jI5YC7LzyzItuia0ouAcePbAYivmWFBuBhVvv4tvpqI
         STctW7cGEeq3u2sl+5kvCVPV0OubAxwP1WquJ00Y=
Date:   Fri, 24 Jul 2020 13:22:43 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 2/6] vmalloc: Add text_alloc() and text_free()
Message-ID: <20200724102243.GA2831654@kernel.org>
References: <20200724050553.1724168-1-jarkko.sakkinen@linux.intel.com>
 <20200724050553.1724168-3-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724050553.1724168-3-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 08:05:49AM +0300, Jarkko Sakkinen wrote:
> Introduce functions for allocating memory for dynamic trampolines, such
> as kprobes. An arch can promote the availability of these functions with
> CONFIG_ARCH_HAS_TEXT_ALLOC.

As it was pointed out at the discussion on the previous version [1],
text_alloc() alone won't necessarily suit other architectures.
 
I don't see a point in defining a "generic" interface that apriory could
not be imeplemented by several architectures.

[1] https://lore.kernel.org/lkml/20200714094625.1443261-1-jarkko.sakkinen@linux.intel.com/

> Cc: linux-mm@kvack.org
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  include/linux/vmalloc.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 0221f852a7e1..6c151a0ac02a 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -249,4 +249,21 @@ pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  int register_vmap_purge_notifier(struct notifier_block *nb);
>  int unregister_vmap_purge_notifier(struct notifier_block *nb);
>  
> +/*
> + * These functions can be optionally implemented by an arch in order to
> + * provide specialized functions for allocating trampoline code.
> + */
> +
> +#ifdef CONFIG_ARCH_HAS_TEXT_ALLOC
> +/*
> + * Allocate memory to be used for trampoline code.
> + */
> +void *text_alloc(unsigned long size);
> +
> +/*
> + * Free memory returned from text_alloc().
> + */
> +void text_free(void *region);
> +#endif /* CONFIG_ARCH_HAS_TEXT_ALLOC */
> +
>  #endif /* _LINUX_VMALLOC_H */
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
