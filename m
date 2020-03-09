Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9CEC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA6520665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 02:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCICP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 22:15:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:40323 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgCICP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 22:15:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Mar 2020 19:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,530,1574150400"; 
   d="scan'208";a="230774999"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga007.jf.intel.com with ESMTP; 08 Mar 2020 19:15:23 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] mm: Add PageLayzyFree() helper functions for MADV_FREE
References: <20200304081732.563536-1-ying.huang@intel.com>
        <d7dcb472-76fa-9d8b-513a-793a7ab8580d@redhat.com>
        <87y2sf1ki1.fsf@yhuang-dev.intel.com>
        <alpine.DEB.2.21.2003061240480.181741@chino.kir.corp.google.com>
Date:   Mon, 09 Mar 2020 10:15:22 +0800
In-Reply-To: <alpine.DEB.2.21.2003061240480.181741@chino.kir.corp.google.com>
        (David Rientjes's message of "Fri, 6 Mar 2020 12:41:32 -0800")
Message-ID: <87eeu2z32d.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes <rientjes@google.com> writes:

> On Thu, 5 Mar 2020, Huang, Ying wrote:
>
>> > In general, I don't think this patch really improves the situation ...
>> > it's only a handful of places where this change slightly makes the code
>> > easier to understand. And there, only slightly ... I'd prefer better
>> > comments instead (e.g., in PageAnon()), documenting what it means for a
>> > anon page to either have PageSwapBacked() set or not.
>> 
>> Personally, I still prefer the better named functions than the comments
>> here and there.  But I can understand that people may have different
>> flavor.
>> 
>
> Maybe add a comment to page-flags.h referring to what PageSwapBacked 
> indicates when PageAnon is true?

If someone find a confusing PageSwapBacked() invocation, and if we only
want to use comments to resolve the confusing, the best place to add the
comments is above the line where PageSwapBacked() is invoked.  Because
it's harder for people to dig out the right comments in page-flags.h.
The appropriate named helper functions can replace that comments and be
more elegant.

Best Regards,
Huang, Ying
