Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9777C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623BE21D79
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgIJRMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:12:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:55321 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgIJRKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:10:52 -0400
IronPort-SDR: O87W02/8X/3D2CO5mblc81Zdm2GR6AeytnTGW5Rhy5bYThU7DtHNasdy7tw2E2l33T22zmeRkw
 XZF314VI5cDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="157869318"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="157869318"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 10:10:51 -0700
IronPort-SDR: y3sx8lMTfOuw2CWmGsmU5NWTdrMQUu/FoHHbxM6PaW6Bm+XOz1mC1rsaSguMbPKBBWT+a28ipy
 /9w6SGhO5lXA==
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="300623572"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 10:10:50 -0700
Date:   Thu, 10 Sep 2020 10:12:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Auger Eric <eric.auger@redhat.com>
Cc:     Jacob Pan <jacob.pan.linux@gmail.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>, Wu Hao <hao.wu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 9/9] iommu/vt-d: Store guest PASID during bind
Message-ID: <20200910101248.19460882@jacob-builder>
In-Reply-To: <60feda75-5862-c898-97b1-1f5eafdb8d8c@redhat.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1598070918-21321-10-git-send-email-jacob.jun.pan@linux.intel.com>
        <60feda75-5862-c898-97b1-1f5eafdb8d8c@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 19:08:44 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 8/22/20 6:35 AM, Jacob Pan wrote:
> > IOASID core maintains the guest-host mapping in the form of SPID and
> > IOASID. This patch assigns the guest PASID (if valid) as SPID while
> > binding guest page table with a host PASID. This mapping will be
> > used for lookup and notifications.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/svm.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index d8a5efa75095..4c958b1aec4c 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -406,6 +406,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> > *domain, struct device *dev, if (data->flags &
> > IOMMU_SVA_GPASID_VAL) { svm->gpasid = data->gpasid;
> >  			svm->flags |= SVM_FLAG_GUEST_PASID;
> > +			ioasid_attach_spid(data->hpasid,
> > data->gpasid);  
> don't you want to handle the returned value?
Yes, I also need to add a check for duplicated SPID within a set.

> >  		}
> >  		svm->iommu = iommu;
> >  		/*
> > @@ -517,6 +518,7 @@ int intel_svm_unbind_gpasid(struct device *dev,
> > int pasid) ioasid_attach_data(pasid, NULL);
> >  				ioasid_notify(pasid, IOASID_UNBIND,
> >  					IOASID_NOTIFY_SET);
> > +				ioasid_attach_spid(pasid,
> > INVALID_IOASID);  
> So this answers my previous question ;-) but won't it enter the if
> (!ioasid_data) path and fail to reset the spid?
> 
Sorry, i am not following. If there is no ioasid_data then there is no
SPID to be stored.

BTW, I plan to separate the APIs into two.
ioasid_attach_spid
ioasid_detach_spid

Only ioasid_detach_spid will be calling synchronize RCU, then
ioasid_attach_spid can be called under spinlock.

Thanks,

> Eric
> >  				kfree(svm);
> >  			}
> >  		}
> >   
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
