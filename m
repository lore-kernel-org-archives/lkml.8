Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F96BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 578E42073D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OgANEZL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbgCDB1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:27:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43765 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgCDB1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:27:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id x17so238050plm.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7j1JY1w6KY3dIJ58LiQwYJdhyGzQgFJSnbbwSZ5yqSA=;
        b=OgANEZL1C13kZ2ZvZHUkXeJc1JPQuFIyEno7NDIjvhkPUtiM/TWxgwb6N3dKz9D5pG
         +8pVMlMcuIH/5q/sRDWZKsIanU3M4ZF9HwukOAli+C4cJXzkGbWKXjJ130jQEuWKrtPj
         W8VRtisrdg6LnTk9Pzc7VGCa0EbxHdtWq4gGeJeuEJ20SnXNf3AXjHxlsrf4APrqeRTl
         PtLJ0XRk38J2Z4KeBB6L+9Ic7Q3kEdGeZU/EgjwzPKZc3j/eGKV+9ZkRr8Pew3+RfyL3
         31O+q/0C+XlUbTSDs5Elcx0XlkkKFY7tzUjliMAZKCM/JpUAQL4JYeh2w8KZv/xmlRlA
         PzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7j1JY1w6KY3dIJ58LiQwYJdhyGzQgFJSnbbwSZ5yqSA=;
        b=WNLfLFFvB/rE7UTk4vGGRa0pq2kNAsYNtYb1QCmBDJGxoD65wZbLvQyuKB113QYzis
         LLkDBj5GISxJUgLAb25D4ay0k6HNaNXHh/Z37k+TBK1GfL1jCOZXrz0BOHF/7+7FbNRM
         YYVGNHQSIhXYcPRrCjCcsu9SsnGQROQScWR6W+FGyUrH9cGDoM1rGz2PF60J1JLB5wZZ
         0XMoHCzUg8yHBfUpmDXiLO2FCdEimMr5AWeWiM/0bYoK1HXUL5bfJl1iC5eRdRtwtqbE
         l4sI/SNHZO7Yyi4PyK/1dYFCQA9giDMOdsAri3PEkjnrFfhqLZi0xW2ZkKj+Zh6sWPPt
         20oA==
X-Gm-Message-State: ANhLgQ3nbLVripGljoN4fIyDyH8ZokjzhwplhhEctCOA3nxywH1hZ2o0
        6oXHglwx3ATiqXQw3AUGrAT/OA==
X-Google-Smtp-Source: ADFU+vvjP7ND+zZEsJE6+EeKEGNYGcKKU/WIpHz06niKLEDLdVZEZP0cj3wUil0uI5MGCUleiJlljQ==
X-Received: by 2002:a17:902:341:: with SMTP id 59mr720350pld.29.1583285226487;
        Tue, 03 Mar 2020 17:27:06 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r13sm25824743pgf.1.2020.03.03.17.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:27:05 -0800 (PST)
Date:   Tue, 3 Mar 2020 17:27:05 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm: Add PageLayzyFree() helper functions for MADV_FREE
In-Reply-To: <20200303165859.7440f23d388503ca77fdb6c2@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.2003031726300.77561@chino.kir.corp.google.com>
References: <20200303033738.281908-1-ying.huang@intel.com> <20200303165859.7440f23d388503ca77fdb6c2@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Mar 2020, Andrew Morton wrote:

> On Tue,  3 Mar 2020 11:37:38 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:
> 
> > From: Huang Ying <ying.huang@intel.com>
> > 
> > Now PageSwapBacked() is used as the helper function to check whether
> > pages have been freed lazily via MADV_FREE.  This isn't very obvious.
> > So Dave suggested to add PageLazyFree() family helper functions to
> > improve the code readability.
> > 
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -498,6 +498,31 @@ static __always_inline int PageKsm(struct page *page)
> >  TESTPAGEFLAG_FALSE(Ksm)
> >  #endif
> >  
> > +/*
> > + * For pages freed lazily via MADV_FREE.  lazyfree pages are clean
> > + * anonymous pages.  They have SwapBacked flag cleared to distinguish
> > + * with normal anonymous pages
> > + */
> > +static __always_inline int PageLazyFree(struct page *page)
> > +{
> > +	page = compound_head(page);
> > +	return PageAnon(page) && !PageSwapBacked(page);
> > +}
> > +
> > +static __always_inline void SetPageLazyFree(struct page *page)
> > +{
> > +	VM_BUG_ON_PAGE(PageTail(page), page);
> > +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +	ClearPageSwapBacked(page);
> > +}
> > +
> > +static __always_inline void ClearPageLazyFree(struct page *page)
> > +{
> > +	VM_BUG_ON_PAGE(PageTail(page), page);
> > +	VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +	SetPageSwapBacked(page);
> > +}
> 
> These BUG_ONs aren't present in the current code and are
> unchangelogged.
> 

Yeah, as well as the implicit conversion to check compound_head().
