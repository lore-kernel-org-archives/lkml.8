Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96EBC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F0B2469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 06:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgB1GsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:48:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:33925 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgB1GsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 01:48:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2020 22:48:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,493,1574150400"; 
   d="scan'208";a="231018405"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga007.fm.intel.com with ESMTP; 27 Feb 2020 22:47:57 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>,
        "Vlastimil Babka" <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC 2/3] mm: Add a new page flag PageLayzyFree() for MADV_FREE
References: <20200228033819.3857058-3-ying.huang@intel.com>
        <0C8CC772-5840-4F0C-9859-C1D7B8BF6025@redhat.com>
Date:   Fri, 28 Feb 2020 14:47:57 +0800
In-Reply-To: <0C8CC772-5840-4F0C-9859-C1D7B8BF6025@redhat.com> (David
        Hildenbrand's message of "Fri, 28 Feb 2020 07:13:33 +0100")
Message-ID: <87eeuf8axu.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

>> Am 28.02.2020 um 04:38 schrieb Huang, Ying <ying.huang@intel.com>:
>> 
>> ﻿From: Huang Ying <ying.huang@intel.com>
>> 
>> Now !PageSwapBacked() is used as the flag for the pages freed lazily
>> via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
>> new page flag for that to improve the code readability.
>
> This patch subject and description is *really* confusing. You‘re adding a helper function, not a page flag. It‘s a fairly easy refactoring.

Yes.  Thanks for reminding.  I will revise this in the next version.

Best Regards,
Huang, Ying

> (Adding new page flags is close to impossible).
>
> Cheers!
