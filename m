Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B52AC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F552051A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHBkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:40:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:8757 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgEHBkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:40:23 -0400
IronPort-SDR: Jwp2tH+KPZI/+BqYQsAeCeHXHd4PXtbXqmmB/DFqxyQwEEyXAzhuAwAA54PYgWst2CDi3PNktW
 dv1Zm/9PtFHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 18:40:22 -0700
IronPort-SDR: 7j287Im+zYIY+vKmt4AEeMUCGpQudOdlqLO9h3v8FS2ILG5N5Zg3xeG2O5fNPd7T19gp2qKSTj
 Ia6QO6odw44A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="278794196"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2020 18:40:19 -0700
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        ashok.raj@intel.com, Liu Yi L <yi.l.liu@intel.com>,
        kevin.tian@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iommu/vt-d: debugfs: Add support to show inv queue
 internals
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-3-baolu.lu@linux.intel.com>
 <20200507094706.6f6a605f@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f6ee653e-01d8-5728-207b-f423f979b624@linux.intel.com>
Date:   Fri, 8 May 2020 09:37:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507094706.6f6a605f@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 5/8/20 12:47 AM, Jacob Pan wrote:
> Hi Baolu,
> 
> Very helpful feature, thanks for doing this. Just a small suggestion.

Thanks a lot for reviewing my patch.

> 
> On Thu,  7 May 2020 08:55:31 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> Export invalidation queue internals of each iommu device through the
>> debugfs.
>>
>> Example of such dump on a Skylake machine:
>>
>> $ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
>> Invalidation queue on IOMMU: dmar1
>>   Base: 0x1672c9000      Head: 80        Tail: 80
>> Index           qw0                     qw1                     status
>>      0   0000000000000004        0000000000000000
>> 0000000000000000 1   0000000200000025        00000001672be804
>> 0000000000000000 2   0000000000000011        0000000000000000
>> 0000000000000000 3   0000000200000025        00000001672be80c
>> 0000000000000000 4   00000000000000d2        0000000000000000
>> 0000000000000000 5   0000000200000025        00000001672be814
>> 0000000000000000 6   0000000000000014        0000000000000000
>> 0000000000000000 7   0000000200000025        00000001672be81c
>> 0000000000000000 8   0000000000000014        0000000000000000
>> 0000000000000000 9   0000000200000025        00000001672be824
>> 0000000000000000
>>
> Head and Tail shows the offset, and queue is dump with index. Would it
> be nice to mark where the Head and Tail is in the list?

The Head and Tail actually show the index. I will mark it clearly in the
dump to avoid any confusion. Thanks for the reminding.

> In your example, the queue is empty (H=T), would be nice to see where
> the previous entry is if there were any faults.
> 

The qi_check_fault() has already cleared the faults and moved ahead the
HEAD register. So probably the developers have to check the kernel log
and locate the fault descriptor by themselves.

Best regards,
baolu
