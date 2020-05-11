Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E99C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F3912082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OpawAOpO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgEKQcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgEKQcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:32:35 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505B2C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:32:35 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id r1so2065660oog.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rN6jrdtkqkuGCg/Q7Taboz2Lln3BwXo5xB8TuXyO+KY=;
        b=OpawAOpO9nm4JEPmdukVT494hmLa6UutUAlyeiEZzga6yDqsAWdv/KR7/PKRbnVE8H
         99R3tjCChbnsGcJfwwkAr9s1/Zw/H0x7wfs9HU9815u0SRg5GVp3kieHYd6ha2af+FGb
         WhCLY6ORMVJbPnjhoQIaL7OaqlaOIu28eRPDZrj3Ff0Qn9k0+XHB4PBIllMbbZMu3yk0
         QECaYZuIeEJZs/ZtNFeCku1eZjdI+dlyP+Rff+nXiKh/2WJh2HrXz/EJtOjiJi8/R/Ox
         +hUk0KSPf7pKrhHu4suoZ3LNMAt4Ws25p66SSsjsmebWebTOaF6f2pq39RwUUUcDYgGR
         edzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rN6jrdtkqkuGCg/Q7Taboz2Lln3BwXo5xB8TuXyO+KY=;
        b=Zy6EDeHzzyJ+QJmon5ltpjaZkRjPn5U3BO4rqERo2KKLG6lPDR+1tcDfH4lcjeN5Yq
         t/Mo3sZUQ3l2gfHSsW6TTcx8FHjGdKyq2O0C/pF9Zl/kdnCLXPvwa3hgV7FJqdfDzRPD
         DvUah/DEcarx+2rwVAozUnJQpcWMeMZyfTKrikCKvDY8iTVNrraIg55yfDNOp6SOv55S
         +zyMBe8rJZsAGi3lKWTxlZ3D2yLk3Rl8kVFMW3O9IIQJZuolXdJ9GgB5RpbE/Im5K1Gh
         Yc2gEvT5MNznoIA7NAvFq2sWBHlvag9NrdJoDUzVuPe6Pq93IChBz7QzHaZLWo3IYChD
         CtZA==
X-Gm-Message-State: AGi0PuZKCJ/tF+0bPU04SVlyPh3BMBX7jbRpikNbhJ1QSmW5PPNIIt+j
        rjK8mWTirkzFC1IRklVLnYR7SV3ocOLWpg==
X-Google-Smtp-Source: APiQypLFH8LB9/mzdkQezPfhqKqOF8gm86/abafai8h/7Y5fVn96TpY2Jop/erQMAKojjWcL9ldIBQ==
X-Received: by 2002:a4a:be13:: with SMTP id l19mr14433407oop.78.1589214754154;
        Mon, 11 May 2020 09:32:34 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id f8sm564287oto.47.2020.05.11.09.32.32
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 11 May 2020 09:32:33 -0700 (PDT)
Date:   Mon, 11 May 2020 09:32:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>, Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
In-Reply-To: <20200511150648.GA306292@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2005110912180.3431@eggly.anvils>
References: <20200420221126.341272-1-hannes@cmpxchg.org> <20200420221126.341272-6-hannes@cmpxchg.org> <20200422064041.GE6780@js1304-desktop> <20200422120946.GA358439@cmpxchg.org> <20200423052450.GA12538@js1304-desktop> <20200508160122.GB181181@cmpxchg.org>
 <alpine.LSU.2.11.2005102350360.2769@eggly.anvils> <20200511150648.GA306292@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020, Johannes Weiner wrote:
