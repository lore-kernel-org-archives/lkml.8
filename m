Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E63C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CF420768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584526017;
	bh=6WIINnc7nl3aVczc8aCkG1HjezohYwjajCACoP0moJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uubgmMTSMWbr1nidGDxTL6HXnhVEAcxHr0ypbPBN5xxegE+1uXyxQhb5fwiqwDQEa
	 3opPw3/UIHChtrG82DJn9PM2FzT9TDRvCQj2lPlDTEgeREgYjULBK7v+fTuu0HIib7
	 RuXqe3bVPVXTiOGeYga1rc3kB7vMFiDoADt3Gt6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgCRKG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgCRKGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:06:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D63120767;
        Wed, 18 Mar 2020 10:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584526013;
        bh=6WIINnc7nl3aVczc8aCkG1HjezohYwjajCACoP0moJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GuyTmsGRIrX7gu9FqdIKPsNn76wmveaDRrE3dK1vcvcEgALr6exgaV2mgPz5tR9kD
         KPce2hmLfoPTRSAmSCY8AJUiD3JG7F3wSincz+xohMp6Ety7uGpcDXfE0yE7tGZpZ+
         hybhUl7GWWrUvxCVBV9WetHzjyzrJqh2fouMtpdc=
Date:   Wed, 18 Mar 2020 11:06:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a58bfd517766aef83043@syzkaller.appspotmail.com>,
        dmitry.torokhov@gmail.com, jslaby@suse.com,
        linux-kernel@vger.kernel.org, rei4dan@gmail.com, slyfox@gentoo.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in vt_do_kdgkb_ioctl
Message-ID: <20200318100650.GB2044908@kroah.com>
References: <000000000000d18d83059f4ed9ad@google.com>
 <20200224130028.13976-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224130028.13976-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:00:28PM +0800, Hillf Danton wrote:
