Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF807C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C17A21775
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 00:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgCCAZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:25:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:18815 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgCCAZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 19:25:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Mar 2020 16:25:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,509,1574150400"; 
   d="scan'208";a="273968558"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga002.fm.intel.com with ESMTP; 02 Mar 2020 16:25:43 -0800
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Minchan Kim" <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
References: <20200228033819.3857058-1-ying.huang@intel.com>
        <20200228034248.GE29971@bombadil.infradead.org>
        <87a7538977.fsf@yhuang-dev.intel.com>
        <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
        <871rqf850z.fsf@yhuang-dev.intel.com>
        <20200228095048.GK3771@dhcp22.suse.cz>
        <87d09u7sm2.fsf@yhuang-dev.intel.com>
        <8005e5a1-e2f2-1e57-ccb4-0cb9371b080d@redhat.com>
Date:   Tue, 03 Mar 2020 08:25:43 +0800
In-Reply-To: <8005e5a1-e2f2-1e57-ccb4-0cb9371b080d@redhat.com> (David
        Hildenbrand's message of "Mon, 2 Mar 2020 15:23:16 +0100")
Message-ID: <878ski708o.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Hildenbrand <david@redhat.com> writes:

> On 02.03.20 15:12, Huang, Ying wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>> 
>>> On Fri 28-02-20 16:55:40, Huang, Ying wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>> [...]
>>>>> E.g., free page reporting in QEMU wants to use MADV_FREE. The guest will
>>>>> report currently free pages to the hypervisor, which will MADV_FREE the
>>>>> reported memory. As long as there is no memory pressure, there is no
>>>>> need to actually free the pages. Once the guest reuses such a page, it
>>>>> could happen that there is still the old page and pulling in in a fresh
>>>>> (zeroed) page can be avoided.
>>>>>
>>>>> AFAIKs, after your change, we would get more pages discarded from our
>>>>> guest, resulting in more fresh (zeroed) pages having to be pulled in
>>>>> when a guest touches a reported free page again. But OTOH, page
>>>>> migration is speed up (avoiding to migrate these pages).
>>>>
>>>> Let's look at this problem in another perspective.  To migrate the
>>>> MADV_FREE pages of the QEMU process from the node A to the node B, we
>>>> need to free the original pages in the node A, and (maybe) allocate the
>>>> same number of pages in the node B.  So the question becomes
>>>>
>>>> - we may need to allocate some pages in the node B
>>>> - these pages may be accessed by the application or not
>>>> - we should allocate all these pages in advance or allocate them lazily
>>>>   when they are accessed.
>>>>
>>>> We thought the common philosophy in Linux kernel is to allocate lazily.
>>>
>>> The common philosophy is to cache as much as possible.
>> 
>> Yes.  This is another common philosophy.  And MADV_FREE pages is
>> different from caches such as the page caches because it has no valid
>> contents.
>
> Side note: It might contain valid content until discarded/zeroed out.
> E.g., an application could use a marker bit (e.g., first bit) to detect
> if the page still contains valid data or not. If the data is still
> marked valid, the content could be reuse immediately. Not sure if there
> is any such application, though :)

I don't think this is the typical use case.  But I admit that this is
possible.

Best Regards,
Huang, Ying