> On Mon, May 11, 2020 at 12:38:04AM -0700, Hugh Dickins wrote:
> > On Fri, 8 May 2020, Johannes Weiner wrote:
> > > 
> > > I looked at this some more, as well as compared it to non-shmem
> > > swapping. My conclusion is - and Hugh may correct me on this - that
> > > the deletion looks mandatory but is actually an optimization. Page
> > > reclaim will ultimately pick these pages up.
> > > 
> > > When non-shmem pages are swapped in by readahead (locked until IO
> > > completes) and their page tables are simultaneously unmapped, the
> > > zap_pte_range() code calls free_swap_and_cache() and the locked pages
> > > are stranded in the swap cache with no page table references. We rely
> > > on page reclaim to pick them up later on.
> > > 
> > > The same appears to be true for shmem. If the references to the swap
> > > page are zapped while we're trying to swap in, we can strand the page
> > > in the swap cache. But it's not up to swapin to detect this reliably,
> > > it just frees the page more quickly than having to wait for reclaim.
> > 
> > I think you've got all that exactly right, thanks for working it out.
> > It originates from v3.7's 215c02bc33bb ("tmpfs: fix shmem_getpage_gfp()
> > VM_BUG_ON") - in which I also had to thank you.
> 
> I should have looked where it actually came from - I had forgotten
> about that patch!
> 
> > I think I chose to do the delete_from_swap_cache() right there, partly
> > because of following shmem_unuse_inode() code which already did that,
> > partly on the basis that while we have to observe the case then it's
> > better to clean it up, and partly out of guilt that our page lock here
> > is what had prevented shmem_undo_range() from completing its job; but
> > I believe you're right that unused swapcache reclaim would sort it out
> > eventually.
> 
> That makes sense to me.
> 
> > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > index e80167927dce..236642775f89 100644
> > > --- a/mm/shmem.c
> > > +++ b/mm/shmem.c
> > > @@ -640,7 +640,7 @@ static int shmem_add_to_page_cache(struct page *page,
> > >  		xas_lock_irq(&xas);
> > >  		entry = xas_find_conflict(&xas);
> > >  		if (entry != expected)
> > > -			xas_set_err(&xas, -EEXIST);
> > > +			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);
> > 
> > Two things on this.
> > 
> > Minor matter of taste, I'd prefer that as
> > 			xas_set_err(&xas, entry ? -EEXIST : -ENOENT);
> > which would be more general and more understandable -
> > but what you have written should be fine for the actual callers.
> 
> Yes, checking `expected' was to differentiate the behavior depending
> on the callsite. But testing `entry' is more obvious in that location.
> 
> > Except... I think returning -ENOENT there will not work correctly,
> > in the case of a punched hole.  Because (unless you've reworked it
> > and I just haven't looked) shmem_getpage_gfp() knows to retry in
> > the case of -EEXIST, but -ENOENT will percolate up to shmem_fault()
> > and result in a SIGBUS, or a read/write error, when the hole should
> > just get refilled instead.
> 
> Good catch, I had indeed missed that. I'm going to make it retry on
> -ENOENT as well.
> 
> We could have it go directly to allocating a new page, but it seems
> unnecessarily complicated: we've already been retrying in this
> situation until now, so I would stick to "there was a race, retry."
> 
> > Not something that needs fixing in a hurry (it took trinity to
> > generate this racy case in the first place), I'll take another look
> > once I've pulled it into a tree (or collected next mmotm) - unless
> > you've already have changed it around by then.
> 
> Attaching a delta fix based on your observations.
> 
> Andrew, barring any objections to this, could you please fold it into
> the version you have in your tree already?

Not so strong as an objection, and I won't get to see whether your
retry on -ENOENT is good (can -ENOENT arrive at that point from any
other case, that might endlessly retry?) until I've got the full
context; but I had arrived at the opposite conclusion overnight.

Given that this case only appeared with a fuzzer, and stale swapcache
reclaim is anyway relied upon to clean up after plenty of other such
races, I think we should agree that I over-complicated the VM_BUG_ON
removal originally, and it's best to kill that delete_from_swap_cache(),
and the comment having to explain it, and your EEXIST/ENOENT distinction.

(I haven't checked, but I suspect that the shmem_unuse_inode() case
that I copied from, actually really needed to delete_from_swap_cache(),
in order to swapoff the page without full retry of the big swapoff loop.)

Hugh

> 
> ---
> 
> From 33d03ceebce0a6261d472ddc9c5a07940f44714c Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 11 May 2020 10:45:14 -0400
> Subject: [PATCH] mm: memcontrol: convert page cache to a new
>  mem_cgroup_charge() API fix
> 
> Incorporate Hugh's feedback:
> 
> - shmem_getpage_gfp() needs to handle the new -ENOENT that was
>   previously implied in the -EEXIST when a swap entry changed under us
>   in any way. Otherwise hole punching could cause a racing fault to
>   SIGBUS instead of allocating a new page.
> 
> - It is indeed page reclaim that picks up any swapcache we leave
>   stranded when free_swap_and_cache() runs on a page locked by
>   somebody else. Document that our delete_from_swap_cache() is an
>   optimization, not something we rely on for correctness.
> 
> - Style cleanup: testing `expected' to decide on -EEXIST vs -ENOENT
>   differentiates the callsites, but is a bit awkward to read. Test
>   `entry' instead.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/shmem.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index afd5a057ebb7..00fb001e8f3e 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -638,7 +638,7 @@ static int shmem_add_to_page_cache(struct page *page,
>  		xas_lock_irq(&xas);
>  		entry = xas_find_conflict(&xas);
>  		if (entry != expected)
> -			xas_set_err(&xas, expected ? -ENOENT : -EEXIST);
> +			xas_set_err(&xas, entry ? -EEXIST : -ENOENT);
>  		xas_create_range(&xas);
>  		if (xas_error(&xas))
>  			goto unlock;
> @@ -1686,10 +1686,13 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
>  		 * We already confirmed swap under page lock, but
>  		 * free_swap_and_cache() only trylocks a page, so it
>  		 * is just possible that the entry has been truncated
> -		 * or holepunched since swap was confirmed.
> -		 * shmem_undo_range() will have done some of the
> -		 * unaccounting, now delete_from_swap_cache() will do
> -		 * the rest.
> +		 * or holepunched since swap was confirmed. This could
> +		 * occur at any time while the page is locked, and
> +		 * usually page reclaim will take care of the stranded
> +		 * swapcache page. But when we catch it, we may as
> +		 * well clean up after ourselves: shmem_undo_range()
> +		 * will have done some of the unaccounting, now
> +		 * delete_from_swap_cache() will do the rest.
>  		 */
>  		if (error == -ENOENT)
>  			delete_from_swap_cache(page);
> @@ -1765,7 +1768,7 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
>  	if (xa_is_value(page)) {
>  		error = shmem_swapin_page(inode, index, &page,
>  					  sgp, gfp, vma, fault_type);
> -		if (error == -EEXIST)
> +		if (error == -EEXIST || error == -ENOENT)
>  			goto repeat;
>  
>  		*pagep = page;
> -- 
> 2.26.2
> 
