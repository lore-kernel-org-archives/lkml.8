Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B3AC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745EE206E6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 07:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgC2Hfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 03:35:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:11649 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgC2Hfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 03:35:53 -0400
IronPort-SDR: eB54OcCA0/HKv3ALiPj2Urc2gaqyI2Gn+MYW4E4sX8tPLwfwPzZzVITMK7a39K3iMAkacxardS
 gGkFh33WzOVg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 00:35:53 -0700
IronPort-SDR: FjWvP1xi9YludaFnGgcfP59D58Ut974bJyTxqpEAKHMvjg6Ta2KiTb67BmFIsnsRPHhXaK+dpQ
 +6rv20iStvdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,319,1580803200"; 
   d="scan'208";a="358885404"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.24]) ([10.254.210.24])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2020 00:35:50 -0700
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH V10 04/11] iommu/vt-d: Use helper function to skip agaw
 for SL
To:     Auger Eric <eric.auger@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED91C@SHSMSX104.ccr.corp.intel.com>
 <310693c3-9bd2-a764-2053-cd785d329ee6@redhat.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <527a5b65-e7df-1281-beee-208d156bee01@linux.intel.com>
Date:   Sun, 29 Mar 2020 15:35:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <310693c3-9bd2-a764-2053-cd785d329ee6@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/28 0:05, Auger Eric wrote:
> Hi Jacob,
> 
> On 3/27/20 12:55 PM, Tian, Kevin wrote:
>>> From: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> Sent: Saturday, March 21, 2020 7:28 AM
>>>
>>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
>>> ---
>>>   drivers/iommu/intel-pasid.c | 14 ++++----------
>>>   1 file changed, 4 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
>>> index 191508c7c03e..9bdb7ee228b6 100644
>>> --- a/drivers/iommu/intel-pasid.c
>>> +++ b/drivers/iommu/intel-pasid.c
>>> @@ -544,17 +544,11 @@ int intel_pasid_setup_second_level(struct
>>> intel_iommu *iommu,
>>>   		return -EINVAL;
>>>   	}
>>>
>>> -	/*
>>> -	 * Skip top levels of page tables for iommu which has less agaw
>>> -	 * than default. Unnecessary for PT mode.
>>> -	 */
>>>   	pgd = domain->pgd;
>>> -	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
>>> -		pgd = phys_to_virt(dma_pte_addr(pgd));
>>> -		if (!dma_pte_present(pgd)) {
>>> -			dev_err(dev, "Invalid domain page table\n");
>>> -			return -EINVAL;
>>> -		}
>>> +	agaw = iommu_skip_agaw(domain, iommu, &pgd);
>>> +	if (agaw < 0) {
>>> +		dev_err(dev, "Invalid domain page table\n");
> is the dev_err() really requested. I see in domain_setup_first_level(),
> there is none.
>>> +		return -EINVAL;
>>>   	}
>> ok, I see how it is used. possibly combine last and this one together since
>> it's mostly moving code...
> I tend to agree with Kevin. May be better squash the 2 patches. Also not
> sure the inline of iommu_skip_agaw() is meaningful then. Also Add commit
> messages on the resulting patch.
> 
> Note domain_setup_first_level() also could use the helper while we are
> it (if declaration moved to common helper). Only the error code differs
> in case !dma_pte_present(pgd), ie. -ENOMEM. May be good to align.
> 
> Otherwise those stuff may be done in a fixup patch.

Agreed. Will squash these 2 patches with a meaningful commit message. As
for using this helper in other files, like domain_setup_first_level(),
we need more review and test efforts, hence it's better to put it in a
followup patch.

Best regards,
baolu
