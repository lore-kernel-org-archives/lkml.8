Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D65C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E080020725
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dFuhPIKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgDPCEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728397AbgDPCEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:04:00 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C209C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:04:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so1783268otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=WUOdBHVjTYSAdHEkzTfIK+cQNyJIvAhfkkqze9Y3vHY=;
        b=dFuhPIKF68NNEtuqTBL5h6FNtryPc7t+6DAdUlHMtza7uJ0lRStsOHpmMu2bth4kbg
         EoLKBlW00QfAXI9xwv5Uba5MgnBSFpa2S12qa3l5NWosBUseQPZ4CMntQhK8OZpDnpjR
         xC6WFPWIVmL9FYv1TmGjK99eXmZOYJgFoGzVl2CkW3VtnvHf09jWjFE3x+q84wf0xkKb
         Cdc4s1FVZGiKG/ePW971uFULtyONT0W5mZKaEvAa3YfXg09Aw2nr2y+kQAjd6uz8Xmwu
         h+AaE0g4c9LYi3y29ho6N/YgqTrMrDU82FapTLDMsqqEQh/2WDj/HK9IAhsa3Ny7hgvl
         b9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=WUOdBHVjTYSAdHEkzTfIK+cQNyJIvAhfkkqze9Y3vHY=;
        b=QOn6PYqX+KBZU/qhBpwJ7dR3zIci+K421O+GJiSCSBC7/XI8xJPRopELx4HvSzhQET
         GrrO4dcEOKCcNALL5b6AZb+evLf2UUHj3Mx2VWAgyc8hTe2xP2frMUPOhGlLvjCeSqf5
         fMfKmSxRQJK8opjL3Hw3oJO+oWM/t0xXkC1GBuYOCN8r7tN+WpzMCIKYJ94RTJBWo6/7
         B3r2cj9nmIB/idy5jaRS8urR7ITKEcjpp8Z6yr5vMABU/argUHlntsYc+PTracoWA3hr
         hknlvasbSscz5R0Zs1V3fazdvAJPCExEfutOc4TLSWQRDtY6bYyf1STOP+4K1gwaA2I/
         7bqw==
X-Gm-Message-State: AGi0PuZq/IWtUWkjzOtj7xB0arZAHS6c6ECNefPRFbpS1irp+Z0ItCzD
        AQHyG7cSop4q0Me6IXisDdZEhA==
X-Google-Smtp-Source: APiQypI5I024fVI+5QUPWnaypCmcRINpmltlMJymdc1sEELchumFcKCJnzObCJmn4NWDBztKx9JyXQ==
X-Received: by 2002:a9d:620c:: with SMTP id g12mr30601otj.158.1587002639307;
        Wed, 15 Apr 2020 19:03:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id v15sm7492966ook.37.2020.04.15.19.03.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2020 19:03:58 -0700 (PDT)
Date:   Wed, 15 Apr 2020 19:03:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     syzbot <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible deadlock in shmem_uncharge
In-Reply-To: <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2004151828350.12919@eggly.anvils>
References: <000000000000e5838c05a3152f53@google.com> <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Yang Shi wrote:
> On Sun, Apr 12, 2020 at 3:11 AM syzbot
> <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ae46d2aa mm/gup: Let __get_user_pages_locked() return -EIN..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14a30a77e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=ca75979eeebf06c2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c8a8197c8852f566b9d9
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15f5632be00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132ade57e00000
> >
> > The bug was bisected to:
> >
> > commit 71725ed10c40696dc6bdccf8e225815dcef24dba
> > Author: Hugh Dickins <hughd@google.com>
> > Date:   Tue Apr 7 03:07:57 2020 +0000
> >
> >     mm: huge tmpfs: try to split_huge_page() when punching hole
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120a752be00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=110a752be00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=160a752be00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com
> > Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")

No, that commit just gave syzkaller an easier way to reach old code.

> >
> > =====================================================
> > WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> > 5.6.0-syzkaller #0 Not tainted
> > -----------------------------------------------------
> > syz-executor428/8337 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
> > ffff8880a851c778 (&info->lock){....}-{2:2}, at: shmem_uncharge+0x24/0x270 mm/shmem.c:341
> >
> > and this task is already holding:
> > ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: spin_lock include/linux/spinlock.h:353 [inline]
> > ffff8880a851cac8 (&xa->xa_lock#4){..-.}-{2:2}, at: split_huge_page_to_list+0xad0/0x33b0 mm/huge_memory.c:2864
> > which would create a new lock dependency:
> >  (&xa->xa_lock#4){..-.}-{2:2} -> (&info->lock){....}-{2:2}
> >
> > but this new dependency connects a SOFTIRQ-irq-safe lock:
> >  (&xa->xa_lock#4){..-.}-{2:2}
> 
> It looks shmem_uncharge() is just called by __split_huge_page() and
> collapse_file(). The collapse_file() has acquired xa_lock with irq
> disabled before acquiring info->lock, so it is safe.
> __split_huge_page() is called with holding xa_lock with irq enabled,
> but lru_lock is acquired with irq disabled before acquiring xa_lock.
> 
> So, it is unnecessary to acquire info->lock with irq disabled in
> shmem_uncharge(). Can syzbot try the below patch?

But I disagree with the patch below.  You're right that IRQ-disabling
here is unnecessary, given its two callers; but I'm not sure that we
want it to look different from shmem_charge() and all other info->lock
takers; and, more importantly, I don't see how removing the redundant
IRQ-saving below could make it any less liable to deadlock.

The crucial observation comes lower down
> > to a SOFTIRQ-irq-unsafe lock:
> >  (shmlock_user_lock){+.+.}-{2:2}
and there's another syzbot report that's come out on shmlock_user_lock,
"possible deadlock in user_shm_lock".

I believe all that's needed to fix both reports is not to use info->lock
in shmem_lock() - I see now that we saw lockdep reports of this kind
internally, a long time ago, and fixed them in that way.

(I haven't composed the patch and references yet, and not decided if
I'll add it here or there or separately. I'll put it together now.)

Hugh

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d722eb8..100117b 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -334,15 +334,14 @@ bool shmem_charge(struct inode *inode, long pages)
>  void shmem_uncharge(struct inode *inode, long pages)
>  {
>         struct shmem_inode_info *info = SHMEM_I(inode);
> -       unsigned long flags;
> 
>         /* nrpages adjustment done by __delete_from_page_cache() or caller */
> 
> -       spin_lock_irqsave(&info->lock, flags);
> +       spin_lock(&info->lock);
>         info->alloced -= pages;
>         inode->i_blocks -= pages * BLOCKS_PER_PAGE;
>         shmem_recalc_inode(inode);
> -       spin_unlock_irqrestore(&info->lock, flags);
> +       spin_unlock(&info->lock);
> 
>         shmem_inode_unacct_blocks(inode, pages);
>  }
