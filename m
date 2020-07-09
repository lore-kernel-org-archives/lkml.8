Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3D4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B722A20708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594277026;
	bh=pkJ6ezzMHfxcsVYH0+dDSAmIk4fMrsPM7woBspxuRlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EyUmf3kZ+0eR0h1yQDsklT5AFLaJnkWVvX2xnGEIGu5wT8OE9CPmShPL36TPSoWo5
	 73y31xu2hc3Qeqmrt9bSJyCy46JXB1uhrgzQapNQbYLBmgIDei8TMUmhZ36pmBn3ja
	 3He03lIl8+vRKK9w2PTVBSvX4nf80Ndc6G89CQ2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgGIGnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:43:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34274 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgGIGno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:43:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id g10so5511525wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YpegqAWT/bjJvlOq0I/Mi3KqTiz8SbdYlvSBIE+Da4=;
        b=evUaAwDk2p68yXwgsKflAoFnxGQKd3vxv5cij/bIVAGu8NcVzpYL7p6wKNGrcpwab6
         oibn4S/KU1wCmPieN/SnP/smXtjHQV83npuakAIsyGDkJxb0Yc+7sSGxgIiKYLIOF4+2
         X9RdxkD5ajM6y76oZta1pShsMFO08fIz9AhjrBVy8ESugl87z0xnwy3jg4RiXy7/au7S
         o1n/vS0o477VCKy5pWK7gkdSvCB4mnRTFLlIcHWs5XFzbHzb6F18BPlaYWJ1AjepwjsG
         aAw0D7Tvz/2Icp7A3NUTz7drhLgHl5Lh+SJTiUiOyaXwkMHC8z4fE/McQ3YIq7w9Tgdz
         598Q==
X-Gm-Message-State: AOAM532l0oosMgSlwAAGR9hpwC1MGfMHAqj2ZUX/9R3dTmfPTCQLGwRz
        XfMVwbw114huT5Qo4hEbiMU=
X-Google-Smtp-Source: ABdhPJzxBKAHGkSGOC291xS+3G8c/+KPFzP0bBQ5AGZ747jCbO0bB/0w22i1PatbGi7Y/wHwD4GDFw==
X-Received: by 2002:a05:600c:241:: with SMTP id 1mr12476277wmj.119.1594277021843;
        Wed, 08 Jul 2020 23:43:41 -0700 (PDT)
Received: from localhost (ip-37-188-179-51.eurotel.cz. [37.188.179.51])
        by smtp.gmail.com with ESMTPSA id z16sm3828164wrr.35.2020.07.08.23.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:43:41 -0700 (PDT)
Date:   Thu, 9 Jul 2020 08:43:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200709064340.GB19160@dhcp22.suse.cz>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
 <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
 <20200708071602.GB16543@js1304-desktop>
 <20200708074103.GD7271@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708074103.GD7271@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-07-20 09:41:06, Michal Hocko wrote:
> On Wed 08-07-20 16:16:02, Joonsoo Kim wrote:
> > On Tue, Jul 07, 2020 at 01:22:31PM +0200, Vlastimil Babka wrote:
> > > On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > > 
> > > > new_non_cma_page() in gup.c which try to allocate migration target page
> > > > requires to allocate the new page that is not on the CMA area.
> > > > new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
> > > > works well for THP page or normal page but not for hugetlb page.
> > > > 
> > > > hugetlb page allocation process consists of two steps.  First is dequeing
> > > > from the pool.  Second is, if there is no available page on the queue,
> > > > allocating from the page allocator.
> > > > 
> > > > new_non_cma_page() can control allocation from the page allocator by
> > > > specifying correct gfp flag.  However, dequeing cannot be controlled until
> > > > now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
> > > > since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
> > > > patch tries to fix this situation.
> > > > 
> > > > This patch makes the deque function on hugetlb CMA aware and skip CMA
> > > > pages if newly added skip_cma argument is passed as true.
> > > 
> > > Hmm, can't you instead change dequeue_huge_page_node_exact() to test the PF_
> > > flag and avoid adding bool skip_cma everywhere?
> > 
> > Okay! Please check following patch.
> > > 
> > > I think that's what Michal suggested [1] except he said "the code already does
> > > by memalloc_nocma_{save,restore} API". It needs extending a bit though, AFAICS.
> > > __gup_longterm_locked() indeed does the save/restore, but restore comes before
> > > check_and_migrate_cma_pages() and thus new_non_cma_page() is called, so an
> > > adjustment is needed there, but that's all?
> > > 
> > > Hm the adjustment should be also done because save/restore is done around
> > > __get_user_pages_locked(), but check_and_migrate_cma_pages() also calls
> > > __get_user_pages_locked(), and that call not being between nocma save and
> > > restore is thus also a correctness issue?
> > 
> > Simply, I call memalloc_nocma_{save,restore} in new_non_cma_page(). It
> > would not cause any problem.
> 
> I believe a proper fix is the following. The scope is really defined for
> FOLL_LONGTERM pins and pushing it inside check_and_migrate_cma_pages
> will solve the problem as well but it imho makes more sense to do it in
> the caller the same way we do for any others. 
> 
> Fixes: 9a4e9f3b2d73 ("mm: update get_user_pages_longterm to migrate pages allocated from CMA region")
> 
> I am not sure this is worth backporting to stable yet.

Should I post it as a separate patch do you plan to include this into your next version?

> 
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
> -- 
> Michal Hocko
> SUSE Labs

-- 
Michal Hocko
SUSE Labs
