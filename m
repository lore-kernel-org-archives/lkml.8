Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70332C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C09D2051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iP7OpWY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgEAMWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgEAMWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:22:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=MhFhYw6pM9dJG//E1anenCrCOzgRlPNRTV2E13gtbCM=; b=iP7OpWY8G0QNFycCHZo3TxaaL5
        W3pZ0Z3wnygKzNhIOsXaDmaOcEIBCyB2ZgunksUXJoz6dpqEoMCgUfEHaYhv5vqbfQGObs1B5gvLI
        uY7E69BdlvSB582PmRj5pZevMxkOfcQ6jZhxSBnP0S0QnDAJPP0IAuYsN/ROB9j3Y7CQ4aCnfheYq
        7MmE584/Xyb3z6W8vwlmYmgTbSFcqg6X5HwDaWZ0qES+VUQ6YxkLfvu5mDMuB7ON3kCDSv2G5YFFG
        DyzWDVaezMecPmGKuJbnq/uNn6AoaTb0wI6cM6LcuGds9oqsBFnBBTzll/pHuHX87tJZJshAwuHbW
        7UAAt+8w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUgn-0000q8-S9; Fri, 01 May 2020 12:22:45 +0000
Date:   Fri, 1 May 2020 05:22:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 04/10] power: separate PageHighMem() and
 PageHighMemZone() use case
Message-ID: <20200501122245.GA21897@infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588130803-20527-5-git-send-email-iamjoonsoo.kim@lge.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:26:37PM +0900, js1304@gmail.com wrote:
> index 6598001..be759a6 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1227,7 +1227,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
>  	if (!page || page_zone(page) != zone)
>  		return NULL;
>  
> -	BUG_ON(!PageHighMem(page));
> +	BUG_ON(!PageHighMemZone(page));

The above check already checks for the highmem zone.  So if we want
to keep the BUG_ON it needs stay PageHighMem to make sense.  That being
said I'd rather remove it entirelẏ.

> -	BUG_ON(PageHighMem(page));
> +	BUG_ON(PageHighMemZone(page));

Same here.

> @@ -1529,7 +1529,7 @@ static unsigned long preallocate_image_pages(unsigned long nr_pages, gfp_t mask)
>  		if (!page)
>  			break;
>  		memory_bm_set_bit(&copy_bm, page_to_pfn(page));
> -		if (PageHighMem(page))
> +		if (PageHighMemZone(page))
>  			alloc_highmem++;
>  		else
>  			alloc_normal++;

I don't fully understand the log here.  Can Pavel or Rafael clarify
why swsupst would care about the exact zone?
