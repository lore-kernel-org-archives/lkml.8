Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4F2C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8BC3206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgF2TYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:24:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:22498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732234AbgF2TYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:12 -0400
IronPort-SDR: P0NquBONXI66EZ8EjWWScDAVlMu26/nRWYk4oTMYSaW+vSlW6sKj2SpwCl4q9HcA3L3yspZJ8f
 f1QRhxqAUY6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144193378"
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="144193378"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 09:57:44 -0700
IronPort-SDR: ab7yGGp3LTENK7bUd1phDwjiigebk0mWVMP2v3rmkM3rourM41GP/9ZXLyy5dvjpom+8+sZI+g
 0YOzMCFkJpXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,295,1589266800"; 
   d="scan'208";a="294937285"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.45.140])
  by orsmga002.jf.intel.com with ESMTP; 29 Jun 2020 09:57:43 -0700
Subject: Re: [Patch] mm: Increase pagevec size on large system
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Vladimir Davydov <vdavydov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
 <20200627031304.GC25039@casper.infradead.org>
 <20200626204704.f023988699421db00e9bdab7@linux-foundation.org>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <6260c66e-68a3-ab3e-4bd9-4a290d068e1f@linux.intel.com>
Date:   Mon, 29 Jun 2020 09:57:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200626204704.f023988699421db00e9bdab7@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/20 8:47 PM, Andrew Morton wrote:
> On Sat, 27 Jun 2020 04:13:04 +0100 Matthew Wilcox <willy@infradead.org> wrote:
> 
>> On Fri, Jun 26, 2020 at 02:23:03PM -0700, Tim Chen wrote:
>>> Enlarge the pagevec size to 31 to reduce LRU lock contention for
>>> large systems.
>>>
>>> The LRU lock contention is reduced from 8.9% of total CPU cycles
>>> to 2.2% of CPU cyles.  And the pmbench throughput increases
>>> from 88.8 Mpages/sec to 95.1 Mpages/sec.
>>
>> The downside here is that pagevecs are often stored on the stack (eg
>> truncate_inode_pages_range()) as well as being used for the LRU list.
>> On a 64-bit system, this increases the stack usage from 128 to 256 bytes
>> for this array.
>>
>> I wonder if we could do something where we transform the ones on the
>> stack to DECLARE_STACK_PAGEVEC(pvec), and similarly DECLARE_LRU_PAGEVEC
>> the ones used for the LRUs.  There's plenty of space in the header to
>> add an unsigned char sz, delete PAGEVEC_SIZE and make it an variable
>> length struct.
>>
>> Or maybe our stacks are now big enough that we just don't care.
>> What do you think?
> 
> And I wonder how useful CONFIG_NR_CPUS is for making this decision. 
> Presumably a lot of general-purpose kernel builds have CONFIG_NR_CPUS
> much larger than the actual number of CPUs.
> 
> I can't think of much of a fix for this, apart from making it larger on
> all kernels, Is there a downside to this?
> 

Thanks for Matthew and Andrew's feedbacks.

I am okay with Matthew's suggestion of keeping the stack pagevec size unchanged.
Andrew, do you have a preference?

I was assuming that for people who really care about saving the kernel memory
usage, they would make CONFIG_NR_CPUS small. I also have a hard time coming
up with a better scheme.

Otherwise, we will have to adjust the pagevec size when we actually 
found out how many CPUs we have brought online.  It seems like a lot
of added complexity for going that route.

Tim
