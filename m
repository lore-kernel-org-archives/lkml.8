Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC20BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FE020738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgHaHbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:31:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:58980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaHbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:31:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15C6FAD5C;
        Mon, 31 Aug 2020 07:31:45 +0000 (UTC)
Date:   Mon, 31 Aug 2020 09:31:06 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     naoya.horiguchi@nec.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: Fix return wrong value when isolate
 page fail
Message-ID: <20200831073059.GA18753@linux>
References: <20200830081053.64981-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830081053.64981-1-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 04:10:53PM +0800, Muchun Song wrote:
> When we isolate page fail, we should not return 0, because we do not
> set page HWPoison on any page.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Thanks for spotting this

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory-failure.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 696505f56910..4eb3c42ffe35 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1850,6 +1850,7 @@ static int __soft_offline_page(struct page *page)
>  	} else {
>  		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
>  			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
> +		ret = -EBUSY;
>  	}
>  	return ret;
>  }
> -- 
> 2.11.0
> 
> 

-- 
Oscar Salvador
SUSE L3
