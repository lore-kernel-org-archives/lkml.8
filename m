Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9E8206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 11:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWtc8D7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgEHLY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 07:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHLY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 07:24:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0C5C05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NxQcpIelyEQesB4Sm1aLDUu9bMqSHC3VF1eV1UfASUg=; b=qWtc8D7+0/9xVqdUbP7k/6JIm1
        RDfSxGbjCusifjScBAtY+UU5VWoPHynFdOxj/MsCdD5rnKX1Irb6qQJf7hiS2eeS/9R/Ihz5A3Lmz
        /13vLvj4Q5IMF/T+/Wsg1Lnd4bK7pB9BG7Om74roMn9fwuqLy496RA3Dp2PBFaCWBAZ2kUoO9KMd6
        Ih22+gY1uwLRktvcICmPI9Rt4D+MdaJY6Z4Y3DYnYtsdMc1d83bWq8eqXda8eGKZNrcsMym/hdjgg
        URCcDV+sJnTVaNeSYzvbBlB1uhsi+gXtV99DneCrhZtavmpUM7IwaFA25iYsm/oHfxEgrf3i2JLyf
        6o7hlM8A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX17Y-0006Gg-8m; Fri, 08 May 2020 11:24:48 +0000
Date:   Fri, 8 May 2020 04:24:48 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mm: adjust vm_committed_as_batch according to vm
 overcommit policy
Message-ID: <20200508112448.GP16070@bombadil.infradead.org>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-4-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588922717-63697-4-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 03:25:17PM +0800, Feng Tang wrote:
> +void mm_compute_batch(void)
>  {
>  	u64 memsized_batch;
>  	s32 nr = num_present_cpus();
>  	s32 batch = max_t(s32, nr*2, 32);
> -
> -	/* batch size set to 0.4% of (total memory/#cpus), or max int32 */
> -	memsized_batch = min_t(u64, (totalram_pages()/nr)/256, 0x7fffffff);
> +	unsigned long ram_pages = totalram_pages();
> +
> +	/*
> +	 * For policy of OVERCOMMIT_NEVER, set batch size to 0.4%
> +	 * of (total memory/#cpus), and lift it to 6.25% for other
> +	 * policies to easy the possible lock contention for percpu_counter
> +	 * vm_committed_as, while the max limit is INT_MAX
> +	 */
> +	if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> +		memsized_batch = min_t(u64, ram_pages/nr/256, INT_MAX);
> +	else
> +		memsized_batch = min_t(u64, ram_pages/nr/16, INT_MAX);
>  
>  	vm_committed_as_batch = max_t(s32, memsized_batch, batch);
> +	printk("vm_committed_as_batch = %d\n", vm_committed_as_batch);
>  }

You left a debugging printk in ...
