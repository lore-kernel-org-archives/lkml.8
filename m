Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16E6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A81020752
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584134013;
	bh=LM5++LylYEYIRcTrBh2u5HABhD5krwH3tGcUTvEG0qI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qg6Hz6NrxZQ7iRKTHh6vrvL0eBqRGhk255Nr/rPgIbXFjnN8+Lf+t6XduUXKWFRRo
	 ANlY963qGkbreGDIOIseTegwvIb2LN5Lhn/bFczlYgx5xMmnDTRKuI+0q97nYdztWU
	 Ml20JMIUawxW9y+46XJkFb1gjh8IvFWJHTXjBeLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCMVNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:13:32 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:34213 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMVNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:13:32 -0400
Received: by mail-pf1-f181.google.com with SMTP id 23so6019125pfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GPR40d1AVVkKCMk1jemHAzvVDuyxID3suTLHfW9Yekk=;
        b=Sks5dbg1n+6xb1A7oEV3VG1BVVLyDZ4bFJ25gFJM8WuoZHcVEes+LCxWloPXtLRHUn
         Wxse0qTqZF00wYNJFUToncrsL+EXdImEzfB0rdn2g2/kZhNS6FH/5OEKKiuBT7BESBld
         I2kxII9aZYslwF6jO8XD2biSZnyyezCWHWFcrOJV47HKl77vFM8wz4Jl9ykkqzxv0NGV
         vNBEwm130xVXanDEopqp1P+eIJfn7IanxMl371sJsS/rqn1ej1o+o+RnsYs0eVre83qh
         zbvMz6xu4n5j/ZjE6mPBB5mciixZESPYpIHVYMoJkhKdudazFLSTWKOlCGSeeHJSWvF/
         yvMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GPR40d1AVVkKCMk1jemHAzvVDuyxID3suTLHfW9Yekk=;
        b=rO2Bu/p9tCWHyaFl/Vl1kBYJ/XvQBCbfNgfOSQpXjBN7ZE1+V+65RfT/7QiDaPyCla
         XNdwnsoAWIZL+qlS0M8hyWteqPyHJM/fzgxmGUXaWHZeB9CncuSYD/RyZcL0cGUX1Kps
         nGC3oDHcv9GuHbTE2sy00Z09CgCikAMRY3GkOQscgdG9/OgARxBx9FtSqPmDIovx0hH8
         AFYXuIq3VRkbrE82fdmlrpRm5/0HQFIlsWbT+BhqP072JsS7/RH82+fgBu99VbkoZvZq
         DUVKRbKdNg/bFZxJ86cglAEgCm0iDLR73I3zdJnhbgDPPXmWWdjf5MAzV7ixm6rL0ryO
         fD7g==
X-Gm-Message-State: ANhLgQ2n5dJNVN/g7jpCE6XvgY2Su0ByxILcSFTSfnjgIBe90WJ6GkHf
        EhLqvTYnGNYy+ZMKXJiuoaNgZ109
X-Google-Smtp-Source: ADFU+vtpwXfQOxeX9sR5OBhdRk9byr7iEC/qcxRjSNexlQH66xsQHXgVmnVACQmITY/0wpdNB+Kg3Q==
X-Received: by 2002:a63:58a:: with SMTP id 132mr15143189pgf.216.1584134010521;
        Fri, 13 Mar 2020 14:13:30 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id x3sm17339812pfp.167.2020.03.13.14.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:13:29 -0700 (PDT)
Date:   Fri, 13 Mar 2020 14:13:27 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Jann Horn <jannh@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200313211327.GB78185@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
 <bd35c17d-8766-cba5-09b3-87970de4c731@intel.com>
 <20200313020018.GC68817@google.com>
 <a3a8a428-17d3-e3cb-913c-b44de12db9e4@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a8a428-17d3-e3cb-913c-b44de12db9e4@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 09:59:50AM -0700, Dave Hansen wrote:
