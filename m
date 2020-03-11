Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9196AC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168B7206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="O7l+serY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgCKOr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:47:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36966 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729100AbgCKOr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:47:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id y126so2313982qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BOUrshlmd64iGTeHVHzh1lBRPXu23AyN5Nnmq3KzE6w=;
        b=O7l+serYmAbtoyZb7Way1eOmtqdMAPT5stve0l0ooG9ny3e4bGBbwKBRRjlQiar7Ti
         MF1wjJ/pGpKG+S9UR8lkBGo3NwP5/nHXNLvpcxBTdfgF2lmEXmga82VupDDZK8SEtX/r
         ya+qAc23/J8Mvuyql73riRdxu6jfNAlePON7q39W08x1mLYU7xnfp/ABPUS2HByFgY1j
         0tKl6PULXkoWbg1cfHNar1khYiaCuSaPR/CmTMhHadMU8oSTHIXkGZA1bEfJhuKqaGz+
         sVU8rFAk5A7xA+/IQCWn5T2MeQI71fw7wFLDHIU8vhi21pKlQL6pNbv8Juj12Dig4/op
         DNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BOUrshlmd64iGTeHVHzh1lBRPXu23AyN5Nnmq3KzE6w=;
        b=iyJuQGnyIKsTNX2uB/ZhCxDtTOdwtt+qFLXsVKx5XHuCNyu4T+UJTEWnMoTy+1aQ35
         K42yu0Ooodwp/BhmPUuxnXPNM1VX0TYrRRyc3jQLKG6f6kIeiBkjyQVPFm01cYHH62eH
         SBPFciUSvjCH3ZMvYC8x5a1mA2Kz2p0n2vsHGbNFDhDGegEYqbHVU2HYzW5U93OKxndm
         tbYvTGoZVscTJ3GccW2KRV7OKBb1DBy94nSy0jI3/2nYelik8ygx/DuftuLvOcAbMK6W
         Xx2s06lFeRL2zPrCQ5mgjPyDhI09Uz6lzIOd0VlyaS1mhzIMwD26DoqIBz4f6R8GCeCG
         AtiA==
X-Gm-Message-State: ANhLgQ0C1z8Jd8DlQjjo2AJywq8ngvieNouM4+CQIeG1IN5OLCMA5eJU
        5UQQtA1mCBKWW/k987pSil69nA==
X-Google-Smtp-Source: ADFU+vvQXun96za+DjYFW6UuPN81X4lp0zCuOkb0lhVTCjaqQyj+2+822GXzi2x0Y47GY1gpLd+CNA==
X-Received: by 2002:a37:4b4c:: with SMTP id y73mr3022722qka.467.1583938073760;
        Wed, 11 Mar 2020 07:47:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::d51c])
        by smtp.gmail.com with ESMTPSA id l2sm2141844qtq.69.2020.03.11.07.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 07:47:53 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:47:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: Add more comments for MADV_FREE
Message-ID: <20200311144751.GA29835@cmpxchg.org>
References: <20200311011117.1656744-1-ying.huang@intel.com>
 <alpine.DEB.2.21.2003102204450.255869@chino.kir.corp.google.com>
 <87imjbv51t.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imjbv51t.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:22:54PM +0800, Huang, Ying wrote:
> David Rientjes <rientjes@google.com> writes:
> 
> > On Wed, 11 Mar 2020, Huang, Ying wrote:
> >
> >> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> >> index 6f2fef7b0784..01144dd02a5f 100644
> >> --- a/include/linux/mm_inline.h
> >> +++ b/include/linux/mm_inline.h
> >> @@ -9,10 +9,11 @@
> >>   * page_is_file_cache - should the page be on a file LRU or anon LRU?
> >>   * @page: the page to test
> >>   *
> >> - * Returns 1 if @page is page cache page backed by a regular filesystem,
> >> - * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
> >> - * Used by functions that manipulate the LRU lists, to sort a page
> >> - * onto the right LRU list.
> >> + * Returns 1 if @page is page cache page backed by a regular filesystem or
> >> + * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
> >> + * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
> >> + * functions that manipulate the LRU lists, to sort a page onto the right LRU
> >> + * list.
> >
> > The function name is misleading: anonymous pages that can be lazily freed 
> > are not file cache.  This returns 1 because of the question it is asking: 
> > anonymous lazily freeable pages should be on the file lru, not the anon 
> > lru.  So before adjusting the comment I'd suggest renaming the function to 
> > something like page_is_file_lru().
> 
> Yes.  I think page_is_file_lru() is a better name too.  And whether
> tmpfs pages are file cache pages is confusing too.  But I think we can
> do that after this patch if others think this is a good idea too.

I also think the rename is a great idea.

Personally, I'd prefer it in the same patch. Right now the name and
the documentation are out of date, but at least they're consistent in
their view of the world. Fixing this interface - name and
documentation - to reflect the existence of MADV_FREE anon pages is
one logical change, not two.
