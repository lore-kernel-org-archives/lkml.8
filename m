Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A70EC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29917206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgCLPks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:40:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:57408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727059AbgCLPkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:40:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BB9FFAC5F;
        Thu, 12 Mar 2020 15:40:45 +0000 (UTC)
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <86dba6eb-9c08-695a-aafd-75260bff1767@suse.cz>
Date:   Thu, 12 Mar 2020 16:40:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312082248.GS23944@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/20 9:22 AM, Michal Hocko wrote:
> [Cc akpm]
> 
> So what about this?
> 
> From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 12 Mar 2020 09:04:35 +0100
> Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> 
> Jann has brought up a very interesting point [1]. While shared pages are
> excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> that way. This can lead to all sorts of hard to debug problems. E.g.
> performance problems outlined by Daniel [2]. There are runtime
> environments where there is a substantial memory shared among security
> domains via CoW memory and a easy to reclaim way of that memory, which
> MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> in for the parent process which might be more privileged or even open
> side channel attacks. The feasibility of the later is not really clear
> to me TBH but there is no real reason for exposure at this stage. It
> seems there is no real use case to depend on reclaiming CoW memory via
> madvise at this stage so it is much easier to simply disallow it and
> this is what this patch does. Put it simply MADV_{PAGEOUT,COLD} can
> operate only on the exclusively owned memory which is a straightforward
> semantic.
> 
> [1] http://lkml.kernel.org/r/CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com
> [2] http://lkml.kernel.org/r/CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com
> 

Reported-by: Jann Horn <jannh@google.com>
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")

Maybe CC stable?

> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/madvise.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 43b47d3fae02..4bb30ed6c8d2 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -335,12 +335,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  		}
>  
>  		page = pmd_page(orig_pmd);
> +
> +		/* Do not interfere with other mappings of this page */
> +		if (page_mapcount(page) != 1)
> +			goto huge_unlock;
> +
>  		if (next - addr != HPAGE_PMD_SIZE) {
>  			int err;
>  
> -			if (page_mapcount(page) != 1)
> -				goto huge_unlock;
> -
>  			get_page(page);
>  			spin_unlock(ptl);
>  			lock_page(page);
> @@ -426,6 +428,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>  			continue;
>  		}
>  
> +		/* Do not interfere with other mappings of this page */
> +		if (page_mapcount(page) != 1)
> +			continue;
> +
>  		VM_BUG_ON_PAGE(PageTransCompound(page), page);
>  
>  		if (pte_young(ptent)) {
> 

