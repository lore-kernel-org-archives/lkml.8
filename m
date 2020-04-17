Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5370C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D100214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 23:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgDQXqV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:46:21 -0400
Received: from mga03.intel.com ([134.134.136.65]:45942 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbgDQXqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 19:46:20 -0400
IronPort-SDR: 7YJm9L6kGFEbGq9F7HuvgyF/ynFuUn6ymqLo0qClyDHPyUeB9h+tAN8yH6smYFf5gEnHxgGSZX
 D+qhV3o34n4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 16:46:19 -0700
IronPort-SDR: ASTM0DenDX4diKwnGTttR6Xv7iDqv3xnQHPdpPTR7mJ4hGFXK2+44Gcq/V1yQWM1yzhcI/Jldu
 X9SO2dbxBxhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="280903732"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2020 16:46:18 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 16:46:18 -0700
Received: from shsmsx108.ccr.corp.intel.com (10.239.4.97) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 16:46:18 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX108.ccr.corp.intel.com ([169.254.8.7]) with mapi id 14.03.0439.000;
 Sat, 18 Apr 2020 07:46:14 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Auger Eric <eric.auger@redhat.com>
CC:     Yi L <yi.l.liu@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: RE: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Thread-Topic: [PATCH v11 05/10] iommu/vt-d: Add bind guest PASID support
Thread-Index: AQHWCebOp12IiW87IUSByO2zgM/w7qhv6qkAgAJcu4CACNZVgIABkaSw///PdICAAIEBgIABEGEg
Date:   Fri, 17 Apr 2020 23:46:13 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D826F9D@SHSMSX104.ccr.corp.intel.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1585939334-21396-6-git-send-email-jacob.jun.pan@linux.intel.com>
        <ab57b85b-235f-dc80-1c25-9b3d42dc5f4e@redhat.com>
        <20200410124557.4012b99b@jacob-builder>
        <6d9721a8-2198-5ecd-6c8b-fc43ff2ad7e1@redhat.com>
        <AADFC41AFE54684AB9EE6CBC0274A5D19D824106@SHSMSX104.ccr.corp.intel.com>
        <2025736d-e7f2-d746-e030-e609b2f465e2@redhat.com>
 <20200417082839.45d6321e@jacob-builder>
In-Reply-To: <20200417082839.45d6321e@jacob-builder>
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
> Sent: Friday, April 17, 2020 11:29 PM
> 
> On Fri, 17 Apr 2020 09:46:55 +0200
> Auger Eric <eric.auger@redhat.com> wrote:
> 
> > Hi Kevin,
> > On 4/17/20 4:45 AM, Tian, Kevin wrote:
> > >> From: Auger Eric
> > >> Sent: Thursday, April 16, 2020 6:43 PM
> > >>
> > > [...]
> > >>>>> +	if (svm) {
> > >>>>> +		/*
> > >>>>> +		 * If we found svm for the PASID, there must
> > >>>>> be at
> > >>>>> +		 * least one device bond, otherwise svm should
> > >>>>> be freed.
> > >>>>> +		 */
> > >>>>> +		if (WARN_ON(list_empty(&svm->devs))) {
> > >>>>> +			ret = -EINVAL;
> > >>>>> +			goto out;
> > >>>>> +		}
> > >>>>> +
> > >>>>> +		for_each_svm_dev(sdev, svm, dev) {
> > >>>>> +			/* In case of multiple sub-devices of
> > >>>>> the same pdev
> > >>>>> +			 * assigned, we should allow multiple
> > >>>>> bind calls with
> > >>>>> +			 * the same PASID and pdev.
> > >>>>> +			 */
> > >>>>> +			sdev->users++;
> > >>>> What if this is not an mdev device. Is it also allowed?
> > >>> Yes. IOMMU and VT-d driver is not mdev aware. Here mdev is just an
> > >>> example of normal use case. You can bind the same PCI device (PF
> > >>> or SRIOV VF) more than once to the same PASID. Just need to
> > >>> unbind also.
> > >>
> > >> I don't get the point of binding a non mdev device several times
> > >> with the same PASID. Do you intend to allow that at userspace
> > >> level or prevent this from happening in VFIO?
> > >
> > > I feel it's better to prevent this from happening, otherwise VFIO
> > > also needs to track the bind count and do multiple unbinds at
> > > mm_exit. But it's not necessary to prevent it in VFIO. We can check
> > > here upon whether aux_domain is valid, and if not return -EBUSY.
> > Ah OK. So if we can detect the case here it is even better
> >
> I don't understand why VFIO cannot track, since it is mdev aware. if we
> don;t refcount the users, one mdev unbind will result unbind for all
> mdev under the same pdev. That may not be the right thing to do.
> 

The open here is not for mdev, which refcount is still required. Eric's
point is for non-mdev endpoints. It's meaningless and not intuitive 
to allow binding a PASID multiple-times to the same device. 

Thanks
Kevin
