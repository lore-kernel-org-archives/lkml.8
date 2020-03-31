Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA27208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgCaW1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:27:41 -0400
Received: from mga18.intel.com ([134.134.136.126]:33635 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730556AbgCaW1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:27:41 -0400
IronPort-SDR: 6942gzEt1BCU0uMt4E3j+nw4YFwcpkxkfyho24pC/QkkOX4x6zw6lz/HJL+n9FHLM2TUM4btyE
 76Isutb6/XqA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 15:27:41 -0700
IronPort-SDR: sm5w+8Oj3UiLPWOp2oWKzbwK5CAF0dUl41izCr8bm23fIOz9KrC7KNrS8TCcWxaCU/TdyyK92T
 0eu547XSuAoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,329,1580803200"; 
   d="scan'208";a="295144707"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2020 15:27:39 -0700
Date:   Tue, 31 Mar 2020 15:33:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 09/11] iommu/vt-d: Cache virtual command capability
 register
Message-ID: <20200331153327.50219c12@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0E7@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA0E7@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020 10:04:38 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, March 21, 2020 7:28 AM
> > 
> > Virtual command registers are used in the guest only, to prevent
> > vmexit cost, we cache the capability and store it during
> > initialization.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > ---
> > v7 Reviewed by Eric & Baolu
> > ---
> > ---
> >  drivers/iommu/dmar.c        | 1 +
> >  include/linux/intel-iommu.h | 5 +++++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> > index 4d6b7b5b37ee..3b36491c8bbb 100644
> > --- a/drivers/iommu/dmar.c
> > +++ b/drivers/iommu/dmar.c
> > @@ -963,6 +963,7 @@ static int map_iommu(struct intel_iommu *iommu,
> > u64 phys_addr)
> >  		warn_invalid_dmar(phys_addr, " returns all ones");
> >  		goto unmap;
> >  	}
> > +	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> > 
> >  	/* the registers might be more than one page */
> >  	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 43539713b3b3..ccbf164fb711
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -194,6 +194,9 @@
> >  #define ecap_max_handle_mask(e) ((e >> 20) & 0xf)
> >  #define ecap_sc_support(e)	((e >> 7) & 0x1) /* Snooping
> > Control */
> > 
> > +/* Virtual command interface capabilities */  
> 
> capabilities -> capability
Will do, I was thinking the future :)

Thanks,

Jacob
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 
> > +#define vccap_pasid(v)		((v & DMA_VCS_PAS)) /* PASID
> > allocation */
> > +
> >  /* IOTLB_REG */
> >  #define DMA_TLB_FLUSH_GRANU_OFFSET  60
> >  #define DMA_TLB_GLOBAL_FLUSH (((u64)1) << 60)
> > @@ -287,6 +290,7 @@
> > 
> >  /* PRS_REG */
> >  #define DMA_PRS_PPR	((u32)1)
> > +#define DMA_VCS_PAS	((u64)1)
> > 
> >  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)
> > 	\
> >  do
> > {
> > \ @@ -537,6 +541,7 @@ struct intel_iommu { u64
> > reg_size; /* size of hw register set */ u64		cap;
> >  	u64		ecap;
> > +	u64		vccap;
> >  	u32		gcmd; /* Holds TE, EAFL. Don't need
> > SRTP, SFL, WBF */
> >  	raw_spinlock_t	register_lock; /* protect register
> > handling */ int		seq_id;	/* sequence id of the
> > iommu */ --
> > 2.7.4  
> 

[Jacob Pan]
