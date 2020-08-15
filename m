Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D20C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B6C820639
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529473;
	bh=tRet6LIgzc2CjvdgM0gdVoNlzG0EX94JA9F2/fcwT9w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=I+/ODcpB5JMWqGWY8XxSxB0FmG3wfh4Z4/sDC7Z0qAD833GhET5xcFrodumTHap9t
	 0yP5o51t6qvgiwMPcnu0XCH6WUNYbqjoe3EicQ8oilSKIUpviKXlejT0naFED0PB5N
	 nZdftizYoN/Lq3kAwI/If81YTHPidIQB/mwx7RXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbgHOWLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbgHOWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A347222DD3;
        Sat, 15 Aug 2020 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597479506;
        bh=tRet6LIgzc2CjvdgM0gdVoNlzG0EX94JA9F2/fcwT9w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hyoEsIKsk9us64WCOdSWE+JsRfTtZao76Fi8LWf9k1TRMnSc6XMZGxnanUUyfgFpy
         MgIPii/ro3p1BhNJzDnwSNGqRfIo7hx9dpbABUcdQU1o1raJUlGC/N/M58mcaa5vov
         ecmcEhsbsyjH3NsZ8QXk50OHJx73iB+aedM1n1No=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <08985916e4bfc3835207ff87634392ae2eac698e.1597307180.git.zhaoqianli@xiaomi.com>
References: <08985916e4bfc3835207ff87634392ae2eac698e.1597307180.git.zhaoqianli@xiaomi.com>
Subject: Re: [PATCH v3] kthread: add objectdebug support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
To:     Felix.Kuehling@amd.com, Qianli Zhao <zhaoqianligood@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk, tglx@linutronix.de
Date:   Sat, 15 Aug 2020 01:18:25 -0700
Message-ID: <159747950551.33733.18397049074515181528@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qianli Zhao (2020-08-13 02:55:16)
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
>=20
> Add debugobject support to track the life time of kthread_work

Subject says 'objectdebug' but then this says debugobject. Use
debugobject throughout please.

> which is used to detect reinitialization/free active object problems

which is used to detect reinitialization/free active object problems.

> Add kthread_init_work_onstack/kthread_init_delayed_work_onstack for
> kthread onstack support

kthread onstack support.

Also, mark functions with parenthesis please.

>=20
> If we reinitialize a kthread_work that has been activated,
> this will cause delayed_work_list/work_list corruption.
> enable this config,there is an chance to fixup these errors

Capitalize enable.

> or WARNING the wrong use of kthread_work
>=20
> [30858.395766] list_del corruption. next->prev should be ffffffe388ebbf88=
, but was ffffffe388ebb588
> [30858.395788] WARNING: CPU: 2 PID: 387 at /home/work/data/codes/build_ho=
me/kernel/msm-4.19/lib/list_debug.c:56 __list_del_entry_valid+0xc8/0xd0
> ...
> [30858.405951] list_add corruption. next->prev should be prev (ffffffe389=
392620), but was ffffffe388ebbf88. (next=3Dffffffe388ebbf88).
> [30858.405977] WARNING: CPU: 0 PID: 7721 at /home/work/data/codes/build_h=
ome/kernel/msm-4.19/lib/list_debug.c:25 __list_add_valid+0x7c/0xc8
>=20
> crash> struct kthread_worker.delayed_work_list 0xffffffe3893925f0
>  [ffffffe389392620] delayed_work_list =3D {
>     next =3D 0xffffffe388ebbf88,
>     prev =3D 0xffffffe388ebb588
>   }
> crash> list 0xffffffe388ebbf88
> ffffffe388ebbf88
>=20
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
[...]
> diff --git a/include/linux/poison.h b/include/linux/poison.h
> index df34330..2e6a370 100644
> --- a/include/linux/poison.h
> +++ b/include/linux/poison.h
> @@ -86,4 +86,7 @@
>  /********** security/ **********/
>  #define KEY_DESTROY            0xbd
> =20
> +/********** kernel/kthread **********/
> +#define KWORK_ENTRY_STATIC     ((void *) 0x600 + POISON_POINTER_DELTA)

Can we get a comment above this like there is for TIMER_ENTRY_STATIC?

