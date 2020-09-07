Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219C5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3E6C208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD7SbxBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgIGIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgIGICM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:02:12 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5FCC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:02:12 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a8so6024866ilk.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZ2HOyjBDsc930x/6Kbk0IIWP/ndx4uvTkn7GBCACbw=;
        b=QD7SbxBMLVEuUGkVq1YEVJTKSyaHqPD9V3gKtgtIFXj8amd2Oa74abnY4ynH8kS6sE
         YbISzVACnb4gnn9XYIoxLeodupuq+KL3ZXFEfY2L2zyKGRX2j8yxCb1HY4jijBpC4vnW
         xx/eEk5EiVtSj0fnPgRTYCslpPrR8xo/VmHpnoSUVxHWKYd48PURfyMxbxyi+LZdNIo3
         ivk0FnJB8ZmPNgYFGj3XcZ7i2k/SECY3ZN1X4KV5CcHRhPEeylGUGaESm0hQ8YThGjRw
         VOfWcHUwMEMMouWNd1/EoVanJzZvjnFhQxKrBmeeydwgKbLpvPeTIOahFvf7F17XBOXv
         NYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZ2HOyjBDsc930x/6Kbk0IIWP/ndx4uvTkn7GBCACbw=;
        b=DSmwW91oz8H5llXqOkAjb7HrputD4LxZ669yTh05bqizG6cNrWSzoURLcRJ+K2HmDK
         bW2PDESUMmpybIXPivPsuapL67KWk3BBr6bPgCZTS3qXB5mwOgMY9UkHpNBll92KAWkO
         kpaCD6NNp/+FFdj0WhOr3LnQ7OIlmcFhT2xeyfLNbprwLsL5XK+gUgXTOEVMsKLAzFjA
         gTw4t/nWWbpxpM5i1LnJ+k/gwKv64xg18AxBIA/X3QragQiRF3nt/vDQJMQ/dLNVJomz
         urfEfhCw0gYikjT4wmD2ZLDq8CCHsld4UJkUjnKjfBnnvuRCTPDE1zNOlMwU2awoXeDs
         UW0g==
X-Gm-Message-State: AOAM531P52wW85aAyx6fDpXhMHZBCW032rUSUydctQ3eVZJHVBcd8MZ8
        +mkScXijiKzeXLl0cOJ0od4I104zOjzNNY8g2N8=
X-Google-Smtp-Source: ABdhPJwd7l8Hkm0sXilI62u9AnhzF23zaIGW8WbEJWZel3Fq8l6iuYJvk2wffEqRS+ImCfA8vmL9sY6/CG0yzACH94I=
X-Received: by 2002:a92:c851:: with SMTP id b17mr18687017ilq.26.1599465731110;
 Mon, 07 Sep 2020 01:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <7a7af0e893e3ceb0d8d1f055bffca1d47025d7ba.1597645588.git.zhaoqianli@xiaomi.com>
In-Reply-To: <7a7af0e893e3ceb0d8d1f055bffca1d47025d7ba.1597645588.git.zhaoqianli@xiaomi.com>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Mon, 7 Sep 2020 16:02:00 +0800
Message-ID: <CAPx_LQHJUEod5XXoKVZuZsKVKL5-DOAzKxoyKFK47jhreLd5BA@mail.gmail.com>
Subject: Re: [PATCH v5] kthread: Add debugobject support
To:     Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk,
        akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        Stephen Boyd <sboyd@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maintainer

Is this change ignored or rejected?
I'm not sure who is the maintainer of kthread, please help give me a
definite reply

Thanks

