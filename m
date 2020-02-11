Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D3EC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4361C20733
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CYQ9LsW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBKDtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:49:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56026 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgBKDtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a7NvNilpUl5bhc9T/eXq6L5I1GFPcDpbrAQedowqMwY=; b=CYQ9LsW7rkCgbKw2z+J2rI0Ma0
        Va6fm0irz2nQg6MMMbI8eRTHUzmutpvZiw/YaOuIUFMH0+tAPVU1YkDwJn61UBTqRaadOdRCdn8qb
        qDi/Y9mUUYaQ8sj7247kA7yYazGNRnY0xrFOKHq+udYn1zDqgtQSpbPRWuwk3ttUCXIjtDPOLcuWv
        U2WvvYmGkeDqKHQJmZfUuM/pPdQJ6OiW67uFcFvDPtExaLicCdMnLdc1YEK3Fz5i6wjNanH6/ZMFf
        RoxhuQuyyI7UXfwKp4erVrmnWy9ZHc82s+r68BAGK3fxrSpCb+EGC8tqUKIbCpgnDyNR3kcKLxdLD
        i1opX2/Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1MXl-0004eR-1f; Tue, 11 Feb 2020 03:49:01 +0000
Date:   Mon, 10 Feb 2020 19:49:00 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2] mm/filemap: fix a data race in filemap_fault()
Message-ID: <20200211034900.GQ8731@bombadil.infradead.org>
References: <20200211030134.1847-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211030134.1847-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:01:34PM -0500, Qian Cai wrote:
> struct file_ra_state ra.mmap_miss could be accessed concurrently during
> page faults as noticed by KCSAN,
> 
>  BUG: KCSAN: data-race in filemap_fault / filemap_map_pages
> 
>  write to 0xffff9b1700a2c1b4 of 4 bytes by task 3292 on cpu 30:
>   filemap_fault+0x920/0xfc0
>   do_sync_mmap_readahead at mm/filemap.c:2384
>   (inlined by) filemap_fault at mm/filemap.c:2486
>   __xfs_filemap_fault+0x112/0x3e0 [xfs]
>   xfs_filemap_fault+0x74/0x90 [xfs]
>   __do_fault+0x9e/0x220
>   do_fault+0x4a0/0x920
>   __handle_mm_fault+0xc69/0xd00
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
>  read to 0xffff9b1700a2c1b4 of 4 bytes by task 3313 on cpu 32:
>   filemap_map_pages+0xc2e/0xd80
>   filemap_map_pages at mm/filemap.c:2625
>   do_fault+0x3da/0x920
>   __handle_mm_fault+0xc69/0xd00
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 32 PID: 3313 Comm: systemd-udevd Tainted: G        W    L 5.5.0-next-20200210+ #1
>  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> 
> ra.mmap_miss is used to contribute the readahead decisions, a data race
> could be undesirable. Both the read and write is only under
> non-exclusive mmap_sem, two concurrent writers could even overflow the
> counter. Fixing the underflow by writing to a local variable before
> committing a final store to ra.mmap_miss given a small inaccuracy of the
> counter should be acceptable.
> 
> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
> Signed-off-by: Qian Cai <cai@lca.pw>

That's more than Suggested-by.  The correct way to submit this patch is:

From: Kirill A. Shutemov <kirill@shutemov.name>
(at the top of the patch, so it gets credited to Kirill)

then in this section:

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Tested-by: Qian Cai <cai@lca.pw>

And now you can add:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
