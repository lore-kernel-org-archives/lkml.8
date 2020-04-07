Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBCBC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4780206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 11:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4qx4JOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgDGLB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 07:01:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33944 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgDGLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:01:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so3401230wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lrvv+xJ1GPbPtd9mC9WfvPH0Y05ufQDVnaAuC8UizGg=;
        b=R4qx4JOBBD08rkaPcYuve7i7YBu+uaBWWCNPH1KgklRWcm2mn+BHz7MFBD/5G8bS63
         pwuLv+YC8yWxneBxjrA8hTtg4wmRTdKuBlFtvMY6YU2WXhvCQnwdKHZivSsJYN65qdWi
         pxV2BL7a3eGDjSvF5CIetpFNRMZezjbn4ZGu3YSPtkW0Umyp2MGbFqCTF/W2N/CcmgwN
         DfU4Rj6iXHK7aR60xMgqb8JRf9PE8Ht8yZ4bm4zYad6J00HHAilj+UBAdAcxo46QQnbs
         lEKsJoFIDF51XrcFPuREZ9391dV/V0TfpC4sOYKSUNM5BWNbmOi/zln3sXSDdDFx5Ox/
         A5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lrvv+xJ1GPbPtd9mC9WfvPH0Y05ufQDVnaAuC8UizGg=;
        b=GrorWDomFI6I6deI1C4HLZ60GrpD3z0jKi6ca/Ht1ZwUMCowX3Y4ZgNSikYTphPYGU
         atLQJJZAXsLlFVpAmw2gmulwe6QBNWnrCLRTzh6blnvc2/rQrwnGqTKE82aPvIV/tPqY
         7ekGeJzD0i0flWEoaykTue9s1aconfeb5fxROoLhRVKWiZwsCwZubRpuixMx+r+rT3Mt
         n4ixCVasS0C4+sAuD9KUql/M6/DSOoL7D4Ol75lK3rNHoZLo/e0d44UdjQ8ohhAtT4/6
         qVgiDlnAaLrHcmaKtucGfHv6Ez4ADFdwnm3raV7N7Bqhc5Pud3pWUd5xd8sK+4WOI/3a
         Pekg==
X-Gm-Message-State: AGi0Pua7u4L930b2fx1dbavqfIbIb05of9s15+MOelPuEUfCJiin7jSU
        9bNXslhMMmc5RHO5qB4b6yQdJQ==
X-Google-Smtp-Source: APiQypIw5mZTJ+obpt9JttMWcZCpY5PLCvRKb+0qmz83brxu78nH/PbJRR8NjOqQssQsjCrOrH/AxA==
X-Received: by 2002:a5d:4842:: with SMTP id n2mr2217910wrs.154.1586257314435;
        Tue, 07 Apr 2020 04:01:54 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
        by smtp.gmail.com with ESMTPSA id c18sm30089003wrx.5.2020.04.07.04.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 04:01:54 -0700 (PDT)
Date:   Tue, 7 Apr 2020 13:01:46 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Message-ID: <20200407110146.GB285264@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401135316.GF882512@myrica>
 <20200406083353.73efda5b@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406083353.73efda5b@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:33:53AM -0700, Jacob Pan wrote:
> Hi Jean,
> 
> On Wed, 1 Apr 2020 15:53:16 +0200
> Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:
> 
> > On Wed, Mar 25, 2020 at 10:55:26AM -0700, Jacob Pan wrote:
> > > Bare metal SVA allocates IOASIDs for native process addresses. This
> > > should be separated from VM allocated IOASIDs thus under its own
> > > set.
> > > 
> > > This patch creates a system IOASID set with its quota set to
> > > PID_MAX. This is a reasonable default in that SVM capable devices
> > > can only bind to limited user processes.  
> > 
> > Yes realistically there won't be more than PID_MAX_DEFAULT=0x8000
> > bound address spaces. My machine uses a PID_MAX of 4 million though,
> > so in theory more than 0x8000 processes may want a bond.
> Got it, I assume we can adjust the system set quota as necessary.
> 
> > On Arm the
> > limit of shared contexts per VM is currently a little less than
> > 0x10000 (which is the number of CPU ASIDs).
> > 
> I guess shared contexts means shared address? then it makes sense
> #IOASID < #ASID.

Yes by shared contexts I mean shared address spaces. Theoretically #ASID <
#IOASID for us, because the max ASID size is 16-bit.

> 
> > But quotas are only necessary for VMs, when the host shares the PASID
> > space with them (which isn't a use-case for Arm systems as far as I
> > know, each VM gets its own PASID space).
> Is there a host-guest PASID translation? or the PASID used by the VM is
> physical PASID? When a page request comes in to SMMU, how does it know
> the owner of the PASID if PASID range can overlap between host and
> guest?

We assign PCI functions to VMs, so Page Requests are routed with
RID:PASID, not PASID alone. The SMMU finds the struct device associated
with the RID, and submits the fault with iommu_report_device_fault(). If
the VF is assigned to a VM, then the page request gets injected into the
VM, otherwise it uses the host IOPF handler

> > Could we have quota-free IOASID sets for the host?
> > 
> Yes, perhaps just add a flag such that the set has its own namespace.
> You mean have this quota-free IOASID set even co-exist with VMs? I still
> don't get how PRQ works.
> 
> That is not the use case for VT-d in that we have to have system-wide
> allocation for host PASIDs. We have enqcmd which can take a PASID from
> the per task MSR and deliver to multiple devices, so even though the
> PASID table is per device the PASID name space must be global.
> 
> > For the SMMU I'd like to allocate two sets, one SVA and one private
> > for auxiliary domains, and I don't think giving either a quota makes
> > much sense at the moment.
> I agree we don;t need the quota if we don't support guest SVA at the
> same time.
> 
> So the sva set and aux_domain set PASIDs have their own namespaces?

