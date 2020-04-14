Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F59EC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622D52074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V4bgcKO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504795AbgDNTaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:30:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504780AbgDNT3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:29:54 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F6C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:13:28 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q73so476174qvq.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C6LPr57lWZSC64vGG3m/7F9hGv26FkwkUKQlSSD5fmM=;
        b=V4bgcKO2h4/hftGysjiOqp+faJ0fUnfl7CGmiLnBy/3ERjUn/9x/GKW6pDj6zQG06n
         VPOlgs2Zg0Q8xXAzpZjFl28BXF5zLuGLvz5wy45lopsUoFSURYo2FlKzCzzfG5KNkWr0
         mOBaK4IQhoIWa5AZjgIrxRd9FsGl1MYZh9TEyeFJ2udxHR5I8wGmkDpKI31+FV02GJat
         aN8EFTcYCFP5Q1hcPSUi+1l6jkZlOrvtZ+kXa3N9ncA7BOWaQjBtrctXae65LRarAQMp
         oYcJrw40qyD+lVF1nlO6XTnveyVPcjCVcmAdK8dYGHSB+TPbaveTq/eeb2aRfmBx1zzt
         VujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C6LPr57lWZSC64vGG3m/7F9hGv26FkwkUKQlSSD5fmM=;
        b=qlfujIqK3JLm+773PWSz55ZBO84MTLM0yUgw0bZADYVbOtqgjkv/mO21XvTFyqqcMk
         S9eusEWwhEjNECn8cKjPgLTcZANoCrfy+6j2Iqab3LyfWWFpUNvvzDGv+rKAte5TN3/Y
         SKV/yoVYyiEqEKHwDvCkhmVviiKBwb7zdY/ZAoJsWaDmpn2frs/CfQviycEO8h5gLMue
         FB4OEnpt3ZVEf3C7YdrkmYCmMaALVYXjY1hjOQtxI6+qdkXrkHomB18WJFVCBXVHicIb
         uwBOb5eQO//ICEzBraiVF3j8iLaU6xJKTAb4PdLkRJatG+f7FRqNzf9aLkS5ULoxyvrY
         lHMQ==
X-Gm-Message-State: AGi0PuZU6XpI0PcghHDHNWhs9H9gKqA3ewpnOyZ5Kws2RIPdcu79CadA
        CfazZeuf6ew/YXc8o0dZftqAQw==
X-Google-Smtp-Source: APiQypLLCv2q5t5WCFmLAy+rjUFaEQYxU9HiJ0USBdZygY8Tz/BJrFvCc+y6FL6Fqeq3MzWGhmXWtQ==
X-Received: by 2002:a05:6214:7ec:: with SMTP id bp12mr1544772qvb.33.1586891608126;
        Tue, 14 Apr 2020 12:13:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v33sm11252906qtd.88.2020.04.14.12.13.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:13:27 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOQzv-0003S0-1H; Tue, 14 Apr 2020 16:13:27 -0300
Date:   Tue, 14 Apr 2020 16:13:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] mm/hugetlb: fix a addressing exception caused by
 huge_pte_offset
Message-ID: <20200414191327.GK5100@ziepe.ca>
References: <20200413010342.771-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413010342.771-1-longpeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 09:03:42AM +0800, Longpeng(Mike) wrote:
> From: Longpeng <longpeng2@huawei.com>
> 
> Our machine encountered a panic(addressing exception) after run
> for a long time and the calltrace is:
> RIP: 0010:[<ffffffff9dff0587>]  [<ffffffff9dff0587>] hugetlb_fault+0x307/0xbe0
> RSP: 0018:ffff9567fc27f808  EFLAGS: 00010286
> RAX: e800c03ff1258d48 RBX: ffffd3bb003b69c0 RCX: e800c03ff1258d48
> RDX: 17ff3fc00eda72b7 RSI: 00003ffffffff000 RDI: e800c03ff1258d48
> RBP: ffff9567fc27f8c8 R08: e800c03ff1258d48 R09: 0000000000000080
> R10: ffffaba0704c22a8 R11: 0000000000000001 R12: ffff95c87b4b60d8
> R13: 00005fff00000000 R14: 0000000000000000 R15: ffff9567face8074
> FS:  00007fe2d9ffb700(0000) GS:ffff956900e40000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffd3bb003b69c0 CR3: 000000be67374000 CR4: 00000000003627e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  [<ffffffff9df9b71b>] ? unlock_page+0x2b/0x30
>  [<ffffffff9dff04a2>] ? hugetlb_fault+0x222/0xbe0
>  [<ffffffff9dff1405>] follow_hugetlb_page+0x175/0x540
>  [<ffffffff9e15b825>] ? cpumask_next_and+0x35/0x50
>  [<ffffffff9dfc7230>] __get_user_pages+0x2a0/0x7e0
>  [<ffffffff9dfc648d>] __get_user_pages_unlocked+0x15d/0x210
>  [<ffffffffc068cfc5>] __gfn_to_pfn_memslot+0x3c5/0x460 [kvm]
>  [<ffffffffc06b28be>] try_async_pf+0x6e/0x2a0 [kvm]
>  [<ffffffffc06b4b41>] tdp_page_fault+0x151/0x2d0 [kvm]
>  ...
>  [<ffffffffc06a6f90>] kvm_arch_vcpu_ioctl_run+0x330/0x490 [kvm]
>  [<ffffffffc068d919>] kvm_vcpu_ioctl+0x309/0x6d0 [kvm]
>  [<ffffffff9deaa8c2>] ? dequeue_signal+0x32/0x180
>  [<ffffffff9deae34d>] ? do_sigtimedwait+0xcd/0x230
>  [<ffffffff9e03aed0>] do_vfs_ioctl+0x3f0/0x540
>  [<ffffffff9e03b0c1>] SyS_ioctl+0xa1/0xc0
>  [<ffffffff9e53879b>] system_call_fastpath+0x22/0x27
> 
> For 1G hugepages, huge_pte_offset() wants to return NULL or pudp, but it
> may return a wrong 'pmdp' if there is a race. Please look at the following
> code snippet:
>     ...
>     pud = pud_offset(p4d, addr);
>     if (sz != PUD_SIZE && pud_none(*pud))
>         return NULL;
>     /* hugepage or swap? */
>     if (pud_huge(*pud) || !pud_present(*pud))
>         return (pte_t *)pud;
> 
>     pmd = pmd_offset(pud, addr);
>     if (sz != PMD_SIZE && pmd_none(*pmd))
>         return NULL;
>     /* hugepage or swap? */
>     if (pmd_huge(*pmd) || !pmd_present(*pmd))
>         return (pte_t *)pmd;
>     ...
> 
> The following sequence would trigger this bug:
> 1. CPU0: sz = PUD_SIZE and *pud = 0 , continue
> 1. CPU0: "pud_huge(*pud)" is false
> 2. CPU1: calling hugetlb_no_page and set *pud to xxxx8e7(PRESENT)
> 3. CPU0: "!pud_present(*pud)" is false, continue
> 4. CPU0: pmd = pmd_offset(pud, addr) and maybe return a wrong pmdp
> However, we want CPU0 to return NULL or pudp in this case.
> 
> We must make sure there is exactly one dereference of pud and pmd.
> 
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
> v4 -> v5:
>   fix a bug of on i386
> v3 -> v4:
>   fix a typo s/p4g/p4d.  [Jason]
> v2 -> v3:
>   make sure p4d/pud/pmd be dereferenced once. [Jason]
> 
> ---
>  mm/hugetlb.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
