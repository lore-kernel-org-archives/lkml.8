Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1968C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF28206FA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgCNBNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:13:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:14194 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCNBNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:13:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Mar 2020 18:13:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,550,1574150400"; 
   d="scan'208";a="354494863"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.137]) ([10.254.208.137])
  by fmsmga001.fm.intel.com with ESMTP; 13 Mar 2020 18:13:02 -0700
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
 <cd0f526c-da68-ef59-580f-665ad08a395f@linux.intel.com>
 <20200313133644.GO3794@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <59e83b11-1483-5e18-6380-7934166268c4@linux.intel.com>
Date:   Sat, 14 Mar 2020 09:13:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200313133644.GO3794@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/13 21:36, Joerg Roedel wrote:
> On Wed, Mar 11, 2020 at 02:50:39PM +0800, Lu Baolu wrote:
>> On 2020/3/10 19:15, Joerg Roedel wrote:
>>> Hi Baolu,
>>>
>>> On Sat, Mar 07, 2020 at 02:20:08PM +0800, Lu Baolu wrote:
>>>> Lu Baolu (5):
>>>>     iommu: Configure default domain with dev_def_domain_type
>>>>     iommu/vt-d: Don't force 32bit devices to uses DMA domain
>>>>     iommu/vt-d: Don't force PCI sub-hierarchy to use DMA domain
>>>>     iommu/vt-d: Add dev_def_domain_type callback
>>>>     iommu/vt-d: Apply per-device dma_ops
>>>>
>>>> Sai Praneeth Prakhya (1):
>>>>     iommu: Add dev_def_domain_type() callback in iommu_ops
>>>
>>> I like this patch-set, but I fear some regressions from patch
>>> "iommu/vt-d: Don't force 32bit devices to uses DMA domain". Have you
>>> tested this series on a couple of machines, ideally even older ones from
>>> the first generation of VT-d hardware?
>>
>> The oldest hardware I have is Ivy Bridge. :-) Actually, The effect of
>> using identity domain for 32-bit devices is the same as that of adding
>> intel_iommu=off in the kernel parameter. Hence, if there is any
>> regression, people should also find it with intel_iommu=off.
>> intel_iommu=off support is added at the very beginning of VT-d driver.
> 
> Okay, I will also do some testing on it, one of my VT-d machines is a
> Haswell. Please send a new version with the recent comments addressed.

Sure.

Best regards,
baolu
