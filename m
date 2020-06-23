Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFD9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2905A206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu0BRWhc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgFWIUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWIUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:20:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1497FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:20:44 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z63so5970094qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 01:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTCrk0q7d5uObaa5idNAN9eS899lK9/IM36Im/keRbk=;
        b=Lu0BRWhct+YEm7W+pLLdLx/UgadyALnnWLv47nG3nkdahtTHcQwE26sYI5ojjAQVIW
         PvNtXZJxdjmshf/deQ6tV41ntBXiN564dZI/VNvGkMcgxpbKXcQLNTb7CrkrCHpD2BVj
         3DO9S2SH6j/qZyKVc8v32VvP68xucvBBmHMwliB6R+oiNBcQR50Gyf2QS9bYTtKxcg9e
         ejt6pD74DgDbofO/Tzs8lASW3ODyZmcXsEGmJIIzQ1PSFkCyRAGOCoIP1CuwGdCrhY3g
         1ruQtgvor6XGkJRploSdaWOwfQsDVLNSCTfpcmzaySTBvir3xTNxG0EZJHUW82xiEhRr
         QGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTCrk0q7d5uObaa5idNAN9eS899lK9/IM36Im/keRbk=;
        b=OTfqKZGihEuULD6368ZGWU1rJ5tSBYExdsDmsg19lP5UEpCsgeCabo36bFpWJgk29f
         4die0AyW8undirQ+67Z5kIqjyb9k6oslZuJlfAkRcOtf93B/Yh0YqDMyCmo6jgHrfn0d
         Bb5BYYrRb0aZRbQTOvUoMPqNJ2owYuFPRXc7CDKzvD+YmlpOstVzT+jF1um9vkWzIDIw
         bvjJGFI8paWWi27fsWWcx39of4cUXWCTHW8DtLltgDEaNnDVW5w+JcS3Ie7CnXgUzGMN
         kfZBtEl1IrJLC6A+zQ03mZGIq2iC0b2PrrqsIfH7wRLNv/MEnHoYfWy7H7SdoyJajSYH
         6yfg==
X-Gm-Message-State: AOAM530G5dFOUYU9EU7AdzsJr16mTvYfq/qMCCwvXi4YWLKhZhWSZspk
        MDORjkmhB+SzU1ckCGoQtAo7G0K000dLiCzqg1ttZg==
X-Google-Smtp-Source: ABdhPJzxoDTPbH+rTKc0PtTBEKZQLUVJhK4nmFBZjj1zRI0VB6mL2z9mmxk5e42jCcK6TNLjD8XGMmvVE/+UKoQ5774=
X-Received: by 2002:a37:4851:: with SMTP id v78mr18721413qka.256.1592900442889;
 Tue, 23 Jun 2020 01:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200601050847.1096-1-walter-zh.wu@mediatek.com> <1592899732.13735.8.camel@mtksdccf07>
