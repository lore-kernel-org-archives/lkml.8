Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E49C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41512070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589234301;
	bh=tXYiBL6lhcDBOgVrVzxBviFHcr3U2rw6/zqjTPOU8TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JoFLej0yUA92tfhuJOZUIrQy359DGB++avLqyjR4z4OryykKheB5JKciOq/KIMTOh
	 4akR/J7UEJUgMIUPfr8jn3vhLYa+K8aWOTvAeAcK7hsiZiQ/X+u1Tc34mEqioiUQa5
	 holTjRn/pgmXbdgKZBzGNK/wJv1YWl4UonQXt1As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEKV6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727860AbgEKV6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:58:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AE0B2070B;
        Mon, 11 May 2020 21:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589234298;
        bh=tXYiBL6lhcDBOgVrVzxBviFHcr3U2rw6/zqjTPOU8TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sjnyo8wqX93srFtzj5MP4ju3f3Wtp95Z+K+KSj7HazuHN20Tj7yLVkftqG9hBG5pc
         Axod5Eghd8FqjYA6qjlCGMHXYjzGAETWnmRLy799ViXfYSO92sArbLrNAhnqTBdl6H
         2CyOT9kpwpLrRF03R+uFYBWQGiLxKfcdNP3NOLgc=
Date:   Mon, 11 May 2020 14:58:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix LRU balancing effect of new transparent huge
 pages
Message-Id: <20200511145817.a1379d6117b43c3f6474e199@linux-foundation.org>
In-Reply-To: <CALvZod7848_BETonZJFxXN1n1E7KtZ4DzT1-BeaN6hvBysN8WQ@mail.gmail.com>
References: <20200509141946.158892-1-shakeelb@google.com>
        <20200511141122.9b03e2f0852b57b224eab066@linux-foundation.org>
        <CALvZod7848_BETonZJFxXN1n1E7KtZ4DzT1-BeaN6hvBysN8WQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 14:38:23 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, May 11, 2020 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Sat,  9 May 2020 07:19:46 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> >
> > > Currently, THP are counted as single pages until they are split right
> > > before being swapped out. However, at that point the VM is already in
> > > the middle of reclaim, and adjusting the LRU balance then is useless.
> > >
> > > Always account THP by the number of basepages, and remove the fixup
> > > from the splitting path.
> >
> > Confused.  What kernel is this applicable to?
> 
> It is still applicable to the latest Linux kernel.

The patch has

> @@ -288,7 +288,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
>  
>  		__count_vm_events(PGACTIVATE, nr_pages);
>  		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
> -		update_page_reclaim_stat(lruvec, file, 1);
> +		update_page_reclaim_stat(lruvec, file, 1, nr_pages);
>  	}
>  }

but current mainline is quite different:

static void __activate_page(struct page *page, struct lruvec *lruvec,
			    void *arg)
{
	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
		int file = page_is_file_lru(page);
		int lru = page_lru_base_type(page);

		del_page_from_lru_list(page, lruvec, lru);
		SetPageActive(page);
		lru += LRU_ACTIVE;
		add_page_to_lru_list(page, lruvec, lru);
		trace_mm_lru_activate(page);

		__count_vm_event(PGACTIVATE);
		update_page_reclaim_stat(lruvec, file, 1);
	}
}

q:/usr/src/linux-5.7-rc5> patch -p1 --dry-run < ~/x.txt
checking file mm/swap.c
Hunk #2 FAILED at 288.
Hunk #3 FAILED at 546.
Hunk #4 FAILED at 564.
Hunk #5 FAILED at 590.
Hunk #6 succeeded at 890 (offset -9 lines).
Hunk #7 succeeded at 915 (offset -9 lines).
Hunk #8 succeeded at 958 with fuzz 2 (offset -10 lines).
4 out of 8 hunks FAILED

