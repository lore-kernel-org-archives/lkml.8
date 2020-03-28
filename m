Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95623C2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 23:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694112074A
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 23:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PRxrzlb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgC1XIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 19:08:02 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40060 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgC1XIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 19:08:02 -0400
Received: by mail-qt1-f193.google.com with SMTP id c9so11991105qtw.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 16:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ll5/yGQZRWchp8TDCZLz4Mu8TR2gdnKXC0ek/0PcC6s=;
        b=PRxrzlb0Wve/L9dD5bq3htIZlmqEDU9F7ufxGYc7pP/BjS+5KOylxKAwwIHMDMf1kK
         GAiNOm04VMgVUa3Supcf92GHzUywRFQX9LS+j1yZM2inMGJrkklncyHL47zpUWxiJFxD
         O0KXdR6lxe3K94eMF4vSmSgRVBZPOlclmZJzUwPUFieMfMIFqx9VB/L1KsAYQpVNzoT3
         Taky/Ug6yOt+8eY58C7ZUJKPjJ66FkhBSnlOpCqrSaWD+arNpe78PUBiSZFcxWGATwqb
         nM+gmuoFbKZCUlF7Fh1fbEu2DrYIZGbWgj64YoAVvRWg8gUWx9i1AZWznrb/ymk7cplj
         J6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ll5/yGQZRWchp8TDCZLz4Mu8TR2gdnKXC0ek/0PcC6s=;
        b=DMXP/+DRBGveiCe4dCnUT2kMgRFpQoOtdSgxGRmlYUu9+lBUEaDRrl7zo28rNxdeSI
         rfu4olHALlDy5pv2pauLIy2TN1Mff6lT5Qp1sqlgDJIWoPjYfLGOVhg3DhOTzFSMjdjp
         pZ9Z7V0vn0JaOvgxHRoWYiX7wohIq/eQUJm/ZDhwaohBrtcXWHOd6ykKG9O2WSfmnQ+D
         gcVnDrII6luvNino9dq/jYAMRnBcNLxodLxqOybqsnAaDOzNyuq9Yijoi1vlR4+jPOEN
         s+KlySvUtS7zNiPyUvQnkux+qo6W+3Ag3vhcWhPxyVzT3ZAKNrk08jm1V2II5VZu+4QG
         9zCQ==
X-Gm-Message-State: ANhLgQ2PZUoTBMmRyL5yk0Qz3vufx6wGqdi8o7IwPmYG2CSSdFIhZOeP
        ljfTl0JpIeFoXk6zy7Brflm+1AQuB30kiA==
X-Google-Smtp-Source: ADFU+vvA0LNIn6qdR1pCMkfY79ytftR4wg2Zm5m4Avobx1Rb43WaXRSlcWMRgHdIm+JTzaDT4ujOqQ==
X-Received: by 2002:ac8:7c92:: with SMTP id y18mr5780170qtv.189.1585436880818;
        Sat, 28 Mar 2020 16:08:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id x89sm7172921qtd.43.2020.03.28.16.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 16:08:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIKYZ-0000ov-QB; Sat, 28 Mar 2020 20:07:59 -0300
Date:   Sat, 28 Mar 2020 20:07:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kvm@vger.kernel.org, arei.gonglei@huawei.com,
        weidong.huang@huawei.com, weifuqiang@huawei.com,
        kirill.shutemov@linux.intel.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] mm/hugetlb: fix a addressing exception caused by
 huge_pte_offset
Message-ID: <20200328230759.GD20941@ziepe.ca>
References: <20200327234122.1985-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327234122.1985-1-longpeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 07:41:22AM +0800, Longpeng(Mike) wrote:
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

> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Longpeng <longpeng2@huawei.com>

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
