Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49D4C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB00B206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 15:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jd5DCA0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHPPcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgHPPcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 11:32:45 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DCC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:32:44 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so15204546ioh.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 08:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBFIS37XssQZkKcIduebc/1OWwcktUvuSbhvJVzo7qM=;
        b=Jd5DCA0m1oi5SF3F13+rkmeBB3DKCajDW0QmQndzj8BGBYWbS5qHAy5CgTMxrODvSk
         4IUTj5zgV4F1EGl7a0289jPZEqD62gPFYKmL0fsUkSYAzVLkTMXcL4h0oRENk7hVo5vM
         FXysPp563k7dMVlJEzAWKFYGRnFzWGSZ4uLxs+YFl+IRUZQQquZHcLEhaH4PbvODjSHG
         bh463lZH+NHB8xnrm1qid/cs44QDi7wHwMcKXik6JbV6aI2u4+nHE7xVTd21vksHG6+W
         0ECJxs8tPdz0WiLamXLLOBMQ2RyZOMonzPr+70kDyQAinFG6quraPNx7xRd0ukCAM3ls
         k6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBFIS37XssQZkKcIduebc/1OWwcktUvuSbhvJVzo7qM=;
        b=KLY8jSRHGTkeiIv/Ov1U83pPrUmEzegVnfvzH4RyeaLp4/RREoRq2w5J8OEiTFmBmg
         BcgAFoux3NkGVSM3mA/pDBmCQmaylQg7Y7pmaDH+ecy6yJ4eN/uWzUeB3ZUc9q1P1IxL
         4//upfwGIk63ir0JS5386saQH7C3BwHIEnrFNvduE8ZGcZy6UlblHE0eBbO+sMKil+0g
         KwQKMK9XXhinN7m8oAUMMDrbThAqS9/Am4VpKilWVyqfz4R1xwDg70+IZDB+ufGa2pUH
         +h+tUqLhskiKDL42970x3eWJfGgQS+qEgkYfRs9PdAnwc57iob1nO3yK++xZm3FiCWKW
         rylw==
X-Gm-Message-State: AOAM5333ylzAIcVuruP7Prwskm6hIYqk6ReUYcyErctd/fsbPDsTumof
        b4H8esVpn2HPIAjg/p/l+Kg7/1yUJZsH9JCnr+w=
X-Google-Smtp-Source: ABdhPJy9a6a7UQKw9ctEsrcIxI210RSxcbvsvAU2EgZfQd7GkJbRtCNV+8eoMgRLxoc53DZdy898atbjHL4bWbjmv2w=
X-Received: by 2002:a05:6638:1685:: with SMTP id f5mr11151955jat.48.1597591964248;
 Sun, 16 Aug 2020 08:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <08985916e4bfc3835207ff87634392ae2eac698e.1597307180.git.zhaoqianli@xiaomi.com>
 <159747950551.33733.18397049074515181528@swboyd.mtv.corp.google.com>
In-Reply-To: <159747950551.33733.18397049074515181528@swboyd.mtv.corp.google.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Sun, 16 Aug 2020 23:32:35 +0800
Message-ID: <CAPx_LQGQx8eaT2V8iGwUE1ptKtmRZ9VZz5Oa0Bybv2+whteKGg@mail.gmail.com>
Subject: Re: [PATCH v3] kthread: add objectdebug support
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Felix.Kuehling@amd.com, akpm@linux-foundation.org, axboe@kernel.dk,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Stephen
Thanks for your suggestion, i will improve my patch.

Thanks.

