Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D3BC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 339A320575
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ni1mw1pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgEGV7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:59:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48044 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbgEGV7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:59:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588888753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zoaD/vZ99qPVucnfK3IScYf0rbMkx7qHOiz4Yv3Ogzg=;
        b=Ni1mw1pBzEkIkKE11YYFAQf1jBwyRJNPYsA+w4J2sSLRQC3nZrbnNy6HPOlUrGWZWcT9Of
        DAkVE/iC6yyEbThvTgO1CjpTB0yYzZaROkOQ421QDj7caYpdP9FviKu9s33G4SDSyrIjIP
        0N5lg/rmxsJ998rVxoxz3KNnlKvayrk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-tOHQU31MMQyHiKY5KnOeXg-1; Thu, 07 May 2020 17:59:11 -0400
X-MC-Unique: tOHQU31MMQyHiKY5KnOeXg-1
Received: by mail-qk1-f200.google.com with SMTP id z8so7330998qki.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zoaD/vZ99qPVucnfK3IScYf0rbMkx7qHOiz4Yv3Ogzg=;
        b=F5i07GRY/hBDuXQLI2Ok0J1V5C4JrGSQy5DsXfvZw9xU1cxioXu4m5F3oA6bOFiOmw
         63kqU7ZjSMupmUs2MgpcXqIzOr6A1EzTKGgia5essme5LfGyWU9mTNg0HImiTl7Gq7Iw
         iwp+RDQamabnB7NcXmosETjqTXOQpFYQMrzKE8avbjJ3sQvVMUXA0PJB/WvGZkiYsjnJ
         j/Sf4r1CHPvsL9hRwT/IjZBgDH1UBPpnEfEcxDNQmjV+NYp/VvnBh25RCihVM518A2pG
         ao4DNDfASF3doDoqUuDU9FjoCUA4IODW1Amc261uZqFWvaIpJq8inYppCar1GOKxpSei
         T1iQ==
X-Gm-Message-State: AGi0PuaIBhedA3SvVw8NQhBr9vxCQbmrnphZWkYAms27AluOLreOObQH
        Zm80C9R+UsCQ7N1icCZ+i2Slno5IKfPfWsEVk9AlmZR/E4vyorXXqr3BnjdVC9o2P3IuuIJy/Xd
        qdOScsgoQuHs70YZsOJxouXxl
X-Received: by 2002:aed:2dc1:: with SMTP id i59mr16853122qtd.182.1588888750767;
        Thu, 07 May 2020 14:59:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypLd8+jTdEka04fZzv2vUUpL+dHbxVfK9jv6upQkE8gQ0PDY1mJ/wapufSn+uMj7hMA/3PNRSg==
X-Received: by 2002:aed:2dc1:: with SMTP id i59mr16853106qtd.182.1588888750522;
        Thu, 07 May 2020 14:59:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y3sm5259605qkc.4.2020.05.07.14.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:59:09 -0700 (PDT)
Date:   Thu, 7 May 2020 17:59:08 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH v2 0/3] vfio-pci: Block user access to disabled device
 MMIO
Message-ID: <20200507215908.GQ228260@xz-x1>
References: <158871401328.15589.17598154478222071285.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158871401328.15589.17598154478222071285.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:54:36PM -0600, Alex Williamson wrote:
> v2:
> 
> Locking in 3/ is substantially changed to avoid the retry scenario
> within the fault handler, therefore a caller who does not allow retry
> will no longer receive a SIGBUS on contention.  IOMMU invalidations
> are still not included here, I expect that will be a future follow-on
> change as we're not fundamentally changing that issue in this series.
> The 'add to vma list only on fault' behavior is also still included
> here, per the discussion I think it's still a valid approach and has
> some advantages, particularly in a VM scenario where we potentially
> defer the mapping until the MMIO BAR is actually DMA mapped into the
> VM address space (or the guest driver actually accesses the device
> if that DMA mapping is eliminated at some point).  Further discussion
> and review appreciated.  Thanks,

Hi, Alex,

I have a general question on the series.

IIUC this series tries to protect illegal vfio userspace writes to device MMIO
regions which may cause platform-level issues.  That makes perfect sense to me.
However what if the write comes from the devices' side?  E.g.:

  - Device A maps MMIO region X

  - Device B do VFIO_IOMMU_DMA_MAP on Device A's MMIO region X
    (so X's MMIO PFNs are mapped in device B's IOMMU page table)

  - Device A clears PCI_COMMAND_MEMORY (reset, etc.)
    - this should zap all existing vmas that mapping region X, however device
      B's IOMMU page table is not aware of this?

  - Device B writes to MMIO region X of device A even if PCI_COMMAND_MEMORY
    cleared on device A's PCI_COMMAND register

Could this happen?

Thanks,

-- 
Peter Xu

