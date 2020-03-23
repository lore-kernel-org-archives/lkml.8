Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4F2C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 274D720722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="dRfuJVBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgCWRnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:43:01 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37042 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgCWRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:43:00 -0400
Received: by mail-qk1-f193.google.com with SMTP id x3so4676937qki.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sMniDVy1p2OmkgYmHjBj3ZlNGasfwYaHXqTVFmvQbLo=;
        b=dRfuJVBuA+ZR77BKWjMOyDWr3ICK4jIJ0UyTL4MJvqSyyRnomtEsmYvBcJ6OC7FhqA
         sM2rUddls7HJuOME+yXGMsXrJ9kSQuidfOA12LHgYOI4HIo/heytF6mpojr296Px9Vlt
         tJn306ooDHJE5UnBOlw2QhnpEmkKG6D+gxVcVdG+qIy/54ewoxtsMwOAHmXx61aTzcfc
         PyzBxX0MFYW745TNGe4+VQKZgBFtz/AYKZgbsS4ttV5nEWmoOIDo3wBPcP1t2C0WbgvP
         O9b62I93Juv1ETY19O0ac4lApoMaP+Hm4GFvjuSsAphS9DJquc7mJNMwxTAGUq4TpfpD
         H13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sMniDVy1p2OmkgYmHjBj3ZlNGasfwYaHXqTVFmvQbLo=;
        b=BSj16geswvKY4zG4OnEUrZxRsuEfWURulBwlWr3CHRq+7cd/5+miwR93jC9tjqHrdJ
         JpGdGdmwVEfm3Wj0aEBeB/hg1C619yyOg5EfnVSVogJ85h4RFyPKaaSIqzN6qSAxurok
         ICMj7P9oNF5K0HBmVfJ/KKsk63uXnYROLE8dFcvQ1Y/j+2mDyxS+Q9VXgY3JePxi/pMd
         723q/q55kfewJ1TDHC2XSldv+DU+MdQbihp+2PW6ytL85AUG4hmHkYL0Uuxyg0LmNj00
         kyZdLK4QQZYqZJkAlSZuAyM2gJcUCQSsPY/+xiWGMXuYA8BFvHiuFLL3H6IeIbvt4wLE
         cb6Q==
X-Gm-Message-State: ANhLgQ24R8z7ATkn0/2TBRy66RQm4tWKzjtud0nQGGgJH9tIpRxNVitV
        A50dqCmDuBpALMripg48cYQDPFVDSW0=
X-Google-Smtp-Source: ADFU+vstQOTUXltPJNCAeftURC+G/GHvMmKeGMWG/dYq7Xd6UmQjdy8N4OI2a+RoHEPxsCP0B2Aw9g==
X-Received: by 2002:a37:8d42:: with SMTP id p63mr21664518qkd.182.1584985379276;
        Mon, 23 Mar 2020 10:42:59 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id x74sm10784599qkb.40.2020.03.23.10.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 10:42:58 -0700 (PDT)
Date:   Mon, 23 Mar 2020 13:42:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 8/8] mm/swap: count a new anonymous page as a
 reclaim_state's rotate
Message-ID: <20200323174257.GF204561@cmpxchg.org>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-9-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584942732-2184-9-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:52:12PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> reclaim_stat's rotate is used for controlling the ratio of scanning page
> between file and anonymous LRU. All new anonymous pages are counted
> for rotate before the patch, protecting anonymous pages on active LRU, and,
> it makes that reclaim on anonymous LRU is less happened than file LRU.
> 
> Now, situation is changed. all new anonymous pages are not added
> to the active LRU so rotate would be far less than before. It will cause
> that reclaim on anonymous LRU happens more and it would result in bad
> effect on some system that is optimized for previous setting.
> 
> Therefore, this patch counts a new anonymous page as a reclaim_state's
> rotate. Although it is non-logical to add this count to
> the reclaim_state's rotate in current algorithm, reducing the regression
> would be more important.
> 
> I found this regression on kernel-build test and it is roughly 2~5%
> performance degradation. With this workaround, performance is completely
> restored.
> 
> v2: fix a bug that reuses the rotate value for previous page

I agree with the rationale, but the magic bit in the page->lru list
pointers seems pretty ugly.

I wrote a patch a few years ago that split lru_add_pvecs into an add
and a putback component. This was to avoid unintentional balancing
effects of LRU isolations, but I think you can benefit from that
cleanup here as well. Would you mind taking a look at it and maybe
take it up into your series?

https://lore.kernel.org/patchwork/patch/685708/