In-Reply-To: <1592899732.13735.8.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Jun 2020 10:20:31 +0200
Message-ID: <CACT4Y+Y4Fe55Sz0Z7TQsKq_4UnfOOYAKtHd5xmMmb8FT2wLN8g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] kasan: memorize and print call_rcu stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:09 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Mon, 2020-06-01 at 13:08 +0800, Walter Wu wrote:
> > This patchset improves KASAN reports by making them to have
> > call_rcu() call stack information. It is useful for programmers
> > to solve use-after-free or double-free memory issue.
> >
> > The KASAN report was as follows(cleaned up slightly):
> >
> > BUG: KASAN: use-after-free in kasan_rcu_reclaim+0x58/0x60
> >
> > Freed by task 0:
> >  kasan_save_stack+0x24/0x50
> >  kasan_set_track+0x24/0x38
> >  kasan_set_free_info+0x18/0x20
> >  __kasan_slab_free+0x10c/0x170
> >  kasan_slab_free+0x10/0x18
> >  kfree+0x98/0x270
> >  kasan_rcu_reclaim+0x1c/0x60
> >
> > Last call_rcu():
> >  kasan_save_stack+0x24/0x50
> >  kasan_record_aux_stack+0xbc/0xd0
> >  call_rcu+0x8c/0x580
> >  kasan_rcu_uaf+0xf4/0xf8
> >
> > Generic KASAN will record the last two call_rcu() call stacks and
> > print up to 2 call_rcu() call stacks in KASAN report. it is only
> > suitable for generic KASAN.
> >
> > This feature considers the size of struct kasan_alloc_meta and
> > kasan_free_meta, we try to optimize the structure layout and size
> > , lets it get better memory consumption.
> >
> > [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> > [2]https://groups.google.com/forum/#!searchin/kasan-dev/better$20stack$20traces$20for$20rcu%7Csort:date/kasan-dev/KQsjT_88hDE/7rNUZprRBgAJ
> >
> > Changes since v1:
> > - remove new config option, default enable it in generic KASAN
> > - test this feature in SLAB/SLUB, it is pass.
> > - modify macro to be more clearly
> > - modify documentation
> >
> > Changes since v2:
> > - change recording from first/last to the last two call stacks
> > - move free track into kasan free meta
> > - init slab_free_meta on object slot creation
> > - modify documentation
> >
> > Changes since v3:
> > - change variable name to be more clearly
> > - remove the redundant condition
> > - remove init free meta-data and increasing object condition
> >
> > Changes since v4:
> > - add a macro KASAN_KMALLOC_FREETRACK in order to check whether
> >   print free stack
> > - change printing message
> > - remove descriptions in Kocong.kasan
> >
> > Changes since v5:
> > - reuse print_stack() in print_track()
> >
> > Changes since v6:
> > - fix typo
> > - renamed the variable name in testcase
> >
> > Walter Wu (4):
> > rcu: kasan: record and print call_rcu() call stack
> > kasan: record and print the free track
> > kasan: add tests for call_rcu stack recording
> > kasan: update documentation for generic kasan
> >
>
> Hi Andrew,
>
> Would you tell me why don't pick up this patches?
> Do I miss something?
>
> I will want to implement another new patches, but it need to depend on
> this patches.

On a related note.
Doing this for workqueue on top of these patches may be useful as
well, here is syzbot UAFs that mention process_one_work:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22use-after-free%22$20process_one_work%7Csort:date

In some of these access/allocation happened in in process_one_work, in
some workqueue queueing stack may not add much.
But if we take the last one:
https://groups.google.com/forum/#!searchin/syzkaller-bugs/%22use-after-free%22$20process_one_work%7Csort:date/syzkaller-bugs/IYE0kt0BZMQ/zNM5rlzjAQAJ
It's exactly the same "free stack is useless" situation:

Freed by task 17:
 kfree+0x10a/0x220 mm/slab.c:3757
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268

The same may stand for times, I think I've seen some bugs where the
bad access happens in the timer as well.
Adding workqueue and timers should be pretty minimal change I think.


> > Documentation/dev-tools/kasan.rst |  3 +++
> > include/linux/kasan.h             |  2 ++
> > kernel/rcu/tree.c                 |  2 ++
> > lib/test_kasan.c                  | 30 ++++++++++++++++++++++++++++++
> > mm/kasan/common.c                 | 26 ++++----------------------
> > mm/kasan/generic.c                | 43 +++++++++++++++++++++++++++++++++++++++++++
> > mm/kasan/generic_report.c         |  1 +
> > mm/kasan/kasan.h                  | 23 +++++++++++++++++++++--
> > mm/kasan/quarantine.c             |  1 +
> > mm/kasan/report.c                 | 54 +++++++++++++++++++++++++++---------------------------
> > mm/kasan/tags.c                   | 37 +++++++++++++++++++++++++++++++++++++
> > 11 files changed, 171 insertions(+), 51 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/1592899732.13735.8.camel%40mtksdccf07.
