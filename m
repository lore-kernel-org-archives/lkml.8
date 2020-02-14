Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6070EC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317852081E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBNXVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 18:21:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:5710 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgBNXVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 18:21:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 15:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="381591053"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2020 15:21:39 -0800
Date:   Fri, 14 Feb 2020 15:27:01 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V9 05/10] iommu/vt-d: Support flushing more translation
 cache types
Message-ID: <20200214152701.18f76ce1@jacob-builder>
In-Reply-To: <11add211-dec0-1932-c29c-22cbbf145bd4@redhat.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1580277713-66934-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <11add211-dec0-1932-c29c-22cbbf145bd4@redhat.com>
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

On Wed, 12 Feb 2020 13:55:25 +0100
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 1/29/20 7:01 AM, Jacob Pan wrote:
> > When Shared Virtual Memory is exposed to a guest via vIOMMU,
> > scalable IOTLB invalidation may be passed down from outside IOMMU
> > subsystems. This patch adds invalidation functions that can be used
> > for additional translation cache types.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/dmar.c        | 33 +++++++++++++++++++++++++++++++++
> >  drivers/iommu/intel-pasid.c |  3 ++-
> >  include/linux/intel-iommu.h | 20 ++++++++++++++++----
> >  3 files changed, 51 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 071bb42bbbc5..206733ec8140 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -1411,6 +1411,39 @@ void qi_flush_piotlb(struct intel_iommu
> > *iommu, u16 did, u32 pasid, u64 addr, qi_submit_sync(&desc, iommu);
> >  }
> >  
> > +/* PASID-based device IOTLB Invalidate */
> > +void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu, u16 sid,
> > u16 pfsid,
> > +		u32 pasid,  u16 qdep, u64 addr, unsigned
> > size_order, u64 granu) +{
> > +	struct qi_desc desc = {.qw2 = 0, .qw3 = 0};
> > +
> > +	desc.qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> > QI_DEV_EIOTLB_SID(sid) |
> > +		QI_DEV_EIOTLB_QDEP(qdep) | QI_DEIOTLB_TYPE |
> > +		QI_DEV_IOTLB_PFSID(pfsid);
> > +	desc.qw1 = QI_DEV_EIOTLB_GLOB(granu);
> > +
> > +	/* If S bit is 0, we only flush a single page. If S bit is
> > set,
> > +	 * The least significant zero bit indicates the
> > invalidation address
> > +	 * range. VT-d spec 6.5.2.6.
> > +	 * e.g. address bit 12[0] indicates 8KB, 13[0] indicates
> > 16KB.
> > +	 */
> > +	if (!size_order) {
> > +		desc.qw0 |= QI_DEV_EIOTLB_ADDR(addr) &
> > ~QI_DEV_EIOTLB_SIZE;
> > +	} else {
> > +		unsigned long mask = 1UL << (VTD_PAGE_SHIFT +
> > size_order);
> > +		desc.qw1 |= QI_DEV_EIOTLB_ADDR(addr & ~mask) |
> > QI_DEV_EIOTLB_SIZE;
> > +	}
> > +	qi_submit_sync(&desc, iommu);  
> I made some comments in
> https://lkml.org/lkml/2019/8/14/1311
> that do not seem to have been taken into account. Or do I miss
> something?
> 
I missed adding these changes. At the time Baolu was doing cache flush
consolidation so I wasn't sure if I could use his code completely. This
patch is on top of his consolidated flush code with what is still
needed for vSVA. Then I forgot to address your comments. Sorry about
that.

> More generally having an individual history log would be useful and
> speed up the review.
> 
Will add history to each patch, e.g. like this?
---
v8 -> v9
---
> Thanks
> 
> Eric
> > +}
> > +
> > +void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64
> > granu, int pasid) +{
> > +	struct qi_desc desc = {.qw1 = 0, .qw2 = 0, .qw3 = 0};
> > +
> > +	desc.qw0 = QI_PC_PASID(pasid) | QI_PC_DID(did) |
> > QI_PC_GRAN(granu) | QI_PC_TYPE;
> > +	qi_submit_sync(&desc, iommu);
> > +}
> > +
> >  /*
> >   * Disable Queued Invalidation interface.
> >   */
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index bd067af4d20b..b100f51407f9
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -435,7 +435,8 @@ pasid_cache_invalidation_with_pasid(struct
> > intel_iommu *iommu, {
> >  	struct qi_desc desc;
> >  
> > -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
> > QI_PC_PASID(pasid);
> > +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> > +		QI_PC_PASID(pasid) | QI_PC_TYPE;
> >  	desc.qw1 = 0;
> >  	desc.qw2 = 0;
> >  	desc.qw3 = 0;
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index b0ffecbc0dfc..dd9fa61689bc
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -332,7 +332,7 @@ enum {
> >  #define QI_IOTLB_GRAN(gran) 	(((u64)gran) >>
> > (DMA_TLB_FLUSH_GRANU_OFFSET-4)) #define QI_IOTLB_ADDR(addr)
> > (((u64)addr) & VTD_PAGE_MASK) #define
> > QI_IOTLB_IH(ih)		(((u64)ih) << 6) -#define
> > QI_IOTLB_AM(am)		(((u8)am)) +#define
> > QI_IOTLB_AM(am)		(((u8)am) & 0x3f) 
> >  #define QI_CC_FM(fm)		(((u64)fm) << 48)
> >  #define QI_CC_SID(sid)		(((u64)sid) << 32)
> > @@ -351,16 +351,21 @@ enum {
> >  #define QI_PC_DID(did)		(((u64)did) << 16)
> >  #define QI_PC_GRAN(gran)	(((u64)gran) << 4)
> >  
> > -#define QI_PC_ALL_PASIDS	(QI_PC_TYPE | QI_PC_GRAN(0))
> > -#define QI_PC_PASID_SEL		(QI_PC_TYPE | QI_PC_GRAN(1))
> > +/* PASID cache invalidation granu */
> > +#define QI_PC_ALL_PASIDS	0
> > +#define QI_PC_PASID_SEL		1
> >  
> >  #define QI_EIOTLB_ADDR(addr)	((u64)(addr) & VTD_PAGE_MASK)
> >  #define QI_EIOTLB_IH(ih)	(((u64)ih) << 6)
> > -#define QI_EIOTLB_AM(am)	(((u64)am))
> > +#define QI_EIOTLB_AM(am)	(((u64)am) & 0x3f)
> >  #define QI_EIOTLB_PASID(pasid) 	(((u64)pasid) << 32)
> >  #define QI_EIOTLB_DID(did)	(((u64)did) << 16)
> >  #define QI_EIOTLB_GRAN(gran) 	(((u64)gran) << 4)
> >  
> > +/* QI Dev-IOTLB inv granu */
> > +#define QI_DEV_IOTLB_GRAN_ALL		1
> > +#define QI_DEV_IOTLB_GRAN_PASID_SEL	0
> > +
> >  #define QI_DEV_EIOTLB_ADDR(a)	((u64)(a) & VTD_PAGE_MASK)
> >  #define QI_DEV_EIOTLB_SIZE	(((u64)1) << 11)
> >  #define QI_DEV_EIOTLB_GLOB(g)	((u64)g)
> > @@ -660,8 +665,15 @@ extern void qi_flush_iotlb(struct intel_iommu
> > *iommu, u16 did, u64 addr, unsigned int size_order, u64 type);
> >  extern void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid,
> > u16 pfsid, u16 qdep, u64 addr, unsigned mask);
> > +
> >  void qi_flush_piotlb(struct intel_iommu *iommu, u16 did, u32
> > pasid, u64 addr, unsigned long npages, bool ih);
> > +
> > +extern void qi_flush_dev_iotlb_pasid(struct intel_iommu *iommu,
> > u16 sid, u16 pfsid,
> > +			u32 pasid, u16 qdep, u64 addr, unsigned
> > size_order, u64 granu); +
> > +extern void qi_flush_pasid_cache(struct intel_iommu *iommu, u16
> > did, u64 granu, int pasid); +
> >  extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu
> > *iommu); 
> >  extern int dmar_ir_support(void);
> >   
> 

[Jacob Pan]
