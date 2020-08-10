Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DFD206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wUj6vFMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHJMpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHJMpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:45:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870C3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zpMQ26Ni/X63SDfQXXGSMQ9+/QGWuEIK8ZFFFlpOEoQ=; b=wUj6vFMkE5dKhoeAhY6Jw9Elk9
        GIOBi+m336KlMWydBY0gGmB/zFI1kiIgOS7DZeVT7Vcgh4jMUp4Nom84xNC2Pu4hWISmSPIWXngs2
        pcfAAbDBPtovfgcqg+Gt2/P0/XPdiDWCMPvwtOvVSR1z4xhfekzZicIVeCb8ZQ9JhepQ7CLfhmzl6
        E1D5rhE2HGYCCtLmJkziZRkGHoc1TISio25sgANqJ8wrTU5LQA3LlKPVHmISUpCEq4KglEbP/OjY5
        JSyh5yd6TeBsGJQw94h5BUZzoRpTS9Hvg/DuoJ9VkZGhJeAKWj3K101rN1iXERNNJHVMkd0pbHVdk
        ixbSTl0A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k57Ay-0006qe-G5; Mon, 10 Aug 2020 12:45:16 +0000
Date:   Mon, 10 Aug 2020 13:45:16 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+0d4522639ba75b02bf19@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: KCSAN: data-race in __xa_clear_mark / xas_find_marked
Message-ID: <20200810124516.GM17456@casper.infradead.org>
References: <00000000000062a49205ac854581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000062a49205ac854581@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 05:41:18AM -0700, syzbot wrote:
> ==================================================================
> BUG: KCSAN: data-race in __xa_clear_mark / xas_find_marked

This is not a bug.  xas_find_marked() is well aware that it is only
running under the RCU lock and may see marks which are concurrently
being set or cleared.

What's the latest wart to add so that this stupid checker will shut up?

> write to 0xffff8880bace9b30 of 8 bytes by interrupt on cpu 1:
>  instrument_write include/linux/instrumented.h:42 [inline]
>  __test_and_clear_bit include/asm-generic/bitops/instrumented-non-atomic.h:85 [inline]
>  node_clear_mark lib/xarray.c:100 [inline]
>  xas_clear_mark lib/xarray.c:908 [inline]
>  __xa_clear_mark+0x229/0x350 lib/xarray.c:1726
>  test_clear_page_writeback+0x28d/0x480 mm/page-writeback.c:2739
>  end_page_writeback+0xa7/0x110 mm/filemap.c:1369
>  page_endio+0x1aa/0x1e0 mm/filemap.c:1400
>  mpage_end_io+0x186/0x1d0 fs/mpage.c:54
>  bio_endio+0x28a/0x370 block/bio.c:1447
>  req_bio_endio block/blk-core.c:259 [inline]
>  blk_update_request+0x535/0xbd0 block/blk-core.c:1576
>  blk_mq_end_request+0x22/0x50 block/blk-mq.c:562
>  lo_complete_rq+0xca/0x180 drivers/block/loop.c:500
>  blk_done_softirq+0x1a5/0x200 block/blk-mq.c:586
>  __do_softirq+0x198/0x360 kernel/softirq.c:298
>  run_ksoftirqd+0x2f/0x60 kernel/softirq.c:652
>  smpboot_thread_fn+0x347/0x530 kernel/smpboot.c:165
>  kthread+0x20d/0x230 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> 
> read to 0xffff8880bace9b30 of 8 bytes by task 12715 on cpu 0:
>  xas_find_chunk include/linux/xarray.h:1625 [inline]
>  xas_find_marked+0x22f/0x6b0 lib/xarray.c:1198
>  find_get_pages_range_tag+0xa3/0x580 mm/filemap.c:1976
>  pagevec_lookup_range_tag+0x37/0x50 mm/swap.c:1120
>  __filemap_fdatawait_range+0xab/0x1b0 mm/filemap.c:519
>  filemap_fdatawait_range mm/filemap.c:554 [inline]
>  filemap_write_and_wait_range+0x119/0x2a0 mm/filemap.c:664
>  generic_file_read_iter+0x11d/0x3e0 mm/filemap.c:2375
>  call_read_iter include/linux/fs.h:1866 [inline]
>  generic_file_splice_read+0x22b/0x310 fs/splice.c:312
>  do_splice_to fs/splice.c:870 [inline]
>  splice_direct_to_actor+0x2a8/0x660 fs/splice.c:950
>  do_splice_direct+0xf2/0x170 fs/splice.c:1059
>  do_sendfile+0x56a/0xba0 fs/read_write.c:1540
>  __do_sys_sendfile64 fs/read_write.c:1595 [inline]
>  __se_sys_sendfile64 fs/read_write.c:1587 [inline]
>  __x64_sys_sendfile64+0xa9/0x130 fs/read_write.c:1587
>  do_syscall_64+0x39/0x80 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 PID: 12715 Comm: syz-executor.4 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
