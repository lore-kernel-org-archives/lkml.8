Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD583C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F52F206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgGFPWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:22:23 -0400
Received: from foss.arm.com ([217.140.110.172]:49078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729197AbgGFPWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:22:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42D44C0A;
        Mon,  6 Jul 2020 08:22:22 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1987A3F71E;
        Mon,  6 Jul 2020 08:22:20 -0700 (PDT)
Date:   Mon, 6 Jul 2020 16:21:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kasan: Remove kasan_unpoison_stack_above_sp_to()
Message-ID: <20200706152152.GA45787@lakrids.cambridge.arm.com>
References: <20200706143505.23299-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706143505.23299-1-vincenzo.frascino@arm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 03:35:05PM +0100, Vincenzo Frascino wrote:
> The function kasan_unpoison_stack_above_sp_to() is defined in kasan code
> but never used. The function was introduced as part of the commit:
> 
>    commit 9f7d416c36124667 ("kprobes: Unpoison stack in jprobe_return() for KASAN")
> 
> ... where it was necessary because x86's jprobe_return() would leave
> stale shadow on the stack, and was an oddity in that regard.
> 
> Since then, jprobes were removed entirely, and as of commit:
> 
>   commit 80006dbee674f9fa ("kprobes/x86: Remove jprobe implementation")
> 
> ... there have been no callers of this function.
> 
> Remove the declaration and the implementation.
> 
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This looks sane to me, and I'm not aware of any cases oputside of
jprobes that would need this, so FWIW:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  include/linux/kasan.h |  2 --
>  mm/kasan/common.c     | 15 ---------------
>  2 files changed, 17 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 82522e996c76..0ebf2fab8567 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -38,7 +38,6 @@ extern void kasan_disable_current(void);
>  void kasan_unpoison_shadow(const void *address, size_t size);
>  
>  void kasan_unpoison_task_stack(struct task_struct *task);
> -void kasan_unpoison_stack_above_sp_to(const void *watermark);
>  
>  void kasan_alloc_pages(struct page *page, unsigned int order);
>  void kasan_free_pages(struct page *page, unsigned int order);
> @@ -101,7 +100,6 @@ void kasan_restore_multi_shot(bool enabled);
>  static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
>  
>  static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
> -static inline void kasan_unpoison_stack_above_sp_to(const void *watermark) {}
>  
>  static inline void kasan_enable_current(void) {}
>  static inline void kasan_disable_current(void) {}
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 757d4074fe28..6339179badb2 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -180,21 +180,6 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
>  	kasan_unpoison_shadow(base, watermark - base);
>  }
>  
> -/*
> - * Clear all poison for the region between the current SP and a provided
> - * watermark value, as is sometimes required prior to hand-crafted asm function
> - * returns in the middle of functions.
> - */
> -void kasan_unpoison_stack_above_sp_to(const void *watermark)
> -{
> -	const void *sp = __builtin_frame_address(0);
> -	size_t size = watermark - sp;
> -
> -	if (WARN_ON(sp > watermark))
> -		return;
> -	kasan_unpoison_shadow(sp, size);
> -}
> -
>  void kasan_alloc_pages(struct page *page, unsigned int order)
>  {
>  	u8 tag;
> -- 
> 2.27.0
> 
