Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC227C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DFAC20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgCIF0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:26:34 -0400
Received: from mga12.intel.com ([192.55.52.136]:60447 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIF0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:26:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 22:26:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,532,1574150400"; 
   d="scan'208";a="265139337"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga004.fm.intel.com with ESMTP; 08 Mar 2020 22:26:30 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <20200228094954.GB3772@suse.de>
        <87h7z76lwf.fsf@yhuang-dev.intel.com> <20200302151607.GC3772@suse.de>
        <87zhcy5hoj.fsf@yhuang-dev.intel.com>
        <20200303080945.GX4380@dhcp22.suse.cz>
        <87o8td4yf9.fsf@yhuang-dev.intel.com>
        <20200303085805.GB4380@dhcp22.suse.cz>
        <87ftep4pzy.fsf@yhuang-dev.intel.com>
        <20200304095802.GE16139@dhcp22.suse.cz>
        <87blpc2wxj.fsf@yhuang-dev.intel.com> <20200305104859.GG3772@suse.de>
Date:   Mon, 09 Mar 2020 13:26:29 +0800
In-Reply-To: <20200305104859.GG3772@suse.de> (Mel Gorman's message of "Thu, 5
        Mar 2020 10:48:59 +0000")
Message-ID: <874kuyyu7u.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman <mgorman@suse.de> writes:

> I think the only concrete outcome has been that userspace potentially
> benefits if the total number of MADV_FREE pages is reported
> globally. Even that is marginal as smaps has the information to tell
> the difference between high RSS due to a memory leak and high RSS
> usage due to MADV_FREE. The /proc/vmstats for MADV_FREE are of
> marginal benefit given that they do not tell us much about the current
> number of MADV_FREE pages in the system.

We can implement a counter for MADV_FREE that increases when we
ClearPageSwapBacked() and decrease when we SetPageSwapBacked() for an
anonymous page.  But this cannot count lazily freed pages correctly.
Because when a clean MDV_FREE page becomes dirty, there's no page fault
so we will not be notified.  And you have never run into the MADV_FREE
issues other than the memory leaking debugging...

Best Regards,
Huang, Ying

