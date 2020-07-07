Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3042DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13667206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594148109;
	bh=SJpLlSM/H2uScaO2WABsU0Id0l1NUW2mH0wRuUAigu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F9G/V9QSFYMVsuCk/6xjuDeAi6oeeg91QKO6JkNMFe3jsr763H1/DKkEEWdZthqqt
	 iChMDO9hl51DQS5FgnDj1SOIuF/NIIOR9BXfp1TeVHYyUfjQdRvihojP0RPtIip5NG
	 +Rp9+OnV1TDJYxXW9rWYPAMT05LaIDRbSJFbqa3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgGGSzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:55:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37362 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGSzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:55:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id o2so202294wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxUeGdy8xixT3qR6TxhpxqIaXyQxpW6SR0YnzaRkS0E=;
        b=cE059tBp6tP/biRonC9H6F7xK7adZMYTvssfLnXW1r0zVF3Z9W2sQZy+pOjvq6FSoC
         ETx5YyXbb7ad4skddCvaHz2qImyhfjBLEgiqekZnMNnurD2QLzzCu2mTbEnfqbv08j/1
         RN1ofgfjgoDBX4EHKSZSY8HY1izgYqAox7F/9kb7JHZOSYxcpKXMki4PLKjyA4wSgB2o
         /fIBO0RnmuWZN0r0GqrKuyhL1oL+uxhrlYT4z99DfwN+z76J5XUzZfA0klScCCK7kHtz
         9OhMYtSq3vbmrYE0z/OvZoQ22gOclHGhhyjl411l4KwD0YJR2smA+X57F9nHm7P9k04B
         QFbA==
X-Gm-Message-State: AOAM531efZZ94ViLyeelNM4GoDEVMcAjujZ6MEFwVu7VLQSymTvvtMBN
        NnMLKL6ontlnhRFQPai9ljo=
X-Google-Smtp-Source: ABdhPJzNRNscumqL6aBLKIQmg6e72dca5LxifBnolOifdcCPhbu8MufNepFv48LoRVlN3rBwq8rLxw==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr5683217wmk.143.1594148105262;
        Tue, 07 Jul 2020 11:55:05 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id b62sm2319785wmh.38.2020.07.07.11.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 11:55:04 -0700 (PDT)
Date:   Tue, 7 Jul 2020 20:55:03 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 10/11] mm/memory-failure: remove a wrapper for
 alloc_migration_target()
Message-ID: <20200707185503.GY5913@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-11-git-send-email-iamjoonsoo.kim@lge.com>
 <20200707114829.GL5913@dhcp22.suse.cz>
 <b54a081a-5748-ce30-75d7-42aab73046ef@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b54a081a-5748-ce30-75d7-42aab73046ef@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-07-20 17:03:50, Vlastimil Babka wrote:
> On 7/7/20 1:48 PM, Michal Hocko wrote:
> > On Tue 07-07-20 16:44:48, Joonsoo Kim wrote:
> >> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >> 
> >> There is a well-defined standard migration target callback. Use it
> >> directly.
> >> 
> >> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >> ---
> >>  mm/memory-failure.c | 18 ++++++------------
> >>  1 file changed, 6 insertions(+), 12 deletions(-)
> >> 
> >> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> >> index 609d42b6..3b89804 100644
> >> --- a/mm/memory-failure.c
> >> +++ b/mm/memory-failure.c
> >> @@ -1677,16 +1677,6 @@ int unpoison_memory(unsigned long pfn)
> >>  }
> >>  EXPORT_SYMBOL(unpoison_memory);
> >>  
> >> -static struct page *new_page(struct page *p, unsigned long private)
> >> -{
> >> -	struct migration_target_control mtc = {
> >> -		.nid = page_to_nid(p),
> >> -		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> >> -	};
> >> -
> >> -	return alloc_migration_target(p, (unsigned long)&mtc);
> >> -}
> >> -
> >>  /*
> >>   * Safely get reference count of an arbitrary page.
> >>   * Returns 0 for a free page, -EIO for a zero refcount page
> >> @@ -1793,6 +1783,10 @@ static int __soft_offline_page(struct page *page)
> >>  	const char *msg_page[] = {"page", "hugepage"};
> >>  	bool huge = PageHuge(page);
> >>  	LIST_HEAD(pagelist);
> >> +	struct migration_target_control mtc = {
> >> +		.nid = NUMA_NO_NODE,
> >> +		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
> >> +	};
> > 
> > Is NUMA_NO_NODE really intended here? The original code has preferred to
> > stay on the same node.
> 
> The alloc_migration_target() interprets NUMA_NO_NODE as a request to call
> page_to_nid(), so we don't need these thin wrappers that do just that. I have
> suggested this in v3 review and it's mentioned in 06/11.

Ohh, right. I just lost that piece of information on the way. It
wouldn't hurt to keep page_to_nid here for readability though.
-- 
Michal Hocko
SUSE Labs
