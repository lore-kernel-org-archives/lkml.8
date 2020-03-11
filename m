Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC31BC10F25
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19FA208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgCKGuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:50:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:32011 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgCKGuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:50:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 23:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="242588178"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.137]) ([10.254.208.137])
  by orsmga003.jf.intel.com with ESMTP; 10 Mar 2020 23:50:40 -0700
Cc:     baolu.lu@linux.intel.com, ashok.raj@intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Derrick Jonathan <jonathan.derrick@intel.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/6] Replace private domain with per-group default
To:     Joerg Roedel <joro@8bytes.org>
References: <20200307062014.3288-1-baolu.lu@linux.intel.com>
 <20200310111503.GF3794@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
Date:   Wed, 11 Mar 2020 14:50:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310111503.GF3794@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020/3/10 19:15, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Sat, Mar 07, 2020 at 02:20:08PM +0800, Lu Baolu wrote:
>> Lu Baolu (5):
>>    iommu: Configure default domain with dev_def_domain_type
>>    iommu/vt-d: Don't force 32bit devices to uses DMA domain
>>    iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
>>    iommu/vt-d: Add dev_def_domain_type callback
>>    iommu/vt-d: Apply per-device dma_ops
>>
>> Sai Praneeth Prakhya (1):
>>    iommu: Add dev_def_domain_type() callback in iommu_ops
> 
> I like this patch-set, but I fear some regressions from patch
> "iommu/vt-d: Don't force 32bit devices to uses DMA domain". Have you
> tested this series on a couple of machines, ideally even older ones from
> the first generation of VT-d hardware?

The oldest hardware I have is Ivy Bridge. :-) Actually, The effect of
using identity domain for 32-bit devices is the same as that of adding
intel_iommu=off in the kernel parameter. Hence, if there is any
regression, people should also find it with intel_iommu=off.
intel_iommu=off support is added at the very beginning of VT-d driver.

Best regards,
baolu
