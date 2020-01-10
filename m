Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31490C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE0D20678
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 01:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgAJBVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 20:21:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:18225 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730504AbgAJBVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 20:21:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 17:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="246847587"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2020 17:21:01 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v8 08/10] iommu/vt-d: Add custom allocator for IOASID
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <1576524252-79116-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1576524252-79116-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <9c9c818c-ccb1-544d-2041-cf7017c4d898@linux.intel.com>
 <20200109140629.0e15c3f3@jacob-builder>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <239924d4-c0c8-54c4-c6a8-bc458bcaea00@linux.intel.com>
Date:   Fri, 10 Jan 2020 09:19:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200109140629.0e15c3f3@jacob-builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/10/20 6:06 AM, Jacob Pan wrote:
>>> +static void register_pasid_allocator(struct intel_iommu *iommu)
>>> +{
>>> +	if (!intel_iommu_sm) {
>> Use sm_supported(iommu) instead.
>>
> sounds good, seems we could separate the sm code more cleanly in the
> future to avoid all these checks.
> 

Agreed.

Best regards,
baolu
