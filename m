Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8F7C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A43B520757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kNl2UNVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgD1RuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgD1RuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:50:00 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097F7C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:50:00 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id o19so22698040qkk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=117ikuQsO0l+zcrA4+37n61daQN/3p1Uz7Uan2I+kn4=;
        b=kNl2UNVaxcoXnt9gWxrro80A9T4X/JO1AQ66AqCSX9d5sfFzrpFidHQHKOXhGIXkJp
         4fn4iqPtKJt1pJH3Cy2T9aSlNOnWH4rRnhXw1wrB4xPTniA4QRMfX5Lr/Zw5TfJN4jYd
         o2AfZb+vlZCSLlLIErP8VoLQ8HMkWz1J0JqlZ7sWYDCjJtwr7CaaASz2pHEPoh9nBOf7
         l5/Lj89TxW3w+CtdglWxNbEXn54NnyOVY0wu8O9Asq2djOcRWGtckk5YeCtNm7nMNW/R
         FgSZ8C6GNduG9O8U82PzHx3GKsRwejfp1HI+UNTircLMVJYgCF2DMzb4amArbvWknS2G
         SO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=117ikuQsO0l+zcrA4+37n61daQN/3p1Uz7Uan2I+kn4=;
        b=OdApEY5dpb72mRmfqHDeZdVv8sZK7zqdPIEdn2vgrZKb+vHU3+LiCcjLTvt9Ty4+mK
         94wFFRPTLwf9XIqmL5eJTEIORq7qKk3kTbvUPRFvYvsWHUVc+LziGdNL/etyHCytaniE
         tXbdUcwa97hdAbjs2TRjxqb8XwNXyw4UeVqTbDpeuxwJntz/pAkda11Dmpc0Q3BTwKdH
         LT1X+2w79V7QCYpQrjLP9pDHTZTvbpyoQ/UU/T3W0hq/AV7uumIomrgnIKt8dvsAn+em
         C7q/dGv8KYohu23FNLdjMCtjgCREVEnIXr07zJB3FNcykbojYXcDiW3SGOEMUttEPxZH
         Arhg==
X-Gm-Message-State: AGi0PuaCI8T2fq88qtERrVggvK1HPvQfu41lSKujAugoc2L0zI+mpCfQ
        z+31cmidif2cW5mFeHxHbhOqCNXWw6tvIw==
X-Google-Smtp-Source: APiQypLmcOhZ8RlXZShNdMqTfkf1hcU2wDgMielFeRa2mTSd3Lz0Eg/u2LrPavky3IqJhKoc+AEVBQ==
X-Received: by 2002:ae9:eb8c:: with SMTP id b134mr29218346qkg.39.1588096199087;
        Tue, 28 Apr 2020 10:49:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c33sm14866702qtb.76.2020.04.28.10.49.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 10:49:58 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTUMn-00059R-Mr; Tue, 28 Apr 2020 14:49:57 -0300
Date:   Tue, 28 Apr 2020 14:49:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [regression?] Re: [PATCH v6 06/12] mm/gup: track FOLL_PIN pages
Message-ID: <20200428174957.GV26002@ziepe.ca>
References: <20200211001536.1027652-1-jhubbard@nvidia.com>
 <20200211001536.1027652-7-jhubbard@nvidia.com>
 <20200424121846.5ee2685f@w520.home>
 <5b901542-d949-8d7e-89c7-f8d5ee20f6e9@nvidia.com>
 <20200424141548.5afdd2bb@w520.home>
 <665ffb48-d498-90f4-f945-997a922fc370@nvidia.com>
 <20200428105455.30343fb4@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428105455.30343fb4@w520.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:54:55AM -0600, Alex Williamson wrote:
>  static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  {
>  	struct vfio_pci_device *vdev = device_data;
> @@ -1253,8 +1323,14 @@ static int vfio_pci_mmap(void *device_data, struct vm_area_struct *vma)
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  	vma->vm_pgoff = (pci_resource_start(pdev, index) >> PAGE_SHIFT) + pgoff;
>  
> +	vma->vm_ops = &vfio_pci_mmap_ops;
> +
> +#if 1
> +	return 0;
> +#else
>  	return remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
> -			       req_len, vma->vm_page_prot);
> +			       vma->vm_end - vma->vm_start, vma->vm_page_prot);

The remap_pfn_range here is what tells get_user_pages this is a
non-struct page mapping:

	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;

Which has to be set when the VMA is created, they shouldn't be
modified during fault.

Also the vma code above looked a little strange to me, if you do send
something like this cc me and I can look at it. I did some work like
this for rdma a while ago..

Jason
