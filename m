Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D8CC35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1722120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgBCUg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:36:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:46229 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgBCUg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:36:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 12:36:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="310830321"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2020 12:36:27 -0800
Date:   Mon, 3 Feb 2020 12:41:43 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 3/3] iommu/uapi: Add helper function for size lookup
Message-ID: <20200203124143.05061d1e@jacob-builder>
In-Reply-To: <20200203112708.14174ce2@w520.home>
References: <1580277724-66994-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277724-66994-4-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200129144046.3f91e4c1@w520.home>
        <20200129151951.2e354e37@w520.home>
        <20200131155125.53475a72@jacob-builder>
        <20200203112708.14174ce2@w520.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 11:27:08 -0700
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Fri, 31 Jan 2020 15:51:25 -0800
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Alex,
> > Sorry I missed this part in the previous reply. Comments below.
> > 
> > On Wed, 29 Jan 2020 15:19:51 -0700
> > Alex Williamson <alex.williamson@redhat.com> wrote:
> >   
> > > Also, is the 12-bytes of padding in struct iommu_gpasid_bind_data
> > > excessive with this new versioning scheme?  Per rule #2 I'm not
> > > sure if we're allowed to repurpose those padding bytes,    
> > We can still use the padding bytes as long as there is a new flag
> > bit to indicate the validity of the new filed within the padding.
> > I should have made it clear in rule #2 when mentioning the flags
> > bits. Should define what extension constitutes.
> > How about this?
> > "
> >  * 2. Data structures are open to extension but closed to
> > modification.
> >  *    Extension should leverage the padding bytes first where a new
> >  *    flag bit is required to indicate the validity of each new
> > member.
> >  *    The above rule for padding bytes also applies to adding new
> > union
> >  *    members.
> >  *    After padding bytes are exhausted, new fields must be added
> > at the
> >  *    end of each data structure with 64bit alignment. Flag bits
> > can be
> >  *    added without size change but existing ones cannot be altered.
> >  *
> > "
> > So if we add new field by doing re-purpose of padding bytes, size
> > lookup result will remain the same. New code would recognize the new
> > flag, old code stays the same.
> > 
> > VFIO layer checks for UAPI compatibility and size to copy, version
> > sanity check and flag usage are done in the IOMMU code.
> >   
> > > but if we add
> > > fields to the end of the structure as the scheme suggests, we're
> > > stuck with not being able to expand the union for new fields.    
> > Good point, it does sound contradictory. I hope the rewritten rule
> > #2 address that.
> > Adding data after the union should be extremely rare. Do you see any
> > issues with the example below?
> >  
> >  offsetofend() can still find the right size.
> > e.g.
> > V1
> > struct iommu_gpasid_bind_data {
> > 	__u32 version;
> > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > 	__u32 format;
> > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > 	__u64 flags;
> > 	__u64 gpgd;
> > 	__u64 hpasid;
> > 	__u64 gpasid;
> > 	__u32 addr_width;
> > 	__u8  padding[12];
> > 	/* Vendor specific data */
> > 	union {
> > 		struct iommu_gpasid_bind_data_vtd vtd;
> > 	};
> > };
> > 
> > const static int
> > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
> > IOMMU_UAPI_BIND_GPASID */ {offsetofend(struct
> > iommu_gpasid_bind_data, vtd)}, ...
> > };
> > 
> > V2, Add new_member at the end (forget padding for now).
> > struct iommu_gpasid_bind_data {
> > 	__u32 version;
> > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > 	__u32 format;
> > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
> > 	__u64 flags;
> > 	__u64 gpgd;
> > 	__u64 hpasid;
> > 	__u64 gpasid;
> > 	__u32 addr_width;
> > 	__u8  padding[12];
> > 	/* Vendor specific data */
> > 	union {
> > 		struct iommu_gpasid_bind_data_vtd vtd;
> > 	};
> > 	__u64 new_member;
> > };
> > const static int
> > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = { /*
> > IOMMU_UAPI_BIND_GPASID */ 
> > 	{offsetofend(struct iommu_gpasid_bind_data,
> > 	vtd), offsetofend(struct
> > iommu_gpasid_bind_data,new_member)},
> > 
> > };
> > 
> > V3, Add smmu to the union,larger than vtd
> > 
> > struct iommu_gpasid_bind_data {
> > 	__u32 version;
> > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > #define IOMMU_PASID_FORMAT_INTEL_SMMU	2
> > 	__u32 format;
> > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > #define IOMMU_NEW_MEMBER_VAL	(1 << 1) /* new member added */
> > #define IOMMU_SVA_SMMU_SUPP	(1 << 2) /* SMMU data supported
> > */ __u64 flags;
> > 	__u64 gpgd;
> > 	__u64 hpasid;
> > 	__u64 gpasid;
> > 	__u32 addr_width;
> > 	__u8  padding[12];
> > 	/* Vendor specific data */
> > 	union {
> > 		struct iommu_gpasid_bind_data_vtd vtd;
> > 		struct iommu_gpasid_bind_data_smmu smmu;
> > 	};
> > 	__u64 new_member;
> > };
> > const static int
> > iommu_uapi_data_size[NR_IOMMU_UAPI_TYPE][IOMMU_UAPI_VERSION] = {
> > 	/* IOMMU_UAPI_BIND_GPASID */
> > 	{offsetofend(struct iommu_gpasid_bind_data,vtd),
> > 	offsetofend(struct iommu_gpasid_bind_data, new_member),
> > 	offsetofend(struct iommu_gpasid_bind_data, new_member)},
> > ...
> > };
> >   
> 
> How are you not breaking rule #3, "Versions are backward compatible"
> with this?  If the kernel is at version 3 and userspace is at version
> 2 then new_member exists at different offsets of the structure.  The
> kernels iommu_uapi_data_size for V2 changed between version 2 and 3.
> Thanks,
> 
You are right. if we want to add new member to the end of the structure
as well as expanding union, I think we have to fix the size of the
union. Would this work? (just an example for one struct)


@@ -344,6 +348,11 @@ struct iommu_gpasid_bind_data_vtd {
  * @gpasid:    Process address space ID used for the guest mm in guest
IOMMU
  * @addr_width:        Guest virtual address width
  * @padding:   Reserved for future use (should be zero)
+ * @dummy      Reserve space for vendor specific data in the union. New
+ *             members added to the union cannot exceed the size of
dummy.
+ *             The fixed size union is needed to allow further
expansion
+ *             after the end of the union while still maintain backward
+ *             compatibility.
  * @vtd:       Intel VT-d specific data
  *
  * Guest to host PASID mapping can be an identity or non-identity,
where guest @@ -365,6 +374,7 @@ struct iommu_gpasid_bind_data {
        __u8  padding[12];
        /* Vendor specific data */
        union {
+               __u8 dummy[128];
                struct iommu_gpasid_bind_data_vtd vtd;
        };
 };

> Alex
> 

[Jacob Pan]
