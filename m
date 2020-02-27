Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9080BC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DF221D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gayusqmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgB0Hs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:48:59 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36469 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbgB0Hs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:48:58 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so1036506pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 23:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XVoZfIsuqX+Guz4IEAWRuvlxI1qIG+Lk5g5VCiapuB8=;
        b=gayusqmHGrlCGDHxF7GXlmeMI4qYKI4IdBfb8aV0uVK3N8EChn+0NyO6VIPhDsn5Pj
         jbpG1wwd/tfS2+qWzw/GJNvrhO/yka2Ft9oWyP490cPr1O0CmNmIt0UbO6lszvHrj+tW
         w2YPwsIZZ8yoA4tDui2JtVcyKFGGYZ1d2tMNcugOtkh5DBgHRm1P8qgeQNDyWgDPWGxK
         LrHkJRbBm0S/sfRZSmh0Os/8Sp6xUUsHJr4SQ2ulSGbur8YOnJSQoT3eCJ5FSmr9sDV1
         KvV0Q87/m8b0peDrgttd51Ow8fkJjjFetmhg3mHRdEJqbZVOAPOVhyZnxXmJsw9Xd6JF
         7Q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XVoZfIsuqX+Guz4IEAWRuvlxI1qIG+Lk5g5VCiapuB8=;
        b=WysPh3g+5aBSRcM3OXj9xdgmMrCZU7uA4HCl+dXmxbhUEZK0GSX9hj+x7C1Rtehf2M
         MSLOPDg80a342j+kJjFO1nLwVXDnX3xTJid+DtrvJMAUBsVdHhNedbwrBgFR4Ay5+QuV
         NmjxdjEOq7feWc/bPL/7yXnbRmFXhRmWwOItYyf/L5URNtWJkkBLWdxOhaU40GVVVHhj
         v1KHPi8Tnnj4jU3az5FnVHt7euvskSStG0xQsxZL19B/GeEMN3Q2bVyzR3uSKjERZ3de
         UfllsElMpVro0FgV2PqzxKvXhCmteUc2MM2hPWsYp3/GxPvQtKNg+3KapSFbOk0807Up
         NRaA==
X-Gm-Message-State: APjAAAUTiomAHb66EQ4k35dGjKuckcDM4I8SftJmZU1pnwBXfF2wt9OQ
        uuqEwejP3MR1h5KifakbV+w=
X-Google-Smtp-Source: APXvYqxs93Cc8RsXUNT4cj+O+zzQEnOX3Un2c0pGk0clle3KXvGwzwrZ+eFt9XwrluA3jvaTg/FjTg==
X-Received: by 2002:a63:f454:: with SMTP id p20mr2905318pgk.149.1582789736965;
        Wed, 26 Feb 2020 23:48:56 -0800 (PST)
Received: from js1304-desktop ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id y10sm5897363pfq.110.2020.02.26.23.48.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 23:48:56 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:48:47 +0900
From:   Joonsoo Kim <js1304@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com
Subject: Re: [PATCH v2 0/9] workingset protection/detection on the anonymous
 LRU list
Message-ID: <20200227074748.GA18113@js1304-desktop>
References: <1582175513-22601-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226193942.30049da9c090b466bdc5ec23@linux-foundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew.

On Wed, Feb 26, 2020 at 07:39:42PM -0800, Andrew Morton wrote:
> On Thu, 20 Feb 2020 14:11:44 +0900 js1304@gmail.com wrote:
> 
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > 
> > Hello,
> > 
> > This patchset implements workingset protection and detection on
> > the anonymous LRU list.
> 
> The test robot measurement got my attention!
> 
> http://lkml.kernel.org/r/20200227022905.GH6548@shao2-debian

I really hope to get an attention!!!
Thanks, test robot and Andrew.

