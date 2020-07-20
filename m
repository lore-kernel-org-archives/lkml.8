Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6403DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34818208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGTXGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:06:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:22610 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTXGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:06:19 -0400
IronPort-SDR: Y6tI7KDspxYUZu6PdetIf+G8jWG19fcL147pF8yOAeUU3hb/RGWgEz5PqKMRmJWhxG9K9sjgec
 crNES6ef3l+g==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="129593625"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="129593625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 16:00:14 -0700
IronPort-SDR: e+PBEERr3qpGboWI3oncS+cts6waS0azn2/MF1eI7znPlqkGl117cK+G3E1r+7z0ZFdgTFsV7X
 CaLUaOsr7AeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; 
   d="scan'208";a="301419563"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 20 Jul 2020 16:00:12 -0700
Date:   Mon, 20 Jul 2020 16:06:58 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v5 1/5] docs: IOMMU user API
Message-ID: <20200720160658.1543d4c1@jacob-builder>
In-Reply-To: <d8677d03-e3b8-88d3-21b1-12647008bb39@redhat.com>
References: <1594925117-64892-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1594925117-64892-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <d8677d03-e3b8-88d3-21b1-12647008bb39@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Fri, 17 Jul 2020 15:32:58 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 7/16/20 8:45 PM, Jacob Pan wrote:
> > IOMMU UAPI is newly introduced to support communications between
> > guest virtual IOMMU and host IOMMU. There has been lots of
> > discussions on how it should work with VFIO UAPI and userspace in
> > general.
> > 
> > This document is indended to clarify the UAPI design and usage.
> > The  
> intended
will fix.

> > mechanics of how future extensions should be achieved are also
> > covered in this documentation.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  Documentation/userspace-api/iommu.rst | 339
> > ++++++++++++++++++++++++++++++++++ 1 file changed, 339 insertions(+)
> >  create mode 100644 Documentation/userspace-api/iommu.rst
> > 
> > diff --git a/Documentation/userspace-api/iommu.rst
> > b/Documentation/userspace-api/iommu.rst new file mode 100644
> > index 000000000000..efc3e1838235
> > --- /dev/null
> > +++ b/Documentation/userspace-api/iommu.rst
> > @@ -0,0 +1,339 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. iommu:
> > +
> > +=====================================
> > +IOMMU Userspace API
> > +=====================================
> > +
> > +IOMMU UAPI is used for virtualization cases where communications
> > are +needed between physical and virtual IOMMU drivers. For native  
> s/native/baremetal?
Sounds good.

> > +usage, IOMMU is a system device which does not need to
> > communicate  
> the IOMMU?
Sounds good.

> > +with user space directly.
> > +
> > +The primary use cases are guest Shared Virtual Address (SVA) and
> > +guest IO virtual address (IOVA), wherein a virtual IOMMU (vIOMMU)
> > is +required to communicate with the physical IOMMU in the host.  
> wherin the vIOMMU implementation relies on the physical IOMMU and for
> this reason requires interactions with the host driver.
> 
Will do, it is more complete.

> > +
> > +.. contents:: :local:
> > +
> > +Functionalities
> > +===============
> > +Communications of user and kernel involve both directions. The
> > +supported user-kernel APIs are as follows:
> > +
> > +1. Alloc/Free PASID
> > +2. Bind/unbind guest PASID (e.g. Intel VT-d)
> > +3. Bind/unbind guest PASID table (e.g. ARM sMMU)  
> s/sMMU/SMMU
Sounds good and all below.

> > +4. Invalidate IOMMU caches
> > +5. Service IO page faults (page request and response)  
> Report errors to the guest and serve page requests?
Yes, the UAPI does cover faults beyond PRS.

> > +
> > +Requirements
> > +============
> > +The IOMMU UAPIs are generic and extensible to meet the following
> > +requirements:
> > +
> > +1. Emulated and para-virtualised vIOMMUs
> > +2. Multiple vendors (Intel VT-d, ARM sMMU, etc.)  
> SMMU
Ditto.

> > +3. Extensions to the UAPI shall not break existing user space
> > +
> > +Interfaces
> > +==========
> > +Although the data structures defined in IOMMU UAPI are
> > self-contained, +there is no user API functions introduced.
> > Instead, IOMMU UAPI is +designed to work with existing user driver
> > frameworks such as VFIO. +
> > +Extension Rules & Precautions
> > +-----------------------------
> > +When IOMMU UAPI gets extended, the data structures can *only* be
> > +modified in two ways:
> > +
> > +1. Adding new fields by re-purposing the padding[] field. No size
> > change. +2. Adding new union members at the end. May increase in
> > size.  
> May increase the structure sizes
Sounds good.

