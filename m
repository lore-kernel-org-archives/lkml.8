Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A44C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8920020721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmHgsIOm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgBCSBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:01:05 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28127 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728211AbgBCSBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:01:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580752863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZhX46YM0FLk44NTBeGHd0UZiF1Orn/r2iNN6uCSjnw=;
        b=fmHgsIOm5Evog/6ylZrDmrerXQ7+0LzM7/ocLPSn+aKRn/VGH/VVVHOa60iHzHySK1LTLU
        vBytzVRzdPZWBdftEYUSOCqkcwrHj/kmXKL7aVsa/NlTqcF3WGi1/O2hRuCcN/wIMTccsv
        gHGVOxMpr5yWjwhtpcnM+MFshOxIHf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-3ZDtis_GPGyUQxhELM89nA-1; Mon, 03 Feb 2020 13:00:54 -0500
X-MC-Unique: 3ZDtis_GPGyUQxhELM89nA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A3C13E6;
        Mon,  3 Feb 2020 18:00:52 +0000 (UTC)
Received: from w520.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5108B8642F;
        Mon,  3 Feb 2020 18:00:46 +0000 (UTC)
Date:   Mon, 3 Feb 2020 11:00:45 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Tian, Jun J" <jun.j.tian@intel.com>,
        "Sun, Yi Y" <yi.y.sun@intel.com>,
        "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v3 4/8] vfio/type1: Add
 VFIO_NESTING_GET_IOMMU_UAPI_VERSION
Message-ID: <20200203110045.1fb3ec8d@w520.home>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1994A2@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
        <1580299912-86084-5-git-send-email-yi.l.liu@intel.com>
        <20200129165649.43008300@w520.home>
        <A2975661238FB949B60364EF0F2C25743A1994A2@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 13:04:11 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> Hi Alex,
> 
> > From: Alex Williamson [mailto:alex.williamson@redhat.com]
> > Sent: Thursday, January 30, 2020 7:57 AM
> > To: Liu, Yi L <yi.l.liu@intel.com>
> > Subject: Re: [RFC v3 4/8] vfio/type1: Add
> > VFIO_NESTING_GET_IOMMU_UAPI_VERSION
> > 
> > On Wed, 29 Jan 2020 04:11:48 -0800
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > From: Liu Yi L <yi.l.liu@intel.com>
> > >
> > > In Linux Kernel, the IOMMU nesting translation (a.k.a. IOMMU dual stage
> > > translation capability) is abstracted in uapi/iommu.h, in which the uAPIs
> > > like bind_gpasid/iommu_cache_invalidate/fault_report/pgreq_resp are defined.
> > >
> > > VFIO_TYPE1_NESTING_IOMMU stands for the vfio iommu type which is backed by
> > > IOMMU nesting translation capability. VFIO exposes the nesting capability
> > > to userspace and also exposes uAPIs (will be added in later patches) to user
> > > space for setting up nesting translation from userspace. Thus applications
> > > like QEMU could support vIOMMU for pass-through devices with IOMMU nesting
> > > translation capability.
> > >
> > > As VFIO expose the nesting IOMMU programming to userspace, it also needs to
> > > provide an API for the uapi/iommu.h version check to ensure compatibility.
> > > This patch reports the iommu uapi version to userspace. Applications could
> > > use this API to do version check before further using the nesting uAPIs.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > ---
> > >  drivers/vfio/vfio.c       |  3 +++
> > >  include/uapi/linux/vfio.h | 10 ++++++++++
> > >  2 files changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > > index 425d60a..9087ad4 100644
> > > --- a/drivers/vfio/vfio.c
> > > +++ b/drivers/vfio/vfio.c
> > > @@ -1170,6 +1170,9 @@ static long vfio_fops_unl_ioctl(struct file *filep,
> > >  	case VFIO_GET_API_VERSION:
> > >  		ret = VFIO_API_VERSION;
> > >  		break;
> > > +	case VFIO_NESTING_GET_IOMMU_UAPI_VERSION:
> > > +		ret = iommu_get_uapi_version();
> > > +		break;  
> > 
> > Shouldn't the type1 backend report this?  It doesn't make much sense
> > that the spapr backend reports a version for something it doesn't
> > support.  Better yet, provide this info gratuitously in the
> > VFIO_IOMMU_GET_INFO ioctl return like you do with nesting in the next
> > patch, then it can help the user figure out if this support is present.  
> 
> yeah, it would be better to report it by type1 backed. However,
> it is kind of issue when QEMU using it.
> 
> My series "hooks" vSVA supports on VFIO_TYPE1_NESTING_IOMMU type.
> [RFC v3 09/25] vfio: check VFIO_TYPE1_NESTING_IOMMU support
> https://www.spinics.net/lists/kvm/msg205197.html
> 
> In QEMU, it will determine the iommu type firstly and then invoke
> VFIO_SET_IOMMU. I think before selecting VFIO_TYPE1_NESTING_IOMMU,
> QEMU needs to check the IOMMU uAPI version. If IOMMU uAPI is incompatible,
> QEMU should not use VFIO_TYPE1_NESTING_IOMMU type. If
> VFIO_NESTING_GET_IOMMU_UAPI_VERSION is available after set iommu, then it
> may be an issue. That's why this series reports the version in vfio layer
> instead of type1 backend.

Why wouldn't you use CHECK_EXTENSION?  You could probe specifically for
a VFIO_TYP1_NESTING_IOMMU_UAPI_VERSION extension that returns the
version number.  Thanks,

Alex

