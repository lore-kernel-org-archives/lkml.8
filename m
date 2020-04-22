Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429D7C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C868206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yxD/HtWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDVNWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:22:00 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8E8C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:21:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g10so1606123lfj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=warOQZMnN+8uV4OA+3DzFVUnpPLSoRdRCB/511qDEfg=;
        b=yxD/HtWhT0spIj3Te6eAFm69YzoVsGgw0KFTgyzeRKdbF4sNPmPbK+Uj4TQ8JOxgyk
         Odwn4XY/lYQDDES8v2Jviymjhs00KKSm/IgG8wYzYu+tbyDt4dFSDqTzMjubiAPFl5Ff
         yi8exEsWRp/eqwY+FVhpR4nnp88QkfdX/0QKQFpPCU5tSCXDE7/pLraquZ0ujS9cdSfa
         SoVSIe/YRG4Bll+PI2520W7AOSueK4k9juBADOMq32nmM4MWIbja+Oz9Npyr7zWPGQVx
         9E3PpU2bL1gZRuyXJe4CuDUtUo5oc/c1CrCoAct5MhyGhxoB4bkztxdsAyoRthjpgM7q
         Z8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=warOQZMnN+8uV4OA+3DzFVUnpPLSoRdRCB/511qDEfg=;
        b=B9MMs037bvy4frUruHGzJV/7fZ1bgedVOvcVMZnAMBnNtrDnDEWsxSpcaMJ214LnIb
         mne/0CrIkFU7xzKbbSyyRJ9msgHd3KBYsHlSPH8q9QYEnPu5mIXQAxd/cpD9O7lNI5tG
         C8Ydokz4sK02+L8hnWbqOEVpM148rXrnbXb0wE9kctEx/uSidnry9MEjWv5V5PBhUAay
         2CP5mzTGQ1xQL4iGMeGO5cW/zuuVtOk62ZBG9c+nMVD9HtwcOj39Iif8ithWhtGNne/z
         ysDpyWvm6/R86+aFM8xpTWR0FRPZBBv/ZbJVLZkjcPOE7f2e1A5ofC+DMaHZVN8Y/v78
         0tUw==
X-Gm-Message-State: AGi0PuaadyHNmHeJ5w0/lOEvGHZlP4gQD41FevBmbYsMPSIy3rporVZ1
        +Dok6C7WtHIxdUrBV6tEnxQk612DjrA+bhlrc1VeOA==
X-Google-Smtp-Source: APiQypK6aHNkNmAQLRyNYvHySvNjV/JodbscZlL/ss00FperuCqsPymgUAShOEb1XE2L9I+UgO5Ac5N96cr+gxD4CNU=
X-Received: by 2002:ac2:46f9:: with SMTP id q25mr17308196lfo.149.1587561717947;
 Wed, 22 Apr 2020 06:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.988065598@infradead.org>
In-Reply-To: <20200422112831.988065598@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Apr 2020 15:21:45 +0200
Message-ID: <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> In an attempt to take away sched_setscheduler() from modules, change
> this into sched_set_normal(.nice = 19).
>
> Cc: john.stultz@linaro.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/staging/android/ion/ion_heap.c |    3 ---
>  1 file changed, 3 deletions(-)
>
> --- a/drivers/staging/android/ion/ion_heap.c
> +++ b/drivers/staging/android/ion/ion_heap.c
> @@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *
>
>  int ion_heap_init_deferred_free(struct ion_heap *heap)
>  {
> -       struct sched_param param = { .sched_priority = 0 };
> -
>         INIT_LIST_HEAD(&heap->free_list);
>         init_waitqueue_head(&heap->waitqueue);
>         heap->task = kthread_run(ion_heap_deferred_free, heap,
> @@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct i
>                        __func__);
>                 return PTR_ERR_OR_ZERO(heap->task);
>         }
> -       sched_setscheduler(heap->task, SCHED_IDLE, &param);
> +       sched_set_normal(heap->task, 19);

Would it make sense to have a sched_set_idle(task) to enable kernel
setting SCHED_IDLE task ?

SCHED_NORMAL w/ nice 19 and SCHED_IDLE tasks are not treated in the
same way when checking for preemption at  wakeup

>
>         return 0;
>  }
>
>
