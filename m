Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C6C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 543032072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 13:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbgDMNBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 09:01:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:34510 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729674AbgDMNA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 09:00:58 -0400
IronPort-SDR: xUTCq/jWK495gEb4VBijUyTY8aPj2iJOJuQUdoN/HZ+34tKPaOuIVQ2HGt6FCOQshlqCZHKjhg
 cla48knxIq9g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 06:00:56 -0700
IronPort-SDR: VIcIbSHG1U1ojTmjU3Gns1TngHKd+Zk0VvGgpSvkGn3lxcOsCA0rU12GeAo6KBY0vFeGJwlHhI
 opTS5Yg1g8/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="276896082"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 13 Apr 2020 06:00:55 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Anchal Agarwal <anchalag@amazon.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm: swap: use fixed-size readahead during swapoff
References: <20200413111810.GA801367@xps-13>
Date:   Mon, 13 Apr 2020 21:00:34 +0800
In-Reply-To: <20200413111810.GA801367@xps-13> (Andrea Righi's message of "Mon,
        13 Apr 2020 13:18:10 +0200")
Message-ID: <87a73f7d71.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Righi <andrea.righi@canonical.com> writes:

[snip]

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ebed37bbf7a3..c71abc8df304 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -20,6 +20,7 @@
>  #include <linux/migrate.h>
>  #include <linux/vmalloc.h>
>  #include <linux/swap_slots.h>
> +#include <linux/oom.h>
>  #include <linux/huge_mm.h>
>  
>  #include <asm/pgtable.h>
> @@ -507,6 +508,14 @@ static unsigned long swapin_nr_pages(unsigned long offset)
>  	max_pages = 1 << READ_ONCE(page_cluster);
>  	if (max_pages <= 1)
>  		return 1;
> +	/*
> +	 * If current task is using too much memory or swapoff is running
> +	 * simply use the max readahead size. Since we likely want to load a
> +	 * lot of pages back into memory, using a fixed-size max readhaead can
> +	 * give better performance in this case.
> +	 */
> +	if (oom_task_origin(current))
> +		return max_pages;
>  
>  	hits = atomic_xchg(&swapin_readahead_hits, 0);
>  	pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,

Thinks this again.  If my understanding were correct, the accessing
pattern during swapoff is sequential, why swap readahead doesn't work?
If so, can you root cause that firstly?

Best Regards,
Huang, Ying
