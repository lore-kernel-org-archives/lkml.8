Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C7AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB6820657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:14:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YL/nqL8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbgGONOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgGONOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:14:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB8C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 06:14:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so1685364qkg.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 06:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=36xFMqA7jKBKS65g8wY6rmZnlfX7TIQ/b5ZfvSdEJW8=;
        b=YL/nqL8tRBuXuNQQaYLOrwV6/rXJobd2XN8BqippDR1hJ6Jyw7DGfbxOkStgeYsAKP
         4XB11f5ZP4U1OmyLH1dGWLHv/p4TTQD+mylxG1uLG2UpkLcYf070VsQ7NxwkHlwe/SA9
         W+on5iAZrkThieSg5SB5tT66cFRWTzdeWyuFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=36xFMqA7jKBKS65g8wY6rmZnlfX7TIQ/b5ZfvSdEJW8=;
        b=RBoe5Q6z/JXyK2hLbnPvZqaG9hhCowEoRJVQUKJWgBsncj6Oy1TMLW1ADZ6M/hp9KL
         y1VMwLltO5jJkcxqq8W3xUcuwXgCwLsPPJX4oqm23iehzVUPpbeXCPjT4B3E8Z+EaC76
         QDPIuEQRhNdnpUvot2KdyXRdT7tekfyoCpaUdsaUnKUI4yPbkajQnXwpXbSVYktklX3Y
         kOBzmXNFZSQCDX1p2ZKVeHdug3fFyoB2rWPDLKgTJWPyQGhsHtHnWmDfmaSaCLHxGhO8
         lreNw/XVelRxwKn64s7EMGis99t2CZmoHeldQXVyrFYJ/9aVfl50uM29u8ti06ykBrDH
         +1lg==
X-Gm-Message-State: AOAM5315oYevHYuLlbJX1q5Ky5yuvGdQblHHvdZ5Jmp5clrgSA0vLy+5
        1V3AUiNFeRj9qIGWP7u9YkDl4A==
X-Google-Smtp-Source: ABdhPJxaafHoFn6d7qIo70bj00//MqfDVz+UywkULGl6GMdlvmjAJbPYgRUr/IKvgTxibmGYIseguw==
X-Received: by 2002:ae9:e517:: with SMTP id w23mr9340433qkf.159.1594818892647;
        Wed, 15 Jul 2020 06:14:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id j18sm2824425qko.95.2020.07.15.06.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 06:14:52 -0700 (PDT)
Date:   Wed, 15 Jul 2020 09:14:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        William Kucharski <william.kucharski@oracle.com>
Subject: Re: [PATCH] mm: Fix warning in move_normal_pmd()
Message-ID: <20200715131451.GA2971370@google.com>
References: <20200715123513.42240-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715123513.42240-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:35:13PM +0300, Kirill A. Shutemov wrote:
> mremap(2) does not allow source and destination regions to overlap, but
> shift_arg_pages() calls move_page_tables() directly and in this case the
> source and destination overlap often. It confuses move_normal_pmd():
> 
>   WARNING: CPU: 3 PID: 27091 at mm/mremap.c:211 move_page_tables+0x6ef/0x720
> 
> move_normal_pmd() expects the destination PMD to be empty, but when
> ranges overlap nobody removes PTE page tables on source side.
> move_ptes() only removes PTE entries, leaving tables behind.
> When the source PMD becomes destination and alignment/size is right we
> step onto the warning.
> 
> The warning is harmless: kernel correctly fallbacks to handle entries on
> per-entry basis.

A link to the debugging effort could be added to the change log:
https://lore.kernel.org/lkml/20200713025354.GB3644504@google.com/

> The fix is to avoid move_normal_pmd() if we see that source and
> destination ranges overlap.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

And one thing that bothers me:

>  mm/mremap.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 5dd572d57ca9..e33fcee541fe 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -245,6 +245,18 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  	unsigned long extent, next, old_end;
>  	struct mmu_notifier_range range;
>  	pmd_t *old_pmd, *new_pmd;
> +	bool overlaps;
> +
> +	/*
> +	 * shift_arg_pages() can call move_page_tables() on overlapping ranges.
> +	 * In this case we cannot use move_normal_pmd() because destination pmd
> +	 * might be established page table: move_ptes() doesn't free page
> +	 * table.
> +	 */
> +	if (old_addr > new_addr)
> +		overlaps = old_addr - new_addr < len;
> +	else
> +		overlaps = new_addr - old_addr < len;

Does the code really work properly if old_addr < new_addr and overlaps ==
true ? If not, then we should add a warning here in the else IMHO:

	if (old_addr >= new_addr) {
		overlaps = old_addr - new_addr < len;
	} else {
		overlaps = new_addr - old_addr < len;
		WARN_ON(overlaps);
	}

(More so, since you have added code that detects overlaps for such a case).

thanks,

 - Joel

>  
>  	old_end = old_addr + len;
>  	flush_cache_range(vma, old_addr, old_end);
> @@ -282,7 +294,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  			split_huge_pmd(vma, old_pmd, old_addr);
>  			if (pmd_trans_unstable(old_pmd))
>  				continue;
> -		} else if (extent == PMD_SIZE) {
> +		} else if (!overlaps && extent == PMD_SIZE) {
>  #ifdef CONFIG_HAVE_MOVE_PMD
>  			/*
>  			 * If the extent is PMD-sized, try to speed the move by
> -- 
> 2.26.2
> 
> 
