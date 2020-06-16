Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99495C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CCC20776
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mOWF7Qg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgFPKpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:45:05 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F0CC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 03:45:04 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id b15so10569364ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bX3GkjoGSkqKozzbiobcK9woQkK/iv79LpydnRCbLkY=;
        b=mOWF7Qg9leKGtX5iTHhUwLC9sVpQXW/Sg3IOz8YmqpaSfHWzLTzN92FOCCurDfCrq8
         s7XAGGpgiC90IOfjj9kbfdtnx8tUm6nu9wNJDZ9kkVAcSezB+P+wyIA/tBZFltZY71fW
         ubZs9TGY0iPvRsF2D7578fmFYmpADV6HqsK9CeCoz+k7tY8+Myi0mklx9Vfl+WroQbJZ
         YNVhbje5m5v062p+dGvE/G4YHnhYXZ/VynvkuxBxEEdwfHuCYzIgJK8mQEQPuybxZy13
         QTy9i13lmlW0bHVBtGcQdBfe62azpKWsdOwT8dm6MvY56EoVKi5Dc7ThFtze8U483edb
         rlag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bX3GkjoGSkqKozzbiobcK9woQkK/iv79LpydnRCbLkY=;
        b=lf9KOlIeclPJKwKgCOoRZSQyFPoDS/qBTkmZ04z3ftIge4HaqntejpZlS1Ui1hanSc
         G3B9XPLua4Kh05tWpKucAHiFyK1tqyNceKawm2k6JfM72e5zr8YDf+9KUF6SYnYVF5d+
         d2nUsR0GcOMDaK6W17sJse7Q+/0go6NWy6GqoGRUbNAqGb7bWBfD30nrizVIVGuU6DIb
         ojC+7Ib+DUHEb8ouKBCoCfCzOwbTs9mI5xc5k8RXmqAWx17eZKHsUl5KQwmtLWARUbJQ
         YZ6HQqEHTLkgBR4G0ecUDOhouosw+pVcl8rEqJstCl0TFtR2CT+CCVkvBJadZOyYx9w0
         YM4Q==
X-Gm-Message-State: AOAM533AHqo3j0ERlgpmuy3QEHPeJxqE5E8UH9IA/bRD570XbEqPpT2o
        ZrmzDNoWeu93PyufS2w3U8+QshIH92AUbBmaCltzLQ==
X-Google-Smtp-Source: ABdhPJwLojkh/J/OmxCSEBsYTn7VvCgC+4bx9uX3Iyfe8I0afiR93x9S54bdhrDvPj2m8towSB9DomoEWU310pXCwVE=
X-Received: by 2002:a25:41d2:: with SMTP id o201mr3148443yba.516.1592304303102;
 Tue, 16 Jun 2020 03:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200616045108.GP75760@lianli.shorne-pla.net> <mhng-b86477b3-4134-4023-968e-532ca0b33125@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-b86477b3-4134-4023-968e-532ca0b33125@palmerdabbelt-glaptop1>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 16 Jun 2020 03:44:49 -0700
Message-ID: <CANN689GkUUfpTn+fkjsC-a=RwGsxVwsg-QXKDnVe6zXLjvuZWA@mail.gmail.com>
Subject: Re: mm lock issue while booting Linux on 5.8-rc1 for RISC-V
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     shorne@gmail.com, atishp@atishpatra.org,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Topel <bjorn.topel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am also unable to reproduce the issue so far.

I wanted to point to a few things in case this helps:
- Commit 42fc541404f2 was bisected as the cause. This commit changes
walk_page_range_novma() to use mmap_assert_locked() instead of
lockdep_assert_held()
- mmap_assert_locked() checks lockdep_assert_held(), but also checks
that the rwsem itself is locked.

Now how could lockdep think the lock is held, but the lock itself is
not marked as locked ???

