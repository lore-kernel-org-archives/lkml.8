Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ACEC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F1120678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkWiRbRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgANKTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:19:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35293 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729346AbgANKTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:19:08 -0500
Received: by mail-qt1-f193.google.com with SMTP id e12so11974684qto.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 02:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+334OqhRdlueyXZAkDH6/dKZdqqueiUAbVLZW2hCYc=;
        b=OkWiRbRcJew3fm+UoFajqny1ZI7xifJZui7rmTFY7Ark3Nr02Wd+XXRWxCsK5pfk+d
         3OjBV2WrLUjfI0ici9Ystkcz9hH2pSv9M0E2PAuuWX2lAY56JgaXIap0+oW/QUknDTZh
         DsEepkDsk7gULTiKK+s05ujh4YlHjj4nFAVMVqyuUEesOMrV2xz+sNgXvjU/vmU9owLA
         Lz8GdfJHG83Jdh4Bil5LkQtMn9yDtfEuGB/KImS1b27dHK4lbLc3ZAEZCP9e7rSE+XPH
         9psXzTWB7D40EWBTomLZpzuQr/5mIdu6da8zePON3rMgKEUU3Uv2ijP7cQK4116jphwj
         ynHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x+334OqhRdlueyXZAkDH6/dKZdqqueiUAbVLZW2hCYc=;
        b=f5VWdQpLoAkunyXzx7RxNfrJiGcik6Md63oXxReQJNY5ti7zg/5heGrPFsUeC301Wa
         V64ub2N8riL8uf1454N4G1f7jqvb+ktLtKx8Blb+Fo3XF7SgNMtZo/cSgg0U0++LOK9n
         bzPYofz4AhExoqB/M4a9u1saBMfSawO8MPQNiEPec9NzEZsH8vsrsdkxgtlB7N/0hhxx
         Pw14Uqer2+u3sDaNOU3q22z/OtSBJK94PAHqgqy26Aki8c6z356OQwr00G2AwPf9Qvvg
         tAKQ+qm5WfxBqU9SWEDW3SAFHUcMDLeHZUPrWL29ZPaUcL9zOatScSSkgEvSGc/9Yhq8
         f+vw==
X-Gm-Message-State: APjAAAVlI+OZ7jXIilTobWBdD2TGpAb1lS4zMwIyx9EqNK7jo8Lt/jGo
        yIjg54MZJoAjH5PjIITcz0NGGG1CJ8/KDLmSEtxQBA==
X-Google-Smtp-Source: APXvYqynjZn5+t0v0UmXYG7tmvs6GqIn2I++z+diVHZ8pUOtsbv/HcYGrT/dfpIPISFWmMMBrqpB3Puixoaf06WnVoc=
X-Received: by 2002:ac8:24c1:: with SMTP id t1mr2829147qtt.257.1578997146344;
 Tue, 14 Jan 2020 02:19:06 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007523a60576e80a47@google.com> <CACT4Y+b3AmVQMjPNsPHOXRZS4tNYb6Z9h5-c=1ZwZk0VR-5J5Q@mail.gmail.com>
 <20180928070042.GF3439@hirez.programming.kicks-ass.net> <CACT4Y+YFmSmXjs5EMNRPvsR-mLYeAYKypBppYq_M_boTi8a9uQ@mail.gmail.com>
 <CACT4Y+ZBYYUiJejNbPcZWS+aHehvkgKkTKm0gvuviXGGcirJ5g@mail.gmail.com> <20200114084334.GI2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20200114084334.GI2827@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Jan 2020 11:18:55 +0100
Message-ID: <CACT4Y+Y9knRot2GUG706AK68XzrOwHpC6EhK0xVFFNKX=V4q7A@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 9:43 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 09, 2020 at 11:59:25AM +0100, Dmitry Vyukov wrote:
>
> > Or are there some ID leaks in lockdep? syzbot has a bunch of very
> > simple reproducers for these bugs, so not really a maximally diverse
> > load. And I think I saw these bugs massively when testing just a
> > single subsystem too, e.g. netfilter.
>
> Can you share me one of the simple ones? A .c files I can run on my
> regular test box that should make it go *splat* ?
>
> Often in the past hitting these limits was the result of some
> particularly poor annotation.
>
> For instance, locks in per-cpu data used to trigger this, since
> static locks don't need explicit {mutex,spin_lock}_init() calls and
> instead use their (static) address. This worked fine for global state,
> but per-cpu is an exception, there it causes a nr_cpus explosion in
> lockdep state because you get nr_cpus different addresses.
>
> Now, we fixed that particular issue:
>
>   383776fa7527 ("locking/lockdep: Handle statically initialized PER_CPU locks properly")
>
> but maybe there's something else going on.
>
> Just blindly bumping the number without analysis of what exactly is
> happening is never a good idea.