> On 3/12/20 7:00 PM, Minchan Kim wrote:
> > On Thu, Mar 12, 2020 at 02:41:07PM -0700, Dave Hansen wrote:
> >> One other fun thing.  I have a "victim" thread sitting in a loop doing:
> >>
> >> 	sleep(1)
> >> 	memcpy(&garbage, buffer, sz);
> >>
> >> The "attacker" is doing
> >>
> >> 	madvise(buffer, sz, MADV_PAGEOUT);
> >>
> >> in a loop.  That, oddly enough doesn't cause the victim to page fault.
> >> But, if I do:
> >>
> >> 	memcpy(&garbage, buffer, sz);
> >> 	madvise(buffer, sz, MADV_PAGEOUT);
> >>
> >> It *does* cause the memory to get paged out.  The MADV_PAGEOUT code
> >> actually has a !pte_present() check.  It will punt on a PTE if it sees
> >> it.  In other words, if a page is in the swap cache but not mapped by a
> >> pte_present() PTE, MADV_PAGEOUT won't touch it.
> >>
> >> Shouldn't MADV_PAGEOUT be able to find and reclaim those pages?  Patch
> >> attached.
> > 
> >>
> >>
> >> ---
> >>
> >>  b/mm/madvise.c |   38 +++++++++++++++++++++++++++++++-------
> >>  1 file changed, 31 insertions(+), 7 deletions(-)
> >>
> >> diff -puN mm/madvise.c~madv-pageout-find-swap-cache mm/madvise.c
> >> --- a/mm/madvise.c~madv-pageout-find-swap-cache	2020-03-12 14:24:45.178775035 -0700
> >> +++ b/mm/madvise.c	2020-03-12 14:35:49.706773378 -0700
> >> @@ -248,6 +248,36 @@ static void force_shm_swapin_readahead(s
> >>  #endif		/* CONFIG_SWAP */
> >>  
> >>  /*
> >> + * Given a PTE, find the corresponding 'struct page'.  Also handles
> >> + * non-present swap PTEs.
> >> + */
> >> +struct page *pte_to_reclaim_page(struct vm_area_struct *vma,
> >> +				 unsigned long addr, pte_t ptent)
> >> +{
> >> +	swp_entry_t entry;
> >> +
> >> +	/* Totally empty PTE: */
> >> +	if (pte_none(ptent))
> >> +		return NULL;
> >> +
> >> +	/* A normal, present page is mapped: */
> >> +	if (pte_present(ptent))
> >> +		return vm_normal_page(vma, addr, ptent);
> >> +
> > 
> > Please check is_swap_pte first.
> 
> Why?
> 
> is_swap_pte() duplicates the first two checks.  But, I need an explicit
> pte_present() check somewhere because I need to call vm_normal_page()
> only on present PTEs.
> 
> I guess the pte_present() check could be:
> 
> 	if (!is_swap_pte(ptent))
> 		return vm_normal_page(...);
> 
> *after* the pte_none() check.

Yub, I thought is_swap_pte looks more readable and maintainable for
the change of pte encoding in future. Anyway, I am not insisting.

> 
> >> +	entry = pte_to_swp_entry(vmf->orig_pte);
> >> +	/* Is it one of the "swap PTEs" that's not really swap? */
> >> +	if (non_swap_entry(entry))
> >> +		return false;
> >> +
> >> +	/*
> >> +	 * The PTE was a true swap entry.  The page may be in the
> >> +	 * swap cache.  If so, find it and return it so it may be
> >> +	 * reclaimed.
> >> +	 */
> >> +	return lookup_swap_cache(entry, vma, addr);
> > 
> > If we go with handling only exclusived owned page for anon,
> > I think we should apply the rule to swap cache, too.
> 
> I'm going back and forth on it.  If we're just trying to avoid causing
> faults in other processes, we could add a mapcount>0 check here in
> addition to the mapcount>1 checks that were added in the other patch.
> 
> But, if we want a check for true exclusivity: no other swap entries or
> mappings, we need to check swap_count() too.  It's getting quite a bit
> uglier as I add that it, but I guess we'll see how it looks in the end.

If we go to the map_count > 1 check here and follows the Daniel's suggestion
of MADV_PAGEOUT_ALL to make shared page paging out, that means it clearly
makes semantic change for MADV_PAGEOUT: "paging out only exclusive owned page"
so it would be rather weired if we reclaim swap_count() > 1 of swap cache.
> 
> > Do you mind posting it as formal patch?
> 
> Yeah, I'll send something out.

Thanks for bring up the issue, Dave!
