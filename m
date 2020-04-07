Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEAFC2BB55
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A4D2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 18:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586283353;
	bh=XXV7u8rrBxz2Q54XgdqfvhwO81iPh0PeMlATFyQ4iBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p0lOwOSTeISuap9q79nVe5vQZ4Pc0ySYdUAHJ1K99bupS0rvgWXypCWPwqXn8QxDJ
	 HPBG5yDeDDHAVmofOudgnfvy59x1rqNYwP43QWIdLSCnPpZqJG35sGmSdas/tntpxS
	 cVkfncGT5UjaKIX1TNd26H6tW9TYAEu0uPyBUZas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDGSPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:15:52 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46875 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGSPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 14:15:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id y44so1425344wrd.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 11:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=30f4EXGKl1YJhrB5sA5rsC6Ua7MRsvS6emxG/UIc+z4=;
        b=IJgJ4V9zpRrmvN8xLIKb4QnOpZU1QZHYzo1s2v3BkpMgVDeFqC4V/ln++5CIKjDqA2
         KLB5YSGtA0BTN3BIc8RpKlS26sfn9rXQfIDUZXCPsBZBDbF5l7bSMh7BY4/lgnG9JDCx
         hGvzSj0UjIXJua9YtYnYOwi5VlMzyBwUDxoFh3hykCtWTMwW0LQwOI7z+c3BPKaW60Pd
         jWPAeledzXkosks0FHnvxr2k88siVaOeYIvXqYmBZkysEb7BuyE5av5Lj5V3w5Dy7wlV
         dNJqrLOTProYt3vO/GG7NpiiE4tXF70ytwOjts16+s83m7oD3iNrYWpMZem9fRxJJA0u
         wIJQ==
X-Gm-Message-State: AGi0Pub8ZUsxbIZ5f0VWpBHtNSL4QpzRNyjcqkSdJeVaghpryB+VzXHb
        GdSHI5tDXUnJCSQwBEdixpA1IBTt
X-Google-Smtp-Source: APiQypITHu4vN/S/wf/3welZh/HKE2B4GgI/qWph0fV/wXNSGjyHrTkeAOlxepCrV64wBXvSikvSFQ==
X-Received: by 2002:adf:90ea:: with SMTP id i97mr3924822wri.123.1586283349499;
        Tue, 07 Apr 2020 11:15:49 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id g2sm31444354wrs.42.2020.04.07.11.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 11:15:48 -0700 (PDT)
Date:   Tue, 7 Apr 2020 20:15:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Aslan Bakirov <aslan@fb.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andreas Schaufler <andreas.schaufler@gmx.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Joonsoo Kim <js1304@gmail.com>
Subject: Re: [PATCH v5 2/2] mm: hugetlb: optionally allocate gigantic
 hugepages using cma
Message-ID: <20200407181546.GV18914@dhcp22.suse.cz>
References: <20200407163840.92263-1-guro@fb.com>
 <20200407163840.92263-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407163840.92263-3-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-04-20 09:38:40, Roman Gushchin wrote:
> Commit 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at
> runtime") has added the run-time allocation of gigantic pages.  However it
> actually works only at early stages of the system loading, when the
> majority of memory is free.  After some time the memory gets fragmented by
> non-movable pages, so the chances to find a contiguous 1 GB block are
> getting close to zero.  Even dropping caches manually doesn't help a lot.
> 
> At large scale rebooting servers in order to allocate gigantic hugepages
> is quite expensive and complex.  At the same time keeping some constant
> percentage of memory in reserved hugepages even if the workload isn't
> using it is a big waste: not all workloads can benefit from using 1 GB
> pages.
> 
> The following solution can solve the problem:
> 1) On boot time a dedicated cma area* is reserved. The size is passed
>    as a kernel argument.
> 2) Run-time allocations of gigantic hugepages are performed using the
>    cma allocator and the dedicated cma area
> 
> In this case gigantic hugepages can be allocated successfully with a high
> probability, however the memory isn't completely wasted if nobody is using
> 1GB hugepages: it can be used for pagecache, anon memory, THPs, etc.
> 
> * On a multi-node machine a per-node cma area is allocated on each node.
>   Following gigantic hugetlb allocation are using the first available
>   numa node if the mask isn't specified by a user.
> 
> Usage:
> 1) configure the kernel to allocate a cma area for hugetlb allocations:
>    pass hugetlb_cma=10G as a kernel argument
> 
> 2) allocate hugetlb pages as usual, e.g.
>    echo 10 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> 
> If the option isn't enabled or the allocation of the cma area failed,
> the current behavior of the system is preserved.
> 
> x86 and arm-64 are covered by this patch, other architectures can be
> trivially added later.
> 
> The patch contains clean-ups and fixes proposed and implemented by
> Aslan Bakirov and Randy Dunlap. It also contains ideas and suggestions
> proposed by Rik van Riel, Michal Hocko and Mike Kravetz. Thanks!
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Tested-by: Andreas Schaufler <andreas.schaufler@gmx.de>
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Michal Hocko <mhocko@kernel.org>
> Cc: Aslan Bakirov <aslan@fb.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Joonsoo Kim <js1304@gmail.com>

Thanks a lot for addressing my review feedback!
-- 
Michal Hocko
SUSE Labs
