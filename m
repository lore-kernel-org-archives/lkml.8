Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85256C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B1B3206EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCJnvNlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgIDDYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgIDDYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:24:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BEAC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 20:24:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id m1so5130090ilj.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 20:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HT921qLwDCWJ1WOt3lUzk7zXUgkMbJX02GM0/k+/ko4=;
        b=wCJnvNlFuxsYBicG2IKm++NcKj33pxbdyD56ZVumkDIZttm7QLnglaaWa0hhHJ4cZL
         zbP2z3orYySWBYG2pHFzTCAwlpk2sAi48Z5nodjQuVNcwRL4yghqJBpUc3KePTx/6kKy
         UwmjKXECIddpzU0HlPSuM/E1saC6gPRijgLbrrL89WJzw3CbkExRREipKNpwz9TLF4eH
         FMDWrFUYHWrqxcTDfzcv1DEg/DVeEP+PiVpQUpJh9KfodmubgKfcArOVhUWAkBPLnAid
         ClRTD0KWIJ9Eeortg9ZE93vFtz6P3ZjMcben4W/L4bJqCj1FTq6BIB6s/AM+PGsko5BV
         nOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HT921qLwDCWJ1WOt3lUzk7zXUgkMbJX02GM0/k+/ko4=;
        b=G7pES++yYt/TF7c4MgWX3/px/sLtOpT0fW/JXklZ1SaoA/GM35fs/ScdSQnA9f15iv
         ipP0Axs310vXO6Yc3QxA9pWWmnVopiTSoSjZOBqm/358aJ/ImUdr54wIRa3r3A7LzDZ1
         H1fW9kwZq5bjbF5qjoRMBXCWSnZbnR35IQQClwq1gtpVVeMDDEdVK6l/Q1keK4IrD/5h
         fTNY7mkkUP3KPOLMoEDY3OtVYw9lM6X7gYUNagpMYuNaz/U9dScPsopE8AI6B/zq7I+n
         Qy9C2tO/Fza9LDdx3lW1Pw8A3yvqss+AfzDYVvNGwrtx1hXVn3YnOhd+1IWZIH5DndZW
         wcXg==
X-Gm-Message-State: AOAM530WbeLQVMQwmBmoqGpTNlg4fCkuHE8XNdLHlK42BYCF/gT3r4Rz
        nMdWDkVmXWco4mo1a6WY3i6HxtkajRwgcA==
X-Google-Smtp-Source: ABdhPJx8zg+xIvj46lxu/GJT4AYzlWPR60Z7uZsdJhkbuo/CnbxPcZ5jQ2EYnkLbM/zey8iEvSiLIg==
X-Received: by 2002:a92:9954:: with SMTP id p81mr6550098ili.25.1599189845273;
        Thu, 03 Sep 2020 20:24:05 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id i85sm2593944ile.27.2020.09.03.20.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 20:24:04 -0700 (PDT)
Date:   Thu, 3 Sep 2020 21:24:00 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200904032400.GA4102421@google.com>
References: <20200831175042.3527153-1-yuzhao@google.com>
 <20200903082832.GR4617@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903082832.GR4617@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 10:28:32AM +0200, Michal Hocko wrote:
> On Mon 31-08-20 11:50:41, Yu Zhao wrote:
> [...]
> > @@ -1860,16 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> >  
> >  		SetPageLRU(page);
> > -		lru = page_lru(page);
> > -
> > -		nr_pages = thp_nr_pages(page);
> > -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> > -		list_move(&page->lru, &lruvec->lists[lru]);
> > +		add_page_to_lru_list(page, lruvec, page_lru(page));
> >  
> >  		if (put_page_testzero(page)) {
> >  			__ClearPageLRU(page);
> > -			__ClearPageActive(page);
> 
> This should go into its own patch. The rest is a mechanical and clear.

Thanks for reviewing.

I assume you are worrying about PG_unevictable being set on the page
because page_off_lru() checks it first. Well, if this can happen,
wouldn't it have been triggering bad_page()? PG_unevictable is in
PAGE_FLAGS_CHECK_AT_FREE.

> This one needs some head scratching. E.g. Is it correct for all compound
> pages. I believe it should be but few words on why would be better.

It seems nothing special here when compared with other places that
follow the same pattern. So I'm not sure what the concern is.

> > -			del_page_from_lru_list(page, lruvec, lru);
> > +			del_page_from_lru_list(page, lruvec, page_off_lru(page));
> >  
> >  			if (unlikely(PageCompound(page))) {
> >  				spin_unlock_irq(&pgdat->lru_lock);
> > @@ -1878,6 +1872,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> >  			} else
> >  				list_add(&page->lru, &pages_to_free);
> >  		} else {
> > +			nr_pages = thp_nr_pages(page);
> >  			nr_moved += nr_pages;
> >  			if (PageActive(page))
> >  				workingset_age_nonresident(lruvec, nr_pages);
> > -- 
> > 2.28.0.402.g5ffc5be6b7-goog
> > 
> 
> -- 
> Michal Hocko
> SUSE Labs
