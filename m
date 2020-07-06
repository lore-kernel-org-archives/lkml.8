Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740B8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAF22082E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgGFM6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:58:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55100 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgGFM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:58:04 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jsQh8-0005bX-2f; Mon, 06 Jul 2020 12:58:02 +0000
Date:   Mon, 6 Jul 2020 14:58:01 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Cc:     christian@brauner.io, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pidfd: fix memory leak in pidfd_getfd()
Message-ID: <20200706125801.xzyizoqkqdk7fpwq@wittgenstein>
References: <20200706125250.GA2828@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706125250.GA2828@cosmos>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 06:22:55PM +0530, Vamshi K Sthambamkadi wrote:
> kmemleak backtrace:
> 
> comm "pidfd_getfd_tes", pid 1406, jiffies 4294936898 (age 8.644s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 90 da d8 f6 80 d5 6f f2  ..............o.
>     b8 fb 9b ea c0 91 99 d1 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<8da987ad>] kmem_cache_alloc+0x199/0x4c0
>     [<8ff6a575>] __alloc_file+0x1e/0xe0
>     [<e1479798>] alloc_empty_file+0x45/0x100
>     [<727fe6eb>] alloc_file+0x23/0xf0
>     [<457148ef>] alloc_file_pseudo+0x98/0x100
>     [<c104ed3d>] __shmem_file_setup.part.67+0x66/0x120
>     [<5edc3e9b>] shmem_file_setup+0x4c/0x70
>     [<9c446684>] __ia32_sys_memfd_create+0x122/0x1c0
>     [<e129fc9c>] do_syscall_32_irqs_on+0x3d/0x260
>     [<62569441>] do_fast_syscall_32+0x39/0xb0
>     [<3c515b7e>] do_SYSENTER_32+0x15/0x20
>     [<69819a3a>] entry_SYSENTER_32+0xa9/0xfc
> 
> comm "pidfd_getfd_tes", pid 1406, jiffies 4294936898 (age 8.644s)
>   hex dump (first 16 bytes):
>     01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<8da987ad>] kmem_cache_alloc+0x199/0x4c0
>     [<b67faec5>] security_file_alloc+0x20/0x90
>     [<ed849d41>] __alloc_file+0x40/0xe0
>     [<e1479798>] alloc_empty_file+0x45/0x100
>     [<727fe6eb>] alloc_file+0x23/0xf0
>     [<457148ef>] alloc_file_pseudo+0x98/0x100
>     [<c104ed3d>] __shmem_file_setup.part.67+0x66/0x120
>     [<5edc3e9b>] shmem_file_setup+0x4c/0x70
>     [<9c446684>] __ia32_sys_memfd_create+0x122/0x1c0
>     [<e129fc9c>] do_syscall_32_irqs_on+0x3d/0x260
>     [<62569441>] do_fast_syscall_32+0x39/0xb0
>     [<3c515b7e>] do_SYSENTER_32+0x15/0x20
>     [<69819a3a>] entry_SYSENTER_32+0xa9/0xfc
> 
> This is because in pidfd_getfd(), the file->f_count is incremented twice
> 1) __pidfd_fget() gets file ref by incrementing f_count in __fget_files()
> 2) f_count is incremented While installing fd in __fd_install_received()
>    i.e. get_file().
> 
> Memory leak occurs because the refs count do not match, the struct file
> object is never freed.
> 
> Secondly the error validity check (ret < 0) after the call to
> fd_install_received() is not needed since this function cannot return
> negative number after incrementing f_count. So it is wrong to call fput
> on condition (ret < 0).
> 
> Change pidfd_getfd() to call fput() on file reference once its installed
> as new_fd in target process.
> 
> Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
> ---

What's the base commit for this fix? The fd_install_received() changes
are not upstream yet. Afaict, they are in Kees tree and in linux-next.
So this really isn't an applicable fix.
I really need to re-review the patches Kees sent. I haven't acked them
yet so we can't really take this patch now.

Thanks!
Christian