Each of these has a fair amount of C reproducers:

BUG: MAX_LOCKDEP_KEYS too low!
https://syzkaller.appspot.com/bug?id=8a18efe79140782a88dcd098808d6ab20ed740cc

BUG: MAX_LOCKDEP_ENTRIES too low!
https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b

BUG: MAX_LOCKDEP_CHAINS too low!
https://syzkaller.appspot.com/bug?id=bf037f4725d40a8d350b2b1b3b3e0947c6efae85

BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a


I just took the latest one for one of the bugs:
https://syzkaller.appspot.com/text?tag=ReproC&x=15a096aee00000
run on next-20200114 with this config:
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-kasan.config
and got:

root@syzkaller:~# ./a.out
[  110.512842][ T6486] BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[  110.518638][ T6486] turning off the locking correctness validator.
[  110.520779][ T6486] CPU: 3 PID: 6486 Comm: kworker/u9:1 Not tainted
5.5.0-rc6-next-20200114 #1
[  110.522496][ T6486] Hardware name: QEMU Standard PC (Q35 + ICH9,
2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebu4
[  110.524367][ T6486] Workqueue: hci0 hci_power_on
[  110.525126][ T6486] Call Trace:
[  110.525633][ T6486]  dump_stack+0x199/0x216
[  110.526294][ T6486]  __lock_acquire.cold.64+0x18/0x385
[  110.527084][ T6486]  ? lock_downgrade+0x900/0x900
[  110.527942][ T6486]  ? __kasan_check_write+0x14/0x20
[  110.528716][ T6486]  ? do_raw_spin_lock+0x132/0x2e0
[  110.529499][ T6486]  ? mark_held_locks+0x130/0x130
[  110.530284][ T6486]  ? kfree_skbmem+0xfb/0x1c0
[  110.531020][ T6486]  ? kfree_skbmem+0xfb/0x1c0
[  110.531748][ T6486]  ? hci_sock_dev_event+0x335/0x580
[  110.532578][ T6486]  lock_acquire+0x194/0x410
[  110.533305][ T6486]  ? skb_dequeue+0x22/0x180
[  110.534028][ T6486]  _raw_spin_lock_irqsave+0x99/0xd0
[  110.534873][ T6486]  ? skb_dequeue+0x22/0x180
[  110.535581][ T6486]  skb_dequeue+0x22/0x180
[  110.536263][ T6486]  skb_queue_purge+0x26/0x40
[  110.536996][ T6486]  ? vhci_open+0x310/0x310
[  110.537794][ T6486]  vhci_flush+0x3b/0x50
[  110.538481][ T6486]  hci_dev_do_close+0x5c8/0x1070
[  110.539297][ T6486]  ? hci_dev_open+0x290/0x290
[  110.540068][ T6486]  hci_power_on+0x1d8/0x690
[  110.540805][ T6486]  ? hci_error_reset+0xf0/0xf0
[  110.541603][ T6486]  ? rcu_read_lock_sched_held+0x9c/0xd0
[  110.542504][ T6486]  ? rcu_read_lock_any_held.part.11+0x50/0x50
[  110.543478][ T6486]  ? trace_hardirqs_on+0x67/0x240
[  110.544300][ T6486]  process_one_work+0x9b5/0x1750
[  110.545138][ T6486]  ? pwq_dec_nr_in_flight+0x320/0x320
[  110.545976][ T6486]  ? lock_acquire+0x194/0x410
[  110.546708][ T6486]  worker_thread+0x8b/0xd20
[  110.547414][ T6486]  ? process_one_work+0x1750/0x1750
[  110.548317][ T6486]  kthread+0x365/0x450
[  110.548960][ T6486]  ? kthread_mod_delayed_work+0x1b0/0x1b0
[  110.549867][ T6486]  ret_from_fork+0x24/0x30


There are probably some clusters of reproducers, I see several that
use /dev/vhci. But there may be other types of reproducers
(potentially for different issues).
