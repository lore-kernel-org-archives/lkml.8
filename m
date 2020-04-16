Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5BAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15B0720737
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcq+6btH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732675AbgDPCUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731550AbgDPCUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:20:44 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC26C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:20:44 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j15so151284ejt.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mgz6bbdQfDVz34mF8jJQbTz4t2DA1H3apdU+WrR+R7Y=;
        b=kcq+6btHmb01cooZ1xUD/y9he2yoQ4t039E5mbUs2BkDlGwudOwJ46xfNOzh91fJrK
         cnmTtdcKJzViFnX/YSyC9g9bK9fy8Z8mBpig5VPviP3O0Zu3fidj81rq0sr+yioLllzb
         i0WBaroEoibasQOLasvyihivuvKavssL5fbCXotGXqFAhNSQebmrLYTKDEJhq1tFswer
         bIju+QaB37x9zzyPDW3ziDpn6Vcjc+yqGwagc5mHDmumsjsCq2LWLOiHIGWCNJK/e9XN
         HEhNHRDuqbY/gV1KmAvZ4hcdQ6vjgXO+BOPkJzxiUZWd34mkQULMsJZcLrOOQFUb8lj0
         mqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mgz6bbdQfDVz34mF8jJQbTz4t2DA1H3apdU+WrR+R7Y=;
        b=G9TpeqDCygETTPMzADpIs11eN95EfcZnpMFjJwsl7WJAvprH5/fbxLuKWS6EUXzHcL
         8domHfslwl802lGUwZ6KmbiA4cuESnrMBfD7VaHXwWm6gT/AaObeW6oaPNKJPO4g75Lt
         58xprVb08WAPL3bUmQQppIKgcmk7xCg5ORtVScoqeCjtsAi/a2OtFTClchpFT32CXd0O
         ccW+na6r/gHoWdvftwvOEEdrSZdQdsTSr3SY5ATRQa6+/iaC4mZIVa6bOaXzVuBMD+SP
         ZhITNRlXHG3wfAkX9K1MW0bHCej3d1HGeiA5lxXVFwCykEp5tZAIXxBrzC8VKV9jqFVY
         mkjQ==
X-Gm-Message-State: AGi0PuY2EYT3ealHQsDGlKHd9/LdVoysYQgqqT87u6mhW1JF2EoiLtnN
        EgaXdYg6Z5JN2rAu+pu2G9pHhXvSt2p8tflKg1U=
X-Google-Smtp-Source: APiQypKpfYDVN5HQk19fsgn0mpfBch5zFFu+LfHUbVv1552Asb2QXRW/U8D7v+O1oz3x859kAMzRv1K1elyUAzZ6qy4=
X-Received: by 2002:a17:906:374b:: with SMTP id e11mr8047637ejc.283.1587003642849;
 Wed, 15 Apr 2020 19:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000e5838c05a3152f53@google.com> <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com>
 <alpine.LSU.2.11.2004151828350.12919@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2004151828350.12919@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Apr 2020 19:20:30 -0700
Message-ID: <CAHbLzko3sFuFC800Mv3b2BiKhaC56TpRri1VCEhKWZMwLBNd4Q@mail.gmail.com>
Subject: Re: possible deadlock in shmem_uncharge
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 7:04 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 13 Apr 2020, Yang Shi wrote:
> > On Sun, Apr 12, 2020 at 3:11 AM syzbot
> > <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    ae46d2aa mm/gup: Let __get_user_pages_locked() return -EIN..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=14a30a77e00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=c8a8197c8852f566b9d9
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5632be00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132ade57e00000
> > >
> > > The bug was bisected to:
> > >
> > > commit 71725ed10c40696dc6bdccf8e225815dcef24dba
> > > Author: Hugh Dickins <hughd@google.com>
> > > Date:   Tue Apr 7 03:07:57 2020 +0000
> > >
> > >     mm: huge tmpfs: try to split_huge_page() when punching hole
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120a752be00000
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=110a752be00000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=160a752be00000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com
> > > Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")
>
> No, that commit just gave syzkaller an easier way to reach old code.
>
> > >
> > > =====================================================
> > > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > > 5.6.0-syzkaller #0 Not tainted
> > > -----------------------------------------------------
> > > syz-executor428/8337 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > > ffff8880a851c778 (&info->lock){....}-{2:2}, at: shmem_uncharge+0x24/0x270 mm/shmem.c:341
> > >
> > > and this task is already holding:
> > > ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
> > > ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: split_huge_page_to_list+0xad0/0x33b0 mm/huge_memory.c:2864
> > > which would create a new lock dependency:
> > >  (&xa->xa_lock#4){..-.}-{2:2} -> (&info->lock){....}-{2:2}
> > >
> > > but this new dependency connects a SOFTIRQ-irq-safe lock:
> > >  (&xa->xa_lock#4){..-.}-{2:2}
> >
> > It looks shmem_uncharge() is just called by __split_huge_page() and
> > collapse_file(). The collapse_file() has acquired xa_lock with irq
> > disabled before acquiring info->lock, so it is safe.
> > __split_huge_page() is called with holding xa_lock with irq enabled,
> > but lru_lock is acquired with irq disabled before acquiring xa_lock.
> >
> > So, it is unnecessary to acquire info->lock with irq disabled in
> > shmem_uncharge(). Can syzbot try the below patch?
>
> But I disagree with the patch below.  You're right that IRQ-disabling
> here is unnecessary, given its two callers; but I'm not sure that we
> want it to look different from shmem_charge() and all other info->lock
> takers; and, more importantly, I don't see how removing the redundant
> IRQ-saving below could make it any less liable to deadlock.

Yes, I realized the patch can't suppress the lockdep splat. But,
actually I didn't understand how this deadlock could happen because
info_lock is acquired with IRQ disabled before acquiring
user_shm_lock. So, interrupt can't come in at all if I didn't miss
anything.

>
> The crucial observation comes lower down
> > > to a SOFTIRQ-irq-unsafe lock:
> > >  (shmlock_user_lock){+.+.}-{2:2}
> and there's another syzbot report that's come out on shmlock_user_lock,
> "possible deadlock in user_shm_lock".
>
> I believe all that's needed to fix both reports is not to use info->lock
> in shmem_lock() - I see now that we saw lockdep reports of this kind
> internally, a long time ago, and fixed them in that way.
>
> (I haven't composed the patch and references yet, and not decided if
> I'll add it here or there or separately. I'll put it together now.)
>
> Hugh
>
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index d722eb8..100117b 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -334,15 +334,14 @@ bool shmem_charge(struct inode *inode, long pages)
> >  void shmem_uncharge(struct inode *inode, long pages)
> >  {
> >         struct shmem_inode_info *info = SHMEM_I(inode);
> > -       unsigned long flags;
> >
> >         /* nrpages adjustment done by __delete_from_page_cache() or caller */
> >
> > -       spin_lock_irqsave(&info->lock, flags);
> > +       spin_lock(&info->lock);
> >         info->alloced -= pages;
> >         inode->i_blocks -= pages * BLOCKS_PER_PAGE;
> >         shmem_recalc_inode(inode);
> > -       spin_unlock_irqrestore(&info->lock, flags);
> > +       spin_unlock(&info->lock);
> >
> >         shmem_inode_unacct_blocks(inode, pages);
> >  }