I'm not sure if it helps at all, but a few commits earlier,
0cc55a0213a0 introduces mmap_read_trylock_non_owner(), which is used
exclusively by stackmap, and does the opposite: it acquires the mmap
lock without telling lockdep about it. I can't see any smoking gun
linking this to our bug, but I thought it may be worth mentioning as
it involves the same suspects (stackmap and the difference between
owning the lock vs lockdep thinking we own the lock).

I'm sorry, that's only how far I was able to go on this bug - I'm not
sure how to investigate it further as I can not reproduce the issue...

On Tue, Jun 16, 2020 at 1:40 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Mon, 15 Jun 2020 21:51:08 PDT (-0700), shorne@gmail.com wrote:
> > On Tue, Jun 16, 2020 at 06:57:47AM +0900, Stafford Horne wrote:
> >> On Mon, Jun 15, 2020 at 12:28:11AM -0700, Atish Patra wrote:
> >> > Hi,
> >> > I encountered the following issue while booting 5.8-rc1 on Qemu for RV64.
> >> > I added additional dump_stack and observed that it's happening in bpf free path.
> >> > It happens always if CONFIG_DEBUG_VM is enabled. VM_BUG_ON_MM is
> >> > compiled away without that.
> >> > ------------------------------------------------------------------------
> >> > forked to background, child pid 113
> >> > [   10.328850] CPU: 3 PID: 51 Comm: kworker/3:1 Not tainted
> >> > 5.8.0-rc1-dirty #732
> >> > [   10.331739] Workqueue: events bpf_prog_free_deferred
> >> > [   10.334133] Call Trace:
> >> > [   10.338039] [<ffffffe000202698>] walk_stackframe+0x0/0xa4
> >> > [   10.339988] [<ffffffe000202880>] show_stack+0x2e/0x3a
> >> > [   10.340902] [<ffffffe00047074c>] dump_stack+0x72/0x8c
> >> > [   10.341451] [<ffffffe0002db4ce>] mmap_assert_locked.part.13+0x14/0x1c
> >> > [   10.342131] [<ffffffe0002db330>] walk_page_range_novma+0x0/0x4e
> >> > [   10.342973] [<ffffffe000204f94>] set_direct_map_invalid_noflush+0x66/0x6e
> >> > [   10.343917] [<ffffffe0002e0706>] __vunmap+0xe8/0x212
> >> > [   10.344680] [<ffffffe0002e0882>] __vfree+0x22/0x6e
> >> > [   10.345270] [<ffffffe0002e0902>] vfree+0x34/0x56
> >> > [   10.345834] [<ffffffe00027d752>] __bpf_prog_free+0x2c/0x36
> >> > [   10.346529] [<ffffffe0002801a2>] bpf_prog_free_deferred+0x74/0x8a
> >> > [   10.347394] [<ffffffe000219c70>] process_one_work+0x13a/0x272
> >> > [   10.348239] [<ffffffe00021a4b4>] worker_thread+0x50/0x2e4
> >> > [   10.348900] [<ffffffe00021ed98>] kthread+0xfc/0x10a
> >> > [   10.349470] [<ffffffe0002013da>] ret_from_exception+0x0/0xc
> >> > [   10.354405] mm ffffffe001018600 mmap 0000000000000000 seqnum 0 task_size 0
> >> > [   10.354405] get_unmapped_area 0000000000000000
> >> > [   10.354405] mmap_base 0 mmap_legacy_base 0 highest_vm_end 0
> >> > [   10.354405] pgd ffffffe001074000 mm_users 2 mm_count 1
> >> > pgtables_bytes 8192 map_count 0
> >> > [   10.354405] hiwater_rss 0 hiwater_vm 0 total_vm 0 locked_vm 0
> >> > [   10.354405] pinned_vm 0 data_vm 0 exec_vm 0 stack_vm 0
> >> > [   10.354405] start_code ffffffe000200000 end_code ffffffe00084acc2
> >> > start_data 0 end_data ffffffe00106dfe4
> >> > [   10.354405] start_brk 0 brk ffffffe0010bd6d0 start_stack 0
> >> > [   10.354405] arg_start 0 arg_end 0 env_start 0 env_end 0
> >> > [   10.354405] binfmt 0000000000000000 flags 0 core_state 0000000000000000
> >> > [   10.354405] ioctx_table 0000000000000000
> >> > [   10.354405] exe_file 0000000000000000
> >> > [   10.354405] tlb_flush_pending 0
> >> > [   10.354405] def_flags: 0x0()
> >> > [   10.369325] ------------[ cut here ]------------
> >> > [   10.370763] kernel BUG at include/linux/mmap_lock.h:81!
> >> > [   10.375235] Kernel BUG [#1]
> >> > [   10.377198] Modules linked in:
> >> > [   10.378931] CPU: 3 PID: 51 Comm: kworker/3:1 Not tainted 5.8.0-rc1-dirty #732
> >> > [   10.380179] Workqueue: events bpf_prog_free_deferred
> >> > [   10.381270] epc: ffffffe0002db4d4 ra : ffffffe0002db4d4 sp : ffffffe3eaea7c70
> >> > [   10.382561]  gp : ffffffe00106d950 tp : ffffffe3ef752f80 t0 :
> >> > ffffffe0010836e8
> >> > [   10.383996]  t1 : 0000000000000064 t2 : 0000000000000000 s0 :
> >> > ffffffe3eaea7c90
> >> > [   10.385119]  s1 : ffffffe001018600 a0 : 0000000000000289 a1 :
> >> > 0000000000000020
> >> > [   10.386099]  a2 : 0000000000000005 a3 : 0000000000000000 a4 :
> >> > ffffffe001012758
> >> > [   10.387294]  a5 : 0000000000000000 a6 : 0000000000000102 a7 :
> >> > 0000000000000006
> >> > [   10.388265]  s2 : ffffffe3f00674c0 s3 : ffffffe00106e108 s4 :
> >> > ffffffe00106e100
> >> > [   10.389250]  s5 : ffffffe00106e908 s6 : 0000000000000000 s7 :
> >> > 6db6db6db6db6db7
> >> > [   10.390272]  s8 : 0000000000000001 s9 : ffffffe00021a4f8 s10:
> >> > ffffffffffffffff
> >> > [   10.391293]  s11: ffffffe3f0066600 t3 : 000000000001a7a8 t4 :
> >> > 000000000001a7a8
> >> > [   10.392314]  t5 : 0000000000000000 t6 : ffffffe00107b76b
> >> > [   10.393096] status: 0000000000000120 badaddr: 0000000000000000
> >> > cause: 0000000000000003
> >> > [   10.397755] ---[ end trace 861659596ac28841 ]---
> >> > ---------------------------------------------------------------------------------------------------
> >> >
> >> > I haven't had the chance to bisect to figure out which commit caused
> >> > the issue. Just wanted
> >> > to check if it is a known issue already.
> >>
> >> Hi Atish,
> >>
> >> Note, I am getting the same (just now) when booting v5.8-rc1 on OpenRISC.  If
> >> you have any updates please post back.  I will try to look into this today or
> >> tomorrow.
> >
> > I have bisected this to, 42fc541404f249778e752ab39c8bc25fcb2dbe1e:
> >
> >   mmap locking API: add mmap_assert_locked() and mmap_assert_write_locked()
> >
> > This should have just changed the existing lockdep api's but something has
> > changed.  I haven't had time to look at it yet.
> >
> > Ccing: Michel Lespinasse <walken@google.com>
>
> This isn't manifesting on boot for me, on either rc1 or that commit.  I'm
> running a simple buildroot-based userspace, so I doubt anything is triggering
> BPF.  I don't run the BPF selftests, as they're a bit of a pain (IIRC they
> don't cross compile and need LLVM) -- does anyone have a userspace I can use to
> trigger the bug?



-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