> 
> On Mon, 24 Feb 2020 01:18:14 -0800
> > syzbot found the following crash on:
> > 
> > HEAD commit:    54dedb5b Merge tag 'for-linus-5.6-rc3-tag' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=100403d9e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a58bfd517766aef83043
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a58bfd517766aef83043@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in vt_do_kdgkb_ioctl+0xb24/0xb50 drivers/tty/vt/keyboard.c:2025
> > Read of size 1 at addr ffff8880a4a8c801 by task syz-executor.4/27890
> > 
> > CPU: 1 PID: 27890 Comm: syz-executor.4 Not tainted 5.6.0-rc2-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x197/0x210 lib/dump_stack.c:118
> >  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
> >  __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
> >  kasan_report+0x12/0x20 mm/kasan/common.c:641
> >  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
> >  vt_do_kdgkb_ioctl+0xb24/0xb50 drivers/tty/vt/keyboard.c:2025
> >  vt_ioctl+0x47e/0x26c0 drivers/tty/vt/vt_ioctl.c:549
> >  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x123/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x45c429
> > Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f0f2868cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f0f2868d6d4 RCX: 000000000045c429
> > RDX: 0000000020000200 RSI: 0000000000004b48 RDI: 0000000000000003
> > RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 000000000000041a R14: 00000000004c676d R15: 000000000076bf2c
> > 
> > Allocated by task 1548:
> >  save_stack+0x23/0x90 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  __kasan_kmalloc mm/kasan/common.c:515 [inline]
> >  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
> >  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
> >  __do_kmalloc mm/slab.c:3656 [inline]
> >  __kmalloc+0x163/0x770 mm/slab.c:3665
> >  kmalloc include/linux/slab.h:560 [inline]
> >  vt_do_kdgkb_ioctl+0x3d1/0xb50 drivers/tty/vt/keyboard.c:2078
> >  vt_ioctl+0x47e/0x26c0 drivers/tty/vt/vt_ioctl.c:549
> >  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x123/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > Freed by task 27892:
> >  save_stack+0x23/0x90 mm/kasan/common.c:72
> >  set_track mm/kasan/common.c:80 [inline]
> >  kasan_set_free_info mm/kasan/common.c:337 [inline]
> >  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
> >  kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
> >  __cache_free mm/slab.c:3426 [inline]
> >  kfree+0x10a/0x2c0 mm/slab.c:3757
> >  vt_do_kdgkb_ioctl+0x5b4/0xb50 drivers/tty/vt/keyboard.c:2104
> >  vt_ioctl+0x47e/0x26c0 drivers/tty/vt/vt_ioctl.c:549
> >  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x123/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > The buggy address belongs to the object at ffff8880a4a8c800
> >  which belongs to the cache kmalloc-1k of size 1024
> > The buggy address is located 1 bytes inside of
> >  1024-byte region [ffff8880a4a8c800, ffff8880a4a8cc00)
> > The buggy address belongs to the page:
> > page:ffffea000292a300 refcount:1 mapcount:0 mapping:ffff8880aa400c40 index:0x0
> > flags: 0xfffe0000000200(slab)
> > raw: 00fffe0000000200 ffffea00026aa6c8 ffffea000210b1c8 ffff8880aa400c40
> > raw: 0000000000000000 ffff8880a4a8c000 0000000100000002 0000000000000000
> > page dumped because: kasan: bad access detected
> > 
> > Memory state around the buggy address:
> >  ffff8880a4a8c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> >  ffff8880a4a8c780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> > >ffff8880a4a8c800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >                    ^
> >  ffff8880a4a8c880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >  ffff8880a4a8c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> > ==================================================================
> 
> Allocate a tmp buf for duplicating the string under lock and use it
> outside lock.
> 
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1995,7 +1995,7 @@ int vt_do_kdgkb_ioctl(int cmd, struct kb
>  	int delta;
>  	char *first_free, *fj, *fnw;
>  	int i, j, k;
> -	int ret;
> +	int ret = 0;
>  	unsigned long flags;
>  
>  	if (!capable(CAP_SYS_TTY_CONFIG))
> @@ -2021,18 +2021,45 @@ int vt_do_kdgkb_ioctl(int cmd, struct kb
>  						  a struct member */
>  		up = user_kdgkb->kb_string;
>  		p = func_table[i];
> -		if(p)
> +		if (p) {
> +			char *tmp_buf = kzalloc(sz + 1, GFP_KERNEL);
> +
> +			if (!tmp_buf) {
> +				ret = -ENOMEM;
> +				goto reterr;
> +			}
> +
> +			spin_lock_irqsave(&func_buf_lock, flags);
> +			p = func_table[i];
> +			if (p) {
> +				__kernel_size_t len = strlen(p);
> +				if (sz < len) {
> +					ret = -EOVERFLOW;
> +					p = NULL;
> +				} else {
> +					memcpy(tmp_buf, p, len);
> +					p = tmp_buf;
> +				}
> +			}
> +			spin_unlock_irqrestore(&func_buf_lock, flags);
> +			if (!p)
> +				goto free_buf;
> +
>  			for ( ; *p && sz; p++, sz--)
>  				if (put_user(*p, up++)) {
>  					ret = -EFAULT;
> -					goto reterr;
> +					goto free_buf;
>  				}
> -		if (put_user('\0', up)) {
> -			ret = -EFAULT;
> -			goto reterr;
> +
> +free_buf:
> +			kfree(tmp_buf);
> +			if (ret)
> +				goto reterr;
>  		}
> -		kfree(kbs);
> -		return ((p && *p) ? -EOVERFLOW : 0);
> +
> +		if (put_user('\0', up))
> +			ret = -EFAULT;
> +		goto reterr;
>  	case KDSKBSENT:
>  		if (!perm) {
>  			ret = -EPERM;
> 

What ever happened to this?  Did it fix the issue?  If so, can you
resend this as a "real" patch I can apply?

thanks,

greg k-h
