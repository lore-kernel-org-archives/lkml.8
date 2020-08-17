Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BAFC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB6620674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgHQWlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:41:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:13677 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730219AbgHQWl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:41:27 -0400
IronPort-SDR: Hd71QBBbHKbSU31DrLUmCdVUjBLFSPKGZ7c4+8+YtXhBVaEbvno5v5W+VDikjP4itcTHbU8/Wq
 z6icF/8lyRow==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="142428172"
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="142428172"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 15:41:26 -0700
IronPort-SDR: kbS4JUFD4lESIJPfbvyLrygG0kinU1ys9lyHsDICdewOCJc0Yg90HIsv0Y/dI8pK0iTkS6viVe
 dD8A5JBamnEg==
X-IronPort-AV: E=Sophos;i="5.76,324,1592895600"; 
   d="scan'208";a="336411372"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 15:41:26 -0700
Date:   Mon, 17 Aug 2020 15:48:25 -0700
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
Subject: Re: [PATCH v7 2/7] iommu/uapi: Add argsz for user filled data
Message-ID: <20200817154825.3f27190f@jacob-builder>
In-Reply-To: <1ac39547-143b-2a2e-e142-92be023ef8d7@redhat.com>
References: <1596068467-49322-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1596068467-49322-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <1ac39547-143b-2a2e-e142-92be023ef8d7@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020 18:59:14 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 7/30/20 2:21 AM, Jacob Pan wrote:
> > As IOMMU UAPI gets extended, user data size may increase. To support
> > backward compatibiliy, this patch introduces a size field to each
> > UAPI  
> s/compatibiliy/compatibility
will fix

> > data structures. It is *always* the responsibility for the user to
> > fill in the correct size. Padding fields are adjusted to ensure 8
> > byte alignment.
> > 
> > Specific scenarios for user data handling are documented in:
> > Documentation/userspace-api/iommu.rst  
> 
> you may mention the struct version does not need to be incremented as
> no IOCTL uses the structs yet.
Yes, good point. I also mentioned in the doc that:

"Version field is only reserved for the unlikely event of UAPI upgrade
at its entirety."

> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index e907b7091a46..d5e9014f690e 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -135,6 +135,7 @@ enum iommu_page_response_code {
> >  
> >  /**
> >   * struct iommu_page_response - Generic page response information
> > + * @argsz: User filled size of this data
> >   * @version: API version of this structure
> >   * @flags: encodes whether the corresponding fields are valid
> >   *         (IOMMU_FAULT_PAGE_RESPONSE_* values)
> > @@ -143,6 +144,7 @@ enum iommu_page_response_code {
> >   * @code: response code from &enum iommu_page_response_code
> >   */
> >  struct iommu_page_response {
> > +	__u32	argsz;
> >  #define IOMMU_PAGE_RESP_VERSION_1	1
> >  	__u32	version;
> >  #define IOMMU_PAGE_RESP_PASID_VALID	(1 << 0)
> > @@ -218,6 +220,7 @@ struct iommu_inv_pasid_info {
> >  /**
> >   * struct iommu_cache_invalidate_info - First level/stage
> > invalidation
> >   *     information
> > + * @argsz: User filled size of this data
> >   * @version: API version of this structure
> >   * @cache: bitfield that allows to select which caches to
> > invalidate
> >   * @granularity: defines the lowest granularity used for the
> > invalidation: @@ -246,6 +249,7 @@ struct iommu_inv_pasid_info {
> >   * must support the used granularity.
> >   */
> >  struct iommu_cache_invalidate_info {
> > +	__u32	argsz;
> >  #define IOMMU_CACHE_INVALIDATE_INFO_VERSION_1 1
> >  	__u32	version;
> >  /* IOMMU paging structure cache */
> > @@ -255,7 +259,7 @@ struct iommu_cache_invalidate_info {
> >  #define IOMMU_CACHE_INV_TYPE_NR		(3)
> >  	__u8	cache;
> >  	__u8	granularity;
> > -	__u8	padding[2];
> > +	__u8	padding[6];
> >  	union {
> >  		struct iommu_inv_pasid_info pasid_info;
> >  		struct iommu_inv_addr_info addr_info;
> > @@ -292,6 +296,7 @@ struct iommu_gpasid_bind_data_vtd {
> >  
> >  /**
> >   * struct iommu_gpasid_bind_data - Information about device and
> > guest PASID binding
> > + * @argsz:	User filled size of this data
> >   * @version:	Version of this data structure
> >   * @format:	PASID table entry format
> >   * @flags:	Additional information on guest bind request
> > @@ -309,17 +314,18 @@ struct iommu_gpasid_bind_data_vtd {
> >   * PASID to host PASID based on this bind data.
> >   */
> >  struct iommu_gpasid_bind_data {
> > +	__u32 argsz;
> >  #define IOMMU_GPASID_BIND_VERSION_1	1
> >  	__u32 version;
> >  #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> >  	__u32 format;
> > +	__u32 addr_width;
> >  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid
> > */ __u64 flags;
> >  	__u64 gpgd;
> >  	__u64 hpasid;
> >  	__u64 gpasid;
> > -	__u32 addr_width;
> > -	__u8  padding[12];
> > +	__u8  padding[8];
> >  	/* Vendor specific data */
> >  	union {
> >  		struct iommu_gpasid_bind_data_vtd vtd;
> >   
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 

[Jacob Pan]
