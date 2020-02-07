Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7CCC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7CB21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dk5vzb2t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBGVIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:08:34 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44592 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgBGVIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:08:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id v195so473871qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 13:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=onxmmjqXELNJOnSDJZ2qgajL7wmylkhLVi0Ggn784AA=;
        b=dk5vzb2tCbBXS4d5M4it8BrIKygD26w5xPGFMn5hH7EB5FDmp0KmRWi/KQkqFkG1m8
         CZbK1VtVLge1Eb4gNl4uRSdTopDs5ifncqrRoaKJt0xiy4KsrUNbkeoHFnpDu82NGpoM
         XgxVX/bjgquMFQ7AL/PU5uShMvk5OCyQSKtUkAks5S2bpFBayhohiAjbSrs0bfH02cql
         1XoSJkbIUFB0Kr13E5+kCY/PyGf5zGsZNuwNfBWNLXgLPruhljRLmWxCkW2WzgOfO3Au
         cCNrrWIRqHsKpBql3MPaR/UFV+dcy3bnv/2M3EhyPrCMvK48LPH69/Y2TcNSDDw1XeRt
         sj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=onxmmjqXELNJOnSDJZ2qgajL7wmylkhLVi0Ggn784AA=;
        b=EoWUGyVXpP2mpmE29xUV3YSQrVb7JAEEuvmfFcwG5rgVUNPcHnFrUsiKAW12uO/ABV
         XgxEgcfLoAwgA1rNFqsiq2TjIMtdH+Faf4iUlOfyKR6eojyUFhLo5F7Z98fzh3n6huhr
         yva2l3lol/2YZCGV3dB2RtatAXrk5ZNHPfCx6lvmzcI4/tJzZkbNljKxe7DIMugjoxoj
         qtG7ATIO3u/BuSt2LBk8a0W8JZvc/jU6Fm/lSPGwBVH35moRqjdXeR2wMy/xOoAYjk0f
         yhm402BvY0r4GT0oPeus8z1csmtKF6HtDqGWkW4Ue/JO4LaZo8CM/SH1a8cO8OGPg+Sn
         yvPw==
X-Gm-Message-State: APjAAAUs4i+AtA2JDuawWqhEBAEW7dN2tPfFj8H0cO8ApfT7dtZUuHaF
        cNARpK98YP8IgijPTJA2VSIrkw==
X-Google-Smtp-Source: APXvYqxV/m72xBwpp0O2ntYMuXRK2I5x5D+oyFT5b9Vs5/VSe70eUTFQFZZtB9ADtTtpSzP+vqImqQ==
X-Received: by 2002:a37:e10f:: with SMTP id c15mr806650qkm.331.1581109713217;
        Fri, 07 Feb 2020 13:08:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n7sm189917qkk.41.2020.02.07.13.08.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 13:08:32 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j0ArY-00086p-0F; Fri, 07 Feb 2020 17:08:32 -0400
Date:   Fri, 7 Feb 2020 17:08:31 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-nvdimm@lists.01.org, Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Liran Alon <liran.alon@oracle.com>,
        Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Barret Rhoden <brho@google.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH RFC 09/10] vfio/type1: Use follow_pfn for VM_FPNMAP VMAs
Message-ID: <20200207210831.GA31015@ziepe.ca>
References: <20200110190313.17144-1-joao.m.martins@oracle.com>
 <20200110190313.17144-10-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110190313.17144-10-joao.m.martins@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 07:03:12PM +0000, Joao Martins wrote:
> From: Nikita Leshenko <nikita.leshchenko@oracle.com>
> 
> Unconditionally interpreting vm_pgoff as a PFN is incorrect.
> 
> VMAs created by /dev/mem do this, but in general VM_PFNMAP just means
> that the VMA doesn't have an associated struct page and is being managed
> directly by something other than the core mmu.
> 
> Use follow_pfn like KVM does to find the PFN.
> 
> Signed-off-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>  drivers/vfio/vfio_iommu_type1.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 2ada8e6cdb88..1e43581f95ea 100644
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -362,9 +362,9 @@ static int vaddr_get_pfn(struct mm_struct *mm, unsigned long vaddr,
>  	vma = find_vma_intersection(mm, vaddr, vaddr + 1);
>  
>  	if (vma && vma->vm_flags & VM_PFNMAP) {
> -		*pfn = ((vaddr - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
> -		if (is_invalid_reserved_pfn(*pfn))
> -			ret = 0;
> +		ret = follow_pfn(vma, vaddr, pfn);
> +		if (!ret && !is_invalid_reserved_pfn(*pfn))
> +			ret = -EOPNOTSUPP;
>  	}

FWIW this existing code is a huge hack and a security problem.

I'm not sure how you could be successfully using this path on actual
memory without hitting bad bugs?

Fudamentally VFIO can't retain a reference to a page from within a VMA
without some kind of recount/locking/etc to allow the thing that put
the page there to know it is still being used (ie programmed in a
IOMMU) by VFIO.

Otherwise it creates use-after-free style security problems on the
page.

This code needs to be deleted, not extended :(

Jason