> 
> > * Changes on v2
> > - fix a critical bug that uses out of index lru list in
> > workingset_refault()
> > - fix a bug that reuses the rotate value for previous page
> > 
> > * SUBJECT
> > workingset protection
> > 
> > * PROBLEM
> > In current implementation, newly created or swap-in anonymous page is
> > started on the active list. Growing the active list results in rebalancing
> > active/inactive list so old pages on the active list are demoted to the
> > inactive list. Hence, hot page on the active list isn't protected at all.
> > 
> > Following is an example of this situation.
> > 
> > Assume that 50 hot pages on active list and system can contain total
> > 100 pages. Numbers denote the number of pages on active/inactive
> > list (active | inactive). (h) stands for hot pages and (uo) stands for
> > used-once pages.
> > 
> > 1. 50 hot pages on active list
> > 50(h) | 0
> > 
> > 2. workload: 50 newly created (used-once) pages
> > 50(uo) | 50(h)
> > 
> > 3. workload: another 50 newly created (used-once) pages
> > 50(uo) | 50(uo), swap-out 50(h)
> > 
> > As we can see, hot pages are swapped-out and it would cause swap-in later.
> > 
> > * SOLUTION
> > Since this is what we want to avoid, this patchset implements workingset
> > protection. Like as the file LRU list, newly created or swap-in anonymous
> > page is started on the inactive list. Also, like as the file LRU list,
> > if enough reference happens, the page will be promoted. This simple
> > modification changes the above example as following.
> 
> One wonders why on earth we weren't doing these things in the first
> place?

I don't know. I tried to find the origin of this behaviour and found
that it's from you 18 years ago. :)

It mentions that starting pages on the active list boosts throughput on
stupid swapstormy test but I cannot guess the exact reason of such
improvement.

Anyway, Following is the related patch history. Could you remember
anything about it?

commit 018c71d821e7cfb13470e43778645c899c30c53e
Author: Andrew Morton <akpm@digeo.com>
Date:   Thu Oct 31 04:09:19 2002 -0800

    [PATCH] start anon pages on the active list (properly this time)

    Use lru_cache_add_active() so ensure that pages which are, or will be
    mapped into pagetables are started out on the active list.

commit 1527d0b71fa1e9db1beb22fda689b9086d025455
Author: Andrew Morton <akpm@digeo.com>
Date:   Thu Oct 31 04:09:13 2002 -0800

    [PATCH] lru_add_active(): for starting pages on the active list

    This is the first in a series of patches which tune up the 2.5
    performance under heavy swap loads.

    Throughput on stupid swapstormy tests is increased by 1.5x to 3x.
    Still about 20% behind 2.4 with multithreaded tests.  That is not
    easily fixable - the virtual scan tends to apply a form of load
    control: particular processes are heavily swapped out so the others can
    get ahead.  With 2.5 all processes make very even progress and much
    more swapping is needed.  It's on par with 2.4 for single-process
    swapstorms.


    In this patch:

    The code which tries to start mapped pages out on the active list
    doesn't work very well.  It uses an "is it mapped into pagetables"
    test.  Which doesn't work for, say, swap readahead pages.  They are not
    mapped into pagetables when they are spilled onto the LRU.

    So create a new `lru_cache_add_active()' function for deferred addition
    of pages to their active list.

    Also move mark_page_accessed() from filemap.c to swap.c where all
    similar functions live.  And teach it to not try to move pages which
    are in the deferred-addition list onto the active list.  That won't
    work, and it's bogusly clearing PageReferenced in that case.

    The deferred-addition lists are a pest.  But lru_cache_add used to be
    really expensive in sime workloads on some machines.  Must persist.

> > * SUBJECT
> > workingset detection
> 
> It sounds like the above simple aging changes provide most of the
> improvement, and that the workingset changes are less beneficial and a
> bit more risky/speculative?

I don't think so.

Although test robot just find the improvement of simple ratio changes,
later patches also have their's own benefit. I found the benefit of
the other patches on our production workload although it isn't
mentioned in cover-letter.

And, what this patchset does looks the reasonable thing.

> If so, would it be best for us to concentrate on the aging changes
> first, let that settle in and spread out and then turn attention to the
> workingset changes?

I hope that more developer pay an attention on this patchset and
the patchset are merged together.

Thanks.
