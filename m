Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED59C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E88246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="jiwAbnKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgB1NIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:08:18 -0500
Received: from ste-pvt-msa1.bahnhof.se ([213.80.101.70]:56018 "EHLO
        ste-pvt-msa1.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgB1NIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:08:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 960713F6E3;
        Fri, 28 Feb 2020 14:08:15 +0100 (CET)
Authentication-Results: ste-pvt-msa1.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=jiwAbnKM;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WAuvgacn0XQ3; Fri, 28 Feb 2020 14:08:13 +0100 (CET)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id 525103F3E7;
        Fri, 28 Feb 2020 14:08:04 +0100 (CET)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id 8BB36360058;
        Fri, 28 Feb 2020 14:08:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1582895284; bh=9KuDoakzQU3d3CJvJMw+Ur864I+q1jzIXNDtCjFACGo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jiwAbnKM8mzmWh1+InaZhw89xfuYrm0p2buDYfV+mf+oEkZit27tONGBWmFD6zFhA
         /LYVlxqf8DII93sn+0XAzHNSkVtCaEgIE8EOFDOc9cNQGLzIw7vwq0km2nFbHdTdx5
         jGDo/81sGgrdfVlv41cUO5mhodivTGIhQPB2evoU=
Subject: Re: [PATCH v4 0/9] Huge page-table entries for TTM
To:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, pv-drivers@vmware.com,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-graphics-maintainer@vmware.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200220122719.4302-1-thomas_os@shipmail.org>
From:   =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Organization: VMware Inc.
Message-ID: <cc469a2a-e31c-4645-503a-f225fb101899@shipmail.org>
Date:   Fri, 28 Feb 2020 14:08:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200220122719.4302-1-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Michal

I'm wondering what's the best way here to get the patches touching mm 
reviewed and accepted?
While drm people and VMware internal people have looked at them, I think 
the huge_fault() fallback splitting and the introduction of 
vma_is_special_huge() needs looking at more thoroughly.

Apart from that, if possible, I think the best way to merge this series 
is also through a DRM tree.

Thanks,
Thomas


On 2/20/20 1:27 PM, Thomas Hellström (VMware) wrote:
> In order to reduce TLB misses and CPU usage this patchset enables huge-
> and giant page-table entries for TTM and TTM-enabled graphics drivers.
>
> Patch 1 and 2 introduce a vma_is_special_huge() function to make the mm code
> take the same path as DAX when splitting huge- and giant page table entries,
> (which currently means zapping the page-table entry and rely on re-faulting).
>
> Patch 3 makes the mm code split existing huge page-table entries
> on huge_fault fallbacks. Typically on COW or on buffer-objects that want
> write-notify. COW and write-notification is always done on the lowest
> page-table level. See the patch log message for additional considerations.
>
> Patch 4 introduces functions to allow the graphics drivers to manipulate
> the caching- and encryption flags of huge page-table entries without ugly
> hacks.
>
> Patch 5 implements the huge_fault handler in TTM.
> This enables huge page-table entries, provided that the kernel is configured
> to support transhuge pages, either by default or using madvise().
> However, they are unlikely to be inserted unless the kernel buffer object
> pfns and user-space addresses align perfectly. There are various options
> here, but since buffer objects that reside in system pages typically start
> at huge page boundaries if they are backed by huge pages, we try to enforce
> buffer object starting pfns and user-space addresses to be huge page-size
> aligned if their size exceeds a huge page-size. If pud-size transhuge
> ("giant") pages are enabled by the arch, the same holds for those.
>
> Patch 6 implements a specialized huge_fault handler for vmwgfx.
> The vmwgfx driver may perform dirty-tracking and needs some special code
> to handle that correctly.
>
> Patch 7 implements a drm helper to align user-space addresses according
> to the above scheme, if possible.
>
> Patch 8 implements a TTM range manager for vmwgfx that does the same for
> graphics IO memory. This may later be reused by other graphics drivers
> if necessary.
>
> Patch 9 finally hooks up the helpers of patch 7 and 8 to the vmwgfx driver.
> A similar change is needed for graphics drivers that want a reasonable
> likelyhood of actually using huge page-table entries.
>
> If a buffer object size is not huge-page or giant-page aligned,
> its size will NOT be inflated by this patchset. This means that the buffer
> object tail will use smaller size page-table entries and thus no memory
> overhead occurs. Drivers that want to pay the memory overhead price need to
> implement their own scheme to inflate buffer-object sizes.
>
> PMD size huge page-table-entries have been tested with vmwgfx and found to
> work well both with system memory backed and IO memory backed buffer objects.
>
> PUD size giant page-table-entries have seen limited (fault and COW) testing
> using a modified kernel (to support 1GB page allocations) and a fake vmwgfx
> TTM memory type. The vmwgfx driver does otherwise not support 1GB-size IO
> memory resources.
>
> Comments and suggestions welcome.
> Thomas
>
> Changes since RFC:
> * Check for buffer objects present in contigous IO Memory (Christian König)
> * Rebased on the vmwgfx emulated coherent memory functionality. That rebase
>    adds patch 5.
> Changes since v1:
> * Make the new TTM range manager vmwgfx-specific. (Christian König)
> * Minor fixes for configs that don't support or only partially support
>    transhuge pages.
> Changes since v2:
> * Minor coding style and doc fixes in patch 5/9 (Christian König)
> * Patch 5/9 doesn't touch mm. Remove from the patch title.
> Changes since v3:
> * Added reviews and acks
> * Implemented ugly but generic ttm_pgprot_is_wrprotecting() instead of arch
>    specific code.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel


