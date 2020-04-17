Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90302C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7302B21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 03:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgDQDZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 23:25:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:46448 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgDQDZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 23:25:22 -0400
IronPort-SDR: iErVSfnI38KwtWQcH4rNDLRGacjRCeNcMdBt/L03K6KGp4kSKPATK795CQhFE6Uq6uZ4mN5Iqc
 CrzmqAlQrtig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 20:25:21 -0700
IronPort-SDR: Y6NxNoqwaocfo1ldFFdrC25qBWTuSkIdagvjBrnhQfQIWAVfWzvOgqnb12F5Lnv/SZ95ck/O34
 JjcEmikH2k1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="428084176"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.63]) ([10.254.212.63])
  by orsmga005.jf.intel.com with ESMTP; 16 Apr 2020 20:25:19 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/7] iommu/vt-d: Save prq descriptors in an internal
 list
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-6-baolu.lu@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D8207B2@SHSMSX104.ccr.corp.intel.com>
 <399dd037-b32e-30a7-013c-b68e9a3bbc7a@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7e95de33-95e9-0647-9611-aa4ec72171c9@linux.intel.com>
Date:   Fri, 17 Apr 2020 11:25:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <399dd037-b32e-30a7-013c-b68e9a3bbc7a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2020/4/16 9:46, Lu Baolu wrote:
> On 2020/4/15 17:30, Tian, Kevin wrote:
>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>> Sent: Wednesday, April 15, 2020 1:26 PM
>>>
>>> Currently, the page request interrupt thread handles the page
>>> requests in the queue in this way:
>>>
>>> - Clear PPR bit to ensure new interrupt could come in;
>>> - Read and record the head and tail registers;
>>> - Handle all descriptors between head and tail;
>>> - Write tail to head register.
>>>
>>> This might cause some descriptors to be handles multiple times.
>>> An example sequence:
>>>
>>> - Thread A got scheduled with PRQ_1 and PRQ_2 in the queue;
>>> - Thread A clear the PPR bit and record the head and tail;
>>> - A new PRQ_3 comes and Thread B gets scheduled;
>>> - Thread B record the head and tail which includes PRQ_1
>>>    and PRQ_2.
>> I may overlook something but isn't the prq interrupt thread
>> per iommu then why would two prq threads contend here?
> 
> The prq interrupt could be masked by the PPR (Pending Page Request) bit
> in Page Request Status Register. In the interrupt handling thread once
> this bit is clear, new prq interrupts are allowed to be generated.
> 
> So, if a page request is in process and the PPR bit is cleared, another
> page request from any devices under the same iommu could trigger another
> interrupt thread.

Rechecked the code. You are right. As long as the interrupt thread is
per iommu, there will only single prq thread scheduled. I will change
this accordingly in the new version. Thank you for pointing this out.

Best regards,
baolu
