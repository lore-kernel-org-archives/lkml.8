Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1846BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E794C22B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NjucUtfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgGTLdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTLdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:33:22 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAADC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:33:22 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t18so11873692otq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP5L8ZYlnMiV5ZTm2sQFXgML/ys0EXULYpA2BT9n7uo=;
        b=NjucUtfBLZZSjns6MT3sM9MAzptturfs1zvMhg+JhpbqBxVuuK8bvlelU6EtCsc3xe
         o4jBXB+pQnWI7zoOqr/rskZx/drISVNJdlK3GwnTKomSjmTnseDE4vBQ9Nr3odvKk1Ei
         RQztpWAn82sJHXSYNCN/Oqt/2y/96f+qIUQaK3tWzlgfEX14FUqGNwxzuTC8sjPDaZlT
         14UZdZutyhON/NdgOA7SmqM/kw05/zVQVrvwVhN9qdoIIJGruavjdgSmrNUAbKq9SUfF
         aOdjs+GLPdspXBsr5PZ88qIW/3lYKcijF65phNGtDt5qIIx2oU0maFXkZS3VjL1Z0KE1
         +BKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP5L8ZYlnMiV5ZTm2sQFXgML/ys0EXULYpA2BT9n7uo=;
        b=e+f7KMdzXoJWnx8HsqHlyUeE91rn6wqHU3uL9emcif0xBR9hwEGkZQy63Qjwla+CZq
         En2lNPU016DDWMBKMh4c8CmUYxeyr/fRWnwRt4BEt5ksfavHUtn9vjOR2PdqPo1X5vbJ
         A0eSW02/qIQEi9NkGWe/0s813F6NOliZMHYC1hTUPEEn5GtyeORoC8RVLUd6AHdHu1es
         Hv8wyRjVO3gh2yXtS7Ki9Gy91Q9c3OZeYk57uFxX1bTYphvnUB/o6G9M+ZAormDdn46R
         YnX8+JdkSl3a9/RIVIsn7snKjVqBh5AQuD+JkIs8VctYG1V2de0isaKacwCntXri5GpB
         VNkQ==
X-Gm-Message-State: AOAM532bFxSRekXHexXoyhxXTlbl//xJIZlBopLBcZwXH7aGoaO9khLO
        6/o6oigLPTG9QqJqSq+3jdIHIubx39S2UZox4sTJd+K6
X-Google-Smtp-Source: ABdhPJzxz7K+Wej434JoZ5m4ZwMsiLrlNMgaHkJFzUDaMfBzDduRPltJQfHKD5ZwQXyeMq+clramMioQzEdhzLhJNkY=
X-Received: by 2002:a9d:12d4:: with SMTP id g78mr19137557otg.215.1595244801543;
 Mon, 20 Jul 2020 04:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <1594967873-29522-1-git-send-email-qianjun.kernel@gmail.com> <20200717220735.GA5965@pc636>
In-Reply-To: <20200717220735.GA5965@pc636>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Mon, 20 Jul 2020 19:33:10 +0800
Message-ID: <CAKc596Ju9LAbTH6YNnkpHQO3qc001mmjiP-0C=6kmTdOtMy_2Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Softirq:avoid large sched delay from the pending softirqs
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 6:07 AM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > From: jun qian <qianjun.kernel@gmail.com>
> >
> > When get the pending softirqs, it need to process all the pending
> > softirqs in the while loop. If the processing time of each pending
> > softirq is need more than 2 msec in this loop, or one of the softirq
> > will running a long time, according to the original code logic, it
> > will process all the pending softirqs without wakeuping ksoftirqd,
> > which will cause a relatively large scheduling delay on the
> > corresponding CPU, which we do not wish to see. The patch will check
> > the total time to process pending softirq, if the time exceeds 2 ms
> > we need to wakeup the ksofirqd to aviod large sched delay.
> >
> > Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> > ---
> >  kernel/softirq.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/kernel/softirq.c b/kernel/softirq.c
> > index c4201b7f..602d9fa 100644
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -299,6 +299,9 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >               }
> >               h++;
> >               pending >>= softirq_bit;
> > +
> > +             if (time_after(jiffies, end) && need_resched())
> > +                     break;
> >       }
> >
> >       if (__this_cpu_read(ksoftirqd) == current)
> >
> I have a small concern about MAX_SOFTIRQ_TIME. The problem is that
> an "end" time is based on jiffies/tick update, so it depends on CONFIG_HZ
> value of your kernel.
>
> For example if we have CONFIG_HZ=100, msecs_to_jiffies(2) will return 1.
> For HZ=100 one jiffie is 10 milliseconds. So we can not rely on it,
> because of low resolution.
>
 good tip. Does this problem also exist in the current code, just like this:

        if (pending) {
                if (time_before(jiffies, end) && !need_resched() &&
/* low resolution problem */
                    --max_restart)
                        goto restart;

                wakeup_softirqd();
        }

> Maybe it make sense to fix it first in order to be at least aligned with
> "2 milliseconds time limit" documentation?
>
> <snip>
>  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
>  * but break the loop if need_resched() is set or after 2 ms.
> <snip>
>
I can't find the snip from the linux/Documentation/, could you please
tell me where I can find this snip, thks

> ktime_get()/ktime_before()...?
>
if the low resolution problem also exists in the above code, i think
also need to fix it with using ktime_get()/ktime_before().

> --
> Vlad Rezki
