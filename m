Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E170C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDEF220768
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXt2sJaD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgIJCHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbgIJByb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:54:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C39AC061348
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 17:32:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w186so4393885qkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 17:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=a2Gw2QTQELKkuv4WuRMTiaWGDMDx+OUJI/W2YlhQu1g=;
        b=hXt2sJaDB69f3HSWBntMKHKu2u6GbGPI56g1GWVWgEWffWRmRF/46fjhjzr4y+kjSS
         olae3KV2INU6xY+5nmScaQwuyflGf/29D3hqz+AwidEpBRlgxwyecVGF+cVfQPTtLVoI
         FqlW4hqo2j4lAXBkqf4P7uucl5pqZpkaibL/ASfdbjENd1k5Lj2lQAZYgMjhdfrXfQ/G
         yabuHDKWP5Zd+KUB09u+iw39GatHXuF+7hFxQmBrzlDN1pJSILYoaj+goqHr9cPUO2WX
         oeenuvj38miM7TkbMjGFMmJyXDGvcmQoD8deSnstcoxJQk/SZIv/p9q8mFYHuaIS0uc8
         Sg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=a2Gw2QTQELKkuv4WuRMTiaWGDMDx+OUJI/W2YlhQu1g=;
        b=UeBhFMwCa+w58dZ5rdkyzO1C0ZrTvL5cvSnhlPXFVOwDUU//TrLJDLv+wXuJ8H0TPh
         xfZKeRmf1JF0YjaZBF0nJlISQk31xTQqDhkbRt3RX+/yGHgnzsvJ2vsmjlWE2LCAbztZ
         Qwa6cVCC83K2Us5eT3ResRPIQp4f5Hn2v3VYadrGuJXSzxcgJLpFXZ85yiYrrKeWUC2Q
         Bx/OVAracOkfnlGwXXo4TeVNE+FcHSnW2f3Me9NxfgOXPP/OqK1a50aQitQTRz8Gwzp+
         T899MPFTPQfRzuIJ8XBjwy8pVkJOseA+A5VuUb6l6/a9xZ8rdPgwTqn8FICrE3CkHDRY
         hIFA==
X-Gm-Message-State: AOAM5336q6C9r1ygEuLtciHOhkmcR+lDp5ZpsEfZms3LIBCQ+AqoMQMu
        4/diVbI6t5O3Kj/DF3KY3EK3bA==
X-Google-Smtp-Source: ABdhPJyF87ooDKnFqIaEGdhP2rgIRd+1mRdTS3gXo69eGiqrL3k3PYHB6g0UOzXsGTOXRmPbTwWZUg==
X-Received: by 2002:a37:ac08:: with SMTP id e8mr5465238qkm.158.1599697962163;
        Wed, 09 Sep 2020 17:32:42 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p68sm4427778qka.78.2020.09.09.17.32.38
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 09 Sep 2020 17:32:40 -0700 (PDT)
Date:   Wed, 9 Sep 2020 17:32:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alexander Duyck <alexander.duyck@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, shy828301@gmail.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v18 00/32] per memcg lru_lock: reviews
In-Reply-To: <CAKgT0Uc_L-Tz_rVJiHc5GUK_ZWOs2wRvez4QGf2wwEjx38qnbg@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2009091640490.10087@eggly.anvils>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com> <20200824114204.cc796ca182db95809dd70a47@linux-foundation.org> <alpine.LSU.2.11.2008241231460.1065@eggly.anvils> <alpine.LSU.2.11.2008262301240.4405@eggly.anvils>
 <alpine.LSU.2.11.2009081640070.7256@eggly.anvils> <CAKgT0Uc_L-Tz_rVJiHc5GUK_ZWOs2wRvez4QGf2wwEjx38qnbg@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Sep 2020, Alexander Duyck wrote:
> On Tue, Sep 8, 2020 at 4:41 PM Hugh Dickins <hughd@google.com> wrote:
> > [PATCH v18 28/32] mm/compaction: Drop locked from isolate_migratepages_block
> > Most of this consists of replacing "locked" by "lruvec", which is good:
> > but please fold those changes back into 20/32 (or would it be 17/32?
> > I've not yet looked into the relationship between those two), so we
> > can then see more clearly what change this 28/32 (will need renaming!)
> > actually makes, to use lruvec_holds_page_lru_lock(). That may be a
> > good change, but it's mixed up with the "locked"->"lruvec" at present,
> > and I think you could have just used lruvec for locked all along
> > (but of course there's a place where you'll need new_lruvec too).
> 
> I am good with my patch being folded in. No need to keep it separate.

Thanks.  Though it was only the "locked"->"lruvec" changes I was
suggesting to fold back, to minimize the diff, so that we could
see your use of lruvec_holds_page_lru_lock() more clearly - you
had not introduced that function at the stage of the earlier patches.

But now that I stare at it again, using lruvec_holds_page_lru_lock()
there doesn't look like an advantage to me: when it decides no, the
same calculation is made all over again in mem_cgroup_page_lruvec(),
whereas the code before only had to calculate it once.

So, the code before looks better to me: I wonder, do you think that
rcu_read_lock() is more expensive than I think it?  There can be
debug instrumentation that makes it heavier, but by itself it is
very cheap (by design) - not worth branching around.

> 
> > [PATCH v18 29/32] mm: Identify compound pages sooner in isolate_migratepages_block
> > NAK. I agree that isolate_migratepages_block() looks nicer this way, but
> > take a look at prep_new_page() in mm/page_alloc.c: post_alloc_hook() is
> > where set_page_refcounted() changes page->_refcount from 0 to 1, allowing
> > a racing get_page_unless_zero() to succeed; then later prep_compound_page()
> > is where PageHead and PageTails get set. So there's a small race window in
> > which this patch could deliver a compound page when it should not.
> 
> So the main motivation for the patch was to avoid the case where we
> are having to reset the LRU flag.

That would be satisfying.  Not necessary, but I agree satisfying.
Maybe depends also on your "skip" change, which I've not looked at yet?

> One question I would have is what if
> we swapped the code block with the __isolate_lru_page_prepare section?
> WIth that we would be taking a reference on the page, then verifying
> the LRU flag is set, and then testing for compound page flag bit.
> Would doing that close the race window since the LRU flag being set
> should indicate that the allocation has already been completed has it
> not?

Yes, I think that would be safe, and would look better.  But I am
very hesitant to give snap assurances here (I've twice missed out
a vital PageLRU check from this sequence myself): it is very easy
to deceive myself and only see it later.

If you can see a bug in what's there before these patches, certainly
we need to fix it.  But adding non-essential patches to the already
overlong series risks delaying it.

Hugh
