Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0379BC83006
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38DA2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 01:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588211235;
	bh=omj+Wnlw7nrRcI7M/Sus+jSIgGuuMMuRYU8ep5SG4rc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CzGwQ6Ejt31v2yHl6HIz50+Hvev50DxvDxVmrgb/RnCbMSNd/WWdgqco/ioxLyeLz
	 iXuMbUMlbz0bdYugD/CISh6oRdQ48MJtd2c2wMneKvBXtGsPnAWrbUpdIcWv2S8sDr
	 cHl1aPFUKlUziQuUPFW+QFLqIVRsrO7KjcUXNvzo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD3BrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 21:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgD3BrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:47:14 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F060A2082E;
        Thu, 30 Apr 2020 01:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588211232;
        bh=omj+Wnlw7nrRcI7M/Sus+jSIgGuuMMuRYU8ep5SG4rc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BMIZZjwZjEHD4ivp8c4hXb9ANAbU7d0Mf0Ecu206TErFrGRBjAHnf1aPsfNc8TksK
         0rQnIb5MLOUk2uwIuoTKS9cS/r3CIBAemt/w9hGpWKO1QOksxWh/kKOP0WadlNepGR
         76JQmcDAPB6vR65CIJlOU/liyBjc6q/5xghTPSpA=
Date:   Wed, 29 Apr 2020 18:47:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 00/10] change the implementation of the PageHighMem()
Message-Id: <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Apr 2020 12:26:33 +0900 js1304@gmail.com wrote:

> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Changes on v2
> - add "acked-by", "reviewed-by" tags
> - replace PageHighMem() with use open-code, instead of using
> new PageHighMemZone() macro. Related file is "include/linux/migrate.h"
> 
> Hello,
> 
> This patchset separates two use cases of PageHighMem() by introducing
> PageHighMemZone() macro. And, it changes the implementation of
> PageHighMem() to reflect the actual meaning of this macro. This patchset
> is a preparation step for the patchset,
> "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE" [1].
> 
> PageHighMem() is used for two different cases. One is to check if there
> is a direct mapping for this page or not. The other is to check the
> zone of this page, that is, weather it is the highmem type zone or not.
> 
> Until now, both the cases are the perfectly same thing. So, implementation
> of the PageHighMem() uses the one case that checks if the zone of the page
> is the highmem type zone or not.
> 
> "#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))"
> 
> ZONE_MOVABLE is special. It is considered as normal type zone on
> !CONFIG_HIGHMEM, but, it is considered as highmem type zone
> on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
> on the ZONE_MOVABLE has no direct mapping until now.
> 
> However, following patchset
> "mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
> , which is once merged and reverted, will be tried again and will break
> this assumption that all pages on the ZONE_MOVABLE has no direct mapping.
> Hence, the ZONE_MOVABLE which is considered as highmem type zone could
> have the both types of pages, direct mapped and not. Since
> the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
> required to allocate the memory from it. And, we conservatively need to
> consider the ZONE_MOVABLE as highmem type zone.
> 
> Even in this situation, PageHighMem() for the pages on the ZONE_MOVABLE
> when it is called for checking the direct mapping should return correct
> result. Current implementation of PageHighMem() just returns TRUE
> if the zone of the page is on a highmem type zone. So, it could be wrong
> if the page on the MOVABLE_ZONE is actually direct mapped.
> 
> To solve this potential problem, this patch introduces a new
> PageHighMemZone() macro. In following patches, two use cases of
> PageHighMem() are separated by calling proper macro, PageHighMem() and
> PageHighMemZone(). Then, implementation of PageHighMem() will be changed
> as just checking if the direct mapping exists or not, regardless of
> the zone of the page.
> 
> Note that there are some rules to determine the proper macro.
> 
> 1. If PageHighMem() is called for checking if the direct mapping exists
> or not, use PageHighMem().
> 2. If PageHighMem() is used to predict the previous gfp_flags for
> this page, use PageHighMemZone(). The zone of the page is related to
> the gfp_flags.
> 3. If purpose of calling PageHighMem() is to count highmem page and
> to interact with the system by using this count, use PageHighMemZone().
> This counter is usually used to calculate the available memory for an
> kernel allocation and pages on the highmem zone cannot be available
> for an kernel allocation.
> 4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
> is just copy of the previous PageHighMem() implementation and won't
> be changed.

hm, this won't improve maintainability :(

- Everyone will need to remember when to use PageHighMem() and when
  to use PageHighMemZone().  If they get it wrong, they're unlikely to
  notice any problem in their runtime testing, correct?

- New code will pop up which gets it wrong and nobody will notice for
  a long time.

So I guess we need to be pretty confident that the series "mm/cma:
manage the memory of the CMA area by using the ZONE_MOVABLE" will be
useful and merged before proceeding with this, yes?

On the other hand, this whole series is a no-op until [10/10]
(correct?) so it can be effectively reverted with a single line change,
with later cleanups which revert the other 9 patches.

So I think I'd like to take another look at "mm/cma: manage the memory
of the CMA area by using the ZONE_MOVABLE" before figuring out what to
do here.  Mainly to answer the question "is the new feature valuable
enough to justify the maintainability impact".  So please do take some
care in explaining the end-user benefit when preparing the new version
of that patchset.

