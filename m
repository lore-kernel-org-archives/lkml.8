Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E772BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D0A20814
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A4SBl6/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404315AbgE1PQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404142AbgE1PQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:16:23 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E360C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:16:23 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id s198so324643oie.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBOMR4dl3vHE3pgP6stmXiAZ6B3bsjHJjxfDsRtyI4A=;
        b=A4SBl6/w43ZFmPzSGY5Z8ulUK7IF0i6PcIN46xxavT2nR0VFUK7a2Pv7I0y+SShRjn
         ga5IlLJePxPDtTCwqxePeDxBSiOclYkPVyys9C2NdQHNwVQUwO8h+i2vDvcYo51dLHIY
         j8dxSFiIAkFX9lp7mdm8zleRow/cFjwG6abx1pBkFvSEqWhdxPoYEmx1hhync4L2sBH3
         VcSno6+3lGGRRriJACB5QE6iTSfVneapDz9OGxxt1pPjYblzcwWefEZORFcrGreMfuQZ
         g4kKDi7hXbuaqmUzgZbP11jQAyXcrUKaVwdsGbKTtQLpcHyTHREQ+30ffdfT/9lDsPwx
         w8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBOMR4dl3vHE3pgP6stmXiAZ6B3bsjHJjxfDsRtyI4A=;
        b=JrlZ2MIbQOdSqNs3WsAmDEn5rwZcNA45BESmgmvmQOh/6wcE5eh4n3tULTRQN9GKA4
         3wtQmSGA41c8bp3fP2wpZhFT74300w7zhr1USPKH3SarIbyLsu3WZFjR8HiVVS7Ncj2P
         9+72wMOpHqviqoJCYdZpJ2oD2qDxPc/mqRoCRC1YiS7j7nnokBOb53ETMPMIC3FGuRwX
         GzMRivQcLdlqo68/5zXnrz4DD33ah8MqaNfDezjONpknOt87Vo/ZrUjoMckVJ/7pucj8
         HIfndf5oTBalJcucf0FQNMsAK11Bqz1gZleNSbwRy1Bwem03RbImP2kOlkqY6If56Boi
         WYwA==
X-Gm-Message-State: AOAM533gBQRA3mjPsM+qH8XeGmjYZw/FK6n4jz0Qnasg2FdOqJwrF6yS
        1szKJMatpNdX/S7J+82bMjSnkYnTDFfSVfd98ziJow==
X-Google-Smtp-Source: ABdhPJxM5pamh6GGN+01LOSNXULC0i4QLFCpvPo9HOfLcSeo8zZ4BE4YJDUsDclBB45Ljy4ycJUMlBMvJD6X9ZDOsw8=
X-Received: by 2002:aca:ebc5:: with SMTP id j188mr2580409oih.70.1590678980942;
 Thu, 28 May 2020 08:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200527103236.148700-1-elver@google.com> <CAK8P3a1MFgRxm6=+9WZKNzN+Nc5fhrDso6orSNQaaa-0yqygYA@mail.gmail.com>
 <CA+icZUWtzu0ONUSy0E27Mq1BrdO79qNaY3Si-PDhHZyF8M4S5g@mail.gmail.com>
 <CAK8P3a04=mVQgSrvDhpVxQj50JEFDn_xMhYrvjmUnLYTWH3QXQ@mail.gmail.com>
 <CA+icZUXVSTxDYJwXLyAwZd91cjMPcPRpeAR72JKqkqa-wRNnWg@mail.gmail.com>
 <CAK8P3a3i0kPf8dRg7Ko-33hsb+LkP=P05uz2tGvg5B43O-hFvg@mail.gmail.com>
 <CA+icZUWr5xDz5ujBfsXjnDdiBuopaGE6xO5LJQP9_y=YoROb+Q@mail.gmail.com>
 <CANpmjNOtKQAB_3t1G5Da-J1k-9Dk6eQKP+xNozRbmHJXZqXGFw@mail.gmail.com>
 <CA+icZUWzPMOj+qsDz-5Z3tD-hX5gcowjBkwYyiy8SL36Jg+2Nw@mail.gmail.com>
 <CANpmjNOPcFSr2n_ro8TqhOBXOBfUY0vZtj_VT7hh3HOhJN4BqQ@mail.gmail.com>
 <CA+icZUVK=5agY_FPdPeRbZyn3EoUgnmPToR3iGWuCzY+KHtoAA@mail.gmail.com>
 <CANpmjNOA2Oa=AJkKYadbvEVOaqzgD840aC5wfGGrFvDqUmjhpg@mail.gmail.com> <CA+icZUXu15=NK8wQgy=eeu=JcOGfB4Qr6UnwzTVvcH4T1L4pUQ@mail.gmail.com>
