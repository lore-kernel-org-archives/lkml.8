Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CCAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752FE207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgEGGrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:47:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:47878 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgEGGrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:47:45 -0400
IronPort-SDR: yBo+CBlGLSVjteJDBjmJ1MTNvhlUjKS4lhiHO2YrtpA6sDqT4EYPexWno/l1xCGOKTi2jPqKGT
 hBZs0bAj6MKg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 23:47:44 -0700
IronPort-SDR: 5pgQX32zHuoaoJHS0ypm2zrWQM8pnclLJQUVs6cFKCishwiQrOTaJJ+NBWZHQnrRUCq8v9KmQl
 AXNNhZ/1Fliw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="260429256"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.169.187]) ([10.249.169.187])
  by orsmga003.jf.intel.com with ESMTP; 06 May 2020 23:47:42 -0700
Cc:     baolu.lu@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] iommu/vt-d: Add page request draining support
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <MWHPR11MB16452D6184F192F6B10784EE8CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <a6b404ef-4a0d-7ad3-2e20-91060e5374c0@linux.intel.com>
Date:   Thu, 7 May 2020 14:47:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB16452D6184F192F6B10784EE8CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thanks a lot for reviewing.

On 2020/5/7 14:38, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, May 7, 2020 8:55 AM
>>
>> When a PASID is stopped or terminated, there can be pending PRQs
>> (requests that haven't received responses) in the software and
>> remapping hardware. The pending page requests must be drained
>> so that the pasid could be reused. The chapter 7.10 in the VT-d
>> specification specifies the software steps to drain pending page
>> requests and responses.
>>
>> This includes two parts:
>>   - PATCH 1/4 ~ 2/4: refactor the qi_submit_sync() to support multiple
>>     descriptors per submission which will be used in the following
>>     patch.
>>   - PATCH 3/4 ~ 4/4: add page request drain support after a pasid entry
>>     is torn down.
>>
> I think you should mention that this series depends on Jacob's nested
> SVA series.
> 

Yes. It's based on Jacob's vSVA series since guest unbind also requires
prq draining.

Best regards,
baolu
