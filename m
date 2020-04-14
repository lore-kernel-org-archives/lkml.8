Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B15C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1E520578
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634402AbgDNXr4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:47:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:61459 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634390AbgDNXrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:47:46 -0400
IronPort-SDR: ASxAReHKm6cZ9kuqRKnSxCurTy5vf+Pbi7jkgA3is8cNv+5Hv8R1XqLstDJDeM//ubOsqC4fUZ
 7D8AyEUx2QnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 16:47:45 -0700
IronPort-SDR: HJEwfmx2SlLZPGikH6t0hQXnR0ePb56U5BQzHKT4XGZ+/3vb8VlyroeVtSYWf0JrbYhiiKd1kK
 2vnv/4bA4F2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="400120235"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2020 16:47:44 -0700
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 16:47:44 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 16:47:43 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 07:47:41 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Topic: [PATCH v2 1/3] iommu/uapi: Define uapi version and capabilities
Thread-Index: AQHWAvq+z2SPyfblHkGvV1oKjQsO9ahaFEoAgAB7VgCAAS14gP//zqQAgAEODYCABAXlIIAALvMAgAFssACAACIBAIABY/uQgAHtwgCAEWzRgIAAG8+AgABw0ICAALrWAIAAEIMAgABZOwCAAJqrwA==
Date:   Tue, 14 Apr 2020 23:47:40 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D81F901@SHSMSX104.ccr.corp.intel.com>
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
        <20200413134157.395981a6@jacob-builder> <20200413162129.313b3b5a@w520.home>
        <20200413220515.25a107b6@jacob-builder> <20200414101358.3ae66ac5@w520.home>
        <20200414101304.27e587eb@jacob-builder>
 <20200414153226.30d8cab3@jacob-builder>
In-Reply-To: <20200414153226.30d8cab3@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, April 15, 2020 6:32 AM
> 
> On Tue, 14 Apr 2020 10:13:04 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > > > >  In any of the proposed solutions, the
> > > > > IOMMU driver is ultimately responsible for validating the user
> > > > > data, so do we want vfio performing the copy_from_user() to an
> > > > > object that could later be assumed to be sanitized, or should
> > > > > vfio just pass a user pointer to make it obvious that the
> > > > > consumer is responsible for all the user protections?  Seems
> > > > > like the latter.
> > > > I like the latter as well.
> > > >
> On a second thought, I think the former is better. Two reasons:
> 
> 1. IOMMU API such as page_response is also used in baremetal. So it is
> not suitable to pass a __user *.
> https://www.spinics.net/lists/arm-kernel/msg798677.html

You can have a wrapped version accepting a __user* and an internal
version for kernel pointers.

> 
> 2. Some data are in the mandatory (fixed offset, never removed or
> extended) portion of the uAPI structure. It is simpler for VFIO to
> extract that and pass it to IOMMU API. For example, the PASID value used
> for unbind_gpasid(). VFIO also need to sanitize the PASID value to make
> sure it belongs to the same VM that did the allocation.

I don't think this makes much difference. If anyway you still plan to
let IOMMU driver parse some user pointers, why not making a clear
split to have it sparse all IOMMU specific fields?

Thanks
Kevin

> 
> 
> > > > >  That still really
> > > > > doesn't address what's in that user data blob yet, but the vfio
> > > > > interface could be:
> > > > >
> > > > > struct {
> > > > > 	__u32 argsz;
> > > > > 	__u32 flags;
> > > > > 	__u8  data[];
> > > > > }
> > > > >
> > > > > Where flags might be partitioned like we do for DEVICE_FEATURE
> > > > > to indicate the format of data and what vfio should do with it,
> > > > > and data might simply be defined as a (__u64 __user *).
> > > > >
> > > > So, __user * will be passed to IOMMU driver if VFIO checks minsz
> > > > include flags and they are valid.
> > > > IOMMU driver can copy the rest based on the mandatory
> > > > version/minsz and flags in the IOMMU uAPI structs.
> > > > Does it sound right? This is really choice #2.
> > >
> > > Sounds like each IOMMU UAPI struct just needs to have an embedded
> > > size and flags field, but yes.
> > >
> > Yes, an argsz field can be added to each UAPI. There are already flags
> > or the equivalent. IOMMU driver can process the __user * based on the
> > argsz, flags, check argsz against offsetofend(iommu_uapi_struct,
> > last_element), etc.;
