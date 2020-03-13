Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC75CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2549206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IJGARbfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgCMTc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:32:57 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44816 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMTc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:32:57 -0400
Received: by mail-qv1-f68.google.com with SMTP id w5so5245229qvp.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gj9REod3DKifQOZS7jRssU7uxrigdjGriKDVOD9FDY4=;
        b=IJGARbfcszD6qRADLeGRmq6DwquToF24a+o3x4Rm9lXqdAO7Y4ajQPBKnfLyjCSpVs
         p55sVqoWqKfxV0qdTFKSLo1mUfqMPLyXYNGiUCShKuu5Lsr/m2bHeD8zkiJDgjFKR6VS
         fnxm6r1HINTVP64O4VdIKvjxUPfXVQiQQ/C7HCoeZ0hhuZGHe/BodEpe2IVibAYF8ZHo
         1IleNIkinIjv8XPMrGyp6723jlM5VDx4ez+DMdQgp1ElZ3xCF1dZrxdXPPn9QEPC+APx
         o37ZzLi7aidLZhhh8LPmiZ4DkPFScIDFcKX/fIcfL3AzGew2vqTi7MoazXna0v2rTGzx
         0lEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gj9REod3DKifQOZS7jRssU7uxrigdjGriKDVOD9FDY4=;
        b=iTUb9ZASCcLadQAiITasxZv2Kb78a3wLi0yplBc6E1NLfeLrZhwUVzE2ZLRpQwU/aC
         Y0L1WwC8RmZUke4IB3BAl1ksVOnkl0QK/KO/c7cY9MT1DTPfJtiOlEKsGjkvJCXgp6AU
         Jub4PYZh9OAnj31E/QDJuRgW/BqhZpjP7gCSyqHhg7WdjSOpfnMZh7vNihMDPxb/IRz8
         RBFpWACSNk3vYQRk/3/aGwYoKt8f5jWOsTlKeJFDr0RmN4/SpTSVB/+TkZn6cXz6PZcr
         KiMnPIsaJmQeHnZEN4F0S+EKQpZX7uODkepXHjRYhr4288LibtRd1iK7iMIwYc3Sn28k
         Gv8Q==
X-Gm-Message-State: ANhLgQ1+oJCgwELdc+Sk//CwtrI6FRk5oisK6ZnHjfItE+2paU8RZkaf
        UBkpKjgqsY/+oF3gHI0WSQLSQg==
X-Google-Smtp-Source: ADFU+vvAqAy0nwqXoSeUM2kZD1c0rqzXoPkdFXLjBWDLx3OtMbOCQPajaI3CAcpQdZdeeuSKrvsmIQ==
X-Received: by 2002:a05:6214:14a:: with SMTP id x10mr14237720qvs.158.1584127975394;
        Fri, 13 Mar 2020 12:32:55 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r29sm9142532qtj.76.2020.03.13.12.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 12:32:54 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH] timer: silenct a lockdep splat with debugobjects
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200313180811.GD12521@hirez.programming.kicks-ass.net>
Date:   Fri, 13 Mar 2020 15:32:52 -0400
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        rostedt@goodmis.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4FFD109D-EAC1-486F-8548-AA1F5E024120@lca.pw>
References: <20200313154221.1566-1-cai@lca.pw>
 <20200313180811.GD12521@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 13, 2020, at 2:08 PM, Peter Zijlstra <peterz@infradead.org> =
