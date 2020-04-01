Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64492C2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B779206F8
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="jfklC9tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgDAOFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:05:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34887 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732854AbgDAOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:05:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id k21so25921193ljh.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 07:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DX54l6mXZgvg8fNpjxDfkSkS7a7YXpNmjQ66Zp5QZwk=;
        b=jfklC9tXAS2ZFL+y9Q7gH4nZZ7YnfJHqPBdCK1oMtQTsFEAaEdcWhbSxHq9hmP0Lpl
         GV5N6ZofZpSSv9pg0jxtoYArNo3d+4ZDGUkXSkHuknLnSDOLQJAMHN4buq4HzDbUveED
         aZyH4HmDjF5plF7q6ujTQzRgMt09SwHAaf6M8AKL+wRcKqVe+5xUyGX6JqVmZvKipbin
         XHrLDj2GHRRndj9fm8ptwKmyWNOK6CwozSav+H4ChEFTRMSZVbB94fJl/L1FwUdPl6ET
         OeBcV6N2BcItxUDf8iv0TFHg1EUHt96T1/QMrcx6Ub89/ECxQ3O7CE/FxQxEQFVJmmqw
         /4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DX54l6mXZgvg8fNpjxDfkSkS7a7YXpNmjQ66Zp5QZwk=;
        b=MPeWPHbMKct09BP1FA/NOY+bYEgkPJhZzQ9t7TqjYwM85M4Jct8DjHjMQpGt/gpaX8
         AHgcCtedFVr87UZ8aIPGtBAMOAS45sl/SBJaVQgkE9arWnf41+iBmFM3e/wr/gT955gI
         NxdH2prVPapgW++WhXqYDyYiKdDzBjq+KFf61UNxkZkW8NjUQZPVOC5dbIOWyyk6HDzT
         ATyLbTIgH/yzH576YnD0vULcTdVF9l5/9QSB41U3lm3QAGNKC6pD48PHt3JT5crR5D1e
         ZQOzGWZeri8UrR/eoO7W9xN4gb2hRI6vF5LIYW0j0525zlEJVQ0KS80g7e6rSSL4Z9FY
         HK4w==
X-Gm-Message-State: AGi0PubqhOj4fn3DGgg7QSjWfmD6GaH/hVA0jrumqio2RSZ11JlI0riP
        zjzTNHAuMzKWLlexoQoFf3+nSAVbavk=
X-Google-Smtp-Source: APiQypKHorHX7t1AMghmwqPTG5hZghSH9yGsQdrU3naHV7seLQRyJU/BjPlzWXNzLdpcl6oyqKkOgA==
X-Received: by 2002:a05:651c:1102:: with SMTP id d2mr13519723ljo.102.1585749946356;
        Wed, 01 Apr 2020 07:05:46 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id e1sm1297999ljo.16.2020.04.01.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 07:05:45 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 24CDE1020AE; Wed,  1 Apr 2020 17:05:44 +0300 (+03)
Date:   Wed, 1 Apr 2020 17:05:44 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: Re: [PATCH] mm, dump_page(): do not crash with invalid mapping
 pointer
