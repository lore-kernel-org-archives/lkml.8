Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7BBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F63206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 14:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6wjXpFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgG1OC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730155AbgG1OC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:02:57 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85987C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:02:57 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id n24so1266595ooc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 07:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jL69nX+B0Hx8u7JYf58E+XYay/YU8aCHKDCqftm6Jow=;
        b=k6wjXpFRtv5x15wt6DJdM0L4rO3whmGRX2Q8SaF9R2IG8WNwjhtcJVE3hk/WdhZJJ0
         7P7dWRayCH5GJ1KKywwpc6ussSFtA4ZLH9yKZnb3afhgBylKUHa7dH5fMkPvZ983d+RR
         WmtO5vyDWgRNuxyYeoLVyD4mSi++/pz6bG6qQXRY74CMSQSBLlvjfQacETc/zBbCyC3T
         qXvpvcEUzddgPHE5tXX6UPMGo1OCcOBM/Nf5TikK8CeGE1mfzxCOYkR5vjkdvxuX4lfu
         DcQTkfoLS2fmblyYlYtBVxo8Y6hWczqtEuthfFxdoBK3WcxZvIHQySZ9Yr4rvCiFJyCM
         L+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jL69nX+B0Hx8u7JYf58E+XYay/YU8aCHKDCqftm6Jow=;
        b=HmbnonYI1IeK0pXgSPdLl4PkeAaeJ+KMu/o5OttRn7xNK5S/8Co5ZOvE5hLa3cgdmN
         zbY5m8pPqOvUEvow9sZL2Yx7gd8D5ausA7MwJskgcXBXqhbQ6DMPrV0OvMikQ6G30l08
         Uw3NquletrHHgUbQvhPqzp2NCcbtmtiUnuH4TsjnbhUp2Jf2SOAybEb5dgICzd0yojN3
         8rR35/rJLR5WH6+UnZqiZlV9WgaLNUK2h1vvoVIwSlsW1AOu3EbDzUg8fT62j5uICjfA
         iKzScuXzCPeQYDIklJesUddIjVgMceKfbphrEb9lCue/2n+JBP/F+rfSF0nQF/hGozdx
         IYTw==
X-Gm-Message-State: AOAM532vyTCBdcAu3dJdPFvMeD6gocuPAqhzeO+Jjft3bH7hgWLseykX
        HukWbQILV6gNixZMoDDNznObrfqGDkpil9Szdds=
X-Google-Smtp-Source: ABdhPJy59m8Y7DkF+E9GWxzb8eZ+7RGaM33JtKndprA8Kb1UzGoWYfpy+k1WnCSY4O/AUCJouIL7k6YGk0QT5m7RYHE=
X-Received: by 2002:a4a:d4d9:: with SMTP id r25mr25151088oos.51.1595944976680;
 Tue, 28 Jul 2020 07:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <1595601083-10183-1-git-send-email-qianjun.kernel@gmail.com> <87sgddaru7.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87sgddaru7.fsf@nanos.tec.linutronix.de>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Tue, 28 Jul 2020 22:02:45 +0800
Message-ID: <CAKc596+vF4eYa4h55P2cssQbRKqBV_-9c_v35SXVMdonP3HBHA@mail.gmail.com>
Subject: Re: [PATCH V4] Softirq:avoid large sched delay from the pending softirqs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:41 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Qian,
>
> qianjun.kernel@gmail.com writes:
> >  /*
> >   * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
> >   * but break the loop if need_resched() is set or after 2 ms.
> > - * The MAX_SOFTIRQ_TIME provides a nice upper bound in most cases, but in
> > - * certain cases, such as stop_machine(), jiffies may cease to
> > - * increment and so we need the MAX_SOFTIRQ_RESTART limit as
> > - * well to make sure we eventually return from this method.
> > + * In the loop, if the processing time of the softirq has exceeded 2
> > + * milliseconds, we also need to break the loop to wakeup the
> > ksofirqd.
>
> You are removing the MAX_SOFTIRQ_RESTART limit explanation and I rather
> have MAX_SOFTIRQ_TIME_NS there than '2 milliseconds' in case the value
> gets adjusted later on. Also while sched_clock() is granular on many
> systems it still can be jiffies based and then the above problem
> persists.
>
> > @@ -299,6 +298,19 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
> >               }
> >               h++;
> >               pending >>= softirq_bit;
> > +
> > +             /*
> > +              * the softirq's action has been running for too much time
> > +              * so it may need to wakeup the ksoftirqd
> > +              */
> > +             if (need_resched() && sched_clock() > end) {
> > +                     /*
> > +                      * Ensure that the remaining pending bits are
> > +                      * handled.
> > +                      */
> > +                     or_softirq_pending(pending << (vec_nr + 1));
>
> To or the value interrupts need to be disabled because otherwise you can
> lose a bit when an interrupt happens in the middle of the RMW operation
> and raises a softirq which is not in @pending and not in the per CPU
> local softirq pending storage.
>
I can't understand the problem described above, could you explain in detail.

thanks.

> There is another problem. Assume bit 0 and 1 are pending when the
> processing starts. Now it breaks out after bit 0 has been handled and
> stores back bit 1 as pending. Before ksoftirqd runs bit 0 gets raised
> again. ksoftirqd runs and handles bit 0, which takes more than the
> timeout. As a result the bit 0 processing can starve all other softirqs.
>
May I use a percpu val to record the order of processing softirq, by the order
val, when it is in ksoftirqd we can process the pending softirq in order. In the
scenario you described above, before ksoftirqd runs, bit 0 gets raised again,
ksoftirqd runs and handles bit 1 by the percpu val. just like a ring.

Looking forward to your suggestions

Thanks
> So this needs more thought.
>
> Thanks,
>
>         tglx
