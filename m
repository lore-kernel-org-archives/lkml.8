Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7180EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453A9206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgCaQD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:03:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:7045 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgCaQD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:29 -0400
IronPort-SDR: IiXMBa3bfCIuIJZm2w4b+W2Rhj4d15YERuatZP8CTPKLuF4Ey9v/6cjXJTMhl6vc6J6kWK35oi
 suxY6cDKezgg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:02:57 -0700
IronPort-SDR: i3YcuqOb7259MzCg51qQzr7zRWRdSHCZlHRjXjPHkSPzX8Syzb4FVL8NB/MFk0tDCUOYsULuoO
 7MWXEsVJyP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="272809187"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by fmsmga004.fm.intel.com with ESMTP; 31 Mar 2020 09:02:56 -0700
Date:   Tue, 31 Mar 2020 09:08:43 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] iommu/vt-d: Fix PASID cache flush
Message-ID: <20200331090843.59961e03@jacob-builder>
In-Reply-To: <53be1d27-6348-56db-7eac-6734f92f123d@redhat.com>
References: <1585610725-78316-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <53be1d27-6348-56db-7eac-6734f92f123d@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, this is not a bug. The current code has:
#define QI_PC_PASID_SEL             (QI_PC_TYPE | QI_PC_GRAN(1))

Which already has the type and shift.

In my vSVA series, I redefined granu such that I can use them in the 2D
table lookup.

-#define QI_PC_ALL_PASIDS       (QI_PC_TYPE | QI_PC_GRAN(0))        
-#define QI_PC_PASID_SEL                (QI_PC_TYPE | QI_PC_GRAN(1))
+/* PASID cache invalidation granu */                               
+#define QI_PC_ALL_PASIDS       0                                   
+#define QI_PC_PASID_SEL                1                           

Please ignore this, sorry about the confusion.

On Tue, 31 Mar 2020 11:28:17 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 3/31/20 1:25 AM, Jacob Pan wrote:
> > PASID cache type and shift of granularity bits are missing in
> > the current code.
> > 
> > Fixes: 6f7db75e1c46 ("iommu/vt-d: Add second level page table
> > interface")
> > 
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric
> 
> > ---
> >  drivers/iommu/intel-pasid.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 22b30f10b396..57d05b0fbafc
> > 100644 --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -365,7 +365,8 @@ pasid_cache_invalidation_with_pasid(struct
> > intel_iommu *iommu, {
> >  	struct qi_desc desc;
> >  
> > -	desc.qw0 = QI_PC_DID(did) | QI_PC_PASID_SEL |
> > QI_PC_PASID(pasid);
> > +	desc.qw0 = QI_PC_DID(did) | QI_PC_GRAN(QI_PC_PASID_SEL) |
> > +		   QI_PC_PASID(pasid) | QI_PC_TYPE;
> >  	desc.qw1 = 0;
> >  	desc.qw2 = 0;
> >  	desc.qw3 = 0;
> >   
> 

[Jacob Pan]
