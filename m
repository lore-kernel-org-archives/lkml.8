Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9005C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A73D32074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgG2Uz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:55:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:12727 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2Uz0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:55:26 -0400
IronPort-SDR: BCC29Ox9ECEanjRvhMD+lhLPar9UyTKfVnH0vzkMifuTkjsByjWlPdnz8jYPabwL8eCcgATERx
 rb75R4P6Aa7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="169620987"
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="169620987"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 13:55:26 -0700
IronPort-SDR: 0DKM30f/id2JQ/CzHqYbno4kUOprMvG1Qm70P/dUa79Jylsb1npgZ7A6/qw2aMjACkNgSg4bLv
 J2FwDP+m5iDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,411,1589266800"; 
   d="scan'208";a="304347308"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga002.jf.intel.com with ESMTP; 29 Jul 2020 13:55:26 -0700
Date:   Wed, 29 Jul 2020 14:02:15 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v6 1/6] docs: IOMMU user API
Message-ID: <20200729140215.0f8c4aca@jacob-builder>
In-Reply-To: <MWHPR11MB1645BA0C8436C3280DBDC5468C700@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1595525140-23899-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200728131950.2aff140d@x1.home>
        <MWHPR11MB1645BA0C8436C3280DBDC5468C700@MWHPR11MB1645.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 01:18:04 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, July 29, 2020 3:20 AM
> >   
> [...]
> > > +
> > > +For example, IOTLB invalidations should always succeed. There is
> > > no +architectural way to report back to the vIOMMU if the UAPI
> > > data is +incompatible. If that happens, in order to guarantee
> > > IOMMU iosolation,  
> > 
> > isolation
> >   
> > > +we have to resort to not giving completion status in vIOMMU.
> > > This may +result in VM hang.
> > > +
> > > +For this reason the following IOMMU UAPIs cannot fail without
> > > +catastrophic effect:
> > > +
> > > +1. Free PASID
> > > +2. Unbind guest PASID
> > > +3. Unbind guest PASID table (SMMU)
> > > +4. Cache invalidate  
> > 
> > I'm not entirely sure what we're trying to assert here.  Clearly
> > cache invalidation can fail and patch 5/6 goes on to add over a
> > dozen checks of the user provided data that return an -errno.  Any
> > user ioctl can fail if the user botches the parameters.  So are we
> > just trying to explain the feature checking that should allow the
> > user to know supported combinations and if they adhere to them,
> > these should not fail?  It's not quite worded to that effect.
> > Thanks, 
> 
> I guess the above wording is messed by what a UAPI should
> behave and whether the vIOMMU reports associated errors.
> UAPI can always fail, as you pointed out. vIOMMU may not
> have a matching error code though, e.g. on Intel VT-d there is no
> error reporting mechanism for cache invalidation. However,
> it is not wise to assert UAPI behavior according to vIOMMU
> definition. An error is an error. vIOMMU should just react to
> UAPI errors according to its architecture definition (e.g. ignore,
> forward to guest, hang, etc.). From this matter I feel above
> section could better be removed.
> 
Yes, I agreed, the scope is not drawn clearly. This section is kind of
the relic of a previous version where responsibility of feature
checking lies with IOMMU UAPI instead of VFIO.

How about just briefly mention that upfront feature checking is
encouraged to avoid complex and catastrophic error at runtime?

I will remove the rest.

> Thanks
> Kevin

[Jacob Pan]
