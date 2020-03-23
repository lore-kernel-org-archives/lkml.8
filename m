Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BEC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0CA2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgCWTbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:31:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:17166 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgCWTbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:31:44 -0400
IronPort-SDR: 56MVZZvxu7sFpJFVVnbnK8QXxHYHD29Jjy+lkrMo6CyBJDAES0vr4G3rcz9KIoqJYPJR0s+9B8
 FFKGjNNupLmA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 12:31:43 -0700
IronPort-SDR: Icf8e98MiUEH/hHIfhewV+VPnMA8LD7cxcdLyLi/5k33n+f3hMfzJSh8lJjfoeiPTl1h+ZzdSu
 dFKFzC5AQiNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,297,1580803200"; 
   d="scan'208";a="235316548"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga007.jf.intel.com with ESMTP; 23 Mar 2020 12:31:43 -0700
Date:   Mon, 23 Mar 2020 12:37:26 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH V10 02/11] iommu/uapi: Define a mask for bind data
Message-ID: <20200323123726.64974d83@jacob-builder>
In-Reply-To: <ae2a1a46-07ed-8445-d905-37dda1459e28@linux.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1584746861-76386-3-git-send-email-jacob.jun.pan@linux.intel.com>
        <ae2a1a46-07ed-8445-d905-37dda1459e28@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Mar 2020 09:29:32 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/3/21 7:27, Jacob Pan wrote:
> > Memory type related flags can be grouped together for one simple
> > check.
> > 
> > ---
> > v9 renamed from EMT to MTS since these are memory type support
> > flags. ---
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   include/uapi/linux/iommu.h | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 4ad3496e5c43..d7bcbc5f79b0 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
> >   	__u32 pat;
> >   	__u32 emt;
> >   };
> > -
> > +#define IOMMU_SVA_VTD_GPASID_MTS_MASK
> > (IOMMU_SVA_VTD_GPASID_CD | \
> > +					 IOMMU_SVA_VTD_GPASID_EMTE
> > | \
> > +					 IOMMU_SVA_VTD_GPASID_PCD
> > |  \
> > +
> > IOMMU_SVA_VTD_GPASID_PWT)  
> 
> As name implies, can this move to intel-iommu.h?
> 
I also thought about this but the masks are in vendor specific part of
the UAPI.

> Best regards,
> baolu
> 
> >   /**
> >    * struct iommu_gpasid_bind_data - Information about device and
> > guest PASID binding
> >    * @version:	Version of this data structure
> >   

[Jacob Pan]
