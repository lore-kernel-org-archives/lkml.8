Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D370120748
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ge+HwPtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgHGRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:16:29 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EE9C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 10:16:29 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h12so1218387pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xF5/XqhC95C9KSNipegVoItT8yYvzxsVDvSLIvoWnRA=;
        b=Ge+HwPtYOmij8Z2Se2SqEHsLb1TMHV2UfHgUNbhNZXmuV5zcie3XIYgLbtEWeQngsz
         9DAtKy0FZN/itwufa5GuGclk9SKcQKql84Szr4yYHwL/3yaUVHPIvxwVsox3w3Cgr3N/
         psCiYr5S/SL5QXBqvB3gMv0YBgbv65LxTNVHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xF5/XqhC95C9KSNipegVoItT8yYvzxsVDvSLIvoWnRA=;
        b=WPLzBvUpcZc/aZ7XD+ZSJPBVy1NLvqn+NJjY8Ot7FFGJigcLqYODrsxaGg3PePT8lc
         Faqgb9+NERaXTwCVYCZJ9FyYZClLWL2RVBh2KeDpEzopU0S3ONahzVPQjcYoZr+PGyoR
         Ea4x3QsJTFPRRPqh1+RK+0G3yKd56OWgPIYrWi3wemluVSHf4p/sXk+qrxPXUgwgVzm9
         t5+wDyAc976FBkeX/pM8xV0FCAqD/luG1mhLvsJWfqW8YFVjtxxnjdajgmCPcc7hT1fz
         A1lTp91Z07+rNwBd4AxcJDGC/9BbRpm63DLUPxRtJzE6n75h/8ejFnYji4EPAoRzave6
         vI/A==
X-Gm-Message-State: AOAM532IQEZ1Ful2wYS2/dEDwrakPXXa2RVCKoUEkiBjOmNqqAHj88z5
        fhS4YO2VdYT4nthj7lkELZ7qEw==
X-Google-Smtp-Source: ABdhPJxJDonV+BervUesKdhxSPdmmqHj1dFB5qEZje7MGhkYJC6b5/UQyCCUbW+H9TxRGZt0magG3w==
X-Received: by 2002:a63:8ec8:: with SMTP id k191mr12472113pge.154.1596820588188;
        Fri, 07 Aug 2020 10:16:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i7sm11565112pgh.58.2020.08.07.10.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 10:16:27 -0700 (PDT)
Date:   Fri, 7 Aug 2020 10:16:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Odd-sized kmem_cache_alloc and slub_debug=Z
Message-ID: <202008071010.69B612E@keescook>
References: <20200807160627.GA1420741@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807160627.GA1420741@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 06:06:27PM +0200, Marco Elver wrote:
> I found that the below debug-code using kmem_cache_alloc(), when using
> slub_debug=Z, results in the following crash:
> 
> 	general protection fault, probably for non-canonical address 0xcccccca41caea170: 0000 [#1] PREEMPT SMP PTI
> 	CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.8.0+ #1
> 	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> 	RIP: 0010:freelist_dereference mm/slub.c:272 [inline]
> 	RIP: 0010:get_freepointer mm/slub.c:278 [inline]

That really looks like more fun from my moving the freelist pointer... 

> 	R13: cccccca41caea160 R14: ffffe7c6a072ba80 R15: ffffa3a41c96d540

Except that it's all cccc at the start, which doesn't look like "data"
nor the hardened freelist obfuscation.

> 	FS:  0000000000000000(0000) GS:ffffa3a41fc00000(0000) knlGS:0000000000000000
> 	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> 	CR2: ffffa3a051c01000 CR3: 000000045140a001 CR4: 0000000000770ef0
> 	DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> 	DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 	PKRU: 00000000
> 	Call Trace:
> 	 ___slab_alloc+0x336/0x340 mm/slub.c:2690
> 	 __slab_alloc mm/slub.c:2714 [inline]
> 	 slab_alloc_node mm/slub.c:2788 [inline]
> 	 slab_alloc mm/slub.c:2832 [inline]
> 	 kmem_cache_alloc+0x135/0x200 mm/slub.c:2837
> 	 start_kernel+0x3d6/0x44e init/main.c:1049
> 	 secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:243
> 
> Any ideas what might be wrong?
> 
> This does not crash when redzones are not enabled.
> 
> Thanks,
> -- Marco
> 
> ------ >8 ------
> 
> diff --git a/init/main.c b/init/main.c
> index 15bd0efff3df..f4aa5bb3f2ec 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1041,6 +1041,16 @@ asmlinkage __visible void __init start_kernel(void)
>  	sfi_init_late();
>  	kcsan_init();
>  
> +	/* DEBUG CODE */
> +	{
> +		struct kmem_cache *c = kmem_cache_create("test", 21, 1, 0, NULL);
> +		char *buf;
> +		BUG_ON(!c);
> +		buf = kmem_cache_alloc(c, GFP_KERNEL);
> +		kmem_cache_free(c, buf);
> +		kmem_cache_destroy(c);
> +	}
> +
>  	/* Do the rest non-__init'ed, we're now alive */
>  	arch_call_rest_init();
>  

Which kernel version? Can you send your CONFIG too?

-- 
Kees Cook