Message-ID: <20200401140544.pkhgfmo5pks3dw6v@box>
References: <20200331165454.12263-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331165454.12263-1-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 06:54:54PM +0200, Vlastimil Babka wrote:
> We have seen a following problem on a RPi4 with 1G RAM:
> 
> BUG: Bad page state in process systemd-hwdb  pfn:35601
> page:ffff7e0000d58040 refcount:15 mapcount:131221 mapping:efd8fe765bc80080 index:0x1 compound_mapcount: -32767
> Unable to handle kernel paging request at virtual address efd8fe765bc80080
> Mem abort info:
>   ESR = 0x96000004
>   Exception class = DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> [efd8fe765bc80080] address between user and kernel address ranges
> Internal error: Oops: 96000004 [#1] SMP
> Modules linked in: btrfs libcrc32c xor xor_neon zlib_deflate raid6_pq mmc_block xhci_pci xhci_hcd usbcore sdhci_iproc sdhci_pltfm sdhci mmc_core clk_raspberrypi gpio_raspberrypi_exp pcie_brcmstb bcm2835_dma gpio_regulator phy_generic fixed sg scsi_mod efivarfs
> Supported: No, Unreleased kernel
> CPU: 3 PID: 408 Comm: systemd-hwdb Not tainted 5.3.18-8-default #1 SLE15-SP2 (unreleased)
> Hardware name: raspberrypi rpi/rpi, BIOS 2020.01 02/21/2020
> pstate: 40000085 (nZcv daIf -PAN -UAO)
> pc : __dump_page+0x268/0x368
> lr : __dump_page+0xc4/0x368
> sp : ffff000012563860
> x29: ffff000012563860 x28: ffff80003ddc4300
> x27: 0000000000000010 x26: 000000000000003f
> x25: ffff7e0000d58040 x24: 000000000000000f
> x23: efd8fe765bc80080 x22: 0000000000020095
> x21: efd8fe765bc80080 x20: ffff000010ede8b0
> x19: ffff7e0000d58040 x18: ffffffffffffffff
> x17: 0000000000000001 x16: 0000000000000007
> x15: ffff000011689708 x14: 3030386362353637
> x13: 6566386466653a67 x12: 6e697070616d2031
> x11: 32323133313a746e x10: 756f6370616d2035
> x9 : ffff00001168a840 x8 : ffff00001077a670
> x7 : 000000000000013d x6 : ffff0000118a43b5
> x5 : 0000000000000001 x4 : ffff80003dd9e2c8
> x3 : ffff80003dd9e2c8 x2 : 911c8d7c2f483500
> x1 : dead000000000100 x0 : efd8fe765bc80080
> Call trace:
>  __dump_page+0x268/0x368
>  bad_page+0xd4/0x168
>  check_new_page_bad+0x80/0xb8
>  rmqueue_bulk.constprop.26+0x4d8/0x788
>  get_page_from_freelist+0x4d4/0x1228
>  __alloc_pages_nodemask+0x134/0xe48
>  alloc_pages_vma+0x198/0x1c0
>  do_anonymous_page+0x1a4/0x4d8
>  __handle_mm_fault+0x4e8/0x560
>  handle_mm_fault+0x104/0x1e0
>  do_page_fault+0x1e8/0x4c0
>  do_translation_fault+0xb0/0xc0
>  do_mem_abort+0x50/0xb0
>  el0_da+0x24/0x28
> Code: f9401025 8b8018a0 9a851005 17ffffca (f94002a0)
> ---[ end trace 703ac54becfd8094 ]---
> 
> Besides the underlying issue with page->mapping containing a bogus value for
> some reason, we can see that __dump_page() crashed by trying to read the
> pointer at mapping->host, turning a recoverable warning into full Oops.
> 
> It can be expected that when page is reported as bad state for some reason, the
> pointers there should not be trusted blindly. So this patch treats all data in
> __dump_page() that depends on page->mapping as lava, using
> probe_kernel_read_strict(). Ideally this would include the dentry->d_parent
> recursively, but that would mean changing printk handler for %pd. Chances of
> reaching the dentry printing part with an initially bogus mapping pointer
> should be rather low, though.
> 
> Also prefix printing mapping->a_ops with a description of what is being
> printed.  In case the value is bogus, %ps will print raw value instead of
> the symbol name and then it's not obvious at all that it's printing a_ops.
> 
> Reported-by: Petr Tesarik <ptesarik@suse.cz>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/debug.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 50 insertions(+), 6 deletions(-)

I'm not sure it worth the effort. It looks way too complex for what it
does.

I also expect it to slowdown dump_page(), which is hotpath for some debug
scenarios :P

Maybe just move printing this info to the end, so we would see the rest
even if ->mapping is bogus?

-- 
 Kirill A. Shutemov