> > +
> > +No new fields can be added *after* the variable sized union in
> > that it +will break backward compatibility when offset moves. In
> > both cases, a +new flag must be accompanied with a new field such
> > that the IOMMU  
> a new flag must be introduced whenever a change affects the structure
> using either method?
Yours is more clear, will change to:

A new flag must be introduced whenever a change affects the structure
using either method. The IOMMU driver processes the data based on flags
which ensures backward compatibility.

> > +driver can process the data based on the new flag. Version field is
> > +only reserved for the unlikely event of UAPI upgrade at its
> > entirety. +
> > +It's *always* the caller's responsibility to indicate the size of
> > the +structure passed by setting argsz appropriately.
> > +Though at the same time, argsz is user provided data which is not
> > +trusted. The argsz field allows the user to indicate how much data
> > +they're providing, it's still the kernel's responsibility to
> > validate  
> he is providing
Sounds good.

> > +whether it's correct and sufficient for the requested operation.
> > +
> > +Compatibility Checking
> > +----------------------
> > +When IOMMU UAPI extension results in size increase, IOMMU UAPI
> > core  
> in some structure size increase, the IOMMU UAPI code
Better

> > +and vendor driver shall handle the following cases:
> > +
> > +1. User and kernel has exact size match
> > +2. An older user with older kernel header (smaller UAPI size)
> > running on a
> > +   newer kernel (larger UAPI size)
> > +3. A newer user with newer kernel header (larger UAPI size) running
> > +   on an older kernel.
> > +4. A malicious/misbehaving user pass illegal/invalid size but
> > within
> > +   range. The data may contain garbage.> +
> > +Feature Checking
> > +----------------
> > +While launching a guest with vIOMMU, it is important to ensure
> > that host +can support the UAPI data structures to be used for
> > vIOMMU-pIOMMU +communications. Without upfront compatibility
> > checking, future faults  
> s/faults/failures?
Indeed, failure means "External behavior is incorrect" according to
IEEE. VMM and user app are external to kernel.

> > +are difficult to report even in normal conditions. For example, TLB
> > +invalidations should always succeed. There is no architectural way
> > to +report back to the vIOMMU if the UAPI data is incompatible. If
> > that +happens, in order to protect IOMMU iosolation guarantee, we
> > have to  
> in order to guarantee IOMMU isOlation
Sounds good.

> > +resort to not giving completion status in vIOMMU. This may result
> > in +VM hang.  
> Why not simply saying a capability getter is offered to discover the
> feature support and potential API incompatibility support at an early
> stage. Detecting this later, when performing the actual
> cache/descriptor handling operations appears to be tricky and
> difficult to escalate to the guest.
> 
I just wanted to give a specific scenario that could result in hang. I
will add this as a general statement.

> > +
> > +For this reason the following IOMMU UAPIs cannot fail:
> > +
> > +1. Free PASID
> > +2. Unbind guest PASID
> > +3. Unbind guest PASID table (SMMU)
> > +4. Cache invalidate  
> 
> hum practically iommu_uapi_sva_unbind_gpasid return an int though (see
> below). So it sounds a bit misleading. What cannot fail?
> 
Perhaps I should say it cannot fail w/o catastrophic effect. If
unbind_gpasid fail, the PASID cache invalidation cannot complete.

