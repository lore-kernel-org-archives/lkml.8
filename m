Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AB7C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11780207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 02:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHTHr65D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHCcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 22:32:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42739 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726509AbgEHCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 22:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588905120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bIUx96mA/EP7X7OGaqdPckgPL6bFvqgGtFSQHtpt5Dw=;
        b=UHTHr65DqkYo0WZzbShmHt4zB1NMRgUkslyHVcxls5WgfER/V2EJWgl9HmLdFkDxEZZcgi
        qFbA/nnim4M4dh3Tr1aScpVHZ0olLyw+j8gBNr3yPixIHGobQ7JVJ0AGmh8B13juCjG9cg
        WCHCjqX2lXmTbY+/+TWQY9Cm1KxhbXM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-EqpMoSSFPMGcWHiYsTWV1A-1; Thu, 07 May 2020 22:31:59 -0400
X-MC-Unique: EqpMoSSFPMGcWHiYsTWV1A-1
Received: by mail-qt1-f199.google.com with SMTP id w12so146507qto.19
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 19:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bIUx96mA/EP7X7OGaqdPckgPL6bFvqgGtFSQHtpt5Dw=;
        b=lG2R0jGeDotKmxmH7fYjR7Xotqb1SFH8zNaMRY2zKEPDS/OcLhqvfZjXF1X+3yL5Yf
         zXpwM7nGZPpFUMV+ZlapV+k1yPQhVH5IlzWHD2dQrNeCGqwoet3LiWAuDkZbNCUQcnxk
         CAsdEM0zggHT8drqsA4shtwDbJPhFvZNzNg/tPOnov1TqOIk5FvB/hYSlwPXmSYBOThX
         VnrBmicRfJiaRAWMdCW1fdjioY5JnH2Y+heMqdNIrwdc0iO5Pn20nyg64lHN7Znc/4k7
         KNDqEykcTRR777F2obG4SaVksOXyryGUXxxUQXSoBE5CPNQxY2nO+aZ+J8gjfsud6JtO
         NRYg==
X-Gm-Message-State: AGi0PubuJlenrC2OYDvYqWxLZQeLBwtVGpDedlF/xF8UeyXQfO1y9/j0
        ib3F3fjBhL6vyv/3o8VucUaVDu1CX7H98Yt9dHn2aKPe9iu7tEiD7Fl5B565wBvaeVE2U5VmLvm
        kPiob60Ab4O30JM0HiYRE91Gt
X-Received: by 2002:aed:2744:: with SMTP id n62mr612557qtd.112.1588905118349;
        Thu, 07 May 2020 19:31:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypIcclFny/DXEGjmyqjelNu3QHTKwYMIpTiZjqFGlhy9uH/EYQIP+qoJWgqSp4XGqubYl7AoHQ==
X-Received: by 2002:aed:2744:: with SMTP id n62mr612540qtd.112.1588905118097;
        Thu, 07 May 2020 19:31:58 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id p22sm365463qte.2.2020.05.07.19.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 19:31:57 -0700 (PDT)
Date:   Thu, 7 May 2020 22:31:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/3] vfio-pci: Block user access to disabled device
 MMIO
Message-ID: <20200508023156.GV228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
 <20200507215908.GQ228260@xz-x1>
 <20200507163437.77b4bf2e@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200507163437.77b4bf2e@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:34:37PM -0600, Alex Williamson wrote:
> On Thu, 7 May 2020 17:59:08 -0400
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Tue, May 05, 2020 at 03:54:36PM -0600, Alex Williamson wrote:
> > > v2:
> > > 
> > > Locking in 3/ is substantially changed to avoid the retry scenario
> > > within the fault handler, therefore a caller who does not allow retry
> > > will no longer receive a SIGBUS on contention.  IOMMU invalidations
> > > are still not included here, I expect that will be a future follow-on
> > > change as we're not fundamentally changing that issue in this series.
> > > The 'add to vma list only on fault' behavior is also still included
> > > here, per the discussion I think it's still a valid approach and has
> > > some advantages, particularly in a VM scenario where we potentially
> > > defer the mapping until the MMIO BAR is actually DMA mapped into the
> > > VM address space (or the guest driver actually accesses the device
> > > if that DMA mapping is eliminated at some point).  Further discussion
> > > and review appreciated.  Thanks,  
> > 
> > Hi, Alex,
> > 
> > I have a general question on the series.
> > 
> > IIUC this series tries to protect illegal vfio userspace writes to device MMIO
> > regions which may cause platform-level issues.  That makes perfect sense to me.
> > However what if the write comes from the devices' side?  E.g.:
> > 
> >   - Device A maps MMIO region X
> > 
> >   - Device B do VFIO_IOMMU_DMA_MAP on Device A's MMIO region X
> >     (so X's MMIO PFNs are mapped in device B's IOMMU page table)
> > 
> >   - Device A clears PCI_COMMAND_MEMORY (reset, etc.)
> >     - this should zap all existing vmas that mapping region X, however device
> >       B's IOMMU page table is not aware of this?
> > 
> >   - Device B writes to MMIO region X of device A even if PCI_COMMAND_MEMORY
> >     cleared on device A's PCI_COMMAND register
> > 
> > Could this happen?
> 
> Yes, this can happen and Jason has brought up variations on this
> scenario that are important to fix as well.  I've got some ideas, but
> the access in this series was the current priority.  There are also
> issues in the above scenario that if a platform considers a DMA write
> to an invalid IOMMU PTE and triggering an IOMMU fault to have the same
> severity as the write to disabled MMIO space we've prevented, then our
> hands are tied.  Thanks,

I see the point now; it makes sense to start with a series like this. Thanks, Alex.

-- 
Peter Xu

