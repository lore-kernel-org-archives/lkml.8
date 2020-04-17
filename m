Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4A6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEC8E20857
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+FhVO5m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgDQPCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgDQPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:02:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B342C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:02:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g74so2621913qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n7rH1ETq2xObwbir2XTShr8sCd3LzS3KQlYtx7gM1SI=;
        b=i+FhVO5m5ZLdW6FGGCbXYlX49XjYZr/JekJ9PAPw1zwa8gD6SPam/koSq5XTkzezaE
         TvWj2RONL20M0ZQ4FzS5kyB5L6XzlppZd7Mhd1VGcO3bTPRT4O4XdZzCbOdLYJBCNEOG
         gugHqi3kSo8BS6V8X/Q7BbNRboS0OmxJInO8ekFLdGbl1XbBrtXcyaoIsP963JUrwhJK
         cOTHS/OR3zjxx0AttW77aYK0D3sG8DLzTzRJwIJ7q11LADlBWyCrO/MDfSuCPW0H0MdA
         TL8F6ydWeDgbHGz/4mIDOwb3Kyc02+Smn9zd2j5q1DO9l6rqcS+e/f74FtmyHZgVfOEp
         c9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n7rH1ETq2xObwbir2XTShr8sCd3LzS3KQlYtx7gM1SI=;
        b=mYdofLvCbUhlCJpOMqtDTHnQKCyspQFRHizcqv37ws9micV0Qq16MPGVniR1HLTX7y
         sdlSXS74mwwHRiD4k3ofnixKYU8bF8NWeGBtYzCW/RXLsjjKnFk5tY0JHc2/8eaDBqb8
         Fv6u5G2hrGoF+JFFddgubQZSzDBiNnfAqXXVE8gOEdkNvyooHlgaWR9Qy4uUaBWXhXh/
         hXlAIVNGFnxrPcbjIQ/UMFCaZSXF4DZ4PfksORwr4fgqTipF+BhOtN/j2hAth1qQ/av5
         gcWMFJHtBPlqOS2D0mpFUmEZCfMpj0AjPQ/OD6AKNcY3/zAF/B7d1KoSbniSvC+mc2Jd
         VM+w==
X-Gm-Message-State: AGi0PuYyxKMU11ZVVOR/tGtyCqMk0+wLuoIcNMnMuPs8KIEx5vu9q0JT
        QVmbywYTEaXnOXAwudpjdP4=
X-Google-Smtp-Source: APiQypIoOoeasR+VnZVMe5E6tAUIi/atjU4RF1db/HOklR3x9AWl7Gs+32zx1K/iztWVKm4618Qpdg==
X-Received: by 2002:a37:6f81:: with SMTP id k123mr3575067qkc.432.1587135764083;
        Fri, 17 Apr 2020 08:02:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z2sm4870709qkc.28.2020.04.17.08.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:02:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFD5C409A3; Fri, 17 Apr 2020 12:02:40 -0300 (-03)
Date:   Fri, 17 Apr 2020 12:02:40 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V4 10/17] perf tools: Save previous sample for LBR
 stitching approach
Message-ID: <20200417150240.GC17973@kernel.org>
References: <20200319202517.23423-1-kan.liang@linux.intel.com>
 <20200319202517.23423-11-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319202517.23423-11-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 19, 2020 at 01:25:10PM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> To retrieve the overwritten LBRs from previous sample for LBR stitching
> approach, perf has to save the previous sample.
> 
> Only allocate the struct lbr_stitch once, when LBR stitching approach
> is enabled and kernel supports hw_idx.

Applied + this one on top:

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 59778f5aec2a..a54ca09a1d00 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2297,7 +2297,7 @@ static bool alloc_lbr_stitch(struct thread *thread)
 	if (thread->lbr_stitch)
 		return true;
 
-	thread->lbr_stitch = calloc(1, sizeof(struct lbr_stitch));
+	thread->lbr_stitch = zalloc(sizeof(*thread->lbr_stitch));
 	if (!thread->lbr_stitch)
 		goto err;
 
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index f65a84a25f93..34eb61cee6a4 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -5,6 +5,7 @@
 #include <linux/refcount.h>
 #include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/zalloc.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/types.h>