On Mon, 17 Aug 2020 at 14:37, Qianli Zhao <zhaoqianligood@gmail.com> wrote:
>
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
>
> Add debugobject support to track the life time of kthread_work
> which is used to detect reinitialization/free active object problems
> Add kthread_init_work_onstack()/kthread_init_delayed_work_onstack() for
> kthread onstack support
>
> If we reinitialize a kthread_work that has been activated,
> this will cause delayed_work_list/work_list corruption.
> enable this config,there is an chance to fixup these errors
> or WARNING the wrong use of kthread_work
>
> [30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88, but was ffffffe388ebb588
> [30858.395788] WARNING: CPU: 2 PID: 387 at kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
> ...
> [30858.395906] Call trace:
> [30858.395909]  __list_del_entry_valid+0xc8/0xd0
> [30858.395912]  __kthread_cancel_work_sync+0x98/0x138
> [30858.395915]  kthread_cancel_delayed_work_sync+0x10/0x20
> [30858.395917]  sde_encoder_resource_control+0xe8/0x12c0
> [30858.395920]  sde_encoder_prepare_for_kickoff+0x5dc/0x2008
> [30858.395923]  sde_crtc_commit_kickoff+0x280/0x890
> [30858.395925]  sde_kms_commit+0x16c/0x278
> [30858.395928]  complete_commit+0x3c4/0x760
> [30858.395931]  _msm_drm_commit_work_cb+0xec/0x1e0
> [30858.395933]  kthread_worker_fn+0xf8/0x190
> [30858.395935]  kthread+0x118/0x128
> [30858.395938]  ret_from_fork+0x10/0x18
>
> crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
>  [ffffffe389392620] delayed_work_list = {
>     next = 0xffffffe388ebbf88,
>     prev = 0xffffffe388ebb588
>   }
> crash> list 0xffffffe388ebbf88
> ffffffe388ebbf88
>
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
> V5:
> - Fix format error checked by checkpatch.pl
>
> V4:
> - Changelog update
> - Add comment for KWORK_ENTRY_STATIC
> - Code format modification
> - Check worker availability early in kthread_flush_work
>
> V3:
> - changelog update
> - add fixup_assert_init support
> - move debug_kwork_activate/debug_kwork_deactivate before list operation
> - name the kconfig CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> - use kthread_init_work_onstack/destroy_kwork_on_stack when kthread_work used on stack
> - __init_kwork before clear kthread_work in kthread_init_work
> ---
>  include/linux/kthread.h |  30 ++++++++++-
>  include/linux/poison.h  |   4 ++
>  kernel/kthread.c        | 136 ++++++++++++++++++++++++++++++++++++++++++++++--
>  lib/Kconfig.debug       |  10 ++++
>  4 files changed, 174 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 65b81e0..706302b 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -108,6 +108,17 @@ struct kthread_delayed_work {
>         struct timer_list timer;
>  };
>
> +#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> +extern void __init_kwork(struct kthread_work *kwork, int onstack);
> +extern void destroy_kwork_on_stack(struct kthread_work *kwork);
> +extern void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork);
> +#else
> +static inline void __init_kwork(struct kthread_work *kwork, int onstack) { }
> +static inline void destroy_kwork_on_stack(struct kthread_work *kwork) { }
> +static inline void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork) { }
> +#endif
> +
> +
>  #define KTHREAD_WORKER_INIT(worker)    {                               \
>         .lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),                \
>         .work_list = LIST_HEAD_INIT((worker).work_list),                \
> @@ -115,7 +126,7 @@ struct kthread_delayed_work {
>         }
>
>  #define KTHREAD_WORK_INIT(work, fn)    {                               \
> -       .node = LIST_HEAD_INIT((work).node),                            \
> +       .node = { .next = KWORK_ENTRY_STATIC },                         \
>         .func = (fn),                                                   \
>         }
>
> @@ -159,6 +170,15 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
>
>  #define kthread_init_work(work, fn)                                    \
>         do {                                                            \
> +               __init_kwork(work, 0);                                          \
> +               memset((work), 0, sizeof(struct kthread_work));         \
> +               INIT_LIST_HEAD(&(work)->node);                          \
> +               (work)->func = (fn);                                    \
> +       } while (0)
> +
> +#define kthread_init_work_onstack(work, fn)                                    \
> +       do {                                                            \
> +               __init_kwork(work, 1);                                          \
>                 memset((work), 0, sizeof(struct kthread_work));         \
>                 INIT_LIST_HEAD(&(work)->node);                          \
>                 (work)->func = (fn);                                    \
> @@ -172,6 +192,14 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
>                              TIMER_IRQSAFE);                            \
>         } while (0)
>
> +#define kthread_init_delayed_work_onstack(dwork, fn)                           \
> +       do {                                                            \
> +               kthread_init_work_onstack(&(dwork)->work, (fn));                \
> +               __init_timer_on_stack(&(dwork)->timer,                          \
> +                            kthread_delayed_work_timer_fn,             \
> +                            TIMER_IRQSAFE);                            \
> +       } while (0)
> +
>  int kthread_worker_fn(void *worker_ptr);
>
>  __printf(2, 3)
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index df34330..d9095ca 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -86,4 +86,8 @@
>  /********** security/ **********/
>  #define KEY_DESTROY            0xbd
>
> +/********** kernel/kthread **********/
> +/*indicate a static kthread_work initializer for the object debugging code.*/
> +#define KWORK_ENTRY_STATIC     ((void *) 0x600 + POISON_POINTER_DELTA)
> +
>  #endif
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 132f84a..c283b24 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -67,6 +67,119 @@ enum KTHREAD_BITS {
>         KTHREAD_SHOULD_PARK,
>  };
>
> +#ifdef CONFIG_DEBUG_OBJECTS_KTHREAD_WORK
> +static struct debug_obj_descr kwork_debug_descr;
> +
> +static void *kwork_debug_hint(void *addr)
> +{
> +       return ((struct kthread_work *) addr)->func;
> +}
> +
> +static bool kwork_is_static_object(void *addr)
> +{
> +       struct kthread_work *kwork = addr;
> +
> +       return (kwork->node.prev == NULL &&
> +               kwork->node.next == KWORK_ENTRY_STATIC);
> +}
> +
> +static bool kwork_fixup_init(void *addr, enum debug_obj_state state)
> +{
> +       struct kthread_work *kwork = addr;
> +
> +       switch (state) {
> +       case ODEBUG_STATE_ACTIVE:
> +               kthread_cancel_work_sync(kwork);
> +               debug_object_init(kwork, &kwork_debug_descr);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static bool kwork_fixup_free(void *addr, enum debug_obj_state state)
> +{
> +       struct kthread_work *kwork = addr;
> +
> +       switch (state) {
> +       case ODEBUG_STATE_ACTIVE:
> +               kthread_cancel_work_sync(kwork);
> +               debug_object_free(kwork, &kwork_debug_descr);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static void stub_kthread_work(struct kthread_work *unuse)
> +{
> +       WARN_ON(1);
> +}
> +
> +static bool kwork_fixup_assert_init(void *addr, enum debug_obj_state state)
> +{
> +       struct kthread_work *kwork = addr;
> +
> +       switch (state) {
> +       case ODEBUG_STATE_NOTAVAILABLE:
> +               kthread_init_work(kwork, stub_kthread_work);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static struct debug_obj_descr kwork_debug_descr = {
> +       .name                   = "kthread_work",
> +       .debug_hint             = kwork_debug_hint,
> +       .is_static_object       = kwork_is_static_object,
> +       .fixup_init             = kwork_fixup_init,
> +       .fixup_free             = kwork_fixup_free,
> +       .fixup_assert_init      = kwork_fixup_assert_init,
> +};
> +
> +static inline void debug_kwork_activate(struct kthread_work *kwork)
> +{
> +       debug_object_activate(kwork, &kwork_debug_descr);
> +}
> +
> +static inline void debug_kwork_deactivate(struct kthread_work *kwork)
> +{
> +       debug_object_deactivate(kwork, &kwork_debug_descr);
> +}
> +
> +static inline void debug_kwork_assert_init(struct kthread_work *kwork)
> +{
> +       debug_object_assert_init(kwork, &kwork_debug_descr);
> +}
> +
> +void __init_kwork(struct kthread_work *kwork, int onstack)
> +{
> +       if (onstack)
> +               debug_object_init_on_stack(kwork, &kwork_debug_descr);
> +       else
> +               debug_object_init(kwork, &kwork_debug_descr);
> +}
> +EXPORT_SYMBOL_GPL(__init_kwork);
> +
> +void destroy_kwork_on_stack(struct kthread_work *kwork)
> +{
> +       debug_object_free(kwork, &kwork_debug_descr);
> +}
> +EXPORT_SYMBOL_GPL(destroy_kwork_on_stack);
> +
> +void destroy_delayed_kwork_on_stack(struct kthread_delayed_work *kdwork)
> +{
> +       destroy_timer_on_stack(&kdwork->timer);
> +       debug_object_free(&kdwork->work, &kwork_debug_descr);
> +}
> +EXPORT_SYMBOL_GPL(destroy_delayed_kwork_on_stack);
> +#else
> +static inline void debug_kwork_activate(struct kthread_work *kwork) { }
> +static inline void debug_kwork_deactivate(struct kthread_work *kwork) { }
> +static inline void debug_kwork_assert_init(struct kthread_work *kwork) { }
> +#endif
> +
>  static inline void set_kthread_struct(void *kthread)
>  {
>         /*
> @@ -697,6 +810,7 @@ int kthread_worker_fn(void *worker_ptr)
>         if (!list_empty(&worker->work_list)) {
>                 work = list_first_entry(&worker->work_list,
>                                         struct kthread_work, node);
> +               debug_kwork_deactivate(work);
>                 list_del_init(&work->node);
>         }
>         worker->current_work = work;
> @@ -833,6 +947,7 @@ static void kthread_insert_work(struct kthread_worker *worker,
>  {
>         kthread_insert_work_sanity_check(worker, work);
>
> +       debug_kwork_activate(work);
>         list_add_tail(&work->node, pos);
>         work->worker = worker;
>         if (!worker->current_work && likely(worker->task))
> @@ -857,6 +972,7 @@ bool kthread_queue_work(struct kthread_worker *worker,
>         bool ret = false;
>         unsigned long flags;
>
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>         if (!queuing_blocked(worker, work)) {
>                 kthread_insert_work(worker, work, &worker->work_list);
> @@ -895,6 +1011,7 @@ void kthread_delayed_work_timer_fn(struct timer_list *t)
>
>         /* Move the work from worker->delayed_work_list. */
>         WARN_ON_ONCE(list_empty(&work->node));
> +       debug_kwork_deactivate(work);
>         list_del_init(&work->node);
>         kthread_insert_work(worker, work, &worker->work_list);
>
> @@ -925,6 +1042,7 @@ static void __kthread_queue_delayed_work(struct kthread_worker *worker,
>         /* Be paranoid and try to detect possible races already now. */
>         kthread_insert_work_sanity_check(worker, work);
>
> +       debug_kwork_activate(work);
>         list_add(&work->node, &worker->delayed_work_list);
>         work->worker = worker;
>         timer->expires = jiffies + delay;
> @@ -954,6 +1072,7 @@ bool kthread_queue_delayed_work(struct kthread_worker *worker,
>         unsigned long flags;
>         bool ret = false;
>
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>
>         if (!queuing_blocked(worker, work)) {
> @@ -987,16 +1106,17 @@ static void kthread_flush_work_fn(struct kthread_work *work)
>  void kthread_flush_work(struct kthread_work *work)
>  {
>         struct kthread_flush_work fwork = {
> -               KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -               COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> +               .done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
>         };
>         struct kthread_worker *worker;
>         bool noop = false;
>
> +       debug_kwork_assert_init(work);
>         worker = work->worker;
>         if (!worker)
>                 return;
>
> +       kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
>         raw_spin_lock_irq(&worker->lock);
>         /* Work must not be used with >1 worker, see kthread_queue_work(). */
>         WARN_ON_ONCE(work->worker != worker);
> @@ -1013,6 +1133,7 @@ void kthread_flush_work(struct kthread_work *work)
>
>         if (!noop)
>                 wait_for_completion(&fwork.done);
> +       destroy_kwork_on_stack(&fwork.work);
>  }
>  EXPORT_SYMBOL_GPL(kthread_flush_work);
>
> @@ -1053,6 +1174,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
>          * be from worker->work_list or from worker->delayed_work_list.
>          */
>         if (!list_empty(&work->node)) {
> +               debug_kwork_deactivate(work);
>                 list_del_init(&work->node);
>                 return true;
>         }
> @@ -1091,6 +1213,7 @@ bool kthread_mod_delayed_work(struct kthread_worker *worker,
>         unsigned long flags;
>         int ret = false;
>
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>
>         /* Do not bother with canceling when never queued. */
> @@ -1115,10 +1238,12 @@ EXPORT_SYMBOL_GPL(kthread_mod_delayed_work);
>
>  static bool __kthread_cancel_work_sync(struct kthread_work *work, bool is_dwork)
>  {
> -       struct kthread_worker *worker = work->worker;
> +       struct kthread_worker *worker;
>         unsigned long flags;
>         int ret = false;
>
> +       debug_kwork_assert_init(work);
> +       worker = work->worker;
>         if (!worker)
>                 goto out;
>
> @@ -1194,12 +1319,13 @@ EXPORT_SYMBOL_GPL(kthread_cancel_delayed_work_sync);
>  void kthread_flush_worker(struct kthread_worker *worker)
>  {
>         struct kthread_flush_work fwork = {
> -               KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -               COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> +               .done = COMPLETION_INITIALIZER_ONSTACK(fwork.done),
>         };
>
> +       kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
>         kthread_queue_work(worker, &fwork.work);
>         wait_for_completion(&fwork.done);
> +       destroy_kwork_on_stack(&fwork.work);
>  }
>  EXPORT_SYMBOL_GPL(kthread_flush_worker);
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210..71d6696 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -540,6 +540,16 @@ config DEBUG_OBJECTS_WORK
>           work queue routines to track the life time of work objects and
>           validate the work operations.
>
> +config DEBUG_OBJECTS_KTHREAD_WORK
> +       bool "Debug kthread work objects"
> +       depends on DEBUG_OBJECTS
> +       help
> +         If you say Y here, additional code will be inserted into the
> +         kthread routines to track the life time of kthread_work objects
> +         and validate the kthread_work operations.
> +
> +         If unsure, say N.
> +
>  config DEBUG_OBJECTS_RCU_HEAD
>         bool "Debug RCU callbacks objects"
>         depends on DEBUG_OBJECTS
> --
> 2.7.4
>
