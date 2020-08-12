Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118082076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Icpguvym";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Va/gAmR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgHLK1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:27:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgHLK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:27:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597228024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5r9hWDwW99yywu0GiffCS2t4+i9DAlf4Ar8Gn4QbAU=;
        b=IcpguvymfkOKOvtKOyUS8vZZtHdSz4DAL7j1cYuGbJJ56NjQYaFkIacfig/QO5Q60hcOtY
        1qwaZxFW536hZXFLeMqg3/sHQk9ktXj1W0V/seEnpsYJywF2YJIZZC5VGsF42c9z9lCmQR
        5uiCA/qlkPprFaL9MWN3WtZqviqDCzNWFhdAtf2p1Nit5zKKLgjQgODOs3YU4BReGtuWZw
        mGcImTbvuzMEoDoIWT1aal/uXN+KgKFRuHi6NvOEjVeH+EvEJ0otuKBKON0EZgA+sf5yPo
        WQjVzcaFmz3IIoJC0CCQSHfs2zynfNQJOX4Tonf+dvre6KTEvd19Tc6iLy1VAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597228024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s5r9hWDwW99yywu0GiffCS2t4+i9DAlf4Ar8Gn4QbAU=;
        b=/Va/gAmRz4fluU+CTzYZf2GxYiCMrqG4tr6nbKJer5IHuNifIR+eD/Fps/W4yFJKv+TMTx
        AAW3RCGCTwHDt4Aw==
To:     Stephen Boyd <sboyd@kernel.org>, Felix.Kuehling@amd.com,
        Qianli Zhao <zhaoqianligood@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
Subject: Re: [RFC V2] kthread: add object debug support
In-Reply-To: <159722125596.33733.17725649536425524344@swboyd.mtv.corp.google.com>
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com> <159722125596.33733.17725649536425524344@swboyd.mtv.corp.google.com>
Date:   Wed, 12 Aug 2020 12:27:03 +0200
Message-ID: <87pn7w5fd4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Stephen Boyd <sboyd@kernel.org> writes:
> Quoting Qianli Zhao (2020-08-11 22:14:14)
>> +/********** kernel/kthread **********/
>> +#define KWORK_ENTRY_STATIC     ((void *) 0x600 + POISON_POINTER_DELTA)
>
> Is this related to the debugobjects change here? It looks like another
> version of list poison.

Yes, it is. We use these poison entries to mark statically allocated
objects. debug objects does not know about statically initialized
objects up to the point where they are used (activated).

That means the object state lookup will fail which causes debugobjects
to complain about using an uninitialized object. But in case of static
initialized ones that's a false positive. So we mark these objects in
their list head (or some other appropriate place) with a poison value
and in case of a failed lookup debug object does:

	if (descr->is_static_object && descr->is_static_object(addr)) {
		/* track this static object */
		debug_object_init(addr, descr);
		debug_object_activate(addr, descr);
        }        

The object specific is_static_object() callback will then check for the
magic list poison value being present:

> +static bool kwork_is_static_object(void *addr)
> +{
> +	struct kthread_work *kwork = addr;
> +
> +	return (kwork->node.prev == NULL &&
> +		kwork->node.next == KWORK_ENTRY_STATIC);
> +}

and if so the debug object core fixes its internal state by creating a
tracking object and then activating it.

It's not a perfect "yes this is statically initialized" check but good
enough. If you go and do:

   work = kzalloc(sizeof(*work);
   work->node.next = KWORK_ENTRY_STATIC;

   kthread_insert_work(worker, work);

or any other variant of insanity which makes the check claim that this
is statically initialized then you rightfully can keep the pieces :)

>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>> index 132f84a..ca00bd2 100644
>> --- a/kernel/kthread.c
>> +++ b/kernel/kthread.c
>> @@ -698,6 +786,7 @@ int kthread_worker_fn(void *worker_ptr)
>>                 work = list_first_entry(&worker->work_list,
>>                                         struct kthread_work, node);
>>                 list_del_init(&work->node);
>> +               debug_kwork_deactivate(work);
>
> Shouldn't this come before the list operation so that any sort of fix
> can be made before possibly corrupting a list?

Yes.

>>         }
>>         worker->current_work = work;
>>         raw_spin_unlock_irq(&worker->lock);
>> @@ -835,8 +924,11 @@ static void kthread_insert_work(struct kthread_worker *worker,
>>  
>>         list_add_tail(&work->node, pos);
>>         work->worker = worker;
>> -       if (!worker->current_work && likely(worker->task))
>> +
>> +       if (!worker->current_work && likely(worker->task)) {
>> +               debug_kwork_activate(work);

You missed this one as I explained to Qianli already. It's way worse
than the other two.

Thanks,

        tglx
