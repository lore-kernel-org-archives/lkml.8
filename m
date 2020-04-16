Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEA3C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C37932076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3Q4agCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgDPB1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731316AbgDPB1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:27:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17762C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:27:43 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j16so15288539oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=t2o9MD3Hx6j5/2C8h4jmxn6G4Qx8JbK6fPjj2wD7HKk=;
        b=v3Q4agCBYVmBhWbMuZkEpyPnLrtl6162KII7OlIrGBCXNS8obmeAAZ1YZ7ReQqgmwd
         CobR5EWoRPmEQOw1D32pdKHYow3Oql5QhZMPcaZcd9Ya7dzAmeuqesFd2QJD9hBTHAaF
         4aEn/iwDVdkAjjRh3O0zpvXWQlxr/9dOmLErzMqiKW0hGc1N9SRZv0n/N5Ha+3s9K3HT
         1JIdh/xFfiayvg43GtxopNevoehLA4e455U2OgRHw7YBwKsyaKhfepyz4Oypc6CZ6b27
         nbsQHeA5NmLgdldX8nf3hiZfZImCrXDNaDEOTjnpA+EGZwwtgMyQrqPs9sMX7W5HgxJm
         H1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=t2o9MD3Hx6j5/2C8h4jmxn6G4Qx8JbK6fPjj2wD7HKk=;
        b=aTdZ/nFqdiDJ9ZhOGcVITnq+/GJIBUTfhtOKUiQjwa4u0A8QrPNfhGlYT4HQYZFrJG
         iTQEMBs+mbMRZ8+NC98XEwIscaTRtzU81gyYC9oGat7WbwdVjFhkLZ+u13jMoqg2ZmK4
         rNkqL8bV2CHGADevgYHSVsMAESfmdBp/UCEeFDSuMr5YAEzE+osYnRrUAHWaH7KB0TQX
         eCqT3FLdyz3uA0zMX+ANdIwckLULYi38k/+93o7MH7rBXndPA4DA+LWsURNE+myeqJ7r
         EKW9UVDGWQdwpVdiOHNA0Ja/9wHiF7QDDlbZz/3fyMHZp/XJ19bo14WxUmCMJWIwaZdp
         Uodw==
X-Gm-Message-State: AGi0Pub8gGlcVDZMVYHIhvJIeK4YR7Q8qRReQCThQ5z/mZh2JDYq9qZm
        GDEROrcHHIP9O3N4LIOafXHDrg==
X-Google-Smtp-Source: APiQypJgoxdNGG4jKe0pEz+4YqDdo0x29qE5m4xUwSSF6eY4kYjKQwUA4IBCgVm07o6l4p/61kmcVQ==
X-Received: by 2002:aca:f50e:: with SMTP id t14mr1423038oih.156.1587000461949;
        Wed, 15 Apr 2020 18:27:41 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id o8sm3379889oom.34.2020.04.15.18.27.40
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2020 18:27:41 -0700 (PDT)
Date:   Wed, 15 Apr 2020 18:27:21 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     syzbot <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in shmem_mfill_atomic_pte
In-Reply-To: <CAHbLzkoTC3WoNa-dLBBmi15oBRXNbJzJuS6-GPr8XPWiHrgO4A@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2004151808370.12919@eggly.anvils>
References: <000000000000571acf05a229cb2f@google.com> <CAHbLzkoTC3WoNa-dLBBmi15oBRXNbJzJuS6-GPr8XPWiHrgO4A@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020, Yang Shi wrote:
> On Tue, Mar 31, 2020 at 10:21 AM syzbot
> <syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    527630fb Merge tag 'clk-fixes-for-linus' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1214875be00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=27392dd2975fd692
> > dashboard link: https://syzkaller.appspot.com/bug?extid=e27980339d305f2dbfd9
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com
> >
> > WARNING: possible irq lock inversion dependency detected
> > 5.6.0-rc7-syzkaller #0 Not tainted
> > --------------------------------------------------------
> > syz-executor.0/10317 just changed the state of lock:
> > ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: spin_lock include/linux/spinlock.h:338 [inline]
> > ffff888021d16568 (&(&info->lock)->rlock){+.+.}, at: shmem_mfill_atomic_pte+0x1012/0x21c0 mm/shmem.c:2407
> > but this lock was taken by another, SOFTIRQ-safe lock in the past:
> >  (&(&xa->xa_lock)->rlock#5){..-.}
> >
> >
> > and interrupts could create inverse lock ordering between them.
> >
> >
> > other info that might help us debug this:
> >  Possible interrupt unsafe locking scenario:
> >
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&(&info->lock)->rlock);
> >                                local_irq_disable();
> >                                lock(&(&xa->xa_lock)->rlock#5);
> >                                lock(&(&info->lock)->rlock);
> >   <Interrupt>
> >     lock(&(&xa->xa_lock)->rlock#5);
> >
> >  *** DEADLOCK ***
> 
> This looks possible. shmem_mfill_atomic_pte() acquires info->lock with
> irq enabled.
> 
> The below patch should be able to fix it:

I agree, thank you: please send to akpm with your signoff and

Reported-by: syzbot+e27980339d305f2dbfd9@syzkaller.appspotmail.com
Fixes: 4c27fe4c4c84 ("userfaultfd: shmem: add shmem_mcopy_atomic_pte for userfaultfd support")
Acked-by: Hugh Dickins <hughd@google.com>

I bet that 4.11 commit was being worked on before 4.8 reversed the
ordering of info->lock and tree_lock, changing spin_lock(&info->lock)s
to spin_lock_irq*(&info->lock)s - this one is the only hold-out; and
not using userfaultfd, I wouldn't have seen the lockdep report.

> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d722eb8..762da6a 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2399,11 +2399,11 @@ static int shmem_mfill_atomic_pte(struct
> mm_struct *dst_mm,
> 
>         lru_cache_add_anon(page);
> 
> -       spin_lock(&info->lock);
> +       spin_lock_irq(&info->lock);
>         info->alloced++;
>         inode->i_blocks += BLOCKS_PER_PAGE;
>         shmem_recalc_inode(inode);
> -       spin_unlock(&info->lock);
> +       spin_unlock_irq(&info->lock);
> 
>         inc_mm_counter(dst_mm, mm_counter_file(page));
>         page_add_file_rmap(page, false);
