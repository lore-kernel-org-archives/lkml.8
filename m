Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6C9C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 635062064A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732910AbgDPBqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:46:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:13648 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730833AbgDPBq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:46:27 -0400
IronPort-SDR: rh4PMB+u2via/grgLW28WwEHtfYCVKBYUM7Kp1DL5UcEruUjJ56tHqMHbKAumYSyL8EQqI09Kq
 AwXqLyNlX7QQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 18:46:24 -0700
IronPort-SDR: 4ir7BZso7cfJHuzUa1A+4Z7QoZGNfojvIlXnYMd/siRdmlT3Tu+gzm64EBH0YxTbdZN7y6Gu8/
 nMmEFt/mjn5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,388,1580803200"; 
   d="scan'208";a="245845976"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.171]) ([10.254.208.171])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 18:46:22 -0700
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
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <399dd037-b32e-30a7-013c-b68e9a3bbc7a@linux.intel.com>
Date:   Thu, 16 Apr 2020 09:46:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D8207B2@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/15 17:30, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 15, 2020 1:26 PM
>>
>> Currently, the page request interrupt thread handles the page
>> requests in the queue in this way:
>>
>> - Clear PPR bit to ensure new interrupt could come in;
>> - Read and record the head and tail registers;
>> - Handle all descriptors between head and tail;
>> - Write tail to head register.
>>
>> This might cause some descriptors to be handles multiple times.
>> An example sequence:
>>
>> - Thread A got scheduled with PRQ_1 and PRQ_2 in the queue;
>> - Thread A clear the PPR bit and record the head and tail;
>> - A new PRQ_3 comes and Thread B gets scheduled;
>> - Thread B record the head and tail which includes PRQ_1
>>    and PRQ_2.
> I may overlook something but isn't the prq interrupt thread
> per iommu then why would two prq threads contend here?

The prq interrupt could be masked by the PPR (Pending Page Request) bit
in Page Request Status Register. In the interrupt handling thread once
this bit is clear, new prq interrupts are allowed to be generated.

So, if a page request is in process and the PPR bit is cleared, another
page request from any devices under the same iommu could trigger another
interrupt thread.

Best regards,
baolu
