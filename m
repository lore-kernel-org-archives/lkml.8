Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BD7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE792078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597221259;
	bh=QgQ9G7VgGQ5ghPCREG54hEA2WO8tzkH95nIRKSgwNAc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=wFgwXWZDS/XbzJiBqrMGmW1UUP8AE7ME4ey8xCpakXY4luj4PJ2mE8tkA/y458Fvi
	 0AvZJBrTo5Odi2B4k+p8vcmaXqkAqMyamupfF4RvwiRXh6VPdbdJvzKT1EkQ01PEyC
	 eP0WcYFeKOKblWL86CXIVl+bXrk+IFz6+iPkTjOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHLIeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:34:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgHLIeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:34:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FE13206C3;
        Wed, 12 Aug 2020 08:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597221257;
        bh=QgQ9G7VgGQ5ghPCREG54hEA2WO8tzkH95nIRKSgwNAc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fKpC3BJ/0lmRhvm19/6bZ+8sGVhdMDVDfzrLXFfyWEb6vh8wgDVJsnAUoj5j7ZN0B
         9u4WeQoHi3dWUXt4nFZu8MDuZPuTwslFTLE8f+Y4VhU/R20w4um6tRQvIkLorapK3M
         FrgoYKZh1Bp5AtE3S9oxnv62Yxo59Q3sdW3P680w=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
References: <311159bc826dcca2848344fc277c0069cff0a164.1597207603.git.zhaoqianli@xiaomi.com>
Subject: Re: [RFC V2] kthread: add object debug support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     john.stultz@linaro.org, ben.dooks@codethink.co.uk,
        bfields@redhat.com, cl@rock-chips.com,
        linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
To:     Felix.Kuehling@amd.com, Qianli Zhao <zhaoqianligood@gmail.com>,
        akpm@linux-foundation.org, axboe@kernel.dk, tglx@linutronix.de
Date:   Wed, 12 Aug 2020 01:34:15 -0700
Message-ID: <159722125596.33733.17725649536425524344@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Qianli Zhao (2020-08-11 22:14:14)
> @@ -115,7 +125,7 @@ struct kthread_delayed_work {
>         }
> =20
>  #define KTHREAD_WORK_INIT(work, fn)    {                               \
> -       .node =3D LIST_HEAD_INIT((work).node),                           =
 \
> +       .node =3D { .next =3D KWORK_ENTRY_STATIC },                      =
   \
>         .func =3D (fn),                                                  =
 \
>         }
> =20
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

Is this related to the debugobjects change here? It looks like another
version of list poison.

> +
>  #endif
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index 132f84a..ca00bd2 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -698,6 +786,7 @@ int kthread_worker_fn(void *worker_ptr)
>                 work =3D list_first_entry(&worker->work_list,
>                                         struct kthread_work, node);
>                 list_del_init(&work->node);
> +               debug_kwork_deactivate(work);

Shouldn't this come before the list operation so that any sort of fix
can be made before possibly corrupting a list?

>         }
>         worker->current_work =3D work;
>         raw_spin_unlock_irq(&worker->lock);
> @@ -835,8 +924,11 @@ static void kthread_insert_work(struct kthread_worke=
r *worker,
> =20
>         list_add_tail(&work->node, pos);
>         work->worker =3D worker;
> -       if (!worker->current_work && likely(worker->task))
> +
> +       if (!worker->current_work && likely(worker->task)) {
> +               debug_kwork_activate(work);
>                 wake_up_process(worker->task);
> +       }
>  }
> =20
>  /**
> @@ -1054,6 +1146,7 @@ static bool __kthread_cancel_work(struct kthread_wo=
rk *work, bool is_dwork,
>          */
>         if (!list_empty(&work->node)) {
>                 list_del_init(&work->node);
> +               debug_kwork_deactivate(work);

Same comment.

>                 return true;
>         }
