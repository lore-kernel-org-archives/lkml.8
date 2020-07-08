Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A29C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BE42065F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGHJ1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:27:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgGHJ1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:27:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E831EAD4D;
        Wed,  8 Jul 2020 09:26:58 +0000 (UTC)
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
To:     Michal Hocko <mhocko@kernel.org>, Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
 <20200708071602.GB16543@js1304-desktop>
 <20200708074103.GD7271@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <8549326e-7485-dd6d-1fa1-a899228b9b2f@suse.cz>
Date:   Wed, 8 Jul 2020 11:26:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708074103.GD7271@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 9:41 AM, Michal Hocko wrote:
> On Wed 08-07-20 16:16:02, Joonsoo Kim wrote:
>> On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
>> 
>> Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
>> would not cause any problem.
> 
> I believe a proper fix is the following. The scope is really defined for
> FOLL_LONGTERM pins and pushing it inside check_and_migrate_cma_pages
> will solve the problem as well but it imho makes more sense to do it in
> the caller the same way we do for any others. 
> 
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")

Agreed.

> 
> I am not sure this is worth backporting to stable yet.

CC Aneesh.

Context: since check_and_migrate_cma_pages() calls __get_user_pages_locked(), it
should also be called under memalloc_nocma_save().

> diff --git a/mm/gup.c b/mm/gup.c
> index de9e36262ccb..75980dd5a2fc 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1794,7 +1794,6 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>  				     vmas_tmp, NULL, gup_flags);
>  
>  	if (gup_flags & FOLL_LONGTERM) {
> -		memalloc_nocma_restore(flags);
>  		if (rc < 0)
>  			goto out;
>  
> @@ -1802,11 +1801,13 @@ static long __gup_longterm_locked(struct task_struct *tsk,
>  			for (i = 0; i < rc; i++)
>  				put_page(pages[i]);
>  			rc = -EOPNOTSUPP;
> +			memalloc_nocma_restore(flags);
>  			goto out;
>  		}
>  
>  		rc = check_and_migrate_cma_pages(tsk, mm, start, rc, pages,
>  						 vmas_tmp, gup_flags);
> +		memalloc_nocma_restore(flags);
>  	}
>  
>  out:
> 

