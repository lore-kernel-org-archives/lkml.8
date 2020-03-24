Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D03EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4BA20722
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 01:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbgCXBma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:42:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:34433 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgCXBm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 21:42:29 -0400
IronPort-SDR: JBgzrgoK7kffK/l+cwFL+d7SaUOn82L3nfteoI5LxGg2pl+/bHN9EyQ4Z+mGy2iOCAnnhPJVE9
 XTl5HhWqlFmw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 18:42:28 -0700
IronPort-SDR: LefSmsp92s2IYF/PXnr6Ipuk/XOB1mRv7a3IU3qijkzj/XlZb1QGzvYjNjxIF9jCqaFVGqPRmz
 mqkp44TBM4QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="264976626"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.83]) ([10.254.208.83])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2020 18:42:22 -0700
Cc:     baolu.lu@linux.intel.com,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Lu, Baolu" <baolu.lu@intel.com>
Subject: Re: [PATCH 2/2] iommu/vt-d: Replace intel SVM APIs with generic SVA
 APIs
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <1582586797-61697-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1582586797-61697-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200320092955.GA1702630@myrica> <20200323230113.GA84386@otc-nc-03>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <6cc2f1ea-5a7d-eeab-b50c-5b464098de6b@linux.intel.com>
Date:   Tue, 24 Mar 2020 09:42:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200323230113.GA84386@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/24 7:01, Raj, Ashok wrote:
> Hi Jean
> 
> On Fri, Mar 20, 2020 at 10:29:55AM +0100, Jean-Philippe Brucker wrote:
>>> +#define to_intel_svm_dev(handle) container_of(handle, struct intel_svm_dev, sva)
>>> +struct iommu_sva *
>>> +intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>>> +{
>>> +	struct iommu_sva *sva = ERR_PTR(-EINVAL);
>>> +	struct intel_svm_dev *sdev = NULL;
>>> +	int flags = 0;
>>> +	int ret;
>>> +
>>> +	/*
>>> +	 * TODO: Consolidate with generic iommu-sva bind after it is merged.
>>> +	 * It will require shared SVM data structures, i.e. combine io_mm
>>> +	 * and intel_svm etc.
>>> +	 */
>>> +	if (drvdata)
>>> +		flags = *(int *)drvdata;
>>
>> drvdata is more for storing device driver contexts that can be passed to
>> iommu_sva_ops, but I get that this is temporary.
>>
>> As usual I'm dreading supervisor mode making it into the common API. What
>> are your plans regarding SUPERVISOR_MODE and PRIVATE_PASID flags?  The
>> previous discussion on the subject [1] had me hoping that you could
>> replace supervisor mode with normal mappings (auxiliary domains?)
>> I'm less worried about PRIVATE_PASID, it would just add complexity into
> 
> We don't seem to have an immediate need for PRIVATE_PASID. There are some talks
> about potential usages, but nothing concrete. I think it might be good to
> get rid of it now and add when we really need.
> 
> For SUPERVISOR_MODE, the idea is to have aux domain. Baolu is working on
> something to replace. Certainly the entire kernel address is opening up
> the whole kimono.. so we are looking at dynamically creating mappings on demand.
> It might take some of the benefits of SVA in general with no need to create
> mappings, but for security somebody has to pay the price :-)

My thought is to reuse below aux-domain API.

int iommu_aux_attach_device(struct iommu_domain *domain,
			    struct device *dev)

Currently, it asks the vendor iommu driver to allocate a PASID and bind
the domain with it. We can change it to allow the caller to pass in an
existing supervisor PASID.

int iommu_aux_attach_device(struct iommu_domain *domain,
			    struct device *dev,
			    int *pasid)

In the vendor iommu driver, if (*pasid == INVALID_IOASID), it will
allocate a pasid (the same as current behavior); otherwise, attach
the domain with the pass-in pasid.

Best regards,
baolu
