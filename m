Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406BAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184752084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 13:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="iyjGew0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390601AbgE1Nt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390538AbgE1NtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 09:49:23 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECFBC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:49:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so3041085qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=miWLmImDnuJKbH2UD6fJ0qtMBZgQrphKm0mtgZhQM7U=;
        b=iyjGew0l2tYfqon7DI+M0hBZTp8v0jwNf9xjgvAAzM6rc7AdrYSecs5Q5cg9z1mPid
         evevW76ufZFzXACoLF/An8MyRGZLqdO2qUmgPR5eNmOdTXVj+J77F1T5xW6bnAEbdc+z
         ROvgmMwU5HkY1Wg5WPg2rq/z4Fig+a1d6EnLxUq/Dod+4hDGjUWDQkD5KQwd3gFuQyrw
         E2LMB//NavOOquFaNBAS+YqmBgD/oXa7qPXhKig3c2j7bSSErEGlgTQBrbj478iRuTgz
         HRWZmaKBkEsVz3+OEGa7EDZJI2WbRU+Mb6s6TbHZBwLrYZK2WW4tF7Uyg+S9Vkq54mV/
         eMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=miWLmImDnuJKbH2UD6fJ0qtMBZgQrphKm0mtgZhQM7U=;
        b=RC9lxXYtoEWFBTlx4AUY7hsnTAbV6LuIfAW6E8NmS1yc9oVqRduSjrtCMbADx0n0bv
         gKt+F3ynKYSVnsrFEHRwrv96VFEA/u2rcnuzqNXDrEK5yZ3CRRFf4XHetTkW9jtvNbDv
         E5r2knNAEdFx79zMR37Ah1M+UArgp2R7vT8NAOlERavbRP3B05dncEfIkNZwVxcCltl+
         uLVgBVJ5IpQAr4qUeJRrxem1zRuyphJDNrhPOQsSV4BvYOtBAPbe/XpauA7OgjHbPUKK
         vMlcJ+Zz5fBhmk6Ng2C0l/wPpq96ej+WQmos7V8v518kziX6EKGztHpNVR4qtsYsdTZC
         nVQQ==
X-Gm-Message-State: AOAM530eloXt8heFtCnv2UXeckPm7jCul/vh6v4OI7uRqPKVkYdtlI0q
        eIpQsnVq1eOhKvTrMHNvyTT6Yw==
X-Google-Smtp-Source: ABdhPJxV6hsMUOeuYKlJIRSfScFpf5CTKmx7dgyP3rPQwIREMnctPCB+tRbhMrTjYZv38/DCNzQ98g==
X-Received: by 2002:a37:e205:: with SMTP id g5mr2875689qki.451.1590673761660;
        Thu, 28 May 2020 06:49:21 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v53sm4006742qtv.10.2020.05.28.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 06:49:21 -0700 (PDT)
Date:   Thu, 28 May 2020 09:49:13 -0400
From:   Qian Cai <cai@lca.pw>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
Message-ID: <20200528134913.GA1810@lca.pw>
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:33:20PM +0200, 'Andrey Konovalov' via kasan-dev wrote:
> The kasan_report() functions belongs to report.c, as it's a common
> functions that does error reporting.
> 
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Today's linux-next produced this with Clang 11.

mm/kasan/report.o: warning: objtool: kasan_report()+0x8a: call to __stack_chk_fail() with UACCESS enabled

kasan_report at mm/kasan/report.c:536

> ---
>  mm/kasan/common.c | 19 -------------------
>  mm/kasan/report.c | 22 ++++++++++++++++++++--
>  2 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 2906358e42f0..757d4074fe28 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -33,7 +33,6 @@
>  #include <linux/types.h>
>  #include <linux/vmalloc.h>
>  #include <linux/bug.h>
> -#include <linux/uaccess.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/tlbflush.h>
> @@ -613,24 +612,6 @@ void kasan_free_shadow(const struct vm_struct *vm)
>  }
>  #endif
>  
> -extern void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip);
> -extern bool report_enabled(void);
> -
> -bool kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> -{
> -	unsigned long flags = user_access_save();
> -	bool ret = false;
> -
> -	if (likely(report_enabled())) {
> -		__kasan_report(addr, size, is_write, ip);
> -		ret = true;
> -	}
> -
> -	user_access_restore(flags);
> -
> -	return ret;
> -}
> -
>  #ifdef CONFIG_MEMORY_HOTPLUG
>  static bool shadow_mapped(unsigned long addr)
>  {
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 80f23c9da6b0..51ec45407a0b 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -29,6 +29,7 @@
>  #include <linux/kasan.h>
>  #include <linux/module.h>
>  #include <linux/sched/task_stack.h>
> +#include <linux/uaccess.h>
>  
>  #include <asm/sections.h>
>  
> @@ -454,7 +455,7 @@ static void print_shadow_for_address(const void *addr)
>  	}
>  }
>  
> -bool report_enabled(void)
> +static bool report_enabled(void)
>  {
>  	if (current->kasan_depth)
>  		return false;
> @@ -479,7 +480,8 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
>  	end_report(&flags);
>  }
>  
> -void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> +static void __kasan_report(unsigned long addr, size_t size, bool is_write,
> +				unsigned long ip)
>  {
>  	struct kasan_access_info info;
>  	void *tagged_addr;
> @@ -518,6 +520,22 @@ void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned lon
>  	end_report(&flags);
>  }
>  
> +bool kasan_report(unsigned long addr, size_t size, bool is_write,
> +			unsigned long ip)
> +{
> +	unsigned long flags = user_access_save();
> +	bool ret = false;
> +
> +	if (likely(report_enabled())) {
> +		__kasan_report(addr, size, is_write, ip);
> +		ret = true;
> +	}
> +
> +	user_access_restore(flags);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_KASAN_INLINE
>  /*
>   * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl%40google.com.
