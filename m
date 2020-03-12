Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8923C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A86B0206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLQt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:49:28 -0400
Received: from foss.arm.com ([217.140.110.172]:37976 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgCLQt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:49:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 923F930E;
        Thu, 12 Mar 2020 09:49:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 913623F6CF;
        Thu, 12 Mar 2020 09:49:24 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:49:22 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     glider@google.com
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, akpm@linux-foundation.org
Subject: Re: [PATCH] arm64: define __alloc_zeroed_user_highpage
Message-ID: <20200312164922.GC21120@lakrids.cambridge.arm.com>
References: <20200312155920.50067-1-glider@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312155920.50067-1-glider@google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:59:20PM +0100, glider@google.com wrote:
> When running the kernel with init_on_alloc=1, calling the default
> implementation of __alloc_zeroed_user_highpage() from include/linux/highmem.h
> leads to double-initialization of the allocated page (first by the page
> allocator, then by clear_user_page().
> Calling alloc_page_vma() with __GFP_ZERO, similarly to e.g. x86, seems
> to be enough to ensure the user page is zeroed only once.

Just to check, is there a functional ussue beyond the redundant zeroing,
or is this jsut a performance issue?

On architectures with real highmem, does GFP_HIGHUSER prevent the
allocator from zeroing the page in this case, or is the architecture
prevented from allocating from highmem?

This feels like something we should be able to fix in the generic
implementation of __alloc_zeroed_user_highpage(), with an additional
check to see if init_on_alloc is in use.

Thanks,
Mark.

> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  arch/arm64/include/asm/page.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
> index d39ddb258a049..75d6cd23a6790 100644
> --- a/arch/arm64/include/asm/page.h
> +++ b/arch/arm64/include/asm/page.h
> @@ -21,6 +21,10 @@ extern void __cpu_copy_user_page(void *to, const void *from,
>  extern void copy_page(void *to, const void *from);
>  extern void clear_page(void *to);
>  
> +#define __alloc_zeroed_user_highpage(movableflags, vma, vaddr) \
> +	alloc_page_vma(GFP_HIGHUSER | __GFP_ZERO | movableflags, vma, vaddr)
> +#define __HAVE_ARCH_ALLOC_ZEROED_USER_HIGHPAGE
> +
>  #define clear_user_page(addr,vaddr,pg)  __cpu_clear_user_page(addr, vaddr)
>  #define copy_user_page(to,from,vaddr,pg) __cpu_copy_user_page(to, from, vaddr)
>  
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 