> > +
> > +User applications such as QEMU are expected to import kernel UAPI
> > +headers. Backward compatibility is supported per feature flags.
> > +For example, an older QEMU (with older kernel header) can run on
> > newer +kernel. Newer QEMU (with new kernel header) may refuse to
> > initialize +on an older kernel if new feature flags are not
> > supported by older +kernel. Simply recompiling existing code with
> > newer kernel header should +not be an issue in that only existing
> > flags are used. +
> > +IOMMU vendor driver should report the below features to IOMMU UAPI
> > +consumers (e.g. via VFIO).
> > +
> > +1. IOMMU_NESTING_FEAT_SYSWIDE_PASID
> > +2. IOMMU_NESTING_FEAT_BIND_PGTBL
> > +3. IOMMU_NESTING_FEAT_BIND_PASID_TABLE
> > +4. IOMMU_NESTING_FEAT_CACHE_INVLD
> > +5. IOMMU_NESTING_FEAT_PAGE_REQUEST
> > +
> > +Take VFIO as example, upon request from VFIO user space (e.g.
> > QEMU), +VFIO kernel code shall query IOMMU vendor driver for the
> > support of +the above features. Query result can then be reported
> > back to the +user-space caller. Details can be found in
> > +Documentation/driver-api/vfio.rst.
> > +
> > +
> > +Data Passing Example with VFIO
> > +------------------------------
> > +As the ubiquitous userspace driver framework, VFIO is already IOMMU
> > +aware and shares many key concepts such as device model, group, and
> > +protection domain. Other user driver frameworks can also be
> > extended +to support IOMMU UAPI but it is outside the scope of this
> > document. +
> > +In this tight-knit VFIO-IOMMU interface, the ultimate consumer of
> > the +IOMMU UAPI data is the host IOMMU driver. VFIO facilitates
> > user-kernel +transport, capability checking, security, and life
> > cycle management of +process address space ID (PASID).
> > +
> > +Unlike normal user data passed via VFIO UAPI IOTCL, IOMMU driver
> > is the +ultimate consumer of its UAPI data.  
> I don't really get this. Part of the VFIO API already mediates info
> towards the IOMMU driver, no?
> 
Here is the first time VFIO passes user pointer to IOMMU, AFAIK. I just
wanted to call out the two layers.

>  At VFIO layer, the IOMMU UAPI data
> > +is wrapped in a VFIO UAPI data. It follows the
> > +pattern below::
> > +
> > +   struct {
> > +	__u32 argsz;
> > +	__u32 flags;
> > +	__u8  data[];
> > +   };
> > +
> > +Here data[] contains the IOMMU UAPI data structures. VFIO has the
> > +freedom to bundle the data as well as parse data size based on its
> > own flags. +
> > +In order to determine the size and feature set of the user data,
> > argsz +and flags are also embedded in the IOMMU UAPI data
> > structures. +A "__u32 argsz" field is *always* at the beginning of
> > each structure. +
> > +For example:
> > +::
> > +
> > +   struct iommu_cache_invalidate_info {
> > +	__u32	argsz;
> > +	#define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> > +	__u32	version;  
> there is no flags field in this struct, as opposed to what I can
> understand from "argsz and flags are also embedded in the IOMMU UAPI
> data structures"
Good point, I didn't mean literal "flags", cache and granu are flags in
reality. Let me clarify as "flags or the equivalent"

> > +	/* IOMMU paging structure cache */
> > +	#define IOMMU_CACHE_INV_TYPE_IOTLB	(1 << 0) /*
> > IOMMU IOTLB */
> > +	#define IOMMU_CACHE_INV_TYPE_DEV_IOTLB	(1 << 1) /*
> > Device IOTLB */
> > +	#define IOMMU_CACHE_INV_TYPE_PASID	(1 << 2) /*
> > PASID cache */
> > +	#define IOMMU_CACHE_INV_TYPE_NR		(3)
> > +	__u8	cache;
> > +	__u8	granularity;
> > +	__u8	padding[6];
> > +	union {
> > +		struct iommu_inv_pasid_info pasid_info;
> > +		struct iommu_inv_addr_info addr_info;
> > +	} granu;
> > +   };
> > +
> > +VFIO is responsible for checking its own argsz and flags then
> > invokes  
> s/flags then invokes/flags. It then invokes
Sounds good.

> > +appropriate IOMMU UAPI functions. User pointer is passed to IOMMU  
> the appropriate... I would say *The* user pointer is passed to *the*
> IOMMU, here and at many places in the doc. But I would prefer a native
> english speaker confirms.
I agree. These are the specific user pointers in the VFIO structures.

> > +layer for further processing. The responsibilities are divided as
> > +follows:
> > +
> > +- Generic IOMMU layer checks argsz range based on UAPI data in the
> > +  current kernel version
> > +
> > +- Generic IOMMU layer checks content of the UAPI data for non-zero
> > +  reserved bits in flags, padding fields, and unsupported version.
> > +  This is to ensure not breaking userspace in the future when these
> > +  fields or flags are used.
> > +
> > +- Vendor IOMMU driver checks argsz based on vendor flags, UAPI data
> > +  is consumed based on flags. Vendor driver has access to
> > +  unadulterated argsz value in case of vendor specific future
> > +  extensions.
> > +
> > +To illustrate the two cases with and without vendor data, cache
> > +invalidation and bind guest PASID are given as examples
> > respectively.  
> 
> I am not sure duplicating the code here is necessary. I think when the
> code gets upstream, it becomes the example to follow. The above
> description can help in understanding why such checks are there and I
> would stop here, personally.
I am torn between the choices here also. Having examples also helps. I
am OK to stop here also.

