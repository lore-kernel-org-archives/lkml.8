Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FF8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4B5C208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgCaPs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:48:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:50171 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbgCaPs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:48:58 -0400
IronPort-SDR: pgbfl++4Z4HwoDTVU+JxyWQaWsDU4pMysg6vJlz1Q7WTCRp7jo7ZxpB/iHGiq6hrBaofyO1hee
 /FoR32r04/AA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 08:48:57 -0700
IronPort-SDR: PdqC4zYT+ixmvpy4eOvwtMXdaQS3wca7lcl9W1cS1p2JTSh7Wr2FcpGOBIvKUXV0eynkw40C/S
 intzyx5ydRBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="249100686"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2020 08:48:57 -0700
Date:   Tue, 31 Mar 2020 08:54:44 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Message-ID: <20200331085444.44bee0bb@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D8011A9@SHSMSX104.ccr.corp.intel.com>
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
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Mar 2020 06:06:38 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Tuesday, March 31, 2020 12:08 AM
> > 
> > On Mon, 30 Mar 2020 05:40:40 +0000
> > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> >   
> > > > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Sent: Saturday, March 28, 2020 7:54 AM
> > > >
> > > > On Fri, 27 Mar 2020 00:47:02 -0700
> > > > Christoph Hellwig <hch@infradead.org> wrote:
> > > >  
> > > > > On Fri, Mar 27, 2020 at 02:49:55AM +0000, Tian, Kevin wrote:  
> > > > > > If those API calls are inter-dependent for composing a
> > > > > > feature (e.g. SVA), shouldn't we need a way to check them
> > > > > > together before exposing the feature to the guest, e.g.
> > > > > > through a iommu_get_uapi_capabilities interface?  
> > > > >
> > > > > Yes, that makes sense.  The important bit is to have a
> > > > > capability flags and not version numbers.  
> > > >
> > > > The challenge is that there are two consumers in the kernel for
> > > > this. 1. VFIO only look for compatibility, and size of each data
> > > > struct such that it can copy_from_user.
> > > >
> > > > 2. IOMMU driver, the "real consumer" of the content.
> > > >
> > > > For 2, I agree and we do plan to use the capability flags to
> > > > check content and maintain backward compatibility etc.
> > > >
> > > > For VFIO, it is difficult to do size look up based on capability
> > > > flags.  
> > >
> > > Can you elaborate the difficulty in VFIO? if, as Christoph Hellwig
> > > pointed out, version number is already avoided everywhere, it is
> > > interesting to know whether this work becomes a real exception
> > > or just requires a different mindset.
> > >  
> > From VFIO p.o.v. the IOMMU UAPI data is opaque, it only needs to do
> > two things:
> > 1. is the UAPI compatible?
> > 2. what is the size to copy?
> > 
> > If you look at the version number, this is really a "version as
> > size" lookup, as provided by the helper function in this patch. An
> > example can be the newly introduced clone3 syscall.
> > https://lwn.net/Articles/792628/
> > In clone3, new version must have new size. The slight difference
> > here is that, unlike clone3, we have multiple data structures
> > instead of a single struct clone_args {}. And each struct has flags
> > to enumerate its contents besides size.  
> 
> Thanks for providing that link. However clone3 doesn't include a
> version field to do "version as size" lookup. Instead, as you said,
> it includes a size parameter which sounds like the option 3 (argsz)
> listed below.
> 
Right, there is no version in clone3. size = version. I view this as
a 1:1 lookup.

> > 
> > Besides breaching data abstraction, if VFIO has to check IOMMU
> > flags to determine the sizes, it has many combinations.
> > 
> > We also separate the responsibilities into two parts
> > 1. compatibility - version, size by VFIO
> > 2. sanity check - capability flags - by IOMMU  
> 
> I feel argsz+flags approach can perfectly meet above requirement. The
> userspace set the size and flags for whatever capabilities it uses,
> and VFIO simply copies the parameters by size and pass to IOMMU for
> further sanity check. Of course the assumption is that we do provide
> an interface for userspace to enumerate all supported capabilities.
> 
You cannot trust user for argsz. the size to be copied from user must
be based on knowledge in kernel. That is why we have this version to
size lookup.

In VFIO, the size to copy is based on knowledge of each VFIO UAPI
structures and VFIO flags. But here the flags are IOMMU UAPI flags. As
you pointed out in another thread, VFIO is one user.

> Is there anything that I overlooked here? I suppose there might be
> some difficulties that block you from going the argsz way...
> 
> Thanks
> Kevin
> 
> > 
> > I think the latter matches what Christoph's comments. So we are in
> > agreement at the IOMMU level :)
> > 
> > For example:
> > During guest PASID bind, IOMMU driver operates on the data passed
> > from VFIO and check format & flags to take different code path.
> > 
> > #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > 	__u32 format;
> > #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > 	__u64 flags;
> > 
> > Jacob
> >   
> > > btw the most relevant discussion which I can find out now is here:
> > > 	https://lkml.org/lkml/2020/2/3/1126
> > >
> > > It mentioned 3 options for handling extension:
> > > --
> > > 1. Disallow adding new members to each structure other than reuse
> > > padding bits or adding union members at the end.
> > > 2. Allow extension of the structures beyond union, but union size
> > > has to be fixed with reserved spaces
> > > 3. Adopt VFIO argsz scheme, I don't think we need version for each
> > > struct anymore. argsz implies the version that user is using
> > > assuming UAPI data is extension only.
> > > --
> > >
> > > the first two are both version-based. Looks most guys agreed with
> > > option-1 (in this v2), but Alex didn't give his opinion at the
> > > moment. The last response from him was the raise of option-3 using
> > > argsz to avoid version. So, we also need hear from him. Alex?
> > >
> > > Thanks
> > > Kevin  
> > 
> > [Jacob Pan]  

[Jacob Pan]
