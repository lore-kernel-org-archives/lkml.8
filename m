Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ADA20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WmcNrU3n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eaPp95qw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgHLKLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:11:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51242 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:10:59 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597227057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytwwSb4p4vNvvu5wDB/51cVTcmm79nUaqk/OMkDkpOQ=;
        b=WmcNrU3nHUhxvUAV0vvMCsCjW/O4drLyEB/NyCRHGmrDN0CCpL/KxbIP5/vsu6PO/bLKiP
        ztrAbH9gf76Qey9C5vEgBP+H51mZP/vcLpAxiisdrYzLUSXWGC9T9oiMrE12THPGTHEsEC
        5+XvnjTr7CJQNPaOKN8j666M6nlSq0M1gRpch+O7YBmFxSNeTbfqKx81zYX9TWhq/lYu7w
        yhL8zfp0qdY3hq60w52u0WYdDy94C/MdY0i3yPmOA9WGPexN4hMB0XHPtdglbTUYvYvVp6
        y6of6jVuY6JwiOK2SL5nkHHI3hG0cwccZgHA23gtTxZU3ovitjkVXo2YOEJ4WA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597227057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ytwwSb4p4vNvvu5wDB/51cVTcmm79nUaqk/OMkDkpOQ=;
        b=eaPp95qw5oeZtYB9zOFUTirIityHYlVCJKnQQ8IPlZzg/lWrLmIRhYRbb8ow++h8yNRzy/
        Eknjvgy38dD7BICg==
To:     Qianli Zhao <zhaoqianligood@gmail.com>, axboe@kernel.dk,
        akpm@linux-foundation.org, Felix.Kuehling@amd.com
Cc:     john.stultz@linaro.org, sboyd@kernel.org,
        ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: Re: [RFC V2] kthread: add object debug support
In-Reply-To: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
Date:   Wed, 12 Aug 2020 12:10:56 +0200
Message-ID: <87sgcs5g3z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qianli,

Qianli Zhao <zhaoqianligood@gmail.com> writes:

> Add debugobject support to track the life time of kthread_work
> which is used to detect reinitialization/free active object problems
> Add kthread_init_work_onstack/kthread_init_delayed_work_onstack for
> kthread onstack support

s/kthread/kthread_work/ ?

It would also be nice to have an example output in the changelog.

> +static struct debug_obj_descr kwork_debug_descr = {
> +	.name		= "kthread_work",
> +	.debug_hint	= kwork_debug_hint,
> +	.is_static_object = kwork_is_static_object,

Nitpick. You nicely aligned all the initializers except of this
one. Just add another TAB to all of them and this becomes a perfect
table.

> +	.fixup_init	= kwork_fixup_init,
> +	.fixup_free	= kwork_fixup_free,

This lacks:

        .fixup_assert_init	= ....

which catches cases where a non static object is used uninitialized.

> @@ -698,6 +786,7 @@ int kthread_worker_fn(void *worker_ptr)
>  		work = list_first_entry(&worker->work_list,
>  					struct kthread_work, node);
>  		list_del_init(&work->node);
> +		debug_kwork_deactivate(work);

Please move that before the list del. Deactivate debug cannot do much
about the wreckage as there is no fixup function, but at least you get
the message printed _before_ the list delete can cause havoc and crashes
something else on a different CPU which makes the whole point of being
able to debug this kind of problems moot.

> @@ -835,8 +924,11 @@ static void kthread_insert_work(struct kthread_worker *worker,
>  
>  	list_add_tail(&work->node, pos);
>  	work->worker = worker;
> -	if (!worker->current_work && likely(worker->task))
> +
> +	if (!worker->current_work && likely(worker->task)) {
> +		debug_kwork_activate(work);

That's misplaced as well. The work is activated with list_add_tail() and
you really want to call debug_kwork_activate() unconditionally before
doing the list operation:

  1) If the object is active or not initialized then the list operation
     will cause memory corruption and the fixup function will operate on
     already wreckaged state. Debug objects is about preventing the
     wreckaged state and keeping the system alive so the debug info goes
     out.

  2) If the worker is busy (worker->current_worker != NULL) then the
     newly queued work is not activated in the debug object tracker and
     the deactivation will complain or a consequent free of the object
     will fail to detect that it's still active.

>  /**
> @@ -1054,6 +1146,7 @@ static bool __kthread_cancel_work(struct kthread_work *work, bool is_dwork,
>  	 */
>  	if (!list_empty(&work->node)) {
>  		list_del_init(&work->node);
> +		debug_kwork_deactivate(work);

See above.

>  		return true;
>  	}
>  
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 9ad9210..8355984 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -540,6 +540,16 @@ config DEBUG_OBJECTS_WORK
>  	  work queue routines to track the life time of work objects and
>  	  validate the work operations.
>  
> +config DEBUG_OBJECTS_KTHREAD
> +	bool "Debug kthread work objects"

This is about debugging kthread_work, so can you please name the
config option accordingly? It's not about debugging KTHREAD itself.

Thanks,

        tglx
