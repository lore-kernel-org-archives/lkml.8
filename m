Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F18EC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D5E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbgCPBmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:42:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:6368 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgCPBmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:42:10 -0400
IronPort-SDR: O/Z2YOTLKLqoK0Fk5c+mgnq9OCGA7MrqfRqvIKQSu6cK3wbeo+jfRGPvgX75zyVdvhTaUNrKq+
 5IHFqPxwtwcQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2020 18:42:09 -0700
IronPort-SDR: lYtXIWizZOAFxPjagGVaF4ViQ1QnfLKlavNwEWajeu07MmSbJti9quaIsPEdONGfRUQppcMPDV
 Dw3YZ6VW3g5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,558,1574150400"; 
   d="scan'208";a="278876272"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga002.fm.intel.com with ESMTP; 15 Mar 2020 18:42:06 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        "Hugh Dickins" <hughd@google.com>, Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm: Code cleanup for MADV_FREE
References: <20200313090056.2104105-1-ying.huang@intel.com>
        <20200313154110.GH21007@dhcp22.suse.cz>
Date:   Mon, 16 Mar 2020 09:42:06 +0800
In-Reply-To: <20200313154110.GH21007@dhcp22.suse.cz> (Michal Hocko's message
        of "Fri, 13 Mar 2020 16:41:10 +0100")
Message-ID: <87lfo1rs7l.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:

> On Fri 13-03-20 17:00:56, Huang, Ying wrote:
>> From: Huang Ying <ying.huang@intel.com>
>> 
>> Some comments for MADV_FREE is revised and added to help people understand the
>> MADV_FREE code, especially the page flag, PG_swapbacked.  This makes
>> page_is_file_cache() isn't consistent with its comments.  So the function is
>> renamed to page_is_file_lru() to make them consistent again.  All these are put
>> in one patch as one logical change.
>> 
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>> Suggested-by: David Rientjes <rientjes@google.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Hugh Dickins <hughd@google.com>
>> Cc: Rik van Riel <riel@surriel.com>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Although I would rephrased this a bit
>> + * PG_swapbacked is cleared if the page is page cache page backed by a regular
>> + * file system or anonymous page lazily freed (e.g. via MADV_FREE).  It is set
>> + * if the page is normal anonymous page, tmpfs or otherwise RAM or swap backed.
>> + *
>
> PG_swapbacked is set when a page uses swap as a backing storage. This
> are usually PageAnon or shmem pages but please note that even anonymous
> pages might lose their PG_swapbacked flag when they simply can be
> dropped (e.g. as a result of MADV_FREE).

This looks better, Thanks!  I will send a new version with this.

Best Regards,
Huang, Ying
