Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E537FC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B728420730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgBEXty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:49:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:5794 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbgBEXty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:49:54 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 15:49:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,407,1574150400"; 
   d="scan'208";a="225981808"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2020 15:49:51 -0800
Date:   Thu, 6 Feb 2020 07:50:08 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200205235007.GA28870@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205231945.GB28446@richard>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
>On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrote:
>>Let's use a calculation that's easier to understand and calculates the
>>same result. Reusing existing macros makes this look nicer.
>>
>>We always want to have the number of pages (> 0) to the next section
>>boundary, starting from the current pfn.
>>
>>Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>>Cc: Andrew Morton <akpm@linux-foundation.org>
>>Cc: Michal Hocko <mhocko@kernel.org>
>>Cc: Oscar Salvador <osalvador@suse.de>
>>Cc: Baoquan He <bhe@redhat.com>
>>Cc: Wei Yang <richardw.yang@linux.intel.com>
>>Signed-off-by: David Hildenbrand <david@redhat.com>
>
>Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>
>BTW, I got one question about hotplug size requirement.
>
>I thought the hotplug range should be section size aligned, while taking a
>look into current code function check_hotplug_memory_range() guard the range.
>
>This function says the range should be block_size aligned. And if I am
>correct, block size on x86 should be in the range
>
>    [MIN_MEMORY_BLOCK_SIZE, MEM_SIZE_FOR_LARGE_BLOCK]
>    
>And MIN_MEMORY_BLOCK_SIZE is section size.
>
>Seems currently we support subsection hotplug? Then how a subsection range got
>hotplug? Or this patch is a pre-requisite?
>

One more question is we support hot-add subsection memory but not support
hot-online subsection memory.

Is my understanding correct?

-- 
Wei Yang
Help you, Help me
