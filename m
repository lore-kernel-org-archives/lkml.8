Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E028FC2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF972176D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589373673;
	bh=w0BMXaAbm3ZXC1lR+6gXnvhYlJsh+XV/CUl+EnU6p4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OxNsuvBOM85dWKGeNl3WIN5ND5duIPZ84nUMMvsZX3d7ci7vAaCEBh2Ipon2CKpru
	 RSSNks6xrI4nVvFFcIJfG6sht385d/qzjnD2jhfEzGw9A4jWxFeyLa/xRW7s+D4oiP
	 WcnS6Z4N+2LSE9KK7bowZpZ+TNxcxBv2ij/it3gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732935AbgEMMlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:41:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgEMMlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:41:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5938920659;
        Wed, 13 May 2020 12:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589373671;
        bh=w0BMXaAbm3ZXC1lR+6gXnvhYlJsh+XV/CUl+EnU6p4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sksyEf4xegzo8O+nHBxTJvdgJPilHUrEFS8lx0hzZcPj+F/z2hJpynOt/nOzlczNT
         zkYzPLKO/JULxjbHoVfFz/slMKxDEN8/IYhkD9GNgx2g9bVoCac33MxmEnRuCk3d4G
         yWq5+v3kYqhx2T8zmeGFifPqwktUwiSfTG5wj9XM=
Date:   Wed, 13 May 2020 14:41:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com>,
        jeremy.linton@arm.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, tglx@linutronix.de,
        Christoph Hellwig <hch@lst.de>, syzkaller-bugs@googlegroups.com
Subject: Re: WARNING in memtype_reserve
Message-ID: <20200513124109.GA1082369@kroah.com>
References: <000000000000f0d8d205a531f1a3@google.com>
 <20200509154728.1548-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509154728.1548-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 11:47:28PM +0800, Hillf Danton wrote:
> 
> Sat, 09 May 2020 00:20:14 -0700
> >syzbot found the following crash on:
> >
> >HEAD commit:    d5eeab8d Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
> >git tree:       upstream
> >console output: https://syzkaller.appspot.com/x/log.txt?x=15093632100000
> >kernel config:  https://syzkaller.appspot.com/x/.config?x=b0212dbee046bc1f
> >dashboard link: https://syzkaller.appspot.com/bug?extid=353be47c9ce21b68b7ed
> >compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >userspace arch: i386
> >syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168ee02c100000
> >C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119f3788100000
> >
> >The bug was bisected to:
> >
> >commit 2bef9aed6f0e22391c8d4570749b1acc9bc3981e
> >Author: Jeremy Linton <jeremy.linton@arm.com>
> >Date:   Mon May 4 20:13:48 2020 +0000
> >
> >    usb: usbfs: correct kernel->user page attribute mismatch
> >
> >bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1701f168100000
> >final crash:    https://syzkaller.appspot.com/x/report.txt?x=1481f168100000
> >console output: https://syzkaller.appspot.com/x/log.txt?x=1081f168100000
> >
> >IMPORTANT: if you fix the bug, please add the following tag to the commit:
> >Reported-by: syzbot+353be47c9ce21b68b7ed@syzkaller.appspotmail.com
> >Fixes: 2bef9aed6f0e ("usb: usbfs: correct kernel->user page attribute mismatch")
> >
> >------------[ cut here ]------------
> >memtype_reserve failed: [mem 0xffffffffff000-0x00008fff], req write-back
> >WARNING: CPU: 1 PID: 7025 at arch/x86/mm/pat/memtype.c:589 memtype_reserve+0x69f/0x820 arch/x86/mm/pat/memtype.c:589
> >Kernel panic - not syncing: panic_on_warn set ...
> >CPU: 1 PID: 7025 Comm: syz-executor254 Not tainted 5.7.0-rc4-syzkaller #0
> >Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> >Call Trace:
> > __dump_stack lib/dump_stack.c:77 [inline]
> > dump_stack+0x188/0x20d lib/dump_stack.c:118
> > panic+0x2e3/0x75c kernel/panic.c:221
> > __warn.cold+0x2f/0x35 kernel/panic.c:582
> > report_bug+0x27b/0x2f0 lib/bug.c:195
> > fixup_bug arch/x86/kernel/traps.c:175 [inline]
> > fixup_bug arch/x86/kernel/traps.c:170 [inline]
> > do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
> > do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> > invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> >RIP: 0010:memtype_reserve+0x69f/0x820 arch/x86/mm/pat/memtype.c:589
> >Code: 48 8b 2c ed c0 00 29 88 e8 ae ad 3e 00 48 8d 4b ff 49 89 e8 4c 89 e2 48 c7 c6 20 01 29 88 48 c7 c7 80 f9 28 88 e8 79 e8 0f 00 <0f> 0b 41 bf ea ff ff ff e9 03 fc ff ff 41 bf ea ff ff ff e9 f8 fb
> >RSP: 0018:ffffc900015e7790 EFLAGS: 00010282
> >RAX: 0000000000000000 RBX: 0000000000009000 RCX: 0000000000000000
> >RDX: 0000000000000000 RSI: ffffffff815ce181 RDI: fffff520002bcee4
> >RBP: ffffffff8828ff40 R08: ffff888097ce85c0 R09: ffffed1015ce45f1
> >R10: ffff8880ae722f83 R11: ffffed1015ce45f0 R12: 000ffffffffff000
> >R13: 1ffff920002bcef8 R14: dffffc0000000000 R15: 0000000000000000
> > reserve_pfn_range+0x173/0x470 arch/x86/mm/pat/memtype.c:941
> > track_pfn_remap+0x18b/0x280 arch/x86/mm/pat/memtype.c:1033
> > remap_pfn_range+0x202/0xbf0 mm/memory.c:2130
> > dma_direct_mmap+0x197/0x260 kernel/dma/direct.c:453
> > dma_mmap_attrs+0xfe/0x150 kernel/dma/mapping.c:237
> > usbdev_mmap+0x3ae/0x730 drivers/usb/core/devio.c:254
> > call_mmap include/linux/fs.h:1912 [inline]
> > mmap_region+0xafb/0x1540 mm/mmap.c:1772
> > do_mmap+0x849/0x1160 mm/mmap.c:1545
> > do_mmap_pgoff include/linux/mm.h:2553 [inline]
> > vm_mmap_pgoff+0x197/0x200 mm/util.c:506
> > ksys_mmap_pgoff+0x457/0x5b0 mm/mmap.c:1595
> > do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
> > do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
> > entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
> 
> Add check of physical address and boundary.
> 
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -447,6 +447,7 @@ int dma_direct_mmap(struct device *dev,
>  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	unsigned long pfn = PHYS_PFN(dma_to_phys(dev, dma_addr));
>  	int ret = -ENXIO;
> +	unsigned long pa;
>  
>  	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
>  
> @@ -455,6 +456,13 @@ int dma_direct_mmap(struct device *dev,
>  
>  	if (vma->vm_pgoff >= count || user_count > count - vma->vm_pgoff)
>  		return -ENXIO;
> +	if (pfn > pfn + vma->vm_pgoff)
> +		return -ENXIO;
> +	pa = (pfn + vma->vm_pgoff) << PAGE_SHIFT;
> +	if (pa < (pfn << PAGE_SHIFT))
> +		return -ENXIO;
> +	if (pa > pa + (user_count << PAGE_SHIFT))
> +		return -ENXIO;
>  	return remap_pfn_range(vma, vma->vm_start, pfn + vma->vm_pgoff,
>  			user_count << PAGE_SHIFT, vma->vm_page_prot);


Isn't there some sort of "check mmap parms" function somewhere that
should do this logic all in one place?  Putting it all over the kernel
feels wrong to me...

thanks,

greg k-h
