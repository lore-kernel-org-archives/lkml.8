Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D8EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2F5207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/WrzGh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGVE7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgGVE7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:59:01 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FBAC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:59:01 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id o36so166587ooi.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 21:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fvKje/flZG2W9r6KvNfECW5YpgjVOIBT6/TN29xaYbY=;
        b=a/WrzGh+g6bK6Gi4fQ/ADVUL9XxFAJz8xhvJmEYpYj3Fueb5WyhhboRaPKkWMWmf1A
         TurpQHuRrAUp//86c5ud+CUxmfaFa05lPXYlZIgjcIZxMwPnWkZSzZ454/++NAlIalZs
         UIOYsA/AOaeU13sx9R00UeiMQNGa04w6HiAu4GBGwOJfSl7NEF0AR69YElnD1uFDrRMG
         sz+Yxk1nDsbTUj7cnM5wROeHq3UQejZi6gumUFQepk1QdwUWedZcz/5lVHLFXnacN3BX
         iH2rLA4Sbtz5d2V1QfGaH+PEs35HLZM0fVCIsQZCV8UaYjB1VMY+AwAEJE2bvrrTPRVy
         ClGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fvKje/flZG2W9r6KvNfECW5YpgjVOIBT6/TN29xaYbY=;
        b=mMNf9BuhLiuZuyhJejO2bx5/Vve0/aO0mfQFlr+SH+OmUAMruVCyz9POES71c3pnm+
         dUTtAoQo6p/JtQi6Bi0d9Pt63cCT9Dz3ueTwD5w3Tja7Nbe7MMpac64HD+FTo4CLVup3
         euoNCINjHuYPcHxWa8FOwDWT3KD4T14/ZZhUBkJYe2qfsckA2K4037BlyY/HiUQ5dB9q
         ExJLl8xWA7rZ4pw3hkdcsO3Otfn9gEHNUKL7F2k82KVNw4izcyANJ309dJiA0H09AtyC
         cM7BLvSxrcCcpxwxctL8LsTQ22DrhHQ+XFX5jw97sv0eYIo5CbBwYIiAB6WOdneRtnCa
         FCXw==
X-Gm-Message-State: AOAM532w3i3sBy4Ev8ONSgaPyxfl++PeZ3dQ5WvfyGskztPUSjaqLAbW
        NXus2B75QI4gTHAInvc0yoBvpvwFFGgYksdGVZA=
X-Google-Smtp-Source: ABdhPJwMznA8HHNg6DAvUiHTcd5uDlMnOFCJIkKxE9tYe2goeWnrI3AS6OnS9i0X+LxqkB/RSEAqx1Y4/Juw6ywYPjk=
X-Received: by 2002:a4a:d4d9:: with SMTP id r25mr26954497oos.51.1595393940797;
 Tue, 21 Jul 2020 21:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <1595250506-9769-1-git-send-email-qianjun.kernel@gmail.com>
In-Reply-To: <1595250506-9769-1-git-send-email-qianjun.kernel@gmail.com>
From:   jun qian <qianjun.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 12:58:49 +0800
Message-ID: <CAKc596J7T7nbft1AEfLN09Seo1mYB_j4t=P5CXxDt6RuNyCYoA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Softirq:avoid large sched delay from the pending softirqs
To:     tglx@linutronix.de, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>
Cc:     laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter & Uladzislau

Are there any issues that have not been considered in this patch? Can
you give me some suggestions on this issue. If the situation I
described is indeed a problem=EF=BC=8Chow about this modification. Thanks a
lot.

On Mon, Jul 20, 2020 at 9:09 PM <qianjun.kernel@gmail.com> wrote:
>
> From: jun qian <qianjun.kernel@gmail.com>
>
> When get the pending softirqs, it need to process all the pending
> softirqs in the while loop. If the processing time of each pending
> softirq is need more than 2 msec in this loop, or one of the softirq
> will running a long time, according to the original code logic, it
> will process all the pending softirqs without wakeuping ksoftirqd,
> which will cause a relatively large scheduling delay on the
> corresponding CPU, which we do not wish to see. The patch will check
> the total time to process pending softirq, if the time exceeds 2 ms
> we need to wakeup the ksofirqd to aviod large sched delay.
>
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  kernel/softirq.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index c4201b7f..f8e5be9 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -210,7 +210,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned =
int cnt)
>   * we want to handle softirqs as soon as possible, but they
>   * should not be able to lock up the box.
>   */
> -#define MAX_SOFTIRQ_TIME  msecs_to_jiffies(2)
> +#define MAX_SOFTIRQ_TIME 2000  /* In microseconds */
>  #define MAX_SOFTIRQ_RESTART 10
>
>  #ifdef CONFIG_TRACE_IRQFLAGS
> @@ -248,7 +248,8 @@ static inline void lockdep_softirq_end(bool in_hardir=
q) { }
>
>  asmlinkage __visible void __softirq_entry __do_softirq(void)
>  {
> -       unsigned long end =3D jiffies + MAX_SOFTIRQ_TIME;
> +       ktime_t end, start;
> +       s64 delta;
>         unsigned long old_flags =3D current->flags;
>         int max_restart =3D MAX_SOFTIRQ_RESTART;
>         struct softirq_action *h;
> @@ -256,6 +257,8 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
>         __u32 pending;
>         int softirq_bit;
>
> +       start =3D ktime_get();
> +
>         /*
>          * Mask out PF_MEMALLOC as the current task context is borrowed f=
or the
>          * softirq. A softirq handled, such as network RX, might set PF_M=
EMALLOC
> @@ -299,6 +302,15 @@ asmlinkage __visible void __softirq_entry __do_softi=
rq(void)
>                 }
>                 h++;
>                 pending >>=3D softirq_bit;
> +
> +               end =3D ktime_get();
> +               delta =3D ktime_to_us(end - start);
> +               /*
> +                * the softirq's action has been running for too much tim=
e
> +                * so it may need to wakeup the ksoftirqd
> +                */
> +               if (delta > MAX_SOFTIRQ_TIME && need_resched())
> +                       break;
>         }
>
>         if (__this_cpu_read(ksoftirqd) =3D=3D current)
> @@ -307,7 +319,9 @@ asmlinkage __visible void __softirq_entry __do_softir=
q(void)
>
>         pending =3D local_softirq_pending();
>         if (pending) {
> -               if (time_before(jiffies, end) && !need_resched() &&
> +               end =3D ktime_get();
> +               delta =3D ktime_to_us(end - start);
> +               if (delta < MAX_SOFTIRQ_TIME && !need_resched() &&
>                     --max_restart)
>                         goto restart;
>
> --
> 1.8.3.1
>