On Sat, Aug 15, 2020 at 4:18 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Qianli Zhao (2020-08-13 02:55:16)
> > From: Qianli Zhao <zhaoqianli@xiaomi.com>
> >
> > Add debugobject support to track the life time of kthread_work
>
> Subject says 'objectdebug' but then this says debugobject. Use
> debugobject throughout please.
>
> > which is used to detect reinitialization/free active object problems
>
> which is used to detect reinitialization/free active object problems.
>
> > Add kthread_init_work_onstack/kthread_init_delayed_work_onstack for
> > kthread onstack support
>
> kthread onstack support.
>
> Also, mark functions with parenthesis please.
>
> >
> > If we reinitialize a kthread_work that has been activated,
> > this will cause delayed_work_list/work_list corruption.
> > enable this config,there is an chance to fixup these errors
>
> Capitalize enable.
>
> > or WARNING the wrong use of kthread_work
> >
> > [30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
> > [30858.395788] WARNING: CPU: 2 PID: 387 at /home/work/data/codes/build_home/kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
> > ...
> > [30858.405951] list_add corruption. next->prev should be prev (ffffffe389392620), but was ffffffe388ebbf88. (next=ffffffe388ebbf88).
> > [30858.405977] WARNING: CPU: 0 PID: 7721 at /home/work/data/codes/build_home/kernel/msm-4.19/lib/list_debug.c:25 __list_add_valid+0x7c/0xc8
> >
> > crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
> >  [ffffffe389392620] delayed_work_list = {
> >     next = 0xffffffe388ebbf88,
> >     prev = 0xffffffe388ebb588
> >   }
> > crash> list 0xffffffe388ebbf88
> > ffffffe388ebbf88
> >
> > Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> [...]
> > diff --git a/include/linux/poison.h b/include/linux/poison.h
> > index df34330..2e6a370 100644
> > --- a/include/linux/poison.h
> > +++ b/include/linux/poison.h
> > @@ -86,4 +86,7 @@
> >  /********** security/ **********/
> >  #define KEY_DESTROY            0xbd
> >
> > +/********** kernel/kthread **********/
> > +#define KWORK_ENTRY_STATIC     ((void *) 0x600 + POISON_POINTER_DELTA)
>
> Can we get a comment above this like there is for TIMER_ENTRY_STATIC?
>
> > +
> >  #endif
> > diff --git a/kernel/kthread.c b/kernel/kthread.c
> > index 132f84a..68a16cc 100644
> > --- a/kernel/kthread.c
> > +++ b/kernel/kthread.c
> > @@ -67,6 +67,118 @@ enum KTHREAD_BITS {
> >         KTHREAD_SHOULD_PARK,
> >  };
> >
> > +#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> > +static struct debug_obj_descr kwork_debug_descr;
> > +
> > +static void *kwork_debug_hint(void *addr)
> > +{
> > +       return ((struct kthread_work *) addr)->func;
> > +}
> > +
> > +static bool kwork_is_static_object(void *addr)
> > +{
> > +       struct kthread_work *kwork = addr;
> > +
> > +       return (kwork->node.prev == NULL &&
> > +               kwork->node.next == KWORK_ENTRY_STATIC);
> > +}
> > +
> > +static bool kwork_fixup_init(void *addr, enum debug_obj_state state)
> > +{
> > +       struct kthread_work *kwork = addr;
> > +
> > +       switch (state) {
> > +       case ODEBUG_STATE_ACTIVE:
> > +               kthread_cancel_work_sync(kwork);
> > +               debug_object_init(kwork, &kwork_debug_descr);
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static bool kwork_fixup_free(void *addr, enum debug_obj_state state)
> > +{
> > +       struct kthread_work *kwork = addr;
> > +
> > +       switch (state) {
> > +       case ODEBUG_STATE_ACTIVE:
> > +               kthread_cancel_work_sync(kwork);
> > +               debug_object_free(kwork, &kwork_debug_descr);
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static void stub_kthread_work(struct kthread_work *unuse)
> > +{
> > +       WARN_ON(1);
> > +}
> > +
> > +static bool kwork_fixup_assert_init(void *addr, enum debug_obj_state state)
> > +{
> > +       struct kthread_work *kwork = addr;
> > +       switch (state) {
> > +       case ODEBUG_STATE_NOTAVAILABLE:
> > +               kthread_init_work(kwork, stub_kthread_work);
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> > +
> > +static struct debug_obj_descr kwork_debug_descr = {
> > +               .name           = "kthread_work",
> > +               .debug_hint     = kwork_debug_hint,
> > +               .is_static_object = kwork_is_static_object,
> > +               .fixup_init     = kwork_fixup_init,
> > +               .fixup_free     = kwork_fixup_free,
> > +               .fixup_assert_init = kwork_fixup_assert_init,
>
> Nitpick: This needs some formatting to deindent one tab and align the
> equals signs.
>
> > +};
> > +
> > +static inline void debug_kwork_activate(struct kthread_work *kwork)
> > +{
> > +       debug_object_activate(kwork, &kwork_debug_descr);
> > +}
> > +
> > +static inline void debug_kwork_deactivate(struct kthread_work *kwork)
> > +{
> > +       debug_object_deactivate(kwork, &kwork_debug_descr);
> > +}
> > +
> > +static inline void debug_kwork_assert_init(struct kthread_work *kwork)
> > +{
> > +       debug_object_assert_init(kwork, &kwork_debug_descr);
> > +}
> > +
> > +void __init_kwork(struct kthread_work *kwork, int onstack)
> > +{
> > +       if (onstack)
> > +               debug_object_init_on_stack(kwork, &kwork_debug_descr);
> > +       else
> > +               debug_object_init(kwork, &kwork_debug_descr);
> > +}
> > +EXPORT_SYMBOL_GPL(__init_kwork);
> > +
> > +void destroy_kwork_on_stack(struct kthread_work *kwork)
> > +{
> > +       debug_object_free(kwork, &kwork_debug_descr);
> > +}
> > +EXPORT_SYMBOL_GPL(destroy_kwork_on_stack);
> > +
> > +void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork)
> > +{
> > +       destroy_timer_on_stack(&kdwork->timer);
> > +       debug_object_free(&kdwork->work, &kwork_debug_descr);
> > +}
> > +EXPORT_SYMBOL_GPL(destroy_delayed_kwork_on_stack);
> > +#else
> > +static inline void debug_kwork_activate(struct kthread_work *kwork) { }
> > +static inline void debug_kwork_deactivate(struct kthread_work *kwork) { }
> > +static inline void debug_kwork_assert_init(struct kthread_work *kwork) { }
> > +#endif
> > +
> >  static inline void set_kthread_struct(void *kthread)
> >  {
> >         /*
> > @@ -697,6 +809,7 @@ int kthread_worker_fn(void *worker_ptr)
> >         if (!list_empty(&worker->work_list)) {
> >                 work = list_first_entry(&worker->work_list,
> >                                         struct kthread_work, node);
> > +               debug_kwork_deactivate(work);
> >                 list_del_init(&work->node);
> >         }
> >         worker->current_work = work;
> > @@ -833,8 +946,10 @@ static void kthread_insert_work(struct kthread_worker *worker,
> >  {
> >         kthread_insert_work_sanity_check(worker, work);
> >
> > +       debug_kwork_activate(work);
> >         list_add_tail(&work->node, pos);
> >         work->worker = worker;
> > +
>
> Drop this newline.
>
> >         if (!worker->current_work && likely(worker->task))
> >                 wake_up_process(worker->task);
> >  }
> > @@ -857,6 +972,7 @@ bool kthread_queue_work(struct kthread_worker *worker,
> >         bool ret = false;
> >         unsigned long flags;
> >
> > +       debug_kwork_assert_init(work);
> >         raw_spin_lock_irqsave(&worker->lock, flags);
> >         if (!queuing_blocked(worker, work)) {
> >                 kthread_insert_work(worker, work, &worker->work_list);
> > @@ -895,6 +1011,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
> >
> >         /* Move the work from worker->delayed_work_list. */
> >         WARN_ON_ONCE(list_empty(&work->node));
> > +       debug_kwork_deactivate(work);
> >         list_del_init(&work->node);
> >         kthread_insert_work(worker, work, &worker->work_list);
> >
> > @@ -924,7 +1041,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
> >
> >         /* Be paranoid and try to detect possible races already now. */
> >         kthread_insert_work_sanity_check(worker, work);
> > -
> > +       debug_kwork_activate(work);
> >         list_add(&work->node, &worker->delayed_work_list);
> >         work->worker = worker;
> >         timer->expires = jiffies + delay;
> > @@ -954,6 +1071,7 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
> >         unsigned long flags;
> >         bool ret = false;
> >
> > +       debug_kwork_assert_init(work);
> >         raw_spin_lock_irqsave(&worker->lock, flags);
> >
> >         if (!queuing_blocked(worker, work)) {
> > @@ -987,15 +1105,16 @@ static void kthread_flush_work_fn(struct kthread_work *work)
> >  void kthread_flush_work(struct kthread_work *work)
> >  {
> >         struct kthread_flush_work fwork = {
> > -               KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> > -               COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> > +               .done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> >         };
> >         struct kthread_worker *worker;
> >         bool noop = false;
> >
> > +       kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
> > +       debug_kwork_assert_init(work);
> >         worker = work->worker;
> >         if (!worker)
> > -               return;
> > +               goto out;
>
> Why make the worker and init it on the stack if there isn't anything to
> do? The !worker check should be early and then bail out before doing
> anything else.
>
> >
> >         raw_spin_lock_irq(&worker->lock);
> >         /* Work must not be used with >1 worker, see kthread_queue_work(). */
> > @@ -1013,6 +1132,9 @@ void kthread_flush_work(struct kthread_work *work)
> >
> >         if (!noop)
> >                 wait_for_completion(&fwork.done);
> > +
> > +out:
>
> Then this label can be dropped.
>
> > +       destroy_kwork_on_stack(&fwork.work);
> >  }
> >  EXPORT_SYMBOL_GPL(kthread_flush_work);
> >
