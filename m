Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C784C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAB0207D0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGIPX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:23:57 -0400
Received: from mga07.intel.com ([134.134.136.100]:63085 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbgGIPX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:23:56 -0400
IronPort-SDR: VwTqOj2jPLcowky/2JJ09tQO6hG1v9cFL/rs2Wl/m4iXIagaqsypRDWkUIYwSaGMrNpTEHt9xJ
 GOeZBFAnKerA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="212926219"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="212926219"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 08:23:42 -0700
IronPort-SDR: o7gO3hg17ryKJug7bQpOb35jPcYNb2P308g6e0B8Bqy4Yi0NV3vsp6mEkAAEJIbLnhpdHPGjng
 5VAC4qaBV8Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="358475675"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.57.174]) ([10.209.57.174])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2020 08:23:41 -0700
Subject: Re: [PATCH v2] dmaengine: check device and channel list for empty
To:     Jiri Slaby <jirislaby@kernel.org>, vkoul@kernel.org
Cc:     Swathi Kovvuri <swathi.kovvuri@intel.com>, peter.ujfalusi@ti.com,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <159319496403.69045.16298280729899651363.stgit@djiang5-desk3.ch.intel.com>
 <ea3ef860-0b7a-e8da-8cf9-5930a8f3b7ed@kernel.org>
 <b9e8f171-6961-b483-c698-18a89e58f361@intel.com>
 <852318ec-9e18-3dee-a91d-1cf4dddb8906@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <83932426-d52a-2e62-9d4b-5abb134a64df@intel.com>
Date:   Thu, 9 Jul 2020 08:23:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <852318ec-9e18-3dee-a91d-1cf4dddb8906@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/8/2020 10:35 PM, Jiri Slaby wrote:
> On 07. 07. 20, 17:42, Dave Jiang wrote:
>> On 7/6/2020 11:05 PM, Jiri Slaby wrote:
>>> On 26. 06. 20, 20:09, Dave Jiang wrote:
>>>> Check dma device list and channel list for empty before iterate as the
>>>> iteration function assume the list to be not empty. With devices and
>>>> channels now being hot pluggable this is a condition that needs to be
>>>> checked. Otherwise it can cause the iterator to spin forever.
>>>
>>> Could you be a little bit more specific how this can spin forever? I.e.
>>> can you attach a stacktrace of such a behaviour?
>>
>> I can't seem to find the original splat that lead me to the conclusion
>> of it's spinning forever. As I recall, the issue seems to produce
>> different splats and not always consistent in being reproduced. Here's a
>> partial splat that was tracked by the internal bug database. Since with
>> the dma device and channel list being are hot added and removed, the
>> device and channel lists can be empty. The list_entry() and friends
>> expect the list to not be empty (according to header comment), I added
>> the check to ensure that isn't the case before using them in dmaengine.
> 
> Yes, the comment states that as it is true: you receive a
> wild/non-checkable pointer if you do list_entry on an empty list. BUT
> have you actually read what I wrote:
> 
>>> As in the empty case, "&pos->member" is "head" (look into
>>> list_for_each_entry) and the for loop should loop exactly zero times.
> 
> HERE ^^^^
> 
>> With the fix, we can no longer produce any of the splats. So maybe the
>> above was a bad description of the issue.
> 
> No, not only the description, worse, the patch proper looks wrong.
> 
>> [ 4216.048375]  ? dma_channel_rebalance+0x7b/0x250
>> [ 4216.056360]  dma_async_device_register+0x349/0x3a0
>> [ 4216.064604]  idxd_register_dma_device+0x90/0xc0 [idxd]
>> [ 4216.073175]  idxd_config_bus_probe.cold+0x7d/0x1fc [idxd]
> 
> So, the good part in the patch is the fixed locking in
> dma_async_device_register. Otherwise it adds nonsense checks. So you
> fixed the issue only by a chance, by a side effect as Peter pointed out.
> Leaving aside that you broke dma_request_chan -- that could happen to
> anybody.
> 
> Vinod, please drop/revert this patch. Then start over only with
> dma_async_device_register fixed locking.

I'll start on the proper fix.

> 
> thanks,
> 
