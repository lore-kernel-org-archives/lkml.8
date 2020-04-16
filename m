Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A27C3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C7520737
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwe0Vw3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732909AbgDPCXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731031AbgDPCXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:23:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:23:08 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s9so155026eju.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtplZXDZUCwzEnV8X/3dSx8FEedlAVQg4boarhoDh04=;
        b=bwe0Vw3VArX62TgjrvU8Fh77fm06SdT16iWG/8aI7WTgEIaYYqaDYYdScO81DO+fpK
         mH9SC+qkQEiPAdhocSHrwMrUnFKLmPRC8K5fdFsJvw4Ggkrblnkvo+RN5FlOhh/A3OXk
         MBnsysLVvdsXRQQzJAI+XdM5v18qBdla/g6XWngr0d+F/i3VH3y6yE+50tBSkLCHToTO
         djhOSiVWuMr5KT346Lf1llmoAw+2Wuzxr7JFBzW/Qhhv376L5Ow0g6SKM8e0EMVssx0G
         2sHRlycLi/+hM6tpIFchSavF0r8m5iYGH6oM68OwSNdcgmNLTxGfe+HC2evh2CHRZjlN
         spbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtplZXDZUCwzEnV8X/3dSx8FEedlAVQg4boarhoDh04=;
        b=Iad8fnQ8NatH4XCht5375gCJA1XydTShaER0MV8lZNZ7tp2rM4nMUwJmYxW03N4ChG
         mCerUbfLBEU69SAXU4VTjPnXGUDyCvi97nzxS22krOlPOjBEPasAuIoroZgGhLOsUlMu
         MftamZ0avNuG+wrGlvG2RgdAqIWrmzZaLPlvYRuvDFtaPd8FFy4uUB8pePKl2v8Hkvtx
         8q6ZmcPm5Z9bs4YdWNkAn1RBzpM2Ve80C9FaMl+/k8HMYr//cBhtjwawhR/BSEDOv6yR
         dSJE5PthBr/yEI5wWanIZNR2Uh0gB4HuYaqeJesc7l0EiOian9sApQg8hZB9d0cqmFDP
         STwQ==
X-Gm-Message-State: AGi0PuZB+lALv4T5F3aZbG4o0l/1l16ZIMn1Mp/VzP6vacUiGbnGTdgo
        LqYw7fImXe+7FBmH4OPu1cLTTMueHFzBUY8Z0fQ=
X-Google-Smtp-Source: APiQypKQLDQm//wlhKhDfnLbV2Q7gFE6oZMcleTwlmpVn5sjjYzf0CIqQb0qZXsfjW++lRO1RPO7rAZrL7b0z/E682s=
X-Received: by 2002:a17:906:69d1:: with SMTP id g17mr7562255ejs.32.1587003787523;
 Wed, 15 Apr 2020 19:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000571acf05a229cb2f@google.com> <CAHbLzkoTC3WoNa-dLBBmi15oBRXNbJzJuS6-GPr8XPWiHrgO4A@mail.gmail.com>
 <alpine.LSU.2.11.2004151808370.12919@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2004151808370.12919@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Apr 2020 19:22:55 -0700
Message-ID: <CAHbLzkqESnh2JNe5CuiH8QjUOskDEihZUXumLAkpLXoa3uvdsg@mail.gmail.com>
Subject: Re: possible deadlock in shmem_mfill_atomic_pte
To:     Hugh Dickins <hughd@google.com>
Cc:     syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 6:27 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Mon, 13 Apr 2020, Yang Shi wrote:
> > On Tue, Mar 31, 2020 at 10:21 AM syzbot
> > <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    527630fb Merge tag 'clk-fixes-for-linus' of git://git.kern..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1214875be00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=e27980339d305f2dbfd9
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > >
> > > Unfortunately, I don't have any reproducer for this crash yet.
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com
> > >
> > > WARNING: possible irq lock inversion dependency detected
> > > 5.6.0-rc7-syzkaller #0 Not tainted
> > > --------------------------------------------------------
> > > syz-executor.0/10317 just changed the state of lock:
> > > ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > > ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
> > > but this lock was taken by another, SOFTIRQ-safe lock in the past:
> > >  (&(&xa->xa_lock)->rlock#5){..-.}
> > >
> > >
> > > and interrupts could create inverse lock ordering between them.
> > >
> > >
> > > other info that might help us debug this:
> > >  Possible interrupt unsafe locking scenario:
> > >
> > >        CPU0                    CPU1
> > >        ----                    ----
> > >   lock(&(&info->lock)->rlock);
> > >                                local_irq_disable();
> > >                                lock(&(&xa->xa_lock)->rlock#5);
> > >                                lock(&(&info->lock)->rlock);
> > >   <Interrupt>
> > >     lock(&(&xa->xa_lock)->rlock#5);
> > >
> > >  *** DEADLOCK ***
> >
> > This looks possible. shmem_mfill_atomic_pte() acquires info->lock with
> > irq enabled.
> >
> > The below patch should be able to fix it:
>
> I agree, thank you: please send to akpm with your signoff and
>
> Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com
> Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
> Acked-by: Hugh Dickins <hughd@google.com>
>
> I bet that 4.11 commit was being worked on before 4.8 reversed the
> ordering of info->lock and tree_lock, changing spin_lock(&info->lock)s
> to spin_lock_irq*(&info->lock)s - this one is the only hold-out; and
> not using userfaultfd, I wouldn't have seen the lockdep report.

Thanks, Hugh. I believe this commit could fix the splat. I'm trying to
push my test tree to github to let syzkaller test it. I will send the
formal patch once I get it tested. It is just slow to push to github,
less than 50KB/s...


>
> >
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index d722eb8..762da6a 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2399,11 +2399,11 @@ static int shmem_mfill_atomic_pte(struct
> > mm_struct *dst_mm,
> >
> >         lru_cache_add_anon(page);
> >
> > -       spin_lock(&info->lock);
> > +       spin_lock_irq(&info->lock);
> >         info->alloced++;
> >         inode->i_blocks += BLOCKS_PER_PAGE;
> >         shmem_recalc_inode(inode);
> > -       spin_unlock(&info->lock);
> > +       spin_unlock_irq(&info->lock);
> >
> >         inc_mm_counter(dst_mm, mm_counter_file(page));
> >         page_add_file_rmap(page, false);
