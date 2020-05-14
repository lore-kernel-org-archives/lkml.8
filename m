Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB2FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0B62065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a35q0EDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgENVZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:25:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgENVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589491543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UMjf23zFxOglYOyxZxoYs74d6iz4BTimsqthHh9qfeo=;
        b=a35q0EDeVhAy1Zihto4QTqnnkuUj0tw3EaAmpuA4TUYrPrbJb4Eb3KhiicJgmR/mBPe8pr
        hTAjlmi4r6P/oaNE/SwAFbjHK1rPbWmdwB+fw9prnzvLX2EKD9UHf9Xwj/9V0E1wh1wv2k
        jeP3CCMAkDUi/amZi7DJJDKD8JjDfdw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-b_4Rih7IMwS3KfKmMRCTUg-1; Thu, 14 May 2020 17:25:42 -0400
X-MC-Unique: b_4Rih7IMwS3KfKmMRCTUg-1
Received: by mail-qk1-f199.google.com with SMTP id d187so458qkc.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UMjf23zFxOglYOyxZxoYs74d6iz4BTimsqthHh9qfeo=;
        b=jEucjme884c1sJd3l0mmM+J1+4nWlWiW/ZcE5BPJkd4LnWpytqUEQRUEDRG97cHumj
         9MkWa9OXvUhE/iOZ9dkUxZTAXhA07THp4Fu6t6J5pzf5kcOZv2blbYIyRiDF0Pzuy0dX
         rnlSf+Q9gxh6RyaLu5ufcH+g9xJ3OgXfw6Vi6Rl8Fu9gyKjj2hdQRCAvNid3rn7Httul
         kdM09IkfPRe+ktdATt6ijV0a1aDqcf8ToxcwfshdjHBI+GdQWhv4hakv092nzODmrUYY
         3OCblx6iMH/LX9f0izS2msfMnD85OnZ1GaS/P76YnmpGNWhrsA6eGEaIrVoJehpPGMfl
         qrsw==
X-Gm-Message-State: AOAM532lApFY002+tBf5XMwXaV6nFiZiADl1tR2rrrsWQK5dIk5tTZWv
        XGsmB8ZdACkDeihH3ww+ePO+xdGQj6wJuHKSZlL8/CDUBwsikw4oX3QV0SHh6Mbdbmt13fBp3nU
        JV27lc7OsVqx984qkirLrh0Tr
X-Received: by 2002:a37:9a95:: with SMTP id c143mr336811qke.201.1589491541726;
        Thu, 14 May 2020 14:25:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiNs/Iz+y1EJvRQqDBIFBJ9ciXXLpzG5kxc5nWqOibFPZOFtWmZWw9dt+cyJR7ZguLOk4Vbg==
X-Received: by 2002:a37:9a95:: with SMTP id c143mr336788qke.201.1589491541421;
        Thu, 14 May 2020 14:25:41 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id v82sm75173qkb.102.2020.05.14.14.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:25:40 -0700 (PDT)
Date:   Thu, 14 May 2020 17:25:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, jgg@ziepe.ca
Subject: Re: [PATCH 0/2] vfio/type1/pci: IOMMU PFNMAP invalidation
Message-ID: <20200514212538.GB449815@xz-x1>
References: <158947414729.12590.4345248265094886807.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158947414729.12590.4345248265094886807.stgit@gimli.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:51:46AM -0600, Alex Williamson wrote:
> This is a follow-on series to "vfio-pci: Block user access to disabled
> device MMIO"[1], which extends user access blocking of disabled MMIO
> ranges to include unmapping the ranges from the IOMMU.  The first patch
> adds an invalidation callback path, allowing vfio bus drivers to signal
> the IOMMU backend to unmap ranges with vma level granularity.  This
> signaling is done both when the MMIO range becomes inaccessible due to
> memory disabling, as well as when a vma is closed, making up for the
> lack of tracking or pinning for non-page backed vmas.  The second
> patch adds registration and testing interfaces such that the IOMMU
> backend driver can test whether a given PFNMAP vma is provided by a
> vfio bus driver supporting invalidation.  We can then implement more
> restricted semantics to only allow PFNMAP DMA mappings when we have
> such support, which becomes the new default.

Hi, Alex,

IIUC we'll directly tearing down the IOMMU page table without telling the
userspace for those PFNMAP pages.  I'm thinking whether there be any side
effect on the userspace side when userspace cached these mapping information
somehow.  E.g., is there a way for userspace to know this event?

Currently, QEMU VT-d will maintain all the IOVA mappings for each assigned
device when used with vfio-pci.  In this case, QEMU will probably need to
depend some invalidations sent from the guest (either userspace or kernel)
device drivers to invalidate such IOVA mappings after they got removed from the
hardware IOMMU page table underneath.  I haven't thought deeper on what would
happen if the vIOMMU has got an inconsistent mapping of the real device.

Thanks,

-- 
Peter Xu