In-Reply-To: <CA+icZUXu15=NK8wQgy=eeu=JcOGfB4Qr6UnwzTVvcH4T1L4pUQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 28 May 2020 17:16:09 +0200
Message-ID: <CANpmjNNFxvL2Mrq1eJeRsyU19wgSdZrtLaTo2ksOfTzPTGKOzQ@mail.gmail.com>
Subject: Re: [PATCH -tip] compiler_types.h: Optimize __unqual_scalar_typeof
 compilation time
To:     sedat.dilek@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 04:12, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
[...]

> > > >
> > > > In general, CONFIG_KCSAN=y and the defaults for the other KCSAN
> > > > options should be good. Depending on the size of your system, you
> > > > could also tweak KCSAN runtime performance:
> > > > https://lwn.net/Articles/816850/#Interacting%20with%20KCSAN%20at%20Runtime
> > > > -- the defaults should be good for most systems though.
> > > > Hope this helps. Any more questions, do let me know.
> > > >
> > >
> > > Which "projects" and packages do I need?
> > >
> > > I have installed:
> > >
> > > # LC_ALL=C apt-get install llvm-11 clang-11 lld-11
> > > --no-install-recommends -t llvm-toolchain -y
> > >
> > > # dpkg -l | grep
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261 | awk
> > > '/^ii/ {print $1 " " $2 " " $3}' | column -t
> > > ii  clang-11
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  libclang-common-11-dev
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  libclang-cpp11
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  libclang1-11
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  libllvm11:amd64
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  lld-11
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  llvm-11
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > > ii  llvm-11-runtime
> > > 1:11~++20200527111130+65030821d4a-1~exp1~20200527091804.3261
> > >
> > > Is that enough?
> >
> > Just clang-11 (and its transitive dependencies) is enough. Unsure what
> > your installed binary is, likely "clang-11", so if you can do "make
> > CC=clang-11 defconfig" (and check for CONFIG_HAVE_KCSAN_COMPILER)
> > you're good to go.
> >
>
> I was able to build with clang-11 from apt.llvm.org.
>
> [ build-time ]
>
> Normally, it takes me approx. 05:00 to build with clang-10
> (10.0.1-rc1) and Linux v5.7-rc7.
>
> This time start: 21:18 and stop: 03:45 means 06:27 - took 01:27 longer.
>
> Samsung Ultrabook 2nd generation aka Intel Sandybridge CPU with 'make -j3'.
>
> [ diffconfig ]
>
>  BUILD_SALT "5.7.0-rc7-2-amd64-clang" -> "5.7.0-rc7-3-amd64-clang"
>  CLANG_VERSION 100001 -> 110000
> +CC_HAS_ASM_INLINE y
> +HAVE_ARCH_KCSAN y
> +HAVE_KCSAN_COMPILER y
> +KCSAN y
> +KCSAN_ASSUME_PLAIN_WRITES_ATOMIC y
> +KCSAN_DEBUG n
> +KCSAN_DELAY_RANDOMIZE y
> +KCSAN_EARLY_ENABLE y
> +KCSAN_IGNORE_ATOMICS n
> +KCSAN_INTERRUPT_WATCHER n
> +KCSAN_NUM_WATCHPOINTS 64
> +KCSAN_REPORT_ONCE_IN_MS 3000
> +KCSAN_REPORT_RACE_UNKNOWN_ORIGIN y
> +KCSAN_REPORT_VALUE_CHANGE_ONLY y
> +KCSAN_SELFTEST y
> +KCSAN_SKIP_WATCH 4000
> +KCSAN_SKIP_WATCH_RANDOMIZE y
> +KCSAN_UDELAY_INTERRUPT 20
> +KCSAN_UDELAY_TASK 80
>
> I am seeing this data-races:
>
> root@iniza:~# LC_ALL=C dmesg -T | grep 'BUG: KCSAN: data-race'
> [Thu May 28 03:51:53 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:52:00 2020] BUG: KCSAN: data-race in mark_page_accessed
> / workingset_activation
> [Thu May 28 03:52:02 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:52:08 2020] BUG: KCSAN: data-race in
> blk_mq_sched_dispatch_requests / blk_mq_sched_dispatch_requests
> [Thu May 28 03:52:10 2020] BUG: KCSAN: data-race in dd_has_work /
> dd_insert_requests
> [Thu May 28 03:52:11 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:52:13 2020] BUG: KCSAN: data-race in
> page_counter_try_charge / page_counter_try_charge
> [Thu May 28 03:52:15 2020] BUG: KCSAN: data-race in ep_poll_callback /
> ep_send_events_proc
> [Thu May 28 03:52:21 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:52:25 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:52:26 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:52:31 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:52:38 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:52:53 2020] BUG: KCSAN: data-race in dd_has_work /
> dd_insert_requests
> [Thu May 28 03:52:56 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:52:59 2020] BUG: KCSAN: data-race in
> blk_mq_sched_dispatch_requests / blk_mq_sched_dispatch_requests
> [Thu May 28 03:53:25 2020] BUG: KCSAN: data-race in
> rwsem_spin_on_owner+0x102/0x1a0
> [Thu May 28 03:53:25 2020] BUG: KCSAN: data-race in
> page_counter_try_charge / page_counter_try_charge
> [Thu May 28 03:53:39 2020] BUG: KCSAN: data-race in do_epoll_wait /
> ep_poll_callback
> [Thu May 28 03:53:39 2020] BUG: KCSAN: data-race in find_next_and_bit+0x30/0xd0
> [Thu May 28 03:53:41 2020] BUG: KCSAN: data-race in dd_has_work /
> dd_insert_requests
> [Thu May 28 03:53:43 2020] BUG: KCSAN: data-race in do_epoll_wait /
> ep_poll_callback
> [Thu May 28 03:53:45 2020] BUG: KCSAN: data-race in dd_has_work /
> dd_insert_requests
> [Thu May 28 03:53:46 2020] BUG: KCSAN: data-race in
> blk_mq_sched_dispatch_requests / blk_mq_sched_dispatch_requests
> [Thu May 28 03:53:47 2020] BUG: KCSAN: data-race in
> rwsem_spin_on_owner+0x102/0x1a0
> [Thu May 28 03:54:02 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:54:11 2020] BUG: KCSAN: data-race in find_next_and_bit+0x30/0xd0
> [Thu May 28 03:54:19 2020] BUG: KCSAN: data-race in
> rwsem_spin_on_owner+0x102/0x1a0
> [Thu May 28 03:55:00 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:56:14 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:56:50 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:56:50 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:56:52 2020] BUG: KCSAN: data-race in
> tick_nohz_next_event / tick_nohz_stop_tick
> [Thu May 28 03:56:58 2020] BUG: KCSAN: data-race in
> blk_mq_sched_dispatch_requests / blk_mq_sched_dispatch_requests
> [Thu May 28 03:57:58 2020] BUG: KCSAN: data-race in
> blk_mq_sched_dispatch_requests / blk_mq_sched_dispatch_requests
> [Thu May 28 03:58:00 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 03:58:07 2020] BUG: KCSAN: data-race in
> tick_nohz_next_event / tick_nohz_stop_tick
> [Thu May 28 03:58:44 2020] BUG: KCSAN: data-race in
> mutex_spin_on_owner+0xe0/0x1b0
> [Thu May 28 03:58:49 2020] BUG: KCSAN: data-race in __bitmap_subset+0x38/0xd0
> [Thu May 28 03:59:46 2020] BUG: KCSAN: data-race in
> tick_nohz_next_event / tick_nohz_stop_tick
> [Thu May 28 04:00:25 2020] BUG: KCSAN: data-race in dd_has_work /
> deadline_remove_request
> [Thu May 28 04:00:26 2020] BUG: KCSAN: data-race in
> tick_nohz_next_event / tick_nohz_stop_tick
>
> Full dmesg output and linux-config attached.

Thank you for the report. There are a number of known data races. Note
that, we do not think it's wise to rush fixes for data races,
especially because each one requires careful analysis of what the
appropriate response is. In the meantime, also have a look at these 2
articles (if you haven't already), which describes the current state
of things:

1. https://lwn.net/Articles/816850/
2. https://lwn.net/Articles/816854/

Thanks,
-- Marco
