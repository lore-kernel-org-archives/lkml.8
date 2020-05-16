Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9266B206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 06:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgEPGC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 02:02:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:51546 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgEPGC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 02:02:29 -0400
IronPort-SDR: oNBafBWNn7G1LUNTsdS1ud4OQIGb13yy1zzPi4A7J4H5sWShRCMi2KWYH0LhfifhulV6bq852W
 8RdslZIdjsuQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 23:02:29 -0700
IronPort-SDR: 3GJ8TXEoFW0EIiFZDPBR6yeHboZpe9vfcLmgL3m9fnWovY/Jny8IZYD6zHr1LD+Pv7F5CDjJWh
 lO0Ic4xBJQkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,397,1583222400"; 
   d="scan'208";a="281439251"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.172.124]) ([10.249.172.124])
  by orsmga002.jf.intel.com with ESMTP; 15 May 2020 23:02:25 -0700
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christoph Hellwig <hch@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200514055930.GD22388@infradead.org>
 <20200514085745.105af4fb@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <462cad5b-624d-6f77-9503-82d2c5142940@linux.intel.com>
Date:   Sat, 16 May 2020 14:02:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200514085745.105af4fb@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob,

On 2020/5/14 23:57, Jacob Pan wrote:
> Hi Christoph,
> 
> Thanks a lot for the reviews, comments below.
> 
> Jacob
> 
> On Wed, 13 May 2020 22:59:30 -0700
> Christoph Hellwig<hch@infradead.org>  wrote:
> 
>>> +	if (dev_is_pci(dev)) {
>>> +		/* VT-d supports devices with full 20 bit PASIDs
>>> only */
>>> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
>>> +			return -EINVAL;
>>> +	} else {
>>> +		return -ENOTSUPP;
>>> +	}
>> This looks strange.  Why not:
>>
>> 	if (!dev_is_pci(dev)) {
>> 		return -ENOTSUPP;
>>
>> 	/* VT-d supports devices with full 20 bit PASIDs only */
>> 	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
>> 		return -EINVAL;
>>
> That is better, will do.
> 
>>> +		for_each_svm_dev(sdev, svm, dev) {
>>> +			/*
>>> +			 * For devices with aux domains, we should
>>> allow multiple
>>> +			 * bind calls with the same PASID and pdev.
>>> +			 */
>>> +			if (iommu_dev_feature_enabled(dev,
>>> IOMMU_DEV_FEAT_AUX)) {
>>> +				sdev->users++;
>>> +			} else {
>>> +				dev_warn_ratelimited(dev, "Already
>>> bound with PASID %u\n",
>>> +						svm->pasid);
>>> +				ret = -EBUSY;
>>> +			}
>>> +			goto out;
>> Is this intentionally a for loop that jumps out of the loop after
>> the first device?
>>
> The name is confusing, it is not a loop. I will change it to
> find_svm_dev() and comments like this?
> 
> /*
>   * Find the matching device in a given SVM. The bind code ensures that
>   * each device can only be added to the SVM list once.
>   */
> #define find_svm_dev(sdev, svm, d)			\
> 	list_for_each_entry((sdev), &(svm)->devs, list)	\
> 		if ((d) != (sdev)->dev) {} else
> 

The for_each_svm_dev() is not added by this series and is also used by
other functions. How about changing it in a separated patch?

Best regards,
baolu
