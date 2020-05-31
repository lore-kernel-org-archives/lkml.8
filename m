Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EB9620723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590907192;
	bh=S1ionXJZ+2RUrPWK2HgapFCNmmAfENq0+X4lG6qHL80=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OR0vZneZUlA6SaTuNk+9Pb6hRGbKoj19lHrxtmT4FQFVohvTnlclVXirNXGLd4oOk
	 UdRmmP0UHXi+rwDnI06rUWkNYXyyg+oj7S0a8bO5NZ/XJ0hJYsSbxxXT0T4WWDY3I6
	 EOj6sVB6qYsaPCKl7Kq2d11cJ4TCg1uukzp1xx4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEaGjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 02:39:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEaGju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:39:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4843E207C4;
        Sun, 31 May 2020 06:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590907189;
        bh=S1ionXJZ+2RUrPWK2HgapFCNmmAfENq0+X4lG6qHL80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y1atu47IkTmRx99YBcQJ0eOmb0dgQe6f2KOaiDDfxONcmnYYYCwofWsnw3WTu7/JR
         VYOj0knZRduKXtVaiKyL3r87T8wljLSPAgtkMihJ9OfkItQMKRa9zcZLC6EevK488O
         +RFNOUeu0lV231kdNhsYwbL3nM/+LcY+8m+MM/H8=
Date:   Sun, 31 May 2020 08:39:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: memory leak in usb_copy_descriptors
Message-ID: <20200531063947.GC1082896@kroah.com>
References: <20200530182456.GA2320@pizza01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530182456.GA2320@pizza01>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 06:25:02PM +0000, Kyungtae Kim wrote:
> We report a bug (in linux-5.6.11) found by FuzzUSB (a modified version
> of syzkaller)
> 
> kernel config: https://kt0755.github.io/etc/config_v5.6.11
> 
> A USB descriptor held by fs_descriotors in usb_function leaked.
> 
> ==================================================================
> BUG: memory leak
> unreferenced object 0xffff888058b7a700 (size 64):
>   comm "syz-executor.0", pid 2473, jiffies 4294942614 (age 3131.830s)
>   hex dump (first 32 bytes):
>     20 a7 b7 58 80 88 ff ff 29 a7 b7 58 80 88 ff ff   ..X....)..X....
>     30 a7 b7 58 80 88 ff ff 00 00 00 00 00 00 00 00  0..X............
>   backtrace:
>     [<000000008820290b>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>     [<000000008820290b>] slab_post_alloc_hook mm/slab.h:586 [inline]
>     [<000000008820290b>] slab_alloc_node mm/slub.c:2786 [inline]
>     [<000000008820290b>] slab_alloc mm/slub.c:2794 [inline]
>     [<000000008820290b>] __kmalloc+0x144/0x310 mm/slub.c:3837
>     [<0000000069f64afa>] kmalloc include/linux/slab.h:560 [inline]
>     [<0000000069f64afa>] usb_copy_descriptors+0xcb/0x270 drivers/usb/gadget/config.c:135
>     [<000000004a667526>] usb_assign_descriptors+0x9f/0x310 drivers/usb/gadget/config.c:168
>     [<0000000001ee4653>] loopback_bind+0x188/0x280 drivers/usb/gadget/function/f_loopback.c:209
>     [<0000000067b9c558>] usb_add_function+0x1f0/0x6c0 drivers/usb/gadget/composite.c:279
>     [<0000000084caf39b>] configfs_composite_bind+0x9d3/0x1110 drivers/usb/gadget/configfs.c:1397
>     [<0000000065d7065c>] udc_bind_to_driver+0x1c6/0x530 drivers/usb/gadget/udc/core.c:1358
>     [<00000000fe783078>] usb_gadget_probe_driver+0x42a/0x4e0 drivers/usb/gadget/udc/core.c:1421
>     [<0000000063f1f5c5>] gadget_dev_desc_UDC_store+0x158/0x200 drivers/usb/gadget/configfs.c:282
>     [<00000000fb18ff7c>] flush_write_buffer fs/configfs/file.c:251 [inline]
>     [<00000000fb18ff7c>] configfs_write_file+0x2f1/0x4c0 fs/configfs/file.c:283
>     [<0000000085920ac6>] __vfs_write+0x85/0x110 fs/read_write.c:494
>     [<0000000052812ae5>] vfs_write+0x1cd/0x510 fs/read_write.c:558
>     [<00000000334feaef>] ksys_write+0x18a/0x220 fs/read_write.c:611
>     [<00000000db0255b5>] __do_sys_write fs/read_write.c:623 [inline]
>     [<00000000db0255b5>] __se_sys_write fs/read_write.c:620 [inline]
>     [<00000000db0255b5>] __x64_sys_write+0x73/0xb0 fs/read_write.c:620
>     [<0000000012ddffe1>] do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
>     [<000000008496dc30>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
> ==================================================================


Great, can you send a patch fixing this please so you can get the proper
credit for finding and fixing the issue?

thanks,

greg k-h
