Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D239C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F0320659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgBFLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:37:59 -0500
Received: from mga18.intel.com ([134.134.136.126]:49547 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgBFLh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:37:58 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 03:37:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="264572935"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2020 03:37:56 -0800
Date:   Thu, 6 Feb 2020 19:38:12 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Easier calculation to get pages to
 next section boundary
Message-ID: <20200206113812.GA7092@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200205135251.37488-1-david@redhat.com>
 <20200205231945.GB28446@richard>
 <20200205235007.GA28870@richard>
 <20200206001317.GH8965@MiWiFi-R3L-srv>
 <20200206003736.GI8965@MiWiFi-R3L-srv>
 <20200206022644.6u7pxf7by2w5trmi@master>
 <20200206024816.GK8965@MiWiFi-R3L-srv>
 <20200206043401.22i2cucwqctsrtps@master>
 <20200206043924.GM8965@MiWiFi-R3L-srv>
 <14cca79e-2e76-28ef-1a17-81f044548c33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14cca79e-2e76-28ef-1a17-81f044548c33@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 10:01:21AM +0100, David Hildenbrand wrote:
>On 06.02.20 05:39, Baoquan He wrote:
>> On 02/06/20 at 04:34am, Wei Yang wrote:
>>> On Thu, Feb 06, 2020 at 10:48:16AM +0800, Baoquan He wrote:
>>>> On 02/06/20 at 02:26am, Wei Yang wrote:
>>>>> On Thu, Feb 06, 2020 at 08:37:36AM +0800, Baoquan He wrote:
>>>>>> On 02/06/20 at 08:13am, Baoquan He wrote:
>>>>>>> On 02/06/20 at 07:50am, Wei Yang wrote:
>>>>>>>> On Thu, Feb 06, 2020 at 07:19:45AM +0800, Wei Yang wrote:
>>>>>>>>> On Wed, Feb 05, 2020 at 02:52:51PM +0100, David Hildenbrand wrote:
>>>>>>>>>> Let's use a calculation that's easier to understand and calculates the
>>>>>>>>>> same result. Reusing existing macros makes this look nicer.
>>>>>>>>>>
>>>>>>>>>> We always want to have the number of pages (> 0) to the next section
>>>>>>>>>> boundary, starting from the current pfn.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Segher Boessenkool <segher@kernel.crashing.org>
>>>>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>>>>> Cc: Michal Hocko <mhocko@kernel.org>
>>>>>>>>>> Cc: Oscar Salvador <osalvador@suse.de>
>>>>>>>>>> Cc: Baoquan He <bhe@redhat.com>
>>>>>>>>>> Cc: Wei Yang <richardw.yang@linux.intel.com>
>>>>>>>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>>>>>>>
>>>>>>>>> Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>
>>>>>>>>>
>>>>>>>>> BTW, I got one question about hotplug size requirement.
>>>>>>>>>
>>>>>>>>> I thought the hotplug range should be section size aligned, while taking a
>>>>>>>>> look into current code function check_hotplug_memory_range() guard the range.
>>>>>>>
>>>>>>> A good question. The current code should be block size aligned. I
>>>>>>> remember in some places we assume each block comprise all the sections.
>>>>>>> Can't imagine one or some of them are half section filled.
>>>>>>
>>>>>> I could be wrong, half filled block may not cause problem. 
>>>>>>
>>>>>
>>>>> David must be angry about our flooding the mail list :-)
>>>>
>>>> Believe he won't, :-) If you like, we can talk off line.
>>>>
>>>>>
>>>>> Check the code again, there are two memory range check:
>>>>>
>>>>>   * check_hotplug_memory_range(), block/section aligned
>>>>>   * check_pfn_span(), subsection aligned
>>>>>
>>>>> The second check, check_pfn_span() in __add_pages(), enable the capability to
>>>>> add a memory range with subsection size.
>>>>>
>>>>> This means hotplug still keeps section alignment.
>>>>
>>>> memremap_pages() also call add_pages(), it doesn't have the
>>>> check_hotplug_memory_range() invocation. check_pfn_span() is made for
>>>> it specifically.
>>>>
>>>
>>> If my understanding is correct, memremap_pages() is used to add some dev
>>> memory to system. This is the use case which Dan want to enable for
>>> sub-section. Since memremap_pages() is not called in mem-hotplug path, this
>>> doesn't affect the hotplug range alignment.
>> 
>> Yeah, we are on the same page.
>
>We allow sub-section hoy-add only for device memory/hmm. BIOS often
>align PMEM devices to sub-sections, and not supporting this makes life
>difficult to support these devices. (You cannot simply cut off something
>of a disk :) )
>
>System memory can only be hotplugged in memory block granularity, the
>same granularity onlining/offlining from user space will happen. Boot
>memory, however, can be sub-section aligned, but can never be offlined
>(as it contains holes) and therefore never be removed.
>

This makes life easier.

Thanks for your explanation.

-- 
Wei Yang
Help you, Help me
