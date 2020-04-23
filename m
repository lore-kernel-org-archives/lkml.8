Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51245C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3121B20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="nUpMcdC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgDWQFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729405AbgDWQFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:05:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C01C09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:05:48 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 71so5252890qtc.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=o8NjJ+ZRGAsBwuc2VNRIDdFrU8QYsgC6lWkhEP4DRqM=;
        b=nUpMcdC5tph7V7/hLjokgO8v0xhUSr01BOjkdxf5RmqOQms9brCIntaSQjPKdrCQxh
         STCb9TFMF7zcBJFU7FPkGp/AnMSTBTnA+UvpxPN8Hr9On8AVnMsw/h7xmJKtO7G1Le6b
         djXqahTH57hxMYNwKcl4QeJtDIxOkXM31eRtr7U90oE4Mof6bMPidWgB1fFDDH4O+W5y
         S08qMc3PF05KcZ4PfmP6aRQOPeK6yLXhmo5jUcvMLbfvL3VbT2QttdEcEiMqkH5te1cm
         0lIwzM+iCv1abdCvh1/udnvoGSOAPpVnWpDtdrqr3XU/My087wIBAcgfrlqnHt+yH5au
         bKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=o8NjJ+ZRGAsBwuc2VNRIDdFrU8QYsgC6lWkhEP4DRqM=;
        b=SL9kxYKhIwf8IwAgNnGnWOcdUMJDVZaU79f6Nf1jQ4XHATBvVkU4MCHjoPHuXrQrjl
         O+xdBFGUds9YkAMDQjr2/0h+ssdr3ejYKsqeTvXQO/uEsSSpdrMUkRezbrcuQJRlxT5f
         ag40V1k8mljfMA7hEecqm2AD+rG95SeMjfS8JOZI7s5NWEFPJojdm+IypUgpeWfTuaX+
         Ff8OitVBsJEhjf91SVb8V/dqokSYCcv91O9pxp4fC3Wdxwpyo1kmXk5sw2onU96BOJkR
         BTA7lKR/1BkB2MNn1p+Mq3OX0W5DirOgISG3JUSTBXiQvdYZR+32fqgWstQ/io2+Zi5p
         SVwg==
X-Gm-Message-State: AGi0Puaonxy0ZjEHA3qykADTbK4ALe/A9097K1HxjbV5hyGoJ0GRdkk8
        HV6aV9ccDi3w0aerOj1qmP5QnQ==
X-Google-Smtp-Source: APiQypIWI+qTohLBPVldLUX02lOsPfHAp5mdWRH+VnhUfYHdm8z4Bw7WAdO2HarO/mORZ3HZb3txdg==
X-Received: by 2002:aed:3aa3:: with SMTP id o32mr4848669qte.364.1587657947786;
        Thu, 23 Apr 2020 09:05:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id 63sm1759922qkl.64.2020.04.23.09.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:05:47 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:05:46 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, mgorman@suse.de, m.szyprowski@samsung.com,
        mina86@mina86.com, shli@fb.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, ytk.lee@samsung.com
Subject: Re: [PATCH v2] mm/vmscan: count layzfree pages and fix nr_isolated_*
 mismatch
Message-ID: <20200423160546.GA389168@cmpxchg.org>
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
 <20200422084815.21913-1-jaewon31.kim@samsung.com>
 <20200422130751.GD358439@cmpxchg.org>
 <5EA10872.3010500@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5EA10872.3010500@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:16:02PM +0900, Jaewon Kim wrote:
> 
> 
> On 2020년 04월 22일 22:07, Johannes Weiner wrote:
> > On Wed, Apr 22, 2020 at 05:48:15PM +0900, Jaewon Kim wrote:
> >> @@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >>  		 */
> >>  		if (page_mapped(page)) {
> >>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
> >> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
> >>  
> >>  			if (unlikely(PageTransHuge(page)))
> >>  				flags |= TTU_SPLIT_HUGE_PMD;
> >> +
> >>  			if (!try_to_unmap(page, flags)) {
> >>  				stat->nr_unmap_fail += nr_pages;
> >> +				if (lazyfree && PageSwapBacked(page))
> > This looks pretty strange, until you remember that try_to_unmap()
> > could SetPageSwapbacked again.
> >
> > This might be more obvious?
> >
> > 			was_swapbacked = PageSwapBacked(page);
> > 			if (!try_to_unmap(page, flags)) {
> > 				stat->nr_unmap_fail += nr_pages;
> > 				if (!was_swapbacked && PageSwapBacked(page))
> Hello Johannes, thank you for your comment.
> 
> The name can changed from layzyfree to was_swapbacked.
> By the way, did you mean removing PageAnon(page), too? It seems to be OK, though.

I can't decide whether PageAnon() makes it clearer or not. But it's
not really needed for correctness. So feel free to keep what you had.

I would really just at least change bool lazyfree to was_lazyfree,
otherwise it seems a bit confusing. was_lazyfree makes it a bit
clearer that we expect try_to_unmap() might change the state.

> >> +					stat->nr_lazyfree_fail += nr_pages;
> >>  				goto activate_locked;
> > Or at least was_lazyfree.
> Sorry but I'm confused.
> I think you meant additional comment to previous your comment
> rather than you wanted to rename stat->nr_lazyfree_fail to stat->was_lazyfree.

No just the bool variable, the stat one seems fine to me.

> >> @@ -1491,8 +1495,8 @@ unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> >>  		.priority = DEF_PRIORITY,
> >>  		.may_unmap = 1,
> >>  	};
> >> -	struct reclaim_stat dummy_stat;
> >> -	unsigned long ret;
> >> +	struct reclaim_stat stat;
> >> +	unsigned long reclaimed;
> > nr_reclaimed would be better.
> I will add nr_ prefix on next patch.

Thanks!

> > I also prefer keeping dummy_stat, since that's still what it is.
> This patch uses stat.nr_lazyfree_fail, I do not understand why it is still dummy_stat.
> If you want, I will keep dummy_stat, though.

My bad, I just misread this. 'stat' makes more sense then.
