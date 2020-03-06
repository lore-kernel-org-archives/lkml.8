Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253BCC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F145D20658
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdvEo/xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgCFQ16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:27:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32462 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726140AbgCFQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583512076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6kqh0g+8DkB9jTIgFcJTQym/+RkRpyGwJz3Ff5AmMcU=;
        b=hdvEo/xEBQq7hMStSxlDNLVAhLfsTguPMQLY5lnVDyaYiZTYRzthIkSJKWLVeH4+fpp9q2
        CVa2b7Gl+US0jDCdSkKvEy+o5yFYVUCOeuzOb4YnYm5AW/3kIPmx8Y/LNzkIANoE2xCD3d
        yck+LcEZpnJgDeXKKrPTosEwoIYRfdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-re09S1kfOLaP6IBVkerikQ-1; Fri, 06 Mar 2020 11:27:54 -0500
X-MC-Unique: re09S1kfOLaP6IBVkerikQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9CB6800D6C;
        Fri,  6 Mar 2020 16:27:52 +0000 (UTC)
Received: from x1.home (ovpn-116-28.phx2.redhat.com [10.3.116.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DBB519C69;
        Fri,  6 Mar 2020 16:27:47 +0000 (UTC)
Date:   Fri, 6 Mar 2020 09:27:46 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>
Subject: Re: [PATCH v3 2/7] vfio: introduce vfio_dma_rw to read/write a
 range of IOVAs
Message-ID: <20200306092746.088a01a3@x1.home>
In-Reply-To: <20200306012148.GB1530@joy-OptiPlex-7040>
References: <20200224084350.31574-1-yan.y.zhao@intel.com>
        <20200224084715.31753-1-yan.y.zhao@intel.com>
        <20200306012148.GB1530@joy-OptiPlex-7040>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 20:21:48 -0500
Yan Zhao <yan.y.zhao@intel.com> wrote:

> On Mon, Feb 24, 2020 at 04:47:15PM +0800, Zhao, Yan Y wrote:
> > vfio_dma_rw will read/write a range of user space memory pointed to by
> > IOVA into/from a kernel buffer without enforcing pinning the user space
> > memory.
> > 
> > TODO: mark the IOVAs to user space memory dirty if they are written in
> > vfio_dma_rw().
> > 
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> > ---
> >  drivers/vfio/vfio.c             | 49 +++++++++++++++++++++
> >  drivers/vfio/vfio_iommu_type1.c | 77 +++++++++++++++++++++++++++++++++
> >  include/linux/vfio.h            |  5 +++
> >  3 files changed, 131 insertions(+)
> > 
> > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> > index 914bdf4b9d73..902867627cbf 100644
> > --- a/drivers/vfio/vfio.c
> > +++ b/drivers/vfio/vfio.c
> > @@ -1998,6 +1998,55 @@ int vfio_unpin_pages(struct device *dev, unsigned long *user_pfn, int npage)
> >  }
> >  EXPORT_SYMBOL(vfio_unpin_pages);
> >  
> > +
> > +/*
> > + * This interface allows the CPUs to perform some sort of virtual DMA on
> > + * behalf of the device.
> > + *
> > + * CPUs read/write a range of IOVAs pointing to user space memory into/from
> > + * a kernel buffer.
> > + *
> > + * As the read/write of user space memory is conducted via the CPUs and is
> > + * not a real device DMA, it is not necessary to pin the user space memory.
> > + *
> > + * The caller needs to call vfio_group_get_external_user() or
> > + * vfio_group_get_external_user_from_dev() prior to calling this interface,
> > + * so as to prevent the VFIO group from disposal in the middle of the call.
> > + * But it can keep the reference to the VFIO group for several calls into
> > + * this interface.
> > + * After finishing using of the VFIO group, the caller needs to release the
> > + * VFIO group by calling vfio_group_put_external_user().
> > + *
> > + * @group [in]: vfio group of a device
> > + * @iova [in] : base IOVA of a user space buffer
> > + * @data [in] : pointer to kernel buffer
> > + * @len [in]  : kernel buffer length
> > + * @write     : indicate read or write
> > + * Return error code on failure or 0 on success.
> > + */
> > +int vfio_dma_rw(struct vfio_group *group, dma_addr_t iova,
> > +		void *data, size_t len, bool write)  
> hi Alex
> May I rename this interface to vfio_dma_rw_from_group() that takes
> VFIO group as arg and add another interface vfio_dma_rw(struct device *dev...) ?
> That might be easier for a driver to use the second one if it does not care about
> performance much.

Perhaps vfio_group_dma_rw() and vfio_dev_dma_rw()?  I'd be reluctant to
add the latter, if a caller doesn't care about performance then they
won't mind making a couple calls to get and release the group reference.
Thanks,

Alex

