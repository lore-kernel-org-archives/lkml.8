Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77631C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560A5207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 06:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590907187;
	bh=MTrSdcN1VmjDTA7hmEcp/kAIKW/bBAXMYB6FTgjyJUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZK+rvGvnr67AAoIYgubex/7/gTimQ50AWJfCojOkqy4GemXeezWH+xRUBd74UsEPO
	 NPSk/AzG0sNQKNkOJE5BGxnYw69hdNMjed4HZeuVtD6mDYy4he8o4HsHnh7NCYhIVi
	 I8YPeZ81z/8t347hQUG7a50BZ1rVOlHCOvwuvfLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgEaGjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 02:39:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgEaGjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 02:39:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A03120723;
        Sun, 31 May 2020 06:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590907183;
        bh=MTrSdcN1VmjDTA7hmEcp/kAIKW/bBAXMYB6FTgjyJUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mg2qJMGy7zOphfocfdXRkp61JKx3hq+eyVVt/xJ5mz8wQVu5DCCyhhJh2a5/vosMC
         S7TVYZmw1hl6m4IrMG8AEV7kkf5CQLyawhLyOt2NL2qIV1p9NofG8eig9WY97/U3NV
         3xDJjMpZ8q+z/Dl3QSZzhkIHtGUmjicx+r7CamF8=
Date:   Sun, 31 May 2020 08:39:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Subject: Re: memory leak in hidg_set_alt
Message-ID: <20200531063936.GB1082896@kroah.com>
References: <20200530171759.GA37895@pizza01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530171759.GA37895@pizza01>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 05:18:06PM +0000, Kyungtae Kim wrote:
> We report a bug (in linux-5.6.11) found by FuzzUSB (a modified version
> of syzkaller)
> 
> kernel config: https://kt0755.github.io/etc/config_v5.6.11
> 
> An usb_request instance allocated for report in hidg_set_alt() leaked.
> 
> ==================================================================
> BUG: memory leak
> unreferenced object 0xffff88803af68400 (size 128):
>   comm "softirq", pid 0, jiffies 4294942450 (age 189.010s)
>   hex dump (first 32 bytes):
>     00 84 f6 3a 80 88 ff ff 00 84 f6 3a 80 88 ff ff  ...:.......:....
>     a8 83 3c 5e 80 88 ff ff 01 00 00 00 00 00 00 00  ..<^............
>   backtrace:
>     [<00000000c77ea9d0>] kmemleak_alloc_recursive include/linux/kmemleak.h:43 [inline]
>     [<00000000c77ea9d0>] slab_post_alloc_hook mm/slab.h:586 [inline]
>     [<00000000c77ea9d0>] slab_alloc_node mm/slub.c:2786 [inline]
>     [<00000000c77ea9d0>] slab_alloc mm/slub.c:2794 [inline]
>     [<00000000c77ea9d0>] kmem_cache_alloc_trace+0x15e/0x2d0 mm/slub.c:2811
>     [<0000000021977c74>] kmalloc include/linux/slab.h:555 [inline]
>     [<0000000021977c74>] kzalloc include/linux/slab.h:669 [inline]
>     [<0000000021977c74>] dummy_alloc_request+0xb4/0x1a0 drivers/usb/gadget/udc/dummy_hcd.c:662
>     [<0000000065bac76c>] usb_ep_alloc_request+0x69/0x2e0 drivers/usb/gadget/udc/core.c:178
>     [<00000000916a7f5e>] alloc_ep_req+0x27/0x1d0 drivers/usb/gadget/u_f.c:18
>     [<00000000a697106a>] hidg_alloc_ep_req drivers/usb/gadget/function/f_hid.c:458 [inline]
>     [<00000000a697106a>] hidg_set_alt+0x1ff/0xbe0 drivers/usb/gadget/function/f_hid.c:662
>     [<000000006a6a3007>] set_config drivers/usb/gadget/composite.c:838 [inline]
>     [<000000006a6a3007>] composite_setup+0x4231/0x6f10 drivers/usb/gadget/composite.c:1717
>     [<000000000c47b49d>] configfs_composite_setup+0x11a/0x170 drivers/usb/gadget/configfs.c:1466
>     [<00000000850a3c44>] dummy_timer+0xda5/0x33f0 drivers/usb/gadget/udc/dummy_hcd.c:1898
>     [<00000000aaf23b82>] call_timer_fn+0x20e/0x770 kernel/time/timer.c:1404
>     [<00000000e04e8038>] expire_timers kernel/time/timer.c:1449 [inline]
>     [<00000000e04e8038>] __run_timers kernel/time/timer.c:1773 [inline]
>     [<00000000e04e8038>] run_timer_softirq+0x63f/0x13c0 kernel/time/timer.c:1786
>     [<00000000deb0ec70>] __do_softirq+0x262/0xb46 kernel/softirq.c:292
>     [<00000000c245a5cd>] invoke_softirq kernel/softirq.c:373 [inline]
>     [<00000000c245a5cd>] irq_exit+0x161/0x1b0 kernel/softirq.c:413
>     [<00000000bacb5a5b>] exiting_irq arch/x86/include/asm/apic.h:546 [inline]
>     [<00000000bacb5a5b>] smp_apic_timer_interrupt+0x137/0x500 arch/x86/kernel/apic/apic.c:1146
>     [<000000001988f5a4>] apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
> ==================================================================

Great, can you send a patch fixing this please so you can get the proper
credit for finding and fixing the issue?

thanks,

greg k-h
