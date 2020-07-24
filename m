Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09441C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98622063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582872;
	bh=xRHdpcBPEE7I6FIgHmPFslMUqiBX/jnfJdPQDmTvwMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKDcLyNTMMYXWLuMlC0FzubsTOP+SW2LhySmBV+DMMQfXalfaf+QlBYqUf3LL0tXQ
	 fSewxWtkhkce1Yj89NoIlsyM0dVHIagEBXjsdOx5MYUEka+htjAID6H0CKDR9140uV
	 D00W/cxs7JHPmOLtUYujCKabR4JihgNMNFj7sKAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGXJ1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXJ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:27:51 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75D4C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:27:50 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id d18so6544239edv.6
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t/IL7SzOQEirppaKu0kppf6/HL3sTtCWEVRaMwuH7Qs=;
        b=oUMohlqXje6HNqC7d0qAdNhF8nSC/reJxnDqywwzHxBm5HAEsEzTejHNXn0iX5gQRb
         n1HvPdZyTzneiEaA9TsDkvYS/o0U2pbSU0XB3ZuDfNMw6ASlOsC2Cw7B0jIE4e+RDeAV
         avUEPrQwU1w+yPA++GrzwdzAmNFTRuLcpymkYuzCQBKgzhGZ7veENgCKNKKJiaKvz3wG
         6IhwOeSohyeDH6gkO5B792fOhiZerw57SxcbTg/jnFWtXSbk/CK9oMzZykP7sjQTFt+p
         01nShC1wyGxpPh4Y0OB8MO/hNW9aN7w3WPK/m6rQKfDrEUm5A9SWUGpf0jduqVJPCYEZ
         bhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t/IL7SzOQEirppaKu0kppf6/HL3sTtCWEVRaMwuH7Qs=;
        b=YuuEBCiEx/U8ipJtxER59YSy84P5OY9cJurYXeWPPz/tzd0pbZ8fcB9rOlXjjj8z1L
         k6/nI/I00iIAUKit2axxBsXHtvko4sxL5NJBUnIZxuxjV1eYaIhCMDGumtYnqrsbk5WY
         dtr5RsOHfsseQej9h5E3MvTbERX9lIqOWVVPSGnIWL6Hv8HyVnQ1/RVm/8IeShH059MF
         VyQ+5XDSKpKCTKDboNLEfnmPjo/5FFI17BwoOFUuwiqdW3kWgD53p71Guj59Y5pmT0S3
         s1DEhHxFCEIT3/t4JI9lUsDhHYYNEqUew9x1Qt4oc2TzT69PZrjFy5C5P6keO0rnAxgd
         H+yg==
X-Gm-Message-State: AOAM533DZwhfpBKiobbZ83lbKGr4gPYoaXDYQn9IJ7sohyqRJ+JNvpkJ
        Q9KjQF8EYuQNqsnJmgbo1RU=
X-Google-Smtp-Source: ABdhPJxSikPx3K43/0XJPgZZQCP8H3i2/aIVPS15slj4KVApInsWFzJo2Eyn5iCZrVt0AejTGDHcaA==
X-Received: by 2002:a05:6402:2350:: with SMTP id r16mr7748316eda.62.1595582869426;
        Fri, 24 Jul 2020 02:27:49 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id d25sm326397edr.78.2020.07.24.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 02:27:48 -0700 (PDT)
Date:   Fri, 24 Jul 2020 11:27:46 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jessica Yu <jeyu@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v5 5/6] kprobes: Use text_alloc() and text_free()
Message-ID: <20200724092746.GD517988@gmail.com>
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


* Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> wrote:

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

I've read the observations in the other threads, but this #ifdef 
jungle is silly, it's a de-facto open coded text_alloc() with a 
module_alloc() fallback...

Thanks,

	Ingo
