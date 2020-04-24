Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF9CC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3199420CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xCajfsFC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDXDBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDXDBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:01:20 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8649C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:01:20 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id di6so4018255qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 20:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyzduwWV8InceUnIl0vidH/X3bbDtm0JxJsBZQHUEsg=;
        b=xCajfsFC29zFs0ldyM1nenfzOzJDtFNYbMcgKb1rYjfjosHZZWeWeXnPI+8bxZ2ntm
         XHXSecOpa9F53pVydA37qwBNQQz3IM8/taC9P6tAXhUnpQt/iT4a01qo0tF1UzjpM1pl
         9weajk44I9MEZiCL03RFgeD8nMd6M1w7/fZJVwQ9w0ADRRNU6IYndhE3AF/qOVSxKDnx
         voK4SCOCZVyquDhFXfze9UC5Qoftazh/65yyjBEJeOa43yxDbu4gxT1oLoaN8bh/AsTH
         9tc/JQBlf043Zpg9/w1+sY2RY/7r2b4k7AZyRfSTf+lRVIRzyrXJ5E4L4HDmZr5V+x+J
         G9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyzduwWV8InceUnIl0vidH/X3bbDtm0JxJsBZQHUEsg=;
        b=E3/TJ0WJf73/Ggw9rBUTgiP+TPIgThsGwIiDT4Bxt9qonnZ3kmyP+7cL6H+1X23yQp
         dWIIX92NbzdsMBSu+PJfbKSEy4AIxvk1IH3pTTWoMtSQMZvwWxDDP5dOMU45LhJAi5Wx
         I/LUhw2yCqBaarPR4bF7L5tKEmAZp4E+zru93IMJkadkuJZgUUDdyrhQkHXUyFYwbjS9
         UFrM8Wtryn0v5h2S3i6HF3Ys2Lnptej6DiPDJnEfEhRS5InCHBk19CfDFzVu3ZWCBQQ3
         W5RUP1Bbvl5gDJNBS9kSKPHWzP2MBZXRM2hHQtdpN0DnZZcgjAxItMpG1g1ZpYEGvOgc
         9nxg==
X-Gm-Message-State: AGi0PuYm+LSxrX3Vm9ZVtU3ZfxfKegCU27NVJBQ7W12a8MEhaqQBkFXE
        cFMKfTMJWKcb3BXxeHlPKysSZA==
X-Google-Smtp-Source: APiQypLJSGpBwzleZnV3t7v1nCIoNAWsHqMVrq1I/vhX91pyUFLlxLheGBhyb3rY17tsM867rwR2zw==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr7437268qvw.64.1587697279787;
        Thu, 23 Apr 2020 20:01:19 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id g187sm2808459qkf.115.2020.04.23.20.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 20:01:19 -0700 (PDT)
Date:   Thu, 23 Apr 2020 23:01:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 15/18] mm: memcontrol: make swap tracking an integral
 part of memory control
Message-ID: <20200424030117.GC464082@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-16-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420221126.341272-16-hannes@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:11:23PM -0400, Johannes Weiner wrote:
> @@ -6884,9 +6876,6 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  
> -	if (!do_memsw_account())
> -		return;
> -
>  	memcg = page->mem_cgroup;
>  
>  	/* Readahead page, never charged */

I messed up here.

mem_cgroup_swapout() must not run on cgroup2, because cgroup2 uses
mem_cgroup_try_charge_swap() instead. Both record a swap entry and
running them both will trigger a VM_BUG_ON() on an existing record.

I'm actually somewhat baffled why this didn't trigger in my
MADV_PAGEOUT -> MADV_WILLNEED swap test. memory.max driven swapout
triggered it right away.

!do_memsw_account() needs to be !cgroup_subsys_on_dfl(memory_cgrp_subsys)

> @@ -6913,7 +6902,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	if (!mem_cgroup_is_root(memcg))
>  		page_counter_uncharge(&memcg->memory, nr_entries);
>  
> -	if (memcg != swap_memcg) {
> +	if (do_memsw_account() && memcg != swap_memcg) {
>  		if (!mem_cgroup_is_root(swap_memcg))
>  			page_counter_charge(&swap_memcg->memsw, nr_entries);
>  		page_counter_uncharge(&memcg->memsw, nr_entries);

And this can be !cgroup_memory_noswap instead. It'll do the same
thing, but will be clearer.

I'll have it fixed in version 2.

