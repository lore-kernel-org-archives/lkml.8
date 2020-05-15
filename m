Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89569C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57918206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 01:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEOBFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 21:05:07 -0400
Received: from mga17.intel.com ([192.55.52.151]:46557 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbgEOBFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 21:05:07 -0400
IronPort-SDR: dxEwKz5tfgJSB63G4KmSPazqecdSXwJzw5RrRo7l7WkN6e1UKKEXww1itfMZH2akJgXxQvmLqD
 sP36g4hL/OSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 18:05:05 -0700
IronPort-SDR: AYRvp11Pc5HEpo+NJXF+QFbw5OWo1DhY/86LeyFxGIGf2xtYb+az13nP3hvVxmbZ3weePZQjRx
 b8V1QiW3INNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,393,1583222400"; 
   d="scan'208";a="281051242"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 14 May 2020 18:05:00 -0700
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
Message-ID: <b21488f2-e389-72de-421f-71d2d9525c06@linux.intel.com>
Date:   Fri, 15 May 2020 09:01:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
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

On 5/14/20 11:57 PM, Jacob Pan wrote:
>>> +	/*
>>> +	 * PASID table is per device for better security.
>>> Therefore, for
>>> +	 * each bind of a new device even with an existing PASID,
>>> we need to
>>> +	 * call the nested mode setup function here.
>>> +	 */
>>> +	spin_lock(&iommu->lock);
>>> +	ret = intel_pasid_setup_nested(iommu,
>>> +				       dev,
>>> +				       (pgd_t *)data->gpgd,
>>> +				       data->hpasid,
>>> +				       &data->vtd,
>>> +				       dmar_domain,
>>> +				       data->addr_width);
>> Why not:
>>
>> 	et = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
>> 			data->hpasid, &data->vtd, dmar_domain,
>> 			data->addr_width);
>>
>> ?
>>
> I thought we want to align the parentheses? Either way is fine.
> Baolu?
> 

Let's keep the code style consistent in this file.

Best regards,
baolu
