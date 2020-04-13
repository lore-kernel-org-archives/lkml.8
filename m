Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A6BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F720735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:12:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgDMPMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:12:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:10948 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbgDMPMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:12:03 -0400
IronPort-SDR: ueho4ZPEHhnjcyGHYvE7m3YPjtdQFjeFC8Wyz1WzPD793IGU1wj8f9imEeeY3HxwXab5Oc85he
 1LPdzymQTSGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:12:02 -0700
IronPort-SDR: 5ovm+3aNlY5JeFBIp9hCB57sR/i0YZc9XXs/RuhyVpRwbXl7IbEuP2IyUpzW3KpyM647xsdQE/
 fjV2Ufjl/PXA==
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="453186629"
Received: from ahduyck-mobl1.amr.corp.intel.com (HELO [10.254.29.128]) ([10.254.29.128])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 08:12:02 -0700
Subject: Re: [RFC PATCH 4/4] mm: Add PG_zero support
To:     Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20200412090945.GA19582@open-light-1.localdomain>
 <20200412101223.GK21484@bombadil.infradead.org>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <5eb37d79-6420-fcb9-2b4c-6cc6194afcd9@linux.intel.com>
Date:   Mon, 13 Apr 2020 08:11:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200412101223.GK21484@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/2020 3:12 AM, Matthew Wilcox wrote:
> On Sun, Apr 12, 2020 at 05:09:49AM -0400, liliangleo wrote:
>> Zero out the page content usually happens when allocating pages,
>> this is a time consuming operation, it makes pin and mlock
>> operation very slowly, especially for a large batch of memory.
>>
>> This patch introduce a new feature for zero out pages before page
>> allocation, it can help to speed up page allocation.
>>
>> The idea is very simple, zero out free pages when the system is
>> not busy and mark the page with PG_zero, when allocating a page,
>> if the page need to be filled with zero, check the flag in the
>> struct page, if it's marked as PG_zero, zero out can be skipped,
>> it can save cpu time and speed up page allocation.
> 
> We are very short on bits in the page flags.  If we can implement this
> feature without using another one, this would be good.
> 
> If the bit is only set on pages which are PageBuddy(), we can definitely
> find space for it as an alias of another bit.


I had considered doing something similar several months back because one 
of the side effects in the VM is that most of the pages appear to have 
been zeroed by page reporting. However the problem is that in order to 
handle the zeroing case you have to push the flag outside the PageBuddy 
region, and you cannot guarantee that the page is even expected to be 
zeroed since it might have been zeroed before it was freed, so it is 
just adding work of having to clear an extra flag some time after 
allocation.

In addition, unlike madvising the page away there is a pretty 
significant performance penalty for having to clear the page a second 
time when the page is split or merged.
