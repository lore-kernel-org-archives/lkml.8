Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87DCC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41AF20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIe3CrdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730740AbgIJCQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730727AbgIJCNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:13:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E42C06179B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 19:13:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b19so6079132lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 19:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAf45icwjNOzKO8vWI2LHCwX/2UF3WrwLeQVnFDm+7g=;
        b=bIe3CrdTeHry1nHBxlH/HKBpIvPq/OGD2pRUgFTD4qzxop7bGp2BzL7inasxrZxkNR
         9fDSOjKoXAnw7BnhBbUgB4eqZ1vzFwY3HksJk36F7DZfo6/RoZvw1fGqU5ko8mrA5Wxs
         xeDpQDcRzojFsRKiZDZrZVEFAM+fboU7gCTlp2bGhrSr9V9LnGWiv+9Q3FAFVJ5pn7Uq
         7Nb1+Vy+pL9V8yW50q4efTvYLdlG7XkiebaKkeuFiY6PPvL2mJ1x5DI2sPyle7WeoZRS
         kydxymov1ybKtQiOW3c5p5IdmhKN2XmqBe/q1/IJBMtFoJmJ/rd8u6LoB2eZGkgfearl
         yFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAf45icwjNOzKO8vWI2LHCwX/2UF3WrwLeQVnFDm+7g=;
        b=eLYkqOL8WU0pGxrZYdZApmXnP9KKgOsYad81lFGdGjwphayIk5qR3p2WTpLQOjwcWD
         SG+4kaYuWWNNpdrirwqBcdcdZl02ys5XDf6+wJpxYhNB+G0FQRwJ1TC7NmKjkhYNBtFF
         Cbw0rgK/pPD8TEPMKyaSTQ8DecAS5TSqiX/GaLjgtghmjfd+0KMYt2fQWDvAC2rjenEx
         4VPl7bYKiyU7F17n+yOjoLM9ujs99VdGW6NNXsDPtbQoOWF77NrInzHXza5JEuITXHyq
         AYpfBxCz7EL1GWT/qi20o6guX2j25KIgohmCOv0LG/NfKQ2EKlJjMRmqi04citepNy9u
         Ml0g==
X-Gm-Message-State: AOAM532UANsrR+TM1JcKx1uSmQelhDveD0HyT+wEl7mSSdGGbxWhmcwv
        wbJBrgDPa3Bi2JMB5cew4oXX9/8jr4jnG4QLRS2vwngGlE8=
X-Google-Smtp-Source: ABdhPJzpxXgZOj5s5L1QGqK6o+SSJpb1iwH2Znu6iaSTJZr4KpEwkxoIpyHuqjeJAR/FpXmPveywNOiq1lXI519WcXU=
X-Received: by 2002:a05:651c:2c9:: with SMTP id f9mr3113764ljo.257.1599704033068;
 Wed, 09 Sep 2020 19:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f7793505aed666dc@google.com> <20200909041537.19628-1-hdanton@sina.com>
In-Reply-To: <20200909041537.19628-1-hdanton@sina.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 10 Sep 2020 07:43:41 +0530
Message-ID: <CAFqt6zZPm=MRfYVMEZMv3KPKmxxJW=vPEWhhXbKKJ7t1tDNgPA@mail.gmail.com>
Subject: Re: general protection fault in unlink_file_vma
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hiff,

On Wed, Sep 9, 2020 at 9:45 AM Hillf Danton <hdanton@sina.com> wrote:
>
>
> Tue, 08 Sep 2020 17:19:17 -0700
> > syzbot found the following issue on:
> >
> > HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1166cb5d900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3c5f6ce8d5b68299
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c5d5a51dcbb558ca0cb5
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11901e95900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15f56195900000
> >
> > Bisection is inconclusive: the issue happens on the oldest tested release.
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1205faed900000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1105faed900000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1605faed900000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com
> >
> > general protection fault, probably for non-canonical address 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: maybe wild-memory-access in range [0x00777770000001d8-0x00777770000001df]
> > CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 5.9.0-rc3-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:unlink_file_vma+0x57/0xb0 mm/mmap.c:164
> > Code: 4c 8b a5 a0 00 00 00 4d 85 e4 74 4e e8 92 d7 cd ff 49 8d bc 24 d8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 3d 4d 8b b4 24 d8 01 00 00 4d 8d 6e 78 4c 89 ef e8
> > RSP: 0018:ffffc9000ac0f9b0 EFLAGS: 00010202
> > RAX: dffffc0000000000 RBX: ffff88800010ceb0 RCX: ffffffff81592421
> > RDX: 000eeeee0000003b RSI: ffffffff81a6736e RDI: 00777770000001d8
> > RBP: ffff88800010ceb0 R08: 0000000000000001 R09: ffff88801291a50f
> > R10: ffffed10025234a1 R11: 0000000000000001 R12: 0077777000000000
> > R13: 00007f1eea0da000 R14: 00007f1eea0d9000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f1eea11a9d0 CR3: 000000000007e000 CR4: 00000000001506e0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  free_pgtables+0x1b3/0x2f0 mm/memory.c:415
> >  exit_mmap+0x2c0/0x530 mm/mmap.c:3184
> >  __mmput+0x122/0x470 kernel/fork.c:1076
> >  mmput+0x53/0x60 kernel/fork.c:1097
> >  exit_mm kernel/exit.c:483 [inline]
> >  do_exit+0xa8b/0x29f0 kernel/exit.c:793
> >  do_group_exit+0x125/0x310 kernel/exit.c:903
> >  get_signal+0x428/0x1f00 kernel/signal.c:2757
> >  arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
> >  exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
> >  exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
> >  syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Looks like d70cec898324 ("mm: mmap: merge vma after call_mmap() if possible")
> added an extra fput.

Can you please help me to understand how do you figure out this commit ?
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1781,7 +1781,6 @@ unsigned long mmap_region(struct file *f
>                         merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
>                                 NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
>                         if (merge) {
> -                               fput(file);
>                                 vm_area_free(vma);
>                                 vma = merge;
>                                 /* Update vm_flags and possible addr to pick up the change. We don't
>
>
