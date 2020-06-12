Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E12320731
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgFKXzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:55:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:57919 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgFKXzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:55:51 -0400
IronPort-SDR: GBSYh4QzDOffPFmVa/XsR7IU2nJy1QwgSzVjOL58QA8KFWtfp27emjtTvXBRecpCrIwmaLDZj5
 S77lGx+4ITtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 16:55:51 -0700
IronPort-SDR: 4x4zF9SvzKmm9dyWY4ue1fzA7Z0jpOO7A56jcV2UPWtsr3bi7KKjOgihk+gEqKQhpjKD9m+RxM
 GgF6RmS9MIng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,501,1583222400"; 
   d="scan'208";a="307124319"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jun 2020 16:55:50 -0700
Date:   Thu, 11 Jun 2020 17:02:15 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 2/3] iommu/uapi: Add argsz for user filled data
Message-ID: <20200611170215.7005042e@jacob-builder>
In-Reply-To: <20200611104936.5129e99e@x1.home>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611104936.5129e99e@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 10:49:36 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Wed, 10 Jun 2020 21:12:14 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > As IOMMU UAPI gets extended, user data size may increase. To support
> > backward compatibiliy, this patch introduces a size field to each
> > UAPI data structures. It is *always* the responsibility for the
> > user to fill in the correct size.  
> 
> Though at the same time, argsz is user provided data which we don't
> trust.  The argsz field allows the user to indicate how much data
> they're providing, it's still the kernel's responsibility to validate
> whether it's correct and sufficient for the requested operation.
> Thanks,
> 
Yes, will add this clarification.

Thanks,

Jacob
> Alex
> 
> > Specific scenarios for user data handling are documented in:
> > Documentation/userspace-api/iommu.rst
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index e907b7091a46..303f148a5cd7 100644
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
> > @@ -292,6 +296,7 @@ struct iommu_gpasid_bind_data_vtd {
> >  
> >  /**
> >   * struct iommu_gpasid_bind_data - Information about device and
> > guest PASID binding
> > + * @argsz:	User filled size of this data
> >   * @version:	Version of this data structure
> >   * @format:	PASID table entry format
> >   * @flags:	Additional information on guest bind request
> > @@ -309,6 +314,7 @@ struct iommu_gpasid_bind_data_vtd {
> >   * PASID to host PASID based on this bind data.
> >   */
> >  struct iommu_gpasid_bind_data {
> > +	__u32 argsz;
> >  #define IOMMU_GPASID_BIND_VERSION_1	1
> >  	__u32 version;
> >  #define IOMMU_PASID_FORMAT_INTEL_VTD	1  
> 

[Jacob Pan]
