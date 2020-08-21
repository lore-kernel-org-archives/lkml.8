Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7176C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D83E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXSykjDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgHURQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgHURP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:15:59 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388BC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:15:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so3156347eje.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLhv+dlgRulyMUTYR7EluA/fm0+WWZQOVaVRuB116Jk=;
        b=aXSykjDcDV9xi4VkacL6aS3kw4HeyODNxJATMu3pAw4xqmgoKpfND2vrbAaHUFRCu9
         9fq6AsbBaIOOs2mF6oVjHHv13QfO8HHrvG+mB0hap7tYEKQXAtZ7yGcPT6lJuZHZVqFX
         SX+OkDYD8Gpl84Lzf691f0UsiDT/JRlbeR4AYypnUb4ijGkFgCujXb4F5ZgfFgmqWews
         6FLiUlW/TQy8jSW+EQB2HYS1bUJ4FpH2B6jbFxdxqvl3rZAy/agUPBz/mjzhIlglAMOG
         HTaZU/++bSWtT6HK9c14W1ex9xTZ7SY4l+2EGMTS9xeC8ayRb3z48vcme9m+NkPM2oeY
         1NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLhv+dlgRulyMUTYR7EluA/fm0+WWZQOVaVRuB116Jk=;
        b=bDTAjgfPxSwczV2qD9SQArAyB5sIb0wnRM3ZNzLq5L31ilCsZI0x8LCUSoTttItNhh
         2J1DcLh24C9b7Z6iUQ6QQT/EMxwsLfo8V3WxCB9+MZkpAvu3/+1dUiGlEdSZLDYGhLCN
         ygkdI4stwZHJqu6olN0SxLKIRJkpK4wT3WbsQzJHGo/xdfUW9L080HVGv2nmX7FOl3He
         MlhzosMrOCudXa20lsp7TFuCJBWm55m7amBtpFbKUN4+U+ybg/vbfVSrDzEgKhCQQoQv
         53q0qrNMSFKxqcVjk84tculc1sq6maZPyupY3uhYX97TaqIp6NhbS5xxKWeGWSUamX80
         Y9eA==
X-Gm-Message-State: AOAM5338/JJa37oli3lNmgCrlzuSX/G9nKEHF/ybycJiayNo1QnZm9x0
        dVjcObcAKApOqXRr+MvtHWiA9EE76+zbTdz1Tn4=
X-Google-Smtp-Source: ABdhPJySpsAZCPPP42VmuygeG2Mfi6X5G6fsKlU35JADIUTD5pa6p3C2PactC/a+5Est4t2zg0G6AA0trYMb7mAsZPo=
X-Received: by 2002:a17:906:7291:: with SMTP id b17mr3770259ejl.25.1598030157296;
 Fri, 21 Aug 2020 10:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e44b7d05ad6624df@google.com>
