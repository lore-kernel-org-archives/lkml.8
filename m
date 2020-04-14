Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F91BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4308F2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391946AbgDNW0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:26:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:38339 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391937AbgDNW0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:26:35 -0400
IronPort-SDR: +tjezwqANsW1dR96k5I7+bfWFyHqWhazeWtouvf2nrCPNhIoljt6wC8dZhI/S/OblQDHkNquzE
 LWKiBczX9Ykw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 15:26:32 -0700
IronPort-SDR: oq184DX6aPOgdSCRIeNXAFlwjcOFZ478YzXipsC7CI01jOPfMgssJsoT9WC8XXqVQs3Lg+NN6g
 TnZK14ggE4AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="427222967"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2020 15:26:32 -0700
Date:   Tue, 14 Apr 2020 15:32:26 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200414153226.30d8cab3@jacob-builder>
In-Reply-To: <20200414101304.27e587eb@jacob-builder>
References: <1585178227-17061-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585178227-17061-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200326092316.GA31648@infradead.org>
        <20200326094442.5be042ce@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7ECB45@SHSMSX104.ccr.corp.intel.com>
        <20200327074702.GA27959@infradead.org>
        <20200327165335.397f24a3@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D7FE150@SHSMSX104.ccr.corp.intel.com>
        <20200330090746.23c5599c@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
        <20200331085444.44bee0bb@jacob-builder>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D803AFF@SHSMSX104.ccr.corp.intel.com>
        <20200402113604.6eea1e6f@jacob-builder>
        <20200413134157.395981a6@jacob-builder>
        <20200413162129.313b3b5a@w520.home>
        <20200413220515.25a107b6@jacob-builder>
        <20200414101358.3ae66ac5@w520.home>
        <20200414101304.27e587eb@jacob-builder>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 10:13:04 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> > > >  In any of the proposed solutions, the
> > > > IOMMU driver is ultimately responsible for validating the user
> > > > data, so do we want vfio performing the copy_from_user() to an
> > > > object that could later be assumed to be sanitized, or should
> > > > vfio just pass a user pointer to make it obvious that the
> > > > consumer is responsible for all the user protections?  Seems
> > > > like the latter.      
> > > I like the latter as well.
> > >     
On a second thought, I think the former is better. Two reasons:

1. IOMMU API such as page_response is also used in baremetal. So it is
not suitable to pass a __user *.
https://www.spinics.net/lists/arm-kernel/msg798677.html

2. Some data are in the mandatory (fixed offset, never removed or
extended) portion of the uAPI structure. It is simpler for VFIO to
extract that and pass it to IOMMU API. For example, the PASID value used
for unbind_gpasid(). VFIO also need to sanitize the PASID value to make
sure it belongs to the same VM that did the allocation.


> > > >  That still really
> > > > doesn't address what's in that user data blob yet, but the vfio
> > > > interface could be:
> > > > 
> > > > struct {
> > > > 	__u32 argsz;
> > > > 	__u32 flags;
> > > > 	__u8  data[];
> > > > }
> > > > 
> > > > Where flags might be partitioned like we do for DEVICE_FEATURE
> > > > to indicate the format of data and what vfio should do with it,
> > > > and data might simply be defined as a (__u64 __user *).
> > > >       
> > > So, __user * will be passed to IOMMU driver if VFIO checks minsz
> > > include flags and they are valid.
> > > IOMMU driver can copy the rest based on the mandatory
> > > version/minsz and flags in the IOMMU uAPI structs.
> > > Does it sound right? This is really choice #2.    
> > 
> > Sounds like each IOMMU UAPI struct just needs to have an embedded
> > size and flags field, but yes.
> >   
> Yes, an argsz field can be added to each UAPI. There are already flags
> or the equivalent. IOMMU driver can process the __user * based on the
> argsz, flags, check argsz against offsetofend(iommu_uapi_struct,
> last_element), etc.;