wrote:
>=20
> On Fri, Mar 13, 2020 at 11:42:21AM -0400, Qian Cai wrote:
>> psi_enqueue() calls add_timer() with pi->lock and rq->lock held which
>> in-turn could allcate with debugobjcets in the locking order,
>>=20
>> pi->lock
>>  rq->lock
>>    base->lock
>>      batched_entropy_u32.lock
>>=20
>> while the random code could always call into the scheduler via
>> try_to_wake_up() in the locking order,
>>=20
>> batched_entropy_u32.lock
>>  pi->lock
>>=20
>> Thus, it could generate a lockdep splat below right after boot. =
Ideally,
>> psi_enqueue() might be able to be called without either pi->lock or
>> rq->lock held, but it is tricky to do.
>>=20
>> Since,
>>=20
>> 1) debugobjects is only used in a debug kernel.
>> 2) the chance to trigger a real deadlock is relative low.
>> 3) once the splat happened, it will disable lockdep to prevent it =
from
>>   catching any more important issues later.
>>=20
>> just silent the splat by temporarily lettting lockdep ignore lockes
>> inside debug_timer_activate() which sounds like a reasonable tradeoff
>> for debug kernels.
>=20
>=20
>> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
>> index 4820823515e9..27bfb8376d71 100644
>> --- a/kernel/time/timer.c
>> +++ b/kernel/time/timer.c
>> @@ -1036,7 +1036,13 @@ __mod_timer(struct timer_list *timer, unsigned =
long expires, unsigned int option
>> 		}
>> 	}
>>=20
>> +	/*
>> +	 * It will allocate under rq->lock and trigger a lockdep slat =
with
>> +	 * random code. Don't disable lockdep with debugobjects.
>> +	 */
>> +	lockdep_off();
>> 	debug_timer_activate(timer);
>> +	lockdep_on();
>>=20
>> 	timer->expires =3D expires;
>> 	/*
>=20
> You have to be f'ing kidding me. You've just earned yourself a =
lifetime
> membership of 'the tinker crew'.
>=20
>> 00: [  321.355501] -> #3 (batched_entropy_u32.lock){-.-.}:
>> 00: [  321.355523]        lock_acquire+0x212/0x460
>> 00: [  321.355536]        _raw_spin_lock_irqsave+0xc4/0xe0
>> 00: [  321.355551]        get_random_u32+0x5a/0x138
>> 00: [  321.355564]        new_slab+0x188/0x760
>> 00: [  321.355576]        ___slab_alloc+0x5d2/0x928
>> 00: [  321.355589]        __slab_alloc+0x52/0x88
>> 00: [  321.355801]        kmem_cache_alloc+0x34a/0x558
>> 00: [  321.355819]        fill_pool+0x29e/0x490
>> 00: [  321.355835]        __debug_object_init+0xa0/0x828
>> 00: [  321.355848]        debug_object_activate+0x200/0x368
>> 00: [  321.355864]        add_timer+0x242/0x538
>> 00: [  321.355877]        queue_delayed_work_on+0x13e/0x148
>> 00: [  321.355893]        init_mm_internals+0x4c6/0x550
>> 00: [  321.355905]        kernel_init_freeable+0x224/0x590
>> 00: [  321.355921]        kernel_init+0x22/0x188
>> 00: [  321.355933]        ret_from_fork+0x30/0x34
>=20
> Did you actually look at debug_object_activate() and read?
>=20
> The only reason that is calling into __debug_object_init() is because =
it
> hadn't been initialized yet when it got activated. That *immediately*
> should've been a clue.
>=20
> You can initialize this stuff early. For instance:
>=20
>  INIT_DELAYED_WORK()
>    __INIT_DELAYED_WORK()
>      __init_timer()
>        init_timer_key()
> 	  debug_init()
> 	    debug_timer_init()
> 	      debug_object_init()
> 	        __debug_object_init()
>=20
> And we're right at where the above callchain goes wrong.
>=20
> Now, it actually looks like kernel/sched/psi.c actually initializes =
all
> delayed works it uses. This then leaves other random delayed works to
> establish the base->lock <- entropy.lock relation.
>=20
> This just means we need to find and kill all such delayed_work users
> that fail to properly initialize their data structure.

Well, in mm/vmstat.c (init_mm_internals) case for example, it was =
initialized
as a static,

static DECLARE_DEFERRABLE_WORK(shepherd, vmstat_shepherd);

which will not call __debug_object_init().=20



