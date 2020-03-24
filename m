Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4878C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9BF2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbgCXBug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:50:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:63029 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbgCXBuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:50:35 -0400
IronPort-SDR: RaR9pXoKbQBN/XGyVdZiXJe3J99HkBEwKfRs0teY0vJKQa2K5a4HSdGwpZjhbhORPaMcWf+mhR
 fMlvVVTirBsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 18:50:34 -0700
IronPort-SDR: hb5mjBhKyue57icqQi85DOjV/OBJFZdhWqWaHBv3XK63dQ41SilVLnhUr8KHWtkMvg1bvqVUOU
 wAVLSU3WTWJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="264978515"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.83]) ([10.254.208.83])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2020 18:50:29 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH V10 02/11] iommu/uapi: Define a mask for bind data
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-3-git-send-email-jacob.jun.pan@linux.intel.com>
 <ae2a1a46-07ed-8445-d905-37dda1459e28@linux.intel.com>
 <20200323123726.64974d83@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c3a8337b-5e38-d883-5ea7-375ff9209acf@linux.intel.com>
Date:   Tue, 24 Mar 2020 09:50:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323123726.64974d83@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/24 3:37, Jacob Pan wrote:
> On Sun, 22 Mar 2020 09:29:32 +0800> Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> 
>> On 2020/3/21 7:27, Jacob Pan wrote:
>>> Memory type related flags can be grouped together for one simple
>>> check.
>>>
>>> ---
>>> v9 renamed from EMT to MTS since these are memory type support
>>> flags. ---
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>    include/uapi/linux/iommu.h | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>>> index 4ad3496e5c43..d7bcbc5f79b0 100644
>>> --- a/include/uapi/linux/iommu.h
>>> +++ b/include/uapi/linux/iommu.h
>>> @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
>>>    	__u32 pat;
>>>    	__u32 emt;
>>>    };
>>> -
>>> +#define IOMMU_SVA_VTD_GPASID_MTS_MASK
>>> (IOMMU_SVA_VTD_GPASID_CD | \
>>> +					 IOMMU_SVA_VTD_GPASID_EMTE
>>> | \
>>> +					 IOMMU_SVA_VTD_GPASID_PCD
>>> |  \
>>> +
>>> IOMMU_SVA_VTD_GPASID_PWT)
>> As name implies, can this move to intel-iommu.h?
>>
> I also thought about this but the masks are in vendor specific part of
> the UAPI.
> 

I looked through this patch series. It looks good to me. I will do some
code style cleanup and take it to v5.7. I am not the right person to
decide whether include/uapi/linux/iommu.h is the right place for this,
so I will move it to Intel IOMMU driver for now.

Best regards,
baolu