@@ -153,7 +154,7 @@ static inline bool thread__is_filtered(struct thread *thread)
 
 static inline void thread__free_stitch_list(struct thread *thread)
 {
-	free(thread->lbr_stitch);
+	zfree(&thread->lbr_stitch);
 }
 
 #endif	/* __PERF_THREAD_H */
 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/machine.c | 23 +++++++++++++++++++++++
>  tools/perf/util/thread.c  |  1 +
>  tools/perf/util/thread.h  | 11 +++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index f1661dd3ca69..d91e11bfc8ca 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2261,6 +2261,21 @@ static int lbr_callchain_add_lbr_ip(struct thread *thread,
>  	return 0;
>  }
>  
> +static bool alloc_lbr_stitch(struct thread *thread)
> +{
> +	if (thread->lbr_stitch)
> +		return true;
> +
> +	thread->lbr_stitch = calloc(1, sizeof(struct lbr_stitch));
> +	if (!thread->lbr_stitch)
> +		goto err;
> +
> +err:
> +	pr_warning("Failed to allocate space for stitched LBRs. Disable LBR stitch\n");
> +	thread->lbr_stitch_enable = false;
> +	return false;
> +}
> +
>  /*
>   * Recolve LBR callstack chain sample
>   * Return:
> @@ -2277,6 +2292,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>  {
>  	struct ip_callchain *chain = sample->callchain;
>  	int chain_nr = min(max_stack, (int)chain->nr), i;
> +	struct lbr_stitch *lbr_stitch;
>  	u64 branch_from = 0;
>  	int err;
>  
> @@ -2289,6 +2305,13 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
>  	if (i == chain_nr)
>  		return 0;
>  
> +	if (thread->lbr_stitch_enable && !sample->no_hw_idx &&
> +	    alloc_lbr_stitch(thread)) {
> +		lbr_stitch = thread->lbr_stitch;
> +
> +		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
> +	}
> +
>  	if (callchain_param.order == ORDER_CALLEE) {
>  		/* Add kernel ip */
>  		err = lbr_callchain_add_kernel_ip(thread, cursor, sample,
> diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> index 1f080db23615..8d0da260c84c 100644
> --- a/tools/perf/util/thread.c
> +++ b/tools/perf/util/thread.c
> @@ -111,6 +111,7 @@ void thread__delete(struct thread *thread)
>  
>  	exit_rwsem(&thread->namespaces_lock);
>  	exit_rwsem(&thread->comm_lock);
> +	thread__free_stitch_list(thread);
>  	free(thread);
>  }
>  
> diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> index 95294050cff2..f65a84a25f93 100644
> --- a/tools/perf/util/thread.h
> +++ b/tools/perf/util/thread.h
> @@ -13,6 +13,7 @@
>  #include <strlist.h>
>  #include <intlist.h>
>  #include "rwsem.h"
> +#include "event.h"
>  
>  struct addr_location;
>  struct map;
> @@ -20,6 +21,10 @@ struct perf_record_namespaces;
>  struct thread_stack;
>  struct unwind_libunwind_ops;
>  
> +struct lbr_stitch {
> +	struct perf_sample		prev_sample;
> +};
> +
>  struct thread {
>  	union {
>  		struct rb_node	 rb_node;
> @@ -49,6 +54,7 @@ struct thread {
>  
>  	/* LBR call stack stitch */
>  	bool			lbr_stitch_enable;
> +	struct lbr_stitch	*lbr_stitch;
>  };
>  
>  struct machine;
> @@ -145,4 +151,9 @@ static inline bool thread__is_filtered(struct thread *thread)
>  	return false;
>  }
>  
> +static inline void thread__free_stitch_list(struct thread *thread)
> +{
> +	free(thread->lbr_stitch);
> +}
> +
>  #endif	/* __PERF_THREAD_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
