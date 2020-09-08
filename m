Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D022C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B724221F1
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 12:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgIHL7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgIHLxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 07:53:24 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB9932067C;
        Tue,  8 Sep 2020 11:53:19 +0000 (UTC)
Date:   Tue, 8 Sep 2020 12:53:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Marco Elver <elver@google.com>
Cc:     glider@google.com, akpm@linux-foundation.org, cl@linux.com,
        rientjes@google.com, iamjoonsoo.kim@lge.com, mark.rutland@arm.com,
        penberg@kernel.org, hpa@zytor.com, paulmck@kernel.org,
        andreyknvl@google.com, aryabinin@virtuozzo.com, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, dvyukov@google.com,
        edumazet@google.com, gregkh@linuxfoundation.org, mingo@redhat.com,
        jannh@google.com, corbet@lwn.net, keescook@chromium.org,
        peterz@infradead.org, cai@lca.pw, tglx@linutronix.de,
        will@kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH RFC 07/10] kfence, kmemleak: make KFENCE compatible with
 KMEMLEAK
Message-ID: <20200908115316.GD25591@gaia>
References: <20200907134055.2878499-1-elver@google.com>
 <20200907134055.2878499-8-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907134055.2878499-8-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 03:40:52PM +0200, Marco Elver wrote:
> From: Alexander Potapenko <glider@google.com>
> 
> Add compatibility with KMEMLEAK, by making KMEMLEAK aware of the KFENCE
> memory pool. This allows building debug kernels with both enabled, which
> also helped in debugging KFENCE.
> 
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>
> ---
>  mm/kmemleak.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 5e252d91eb14..2809c25c0a88 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -97,6 +97,7 @@
>  #include <linux/atomic.h>
>  
>  #include <linux/kasan.h>
> +#include <linux/kfence.h>
>  #include <linux/kmemleak.h>
>  #include <linux/memory_hotplug.h>
>  
> @@ -1946,8 +1947,18 @@ void __init kmemleak_init(void)
>  	/* register the data/bss sections */
>  	create_object((unsigned long)_sdata, _edata - _sdata,
>  		      KMEMLEAK_GREY, GFP_ATOMIC);
> +#if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL)
> +	/* KFENCE objects are located in .bss, which may confuse kmemleak. Skip them. */
> +	create_object((unsigned long)__bss_start, __kfence_pool - __bss_start,
> +		      KMEMLEAK_GREY, GFP_ATOMIC);
> +	create_object((unsigned long)__kfence_pool + KFENCE_POOL_SIZE,
> +		      __bss_stop - (__kfence_pool + KFENCE_POOL_SIZE),
> +		      KMEMLEAK_GREY, GFP_ATOMIC);
> +#else
>  	create_object((unsigned long)__bss_start, __bss_stop - __bss_start,
>  		      KMEMLEAK_GREY, GFP_ATOMIC);
> +#endif

Could you instead do:

#if defined(CONFIG_KFENCE) && defined(CONFIG_HAVE_ARCH_KFENCE_STATIC_POOL)
	delete_object_part((unsigned long)__kfence_pool, KFENCE_POOL_SIZE);
#endif

-- 
Catalin