> +
>  #endif
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 132f84a..68a16cc 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -67,6 +67,118 @@ enum KTHREAD_BITS {
>         KTHREAD_SHOULD_PARK,
>  };
> =20
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
> +       struct kthread_work *kwork =3D addr;
> +
> +       return (kwork->node.prev =3D=3D NULL &&
> +               kwork->node.next =3D=3D KWORK_ENTRY_STATIC);
> +}
> +
> +static bool kwork_fixup_init(void *addr, enum debug_obj_state state)
> +{
> +       struct kthread_work *kwork =3D addr;
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
> +       struct kthread_work *kwork =3D addr;
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
> +static bool kwork_fixup_assert_init(void *addr, enum debug_obj_state sta=
te)
> +{
> +       struct kthread_work *kwork =3D addr;
> +       switch (state) {
> +       case ODEBUG_STATE_NOTAVAILABLE:
> +               kthread_init_work(kwork, stub_kthread_work);
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static struct debug_obj_descr kwork_debug_descr =3D {
> +               .name           =3D "kthread_work",
> +               .debug_hint     =3D kwork_debug_hint,
> +               .is_static_object =3D kwork_is_static_object,
> +               .fixup_init     =3D kwork_fixup_init,
> +               .fixup_free     =3D kwork_fixup_free,
> +               .fixup_assert_init =3D kwork_fixup_assert_init,

Nitpick: This needs some formatting to deindent one tab and align the
equals signs.

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
> +static inline void debug_kwork_assert_init(struct kthread_work *kwork) {=
 }
> +#endif
> +
>  static inline void set_kthread_struct(void *kthread)
>  {
>         /*
> @@ -697,6 +809,7 @@ int kthread_worker_fn(void *worker_ptr)
>         if (!list_empty(&worker->work_list)) {
>                 work =3D list_first_entry(&worker->work_list,
>                                         struct kthread_work, node);
> +               debug_kwork_deactivate(work);
>                 list_del_init(&work->node);
>         }
>         worker->current_work =3D work;
> @@ -833,8 +946,10 @@ static void kthread_insert_work(struct kthread_worke=
r *worker,
>  {
>         kthread_insert_work_sanity_check(worker, work);
> =20
> +       debug_kwork_activate(work);
>         list_add_tail(&work->node, pos);
>         work->worker =3D worker;
> +

Drop this newline.

>         if (!worker->current_work && likely(worker->task))
>                 wake_up_process(worker->task);
>  }
> @@ -857,6 +972,7 @@ bool kthread_queue_work(struct kthread_worker *worker,
>         bool ret =3D false;
>         unsigned long flags;
> =20
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
>         if (!queuing_blocked(worker, work)) {
>                 kthread_insert_work(worker, work, &worker->work_list);
> @@ -895,6 +1011,7 @@ void kthread_delayed_work_timer_fn(struct timer_list=
 *t)
> =20
>         /* Move the work from worker->delayed_work_list. */
>         WARN_ON_ONCE(list_empty(&work->node));
> +       debug_kwork_deactivate(work);
>         list_del_init(&work->node);
>         kthread_insert_work(worker, work, &worker->work_list);
> =20
> @@ -924,7 +1041,7 @@ static void __kthread_queue_delayed_work(struct kthr=
ead_worker *worker,
> =20
>         /* Be paranoid and try to detect possible races already now. */
>         kthread_insert_work_sanity_check(worker, work);
> -
> +       debug_kwork_activate(work);
>         list_add(&work->node, &worker->delayed_work_list);
>         work->worker =3D worker;
>         timer->expires =3D jiffies + delay;
> @@ -954,6 +1071,7 @@ bool kthread_queue_delayed_work(struct kthread_worke=
r *worker,
>         unsigned long flags;
>         bool ret =3D false;
> =20
> +       debug_kwork_assert_init(work);
>         raw_spin_lock_irqsave(&worker->lock, flags);
> =20
>         if (!queuing_blocked(worker, work)) {
> @@ -987,15 +1105,16 @@ static void kthread_flush_work_fn(struct kthread_w=
ork *work)
>  void kthread_flush_work(struct kthread_work *work)
>  {
>         struct kthread_flush_work fwork =3D {
> -               KTHREAD_WORK_INIT(fwork.work, kthread_flush_work_fn),
> -               COMPLETION_INITIALIZER_ONSTACK(fwork.done),
> +               .done =3D COMPLETION_INITIALIZER_ONSTACK(fwork.done),
>         };
>         struct kthread_worker *worker;
>         bool noop =3D false;
> =20
> +       kthread_init_work_onstack(&fwork.work, kthread_flush_work_fn);
> +       debug_kwork_assert_init(work);
>         worker =3D work->worker;
>         if (!worker)
> -               return;
> +               goto out;

Why make the worker and init it on the stack if there isn't anything to
do? The !worker check should be early and then bail out before doing
anything else.

> =20
>         raw_spin_lock_irq(&worker->lock);
>         /* Work must not be used with >1 worker, see kthread_queue_work()=
. */
> @@ -1013,6 +1132,9 @@ void kthread_flush_work(struct kthread_work *work)
> =20
>         if (!noop)
>                 wait_for_completion(&fwork.done);
> +
> +out:

Then this label can be dropped.

> +       destroy_kwork_on_stack(&fwork.work);
>  }
>  EXPORT_SYMBOL_GPL(kthread_flush_work);
>
