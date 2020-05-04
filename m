Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184DFC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC52E20721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588622220;
	bh=oHMQloXxyrl24y13J91piTNe8Aacl9gxAnSKSNGhPtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zH2RwEiu04rHedPWOD+0j7LLyXJ9wKZuo5RsAX3J5oy8uoR+dKXDzqXstdQZWOD74
	 OsSMsP1ZB8TnJ9xf6+MIA8R21ybCOvIdSaZ6tMdHrAOvKh+4UhVeqyi7SdfpSNBXyf
	 CIDfU/yBhOi3TQ+vD6W06JFeRhD+kQIZ/gzBQ1tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEDT47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:56:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgEDT46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:56:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985F1206B8;
        Mon,  4 May 2020 19:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588622216;
        bh=oHMQloXxyrl24y13J91piTNe8Aacl9gxAnSKSNGhPtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tg5QFlhwm+Z9uA105367UbiGVChmwB2HiWa2NADvkVdnw/b71CX4o1gElaoC/TyIw
         nugCDU17zZY/VmH1jBbg1EzV3oxfcIoPNDEbGO1fEkGIBCqFvtp74A9MvHmt0OtggL
         jUAmIzeKzl0bIAklRuWtLx4q4DaYbqTp0aSUqIxs=
Date:   Mon, 4 May 2020 12:56:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
Message-Id: <20200504125656.e3d04b350c807aba8a2a7271@linux-foundation.org>
In-Reply-To: <158860845968.33385.4165926113074799048.stgit@buzz>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 May 2020 19:07:39 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> To get exact count of free and used objects slub have to scan list of
> partial slabs. This may take at long time. Scanning holds spinlock and
> blocks allocations which move partial slabs to per-cpu lists and back.
> 
> Example found in the wild:
> 
> # cat /sys/kernel/slab/dentry/partial
> 14478538 N0=7329569 N1=7148969
> # time cat /sys/kernel/slab/dentry/objects
> 286225471 N0=136967768 N1=149257703
> 
> real	0m1.722s
> user	0m0.001s
> sys	0m1.721s

I assume this could trigger the softlockup detector or even NMI
watchdog in some situations?

> The same problem in slab was addressed in commit f728b0a5d72a ("mm, slab:
> faster active and free stats") by adding more kmem cache statistics.
> For slub same approach requires atomic op on fast path when object frees.
> 
> Let's simply limit count of scanned slabs and print warning.
> Limit set in /sys/module/slub/parameters/max_partial_to_count.
> Default is 10000 which should be enough for most sane cases.
> 
> Return linear approximation if list of partials is longer than limit.
> Nobody should notice difference.

That's a pretty sad "solution" :(

But I guess it's better than nothing at all, unless there are
alternative ideas?

> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2407,16 +2407,29 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
> +
> +static unsigned long max_partial_to_count __read_mostly = 10000;
> +module_param(max_partial_to_count, ulong, 0644);
> +
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct page *))
>  {
> +	unsigned long counted = 0;
>  	unsigned long flags;
>  	unsigned long x = 0;
>  	struct page *page;
>  
>  	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry(page, &n->partial, slab_list)
> +	list_for_each_entry(page, &n->partial, slab_list) {
>  		x += get_count(page);
> +
> +		if (++counted > max_partial_to_count) {
> +			pr_warn_once("SLUB: too much partial slabs to count all objects, increase max_partial_to_count.\n");
> +			/* Approximate total count of objects */
> +			x = mult_frac(x, n->nr_partial, counted);
> +			break;
> +		}
> +	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }
