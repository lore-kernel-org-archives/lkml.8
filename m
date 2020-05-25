Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C507C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1380120890
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rgBxhahP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404030AbgEYO4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390921AbgEYO4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:56:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6574EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:56:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k5so21022668lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Yz/iCNo6m0AB4cxN2lhc/SEr0qpr3e5JTbSbJHnwVIU=;
        b=rgBxhahPLGexiDdGfj/1yCvH/idNIEtEz+uUoV+m0qvlWDSbpeOv0ru+XBlrhVs3Mo
         paASWIqprgWhFyEyiDQUQkMZw63B8KqNumeTRqC9NyezMGqG6coxs6jlPY3Y0gurO3ef
         xZDm5kNwe0l7jtr/+webOXClGwgRFq8+RNKp48u2yBbEk8VXMGz7H/cCdPeVszeSoJLO
         Y+2uSPZ33CmHwjGoln7AYyW5J6OTubZDqkRNWDAHNFMrVCDzSxgBuAaKkjxzfOHF+5H3
         LlVfWEhgFAXjsouBqP6CgrZaZhJr3sJPLFpWTihk/wdddYr3owUyq4WBTPnJwV7S+/yY
         wiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yz/iCNo6m0AB4cxN2lhc/SEr0qpr3e5JTbSbJHnwVIU=;
        b=Exc59fAlPJeE5XWaLJV4Egl5ztRgzaMBBwYxIIZAF/hH8Jq6fnFp3XUFJ0NRKxBkys
         0RHt8DYC5ro1v+gs7N9mATFn1N4zK3yOUAsp2tfQoyy9PRYpqnc+fLDYVTSisg47zd+C
         XjLA5RMs/rNcNX0UJME+OLw62cXxLT3nwAP+D9Yl/xDt/bJYjUvI0+p25p5tqPB7IGGz
         nCOVd3vcOCYsr2z2zU03uSNwaJMRuuAkyanPQkQizH9vhYAg676L16wuOdQxivwFg+32
         qeNgzeaHKK1kj3sP7o47CcZdDKIBOqVfA89aimbLcCVKCcs3aaastViEIrhZPBadjhRa
         oxhg==
X-Gm-Message-State: AOAM533iZuVxBCtWhs+CXUwpo8eFPDcKJ9vgZkqJcNqPSoS3FjAuLrqf
        R4Cy77S/0r1AgC2V8tfjJGgAPQ==
X-Google-Smtp-Source: ABdhPJx4ytdRNFb6NqA5DIjE3V32k85IYdmOTRCMb5IaUCzSBBAku30pQ6a6xJNGZNCFUIRc9k3qjg==
X-Received: by 2002:a2e:8956:: with SMTP id b22mr15057648ljk.16.1590418611930;
        Mon, 25 May 2020 07:56:51 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id v22sm643925ljj.75.2020.05.25.07.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:56:51 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 56AC310230F; Mon, 25 May 2020 17:56:52 +0300 (+03)
Date:   Mon, 25 May 2020 17:56:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] mm: dump_page: add debugfs file for dumping page state
 by pfn
Message-ID: <20200525145652.u3xnom5fyuxvn7p4@box>
References: <159041635119.987025.7321864888027213705.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159041635119.987025.7321864888027213705.stgit@buzz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 25, 2020 at 05:19:11PM +0300, Konstantin Khlebnikov wrote:
> Tool 'page-types' could list pages mapped by process or file cache pages,
> but it shows only limited amount of state exported via procfs.
> 
> Let's employ existing helper dump_page() to reach remaining information:
> writing pfn into /sys/kernel/debug/dump_page dumps state into kernel log.
> 
> # echo 0x37c43c > /sys/kernel/debug/dump_page
> # dmesg | tail -6
>  page:ffffcb0b0df10f00 refcount:1 mapcount:0 mapping:000000007755d3d9 index:0x30
>  0xffffffffae4239e0 name:"libGeoIP.so.1.6.9"
>  flags: 0x200000000020014(uptodate|lru|mappedtodisk)
>  raw: 0200000000020014 ffffcb0b187fd288 ffffcb0b189e6248 ffff9528a04afe10
>  raw: 0000000000000030 0000000000000000 00000001ffffffff 0000000000000000
>  page dumped because: debugfs request
> 
> With CONFIG_PAGE_OWNER=y shows also stacks for last page alloc and free:
> 
>  page:ffffea0018fff480 refcount:1 mapcount:1 mapping:0000000000000000 index:0x7f9f28f62
>  anon flags: 0x100000000080034(uptodate|lru|active|swapbacked)
>  raw: 0100000000080034 ffffea00184140c8 ffffea0018517d88 ffff8886076ba161
>  raw: 00000007f9f28f62 0000000000000000 0000000100000000 ffff888bfc79f000
>  page dumped because: debugfs request
>  page->mem_cgroup:ffff888bfc79f000
>  page_owner tracks the page as allocated
>  page last allocated via order 0, migratetype Movable, gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO)
>   prep_new_page+0x139/0x1a0
>   get_page_from_freelist+0xde9/0x14e0
>   __alloc_pages_nodemask+0x18b/0x360
>   alloc_pages_vma+0x7c/0x270
>   __handle_mm_fault+0xd40/0x12b0
>   handle_mm_fault+0xe7/0x1e0
>   do_page_fault+0x2d5/0x610
>   page_fault+0x2f/0x40
>  page last free stack trace:
>   free_pcp_prepare+0x11e/0x1c0
>   free_unref_page_list+0x71/0x180
>   release_pages+0x31e/0x480
>   tlb_flush_mmu+0x44/0x150
>   tlb_finish_mmu+0x3d/0x70
>   exit_mmap+0xdd/0x1a0
>   mmput+0x70/0x140
>   do_exit+0x33f/0xc40
>   do_group_exit+0x3a/0xa0
>   __x64_sys_exit_group+0x14/0x20
>   do_syscall_64+0x48/0x130
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Looks useful to me:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
