Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD912065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgENPvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:51:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:40128 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgENPvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:51:36 -0400
IronPort-SDR: RhybmlFbZieR3VyvLsc+sTKGxFpN+yhNSnfyeHuZDVJkiFBYAiRXkYO8haDm15pxdY5mJqswyW
 8nnARNsupCsw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 08:51:35 -0700
IronPort-SDR: I/hGnemAqgDMh5MYOq4b6XxPhMa7ut5i+YI+RWKp5VDKXZoqgRQ5x2ah70x0nhPFf5S+PKF035
 OJ3tp9gwsjFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="437953389"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 14 May 2020 08:51:34 -0700
Date:   Thu, 14 May 2020 08:57:45 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v13 4/8] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200514085745.105af4fb@jacob-builder>
In-Reply-To: <20200514055930.GD22388@infradead.org>
References: <1589410909-38925-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1589410909-38925-5-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200514055930.GD22388@infradead.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks a lot for the reviews, comments below.

Jacob

On Wed, 13 May 2020 22:59:30 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> > +	if (dev_is_pci(dev)) {
> > +		/* VT-d supports devices with full 20 bit PASIDs
> > only */
> > +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> > +			return -EINVAL;
> > +	} else {
> > +		return -ENOTSUPP;
> > +	}  
> 
> This looks strange.  Why not:
> 
> 	if (!dev_is_pci(dev)) {
> 		return -ENOTSUPP;
> 
> 	/* VT-d supports devices with full 20 bit PASIDs only */
> 	if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> 		return -EINVAL;
> 
That is better, will do.

> > +		for_each_svm_dev(sdev, svm, dev) {
> > +			/*
> > +			 * For devices with aux domains, we should
> > allow multiple
> > +			 * bind calls with the same PASID and pdev.
> > +			 */
> > +			if (iommu_dev_feature_enabled(dev,
> > IOMMU_DEV_FEAT_AUX)) {
> > +				sdev->users++;
> > +			} else {
> > +				dev_warn_ratelimited(dev, "Already
> > bound with PASID %u\n",
> > +						svm->pasid);
> > +				ret = -EBUSY;
> > +			}
> > +			goto out;  
> 
> Is this intentionally a for loop that jumps out of the loop after
> the first device?
> 
The name is confusing, it is not a loop. I will change it to
find_svm_dev() and comments like this?

/*
 * Find the matching device in a given SVM. The bind code ensures that
 * each device can only be added to the SVM list once.
 */ 
#define find_svm_dev(sdev, svm, d)			\
	list_for_each_entry((sdev), &(svm)->devs, list)	\
		if ((d) != (sdev)->dev) {} else

> > +	/*
> > +	 * PASID table is per device for better security.
> > Therefore, for
> > +	 * each bind of a new device even with an existing PASID,
> > we need to
> > +	 * call the nested mode setup function here.
> > +	 */
> > +	spin_lock(&iommu->lock);
> > +	ret = intel_pasid_setup_nested(iommu,
> > +				       dev,
> > +				       (pgd_t *)data->gpgd,
> > +				       data->hpasid,
> > +				       &data->vtd,
> > +				       dmar_domain,
> > +				       data->addr_width);  
> 
> Why not:
> 
> 	et = intel_pasid_setup_nested(iommu, dev, (pgd_t *)data->gpgd,
> 			data->hpasid, &data->vtd, dmar_domain,
> 			data->addr_width);
> 
> ?
> 
I thought we want to align the parentheses? Either way is fine.
Baolu?

> > +	for_each_svm_dev(sdev, svm, dev) {
> > +		ret = 0;  
> 
> 		...
> 
> > +		break;
> > +	}  
> 
> Same only looks at the first device style.  Why dos it only care about
> the first device?  That needs at least a comment, and probably a
> first_svm_dev or so heper to make it explicit.

Yes, same as above. change to find_svm_dev() since there should be at
most one matching device in the svm list.