They share the same PASID space, but they store different objects
(mm_struct and context descriptor, respectively) so they need different
ioasid_set tokens.

> 
> > There can be systems using only SVA and
> > systems using only private PASIDs. I think it should be
> > first-come-first-served until admins want a knob to define a policy
> > themselves, based on cgroups for example.
> > 
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/iommu/intel-iommu.c | 8 +++++++-
> > >  drivers/iommu/ioasid.c      | 9 +++++++++
> > >  include/linux/ioasid.h      | 9 +++++++++
> > >  3 files changed, 25 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iommu/intel-iommu.c
> > > b/drivers/iommu/intel-iommu.c index ec3fc121744a..af7a1ef7b31e
> > > 100644 --- a/drivers/iommu/intel-iommu.c
> > > +++ b/drivers/iommu/intel-iommu.c
> > > @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
> > >  		goto free_iommu;
> > >  
> > >  	/* PASID is needed for scalable mode irrespective to SVM */
> > > -	if (intel_iommu_sm)
> > > +	if (intel_iommu_sm) {
> > >  		ioasid_install_capacity(intel_pasid_max_id);
> > > +		/* We should not run out of IOASIDs at boot */
> > > +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> > > +			pr_err("Failed to enable host PASID
> > > allocator\n");
> > > +			intel_iommu_sm = 0;
> > > +		}
> > > +	}
> > >  
> > >  	/*
> > >  	 * for each drhd
> > > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > > index 6265d2dbbced..9135af171a7c 100644
> > > --- a/drivers/iommu/ioasid.c
> > > +++ b/drivers/iommu/ioasid.c
> > > @@ -39,6 +39,9 @@ struct ioasid_data {
> > >  static ioasid_t ioasid_capacity;
> > >  static ioasid_t ioasid_capacity_avail;
> > >  
> > > +int system_ioasid_sid;
> > > +static DECLARE_IOASID_SET(system_ioasid);
> > > +
> > >  /* System capacity can only be set once */
> > >  void ioasid_install_capacity(ioasid_t total)
> > >  {
> > > @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
> > >  }
> > >  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> > >  
> > > +int ioasid_alloc_system_set(int quota)
> > > +{
> > > +	return ioasid_alloc_set(&system_ioasid, quota,
> > > &system_ioasid_sid); +}
> > > +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);  
> > 
> > I think this helper could stay in the VT-d driver for the moment. If
> > the SMMU driver ever implements auxiliary domains it will use a
> > private IOASID set, separate from the shared IOASID set managed by
> > iommu-sva. Both could qualify as "system set".
> > 
> Sounds good. Perhaps remove the special "system set". SVA code,
> VFIO, VT-d, or SMMU driver can all allocate their own sets.
> So to meet both SMMU and VT-d requirements, we should do:
> 1. add an IOASID_PRIVATE flag to ioasid_alloc_set(), indicating this is
> a private set
> 2. All APIs operate on the set_id accordingly, e.g. ioasid_find() will
> only search within the private set. Private set is excluded from from
> global search (VT-d needs this in PRQ).
> 
> Since VT-d already needs private PASIDs for guest SVM where
> GPASID!=HPASID, I feel we can just reuse the per ioasid_set Xarray for
> both quota-free private set and guest set.

Ok I think this sounds fine

Thanks,
Jean

> 
> 
> Thanks for the feedback!
> 
> Jacob
> 
> > Thanks,
> > Jean
> > 
> > > +
> > >  /*
> > >   * struct ioasid_allocator_data - Internal data structure to hold
> > > information
> > >   * about an allocator. There are two types of allocators:
> > > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > > index 8c82d2625671..097b1cc043a3 100644
> > > --- a/include/linux/ioasid.h
> > > +++ b/include/linux/ioasid.h
> > > @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
> > >  	void *pdata;
> > >  };
> > >  
> > > +/* Shared IOASID set for reserved for host system use */
> > > +extern int system_ioasid_sid;
> > > +
> > >  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> > >  
> > >  #if IS_ENABLED(CONFIG_IOASID)
> > > @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct
> > > ioasid_allocator_ops *allocator); void
> > > ioasid_unregister_allocator(struct ioasid_allocator_ops
> > > *allocator); int ioasid_attach_data(ioasid_t ioasid, void *data);
> > > void ioasid_install_capacity(ioasid_t total); +int
> > > ioasid_alloc_system_set(int quota); int ioasid_alloc_set(struct
> > > ioasid_set *token, ioasid_t quota, int *sid); void
> > > ioasid_free_set(int sid, bool destroy_set); int
> > > ioasid_find_sid(ioasid_t ioasid); @@ -88,5 +92,10 @@ static inline
> > > void ioasid_install_capacity(ioasid_t total) {
> > >  }
> > >  
> > > +static inline int ioasid_alloc_system_set(int quota)
> > > +{
> > > +	return -ENOTSUPP;
> > > +}
> > > +
> > >  #endif /* CONFIG_IOASID */
> > >  #endif /* __LINUX_IOASID_H */
> > > -- 
> > > 2.7.4
> > >   
> 
> [Jacob Pan]