In-Reply-To: <000000000000e44b7d05ad6624df@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 21 Aug 2020 10:15:45 -0700
Message-ID: <CAHbLzkqM-x0aD59z0mFRW37JsxRPL+5xKRRfU1qY18LKksQ3ZQ@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in do_madvise
To:     syzbot <syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:06 AM syzbot
<syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    da2968ff Merge tag 'pci-v5.9-fixes-1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1339995a900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a0437fdd630bee11
> dashboard link: https://syzkaller.appspot.com/bug?extid=b90df26038d1d5d85c97
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1225d919900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b90df26038d1d5d85c97@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: use-after-free in madvise_willneed mm/madvise.c:293 [inline]
> BUG: KASAN: use-after-free in madvise_vma mm/madvise.c:942 [inline]
> BUG: KASAN: use-after-free in do_madvise.part.0+0x1c8b/0x1cf0 mm/madvise.c:1145
> Read of size 8 at addr ffff8880a6163eb0 by task syz-executor.0/9996
>
> CPU: 0 PID: 9996 Comm: syz-executor.0 Not tainted 5.9.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
>  madvise_willneed mm/madvise.c:293 [inline]
>  madvise_vma mm/madvise.c:942 [inline]
>  do_madvise.part.0+0x1c8b/0x1cf0 mm/madvise.c:1145
>  do_madvise mm/madvise.c:1169 [inline]
>  __do_sys_madvise mm/madvise.c:1171 [inline]
>  __se_sys_madvise mm/madvise.c:1169 [inline]
>  __x64_sys_madvise+0xd9/0x110 mm/madvise.c:1169
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45d4d9
> Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f04f7464c78 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
> RAX: ffffffffffffffda RBX: 0000000000020800 RCX: 000000000045d4d9
> RDX: 0000000000000003 RSI: 0000000000600003 RDI: 0000000020000000
> RBP: 000000000118d020 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cfec
> R13: 00007ffc579cce7f R14: 00007f04f74659c0 R15: 000000000118cfec
>
> Allocated by task 9992:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
>  kasan_set_track mm/kasan/common.c:56 [inline]
>  __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
>  slab_post_alloc_hook mm/slab.h:518 [inline]
>  slab_alloc mm/slab.c:3312 [inline]
>  kmem_cache_alloc+0x138/0x3a0 mm/slab.c:3482
>  vm_area_alloc+0x1c/0x110 kernel/fork.c:347
>  mmap_region+0x8e5/0x1780 mm/mmap.c:1743
>  do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
>  vm_mmap_pgoff+0x195/0x200 mm/util.c:506
>  ksys_mmap_pgoff+0x43a/0x560 mm/mmap.c:1596
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Freed by task 9992:
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
>  kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
>  kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
>  __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
>  __cache_free mm/slab.c:3418 [inline]
>  kmem_cache_free.part.0+0x67/0x1f0 mm/slab.c:3693
>  remove_vma+0x132/0x170 mm/mmap.c:184
>  remove_vma_list mm/mmap.c:2613 [inline]
>  __do_munmap+0x743/0x1170 mm/mmap.c:2869
>  do_munmap mm/mmap.c:2877 [inline]
>  mmap_region+0x257/0x1780 mm/mmap.c:1716
>  do_mmap+0xcf9/0x11d0 mm/mmap.c:1545
>  vm_mmap_pgoff+0x195/0x200 mm/util.c:506
>  ksys_mmap_pgoff+0x43a/0x560 mm/mmap.c:1596
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

It looks the vma is gone. The below patch should be able to fix it:

diff --git a/mm/madvise.c b/mm/madvise.c
index dd1d43cf026d..d4aa5f776543 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -289,9 +289,9 @@ static long madvise_willneed(struct vm_area_struct *vma,
         */
        *prev = NULL;   /* tell sys_madvise we drop mmap_lock */
        get_file(file);
-       mmap_read_unlock(current->mm);
        offset = (loff_t)(start - vma->vm_start)
                        + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+       mmap_read_unlock(current->mm);
        vfs_fadvise(file, offset, end - start, POSIX_FADV_WILLNEED);
        fput(file);
        mmap_read_lock(current->mm);

>
> The buggy address belongs to the object at ffff8880a6163eb0
>  which belongs to the cache vm_area_struct of size 200
> The buggy address is located 0 bytes inside of
>  200-byte region [ffff8880a6163eb0, ffff8880a6163f78)
> The buggy address belongs to the page:
> page:00000000dc1e014c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xa6163
> flags: 0xfffe0000000200(slab)
> raw: 00fffe0000000200 ffffea0002494bc8 ffffea0002a5ad88 ffff8880aa06f500
> raw: 0000000000000000 ffff8880a6163040 000000010000000f 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8880a6163d80: fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00 00
>  ffff8880a6163e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc
> >ffff8880a6163e80: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
>                                      ^
>  ffff8880a6163f00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
>  ffff8880a6163f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
