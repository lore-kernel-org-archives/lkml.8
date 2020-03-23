Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEEEC54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB5820722
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CHkzV0CU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgCWQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:44:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42440 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbgCWQoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:44:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id e11so15928289qkg.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gOqUZhrB3tbP37O07iZXzI++c1tt+580wf55GATS2SM=;
        b=CHkzV0CUaFfnHgtED9IRJD4ztA7/XKt6w3TMqe+emVP/CoIvuvXtYA2Rntt9fhIupT
         FDhFCWE3zOJ+1mdE4OhnqVBGkGJplnaoVMH6yWifoIndPxyJWU6t2TbUiHx+Fabkz4AU
         Bo6VUH5I/z+vdpQyLloUPnUFcyCsVgk/ZKOq7fZWdshq+tD1F2JqhgynUuOC9Clph639
         oYUZtEi9XKMwwJh4wsqKYBmavQEBgUhAg1WuJMXTB5ek2FIUwDvyCE3rofJYHNfQbqHY
         1ibApMJdvmmqRPne6+/xBnr+WdEY9aK5/EWxYtSutuEpgLnfjdVKLjxpd/vvow8QZIkD
         0bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gOqUZhrB3tbP37O07iZXzI++c1tt+580wf55GATS2SM=;
        b=faGh7Gy2+xv3bRcI5SYV8dqyEpf4E2ykLzgVG/m2QIlJdK4uncxt4J/lZI3gy0cFf9
         o09kI/FHbG+bYNZYkPnm8wYCUI8gjr8Zh5mBhVEOwQLnq6P4161dv0U9W3VjVye4240X
         P61RC9YCj0lcFelu37ENzjLdCcM6lEW7tm+8XdnQNpIA+mwIEg9STIW+Ejx/OO8pv7bE
         cEjKDuqU9MTGKVZAk66ZlaCFE1UghN+5C3OZ7YfvqZ+spmnau2K5K3e3/iPMDKQlT+8W
         qccJBOjmEs9CDqshiSt2w+FzA7JZKB5De15v2kD2+u2qfISfOR6MWF+BZ31x2gMPIFSQ
         5C9w==
X-Gm-Message-State: ANhLgQ2YptI3X84iXrRiVqDUHmC/gXlax7WPfz5P4PHj4Os6pA3GiJ2l
        xATeaN4o1jtTsejX8L0vQqud4A==
X-Google-Smtp-Source: ADFU+vtcop8zgZHP+bMT/hRGVH1iCEYh7uqN8r13iYqMZjJ4sAKMDQgt2z2v/hovRrjc1FG+Yk1+6Q==
X-Received: by 2002:a05:620a:84d:: with SMTP id u13mr21724625qku.94.1584981845232;
        Mon, 23 Mar 2020 09:44:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id f13sm12827393qte.53.2020.03.23.09.44.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 09:44:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jGQBH-0005fK-Aj; Mon, 23 Mar 2020 13:44:03 -0300
Date:   Mon, 23 Mar 2020 13:44:03 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        arei.gonglei@huawei.com, weidong.huang@huawei.com,
        weifuqiang@huawei.com, kvm@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/hugetlb: fix a addressing exception caused by
 huge_pte_offset()
Message-ID: <20200323164403.GZ20941@ziepe.ca>
References: <1582342427-230392-1-git-send-email-longpeng2@huawei.com>
 <51a25d55-de49-4c0a-c994-bf1a8cfc8638@oracle.com>
 <5700f44e-9df9-1b12-bc29-68e0463c2860@huawei.com>
 <e16fe81b-5c4c-e689-2f48-214f2025df2f@oracle.com>
 <20200323144030.GA28711@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323144030.GA28711@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 07:40:31AM -0700, Sean Christopherson wrote:
> On Sun, Mar 22, 2020 at 07:54:32PM -0700, Mike Kravetz wrote:
> > On 3/22/20 7:03 PM, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> > > 
> > > On 2020/3/22 7:38, Mike Kravetz wrote:
> > >> On 2/21/20 7:33 PM, Longpeng(Mike) wrote:
> > >>> From: Longpeng <longpeng2@huawei.com>
> > I have not looked closely at the generated code for lookup_address_in_pgd.
> > It appears that it would dereference p4d, pud and pmd multiple times.  Sean
> > seemed to think there was something about the calling context that would
> > make issues like those seen with huge_pte_offset less likely to happen.  I
> > do not know if this is accurate or not.
> 
> Only for KVM's calls to lookup_address_in_mm(), I can't speak to other
> calls that funnel into to lookup_address_in_pgd().
> 
> KVM uses a combination of tracking and blocking mmu_notifier calls to ensure
> PTE changes/invalidations between gup() and lookup_address_in_pgd() cause a
> restart of the faulting instruction, and that pending changes/invalidations
> are blocked until installation of the pfn in KVM's secondary MMU completes.
> 
> kvm_mmu_page_fault():
> 
> 	mmu_seq = kvm->mmu_notifier_seq;
> 	smp_rmb();
> 
> 	pfn = gup(hva);
> 
> 	spin_lock(&kvm->mmu_lock);
> 	smp_rmb();
> 	if (kvm->mmu_notifier_seq != mmu_seq)
> 		goto out_unlock: // Restart guest, i.e. retry the fault
> 
> 	lookup_address_in_mm(hva, ...);

It works because the mmu_lock spinlock is taken before and after any
change to the page table via invalidate_range_start/end() callbacks.

So if you are in the spinlock and mmu_notifier_count == 0, then nobody
can be writing to the page tables. 

It is effectively a full page table lock, so any page table read under
that lock do not need to worry about any data races.

Jason
