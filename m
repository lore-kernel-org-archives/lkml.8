Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38901C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB2CE2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 00:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCYA6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 20:58:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:49036 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgCYA6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 20:58:04 -0400
IronPort-SDR: IkT58Ib1yHBEOUxWU7a99sy7VrVYWoq/P/xRhFcXaBX8Tkrh3SWQsZhdeoCsaPsqqn8Sv85xa5
 QueftadsfboQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 17:48:55 -0700
IronPort-SDR: dtHPvsrDTJbb71F/Q2NRkZDgf4EaQFXvvH0YunX2hhXNbctEMRMsmQtQcH+Qd/SLuiVEsk7tQk
 BqFNc4vlY1DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="357663286"
Received: from yujietax-mobl1.ccr.corp.intel.com (HELO [10.254.214.161]) ([10.254.214.161])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2020 17:48:52 -0700
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Remove redundant IOTLB flush
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
 <20200320092047.4a4cf551@jacob-builder>
 <06c9751a-417d-3c32-65af-0788593f811a@linux.intel.com>
 <20200324083125.27b78594@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5aff3f99-9f8b-4d61-8c88-8b22a8f7f722@linux.intel.com>
Date:   Wed, 25 Mar 2020 08:48:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200324083125.27b78594@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/24 23:31, Jacob Pan wrote:
> On Sat, 21 Mar 2020 09:32:45 +0800
> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> On 2020/3/21 0:20, Jacob Pan wrote:
>>> On Fri, 20 Mar 2020 21:45:26 +0800
>>> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
>>>    
>>>> On 2020/3/20 12:32, Jacob Pan wrote:
>>>>> IOTLB flush already included in the PASID tear down process. There
>>>>> is no need to flush again.
>>>> It seems that intel_pasid_tear_down_entry() doesn't flush the pasid
>>>> based device TLB?
>>>>   
>>> I saw this code in intel_pasid_tear_down_entry(). Isn't the last
>>> line flush the devtlb? Not in guest of course since the passdown
>>> tlb flush is inclusive.
>>>
>>> 	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
>>> 	iotlb_invalidation_with_pasid(iommu, did, pasid);
>>>
>>> 	/* Device IOTLB doesn't need to be flushed in caching mode.
>>> */ if (!cap_caching_mode(iommu->cap))
>>> 		devtlb_invalidation_with_pasid(iommu, dev, pasid);
>>>    
>> But devtlb_invalidation_with_pasid() doesn't do the right thing, it
>> flushes the device tlb, instead of pasid-based device tlb.
>>
> Hmm, you are right. But the function name is misleading, pasid argument
> is not used, is there a reason why?
> This is used for PASID based device IOTLB flush, right?
> 

Yes. I will fix and put your patch after it.

Best regards,
baolu
