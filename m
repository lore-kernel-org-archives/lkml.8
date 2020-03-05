Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C087BC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96C4B20637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A4CQsRzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgCER2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:28:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47092 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgCER2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:28:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id w12so2756053pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5GhHy6u24nuTxo8vi/P/XG6wbWlOlpBB+6uXAshE3BI=;
        b=A4CQsRzjUzZ0cLeBtHH9oLFUJ4aelq20S7th9dj2XK8h/GLg3g014pqdJUKLoqA0FM
         kzns6+QfkYUaithselbfQs7xXHEzM/4UW6AoIVINiEkKobKPGvYeyOP6PflwjL9HW/I0
         e/LErikhTuupgqBO8GJpKz+nXDKQWioFc/KBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5GhHy6u24nuTxo8vi/P/XG6wbWlOlpBB+6uXAshE3BI=;
        b=p7DeWAkxr82qOENmX5zQosJjzXvga5/poKp66S386i5RuMEHCVRiMkTyOOHUid4dPG
         S2sF6XpdA6jnQDYrJVXb5LJvnYZnwpAliZ3U4rErwsCOn2IpmE0Okl474yYOMMUr9zKc
         1116yZhcTh7aq+utjZKpHjkCRB7ZU5xbquQ/XMqymu/qlwWD3xa1vDhq12c7na7j4jtb
         PAkXmeEjTtemRwcOm+CT4b2uzcesOG+ffOuJeXOJUp9qABC+ORlDWRw9fI7pjzl424B5
         WRaq1wqDjlYMCZgqQr2hxPwxksyy6UyiB+DNZH6aEBwrTCWWBLB3QagHZ1eM58X6r2S0
         5hOw==
X-Gm-Message-State: ANhLgQ2HgFmIXx6yk3nNMhXmEFKnTucPJefJjVpdlbtCxg/qY8hHFZVK
        Q2bW1+6lodo13/uuQS5TyW3/Iw==
X-Google-Smtp-Source: ADFU+vuUsQWGkxxWgS7KjDFtTWamXbEaGYMhsSxuelmLP1uSQonzU5BrsFVVTKypW8ChVGWvHZ3Ygg==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr9853361pjq.14.1583429330172;
        Thu, 05 Mar 2020 09:28:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q187sm32502597pfq.185.2020.03.05.09.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 09:28:49 -0800 (PST)
Date:   Thu, 5 Mar 2020 09:28:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kernel-hardening@lists.openwall.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] x86/mm/init_32: Stop printing the virtual memory
 layout
Message-ID: <202003050927.530CC2D6DD@keescook>
References: <202003021039.257258E1B@keescook>
 <20200305150152.831697-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305150152.831697-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:01:52AM -0500, Arvind Sankar wrote:
> For security, don't display the kernel's virtual memory layout.
> 
> Kees Cook points out:
> "These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally."
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Thanks!

(*randomly choosing an x86 maintainer to aim this patch at; hi Thomas!*)

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/mm/init_32.c | 38 --------------------------------------
>  1 file changed, 38 deletions(-)
> 
> diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
> index 23df4885bbed..8ae0272c1c51 100644
> --- a/arch/x86/mm/init_32.c
> +++ b/arch/x86/mm/init_32.c
> @@ -788,44 +788,6 @@ void __init mem_init(void)
>  	x86_init.hyper.init_after_bootmem();
>  
>  	mem_init_print_info(NULL);
> -	printk(KERN_INFO "virtual kernel memory layout:\n"
> -		"    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -		"  cpu_entry : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -#ifdef CONFIG_HIGHMEM
> -		"    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -#endif
> -		"    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -		"    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
> -		"      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -		"      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
> -		"      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
> -		FIXADDR_START, FIXADDR_TOP,
> -		(FIXADDR_TOP - FIXADDR_START) >> 10,
> -
> -		CPU_ENTRY_AREA_BASE,
> -		CPU_ENTRY_AREA_BASE + CPU_ENTRY_AREA_MAP_SIZE,
> -		CPU_ENTRY_AREA_MAP_SIZE >> 10,
> -
> -#ifdef CONFIG_HIGHMEM
> -		PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
> -		(LAST_PKMAP*PAGE_SIZE) >> 10,
> -#endif
> -
> -		VMALLOC_START, VMALLOC_END,
> -		(VMALLOC_END - VMALLOC_START) >> 20,
> -
> -		(unsigned long)__va(0), (unsigned long)high_memory,
> -		((unsigned long)high_memory - (unsigned long)__va(0)) >> 20,
> -
> -		(unsigned long)&__init_begin, (unsigned long)&__init_end,
> -		((unsigned long)&__init_end -
> -		 (unsigned long)&__init_begin) >> 10,
> -
> -		(unsigned long)&_etext, (unsigned long)&_edata,
> -		((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
> -
> -		(unsigned long)&_text, (unsigned long)&_etext,
> -		((unsigned long)&_etext - (unsigned long)&_text) >> 10);
>  
>  	/*
>  	 * Check boundaries twice: Some fundamental inconsistencies can
> -- 
> 2.24.1
> 

-- 
Kees Cook
