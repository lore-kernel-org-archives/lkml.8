Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7913CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49C3120795
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o4rLgyn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgIDQzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgIDQyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:54:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941C8C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 09:54:47 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h4so7821605ioe.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yuyjbFHoO/MfKcJCdSK7UzvOyTNj/L7bhfgE/kRmYrI=;
        b=o4rLgyn8Ia62kQ510NnS41tFAUR14f/25JpG4QxR1t3v6u2Ph5mZ/wVWzd0IsvlCua
         HWUfuFohjJrLkPsaQdyzC4cTyv9vmVPi/CZVPoVdDSjREVUYStTlViWHn9jFYfsSEx77
         7u5HMl5d7CmMv9w3mJjhKSKZfxykcrclOyXmqGWajNo1C3vTMT0J9gOqCVOEz9tFmIQU
         Xu0biTepgJ7S41//yt8ix++XO8tjr6+dnwuC+Wq79nivDIw7R6qx6VPiY8ydbHifMXGv
         2E6AdHSBfK5t7Vv30RuDFC/pz2fHgi3USf+RAwht0XcOM16usa4G66B3FmzUTJq2ZQ6Z
         HWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yuyjbFHoO/MfKcJCdSK7UzvOyTNj/L7bhfgE/kRmYrI=;
        b=ozxIrlZOk7NK/jgpBUzp5qG2LLM/UKNvDxp651FtNGW40zz2uNVvrkHzwOyM4FCtAb
         W7nI21z36GnXaPY65yO8zPrjOpmG4qIjLDHZIn0Utth2bSlVCjybU4crG6EHcis+Pyzl
         jIS5NabZjGVwfPTpTKaaD1UX+ruZmyaHVMjPtz8y0ibpX0cPHRTDcPMFUppv76YE5GgE
         X0kHS5BTi/X+lteommVAXVy4Im2xU+xvGgy5CAHLbUGRtFO8W/MCQWl57qfoYJfulcAY
         nUE+dC73SdgYZWlKBHoF1YBI/+JShJj1WR658F2JLZxUyZnrN91dcDI4nC6dEryokgy4
         e8Hg==
X-Gm-Message-State: AOAM532zpC2rGhSmMOO9uwrk4JExHnTbFXX/x5NnINk+7n1b1vWnehlu
        vDJ/oSxFRebWIS0z7M8UdDCXFG4meJEmXA==
X-Google-Smtp-Source: ABdhPJyvjCMO8yHsIwpQyd+tA1kiQKGBNHJ4w4x3gKmZwPYKev70Sc0PceLLJ2pEPctmG59ok2Cy+Q==
X-Received: by 2002:a6b:2b45:: with SMTP id r66mr8318965ior.159.1599238482727;
        Fri, 04 Sep 2020 09:54:42 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id w17sm348678ilo.36.2020.09.04.09.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:54:41 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:54:37 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: use
 add_page_to_lru_list()/page_lru()/page_off_lru()
Message-ID: <20200904165437.GA77761@google.com>
References: <20200831175042.3527153-1-yuzhao@google.com>
 <20200903082832.GR4617@dhcp22.suse.cz>
 <20200904032400.GA4102421@google.com>
 <20200904105001.GH15277@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904105001.GH15277@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:50:01PM +0200, Michal Hocko wrote:
> On Thu 03-09-20 21:24:00, Yu Zhao wrote:
> > On Thu, Sep 03, 2020 at 10:28:32AM +0200, Michal Hocko wrote:
> > > On Mon 31-08-20 11:50:41, Yu Zhao wrote:
> > > [...]
> > > > @@ -1860,16 +1859,11 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
> > > >  		lruvec = mem_cgroup_page_lruvec(page, pgdat);
> > > >  
> > > >  		SetPageLRU(page);
> > > > -		lru = page_lru(page);
> > > > -
> > > > -		nr_pages = thp_nr_pages(page);
> > > > -		update_lru_size(lruvec, lru, page_zonenum(page), nr_pages);
> > > > -		list_move(&page->lru, &lruvec->lists[lru]);
> > > > +		add_page_to_lru_list(page, lruvec, page_lru(page));
> > > >  
> > > >  		if (put_page_testzero(page)) {
> > > >  			__ClearPageLRU(page);
> > > > -			__ClearPageActive(page);
> > > 
> > > This should go into its own patch. The rest is a mechanical and clear.
> > 
> > Thanks for reviewing.
> > 
> > I assume you are worrying about PG_unevictable being set on the page
> > because page_off_lru() checks it first.
> 
> No, I was referring to __ClearPageActive. You are right that this is
> cleared in page_off_lru but that is hidden in a release path and e.g.
> compound pages are released via their destructor which for some might
> not involve releasing the page - e.g. hugetlb pages. This should be fine
> because hugetlb pages are not on LRU so as I've said this is fine but it
> belongs to its own patch because it is not a pure mechanical change like
> the rest of the patch.

Please bear with me. This is the change in question:

 		if (put_page_testzero(page)) {
 			__ClearPageLRU(page);
-			__ClearPageActive(page);
-			del_page_from_lru_list(page, lruvec, lru);
+			del_page_from_lru_list(page, lruvec, page_off_lru(page));

 			if (unlikely(PageCompound(page))) {

If the PageUnevictable() check in page_off_lru() is not a concern,
I'm trying to understand what else is different between them:

	Before this path:		After this patch:

					page_off_lru()
	__ClearPageActive()			__ClearPageActive()
	add_page_to_lru_list()		add_page_to_lru_list()

And why is page_off_lru() hidden in a release path?
