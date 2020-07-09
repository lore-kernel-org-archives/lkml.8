Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC43C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F57720708
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 00:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgGIAtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:49:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:41630 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGIAtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 20:49:07 -0400
IronPort-SDR: C4m2LY0m9qEZaVnoKLPUg5PV6ZL8cHd3/JDCufNR6kdSPlJun7wc63geWi54C1b/glvQV1NWCf
 oyybdq+dKiPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="212838297"
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="scan'208";a="212838297"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 17:49:06 -0700
IronPort-SDR: MsuP/jCn6yqWaqU9WMjnXNhTSD5xPOd5WBWLnLNdLcb2O4yzysFZWViMMGBEHLuFidFNATE9Y+
 TIXsXxB6u2XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,329,1589266800"; 
   d="scan'208";a="457701959"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga005.jf.intel.com with ESMTP; 08 Jul 2020 17:49:03 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 1/5] docs: IOMMU user API
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <6d01dac0-aa9d-e22b-9baf-28c2f538871a@linux.intel.com>
 <20200708082905.1b5da847@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <3777718a-9984-f9a5-5ab3-7f5e5782c148@linux.intel.com>
Date:   Thu, 9 Jul 2020 08:44:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708082905.1b5da847@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 7/8/20 11:29 PM, Jacob Pan wrote:
> On Wed, 8 Jul 2020 10:07:13 +0800
> Lu Baolu <baolu.lu@linux.intel.com> wrote:
> 
>> Hi,
>>
>> On 7/8/20 7:43 AM, Jacob Pan wrote:
>>> +For UAPIs that are shared with in-kernel users, a wrapper function
>>> +is provided to distinguish the callers. For example,
>>> +
>>> +Userspace caller ::
>>> +
>>> +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
>>> device *dev,
>>> +  void __user *udata)
>>> +
>>> +In-kernel caller ::
>>> +
>>> +  int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
>>> struct device *dev,
>>> +  struct iommu_gpasid_bind_data *data)
>>
>> iommu_page_response() may have the same needs. Can we reach an
>> agreement on the naming rules?
>>
> Yes iommu_page_response() also has to deal with in-kernel and UAPI
> callers. I left it out because I thought the current VFIO and SVA common
> code is not ready for PRQ yet, I might be reading old news :) argsz
> need to be handled as well.
> 
> Perhaps we can wait until this set is settled? Do you have a suggestion
> on the naming rules?

I have no suggestion on the naming rules, just wanted to check whether
others have any preference. I agree that we can wait until this series
is settled.

Best regards,
baolu