Anyone else has an opinion?

> > +
> > +Example 1: Guest issues IOTLB invalidation, all guest provided data
> > +are generic. Vendor driver does not need to check argsz.
> > +
> > +::
> > +
> > + static int iommu_check_cache_invl_data(struct
> > iommu_cache_invalidate_info *info)
> > + {
> > +	u32 mask;
> > +
> > +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
> > +	if (info->cache & ~mask)
> > +		return -EINVAL;
> > +
> > +	if (info->granularity >= IOMMU_INV_GRANU_NR)
> > +		return -EINVAL;
> > +
> > +	switch (info->granularity) {
> > +	case IOMMU_INV_GRANU_ADDR:
> > +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> > +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> > +			IOMMU_INV_ADDR_FLAGS_LEAF;
> > +
> > +		if (info->granu.addr_info.flags & ~mask)
> > +			return -EINVAL;
> > +		break;
> > +	case IOMMU_INV_GRANU_PASID:
> > +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> > +			IOMMU_INV_PASID_FLAGS_ARCHID;
> > +		if (info->granu.pasid_info.flags & ~mask)
> > +			return -EINVAL;
> > +
> > +		break;
> > +	case IOMMU_INV_GRANU_DOMAIN:
> > +		/* No flags to check */
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (info->padding[0] || info->padding[1])
> > +		return -EINVAL;
> > +
> > +	return 0;
> > + }
> > +
> > + int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > +			   void __user *uinfo)
> > + {
> > +	struct iommu_cache_invalidate_info inv_info = { 0 };
> > +	u32 minsz, maxsz;
> > +	int ret = 0;
> > +
> > +	if (unlikely(!domain->ops->cache_invalidate))
> > +		return -ENODEV;
> > +
> > +	/* Current kernel data size is the max to be copied from
> > user */
> > +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> > +
> > +	/*
> > +	 * No new spaces can be added before the variable sized
> > union, the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_cache_invalidate_info,
> > granu); +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (inv_info.argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	/* PASID and address granu requires additional info beyond
> > minsz */
> > +	if (inv_info.argsz == minsz &&
> > +		((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> > +			(inv_info.granularity ==
> > IOMMU_INV_GRANU_ADDR)))
> > +		return -EINVAL;
> > +	/*
> > +	 * User might be using a newer UAPI header which has a
> > larger data
> > +	 * size, we shall support the existing flags within the
> > current
> > +	 * size. Copy the remaining user data _after_ minsz but
> > not more
> > +	 * than the current kernel supported size.
> > +	 */
> > +	if (copy_from_user((void *)&inv_info + minsz, uinfo +
> > minsz,
> > +				min(inv_info.argsz, maxsz) -
> > minsz))
> > +		return -EFAULT;
> > +
> > +	/* Now the argsz is validated, check the content */
> > +	ret = iommu_check_cache_invl_data(&inv_info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->cache_invalidate(domain, dev,
> > &inv_info);
> > + }
> > + EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> > +
> > +
> > +Example 2: Bind guest PASID which includes vendor specific data.
> > +The IOMMU core processing of UAPI data follows the same flow as
> > +Example 1. Vendor driver handles the additional vendor specific
> > flags +as in VT-d driver below:
> > +
> > +::
> > +
> > + int intel_svm_bind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			  struct iommu_gpasid_bind_data *data)
> > + {
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct dmar_domain *dmar_domain;
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!iommu) || !data)
> > +		return -EINVAL;
> > +
> > +	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	/* IOMMU core ensures argsz is more than the start of the
> > union */
> > +	if (data->argsz < offsetofend(struct
> > iommu_gpasid_bind_data,
> > +            vendor.vtd))
> > +		return -EINVAL;
> > +   ...
> > + }
> > +
> > +
> > +Sharing UAPI with in-kernel users
> > +---------------------------------
> > +For UAPIs that are shared with in-kernel users, a wrapper function
> > is +provided to distinguish the callers. For example,
> > +
> > +Userspace caller ::
> > +
> > +  int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > +                                   struct device *dev,
> > +                                   void __user *udata)
> > +
> > +In-kernel caller ::
> > +
> > +  int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> > +                                   struct device *dev,
> > +                                   struct iommu_gpasid_bind_data
> > *data)
> >Hope this helps. If some of my comments drive you in an opposite  
> direction of what was said earlier, please feel free to ignore
> them ;-)
> 
Yes, thanks a lot for your review.

> Thanks
> 
> Eric
> 

[Jacob Pan]
