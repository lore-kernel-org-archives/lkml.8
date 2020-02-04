Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33015C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D274721744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgBDFil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:38:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:59900 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDFil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:38:41 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 21:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="310944047"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2020 21:38:40 -0800
Date:   Mon, 3 Feb 2020 21:43:57 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V9 10/10] iommu/vt-d: Report PASID format as domain
 attribute
Message-ID: <20200203214357.09d01729@jacob-builder>
In-Reply-To: <45cacbf2-c326-847d-dc6e-949e3e8de78d@linux.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277713-66934-11-git-send-email-jacob.jun.pan@linux.intel.com>
        <45cacbf2-c326-847d-dc6e-949e3e8de78d@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 15:54:44 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi,
> 
> On 2020/1/29 14:01, Jacob Pan wrote:
> > Report the domain attribute of PASID table format. As multiple
> > formats of PASID table entry are supported, it is important for the
> > guest to know which format to use in virtual IOMMU. The result will
> > be used for binding device with guest PASID.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
> >   include/linux/iommu.h       |  1 +
> >   2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 2f0bf7cc70ce..b3778e86dc32
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6413,6 +6413,27 @@ intel_iommu_domain_set_attr(struct
> > iommu_domain *domain, return ret;
> >   }
> >   
> > +static int intel_iommu_domain_get_attr(struct iommu_domain *domain,
> > +				       enum iommu_attr attr, void
> > *data) +{
> > +	/* Only used for guest */
> > +	switch (domain->type) {
> > +	case IOMMU_DOMAIN_DMA:
> > +		return -ENODEV;
> > +	case IOMMU_DOMAIN_UNMANAGED:
> > +		switch (attr) {
> > +		case DOMAIN_ATTR_PASID_FORMAT:
> > +			*(int *)data =
> > IOMMU_PASID_FORMAT_INTEL_VTD;
> > +			return 0;
> > +		default:
> > +			return -ENODEV;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >   const struct iommu_ops intel_iommu_ops = {
> >   	.capable		= intel_iommu_capable,
> >   	.domain_alloc		= intel_iommu_domain_alloc,
> > @@ -6432,6 +6453,7 @@ const struct iommu_ops intel_iommu_ops = {
> >   	.put_resv_regions	= intel_iommu_put_resv_regions,
> >   	.apply_resv_region	= intel_iommu_apply_resv_region,
> >   	.device_group		= pci_device_group,
> > +	.domain_get_attr	= intel_iommu_domain_get_attr,
> >   	.dev_has_feat		= intel_iommu_dev_has_feat,
> >   	.dev_feat_enabled	= intel_iommu_dev_feat_enabled,
> >   	.dev_enable_feat	= intel_iommu_dev_enable_feat,
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index f2223cbb5fd5..9718c109ea0a 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -126,6 +126,7 @@ enum iommu_attr {
> >   	DOMAIN_ATTR_FSL_PAMUV1,
> >   	DOMAIN_ATTR_NESTING,	/* two stages of translation
> > */ DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > +	DOMAIN_ATTR_PASID_FORMAT,
> >   	DOMAIN_ATTR_MAX,
> >   };  
> 
> Need to separate the new domain attribution definition and the vt-d
> implementation.
> 
In the current iommu uapi, VTD is the only format. However, PASID table
entry format is a generic attribute, not VT-d specific. It expected to
have more vendor format can be reported under this attribute.

struct iommu_gpasid_bind_data {
	__u32 version;
#define IOMMU_PASID_FORMAT_INTEL_VTD	1


> Best regards,
> baolu

[Jacob Pan]
