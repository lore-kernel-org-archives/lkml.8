Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA10BC35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 06:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC0F2071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 06:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwAfuCGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgAZGlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 01:41:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35907 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgAZGlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 01:41:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id f24so4030268lfh.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 22:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5C28FWFmtkB52uEIeP3Jlf3NfYS9TEO0X+j3iCrN7vk=;
        b=VwAfuCGK7dXmdgy4VgKXiclK866t47Gl1YYdvqp+K4j9JqL/fJ/FXC35OdhlfTa5MO
         NuPhd2wumA8iedA+5pk4t83qOKxYYlEzml+fPNjgQts2u7GwLeJ9Ofn1NvvnuTbIJiqY
         eAJvtUrYtGQd2TK8EBn07GAfvebsdImNJDPlBntiE84LY97gxIzDmPTa1vxW4IINZ55b
         /YYbp6w197Qa4wpZyVsaSwPjoa1UoBpV8oSzy4DYtCwpfDxjkYzPspGEO2npawPAfScd
         64x4Ym1Vt/iN7KP4ptHV+a6c+aUWEEJNZfVItpQvpNZDXk3Cxt/CSBP6C4lwxGnmGm7a
         OYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5C28FWFmtkB52uEIeP3Jlf3NfYS9TEO0X+j3iCrN7vk=;
        b=F+wMEUN0J+npUUlNjF+A2UJEt6Sk58eK87jUs9DymRbEWroaPYNjsz3VavtIUSXKVJ
         /wdAeM5d7Wj5U1N7U/jvaBATI3vnNYaNcI1HSEjwaJmJ4+uucNn654HB/S9G4xJCoxbD
         gIhQEwYIwmRJ4hqvq9rZ224pm+980eCHnqALoAf4Dt9QpMf2/ptYj08rcRveVycGJRsH
         YUA1PM0XVMURup+JMg4NW/fyxaza9RQFL22S5d/q7x+h/iHI1LBycjKXccST49jyuC7G
         88BEs1fv0QxWppTnknCDy4N9hEgvLAQrVd++oIOdMu3Y86j/gcSDZnuuGkNa0oLRTY4s
         DkAg==
X-Gm-Message-State: APjAAAWTzI6xN8KbYvfRvX3e0cyw7VmsUvPkzIjetWmjXO4C2lD/1mmP
        TzZGEVJP96iJThnakNUfheLvArIMfBgqm53bH7Y=
X-Google-Smtp-Source: APXvYqxMkKJpNN8pUCRpW8fBEV0h3mqYIvst82F83LWy1k2W6aIrO75TY6pka1HKVv8lqtPwx4akQpm3LMyu+sYTPtM=
X-Received: by 2002:ac2:599c:: with SMTP id w28mr5299421lfn.78.1580020910045;
 Sat, 25 Jan 2020 22:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20200124002811.228334-1-wvw@google.com> <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com> <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
 <20200124113050.i6ovkibcmutypm3q@e107158-lin> <CAGXk5yrTc2-k5oDjGyAwYn2KTroQy0JtEYQzSeOizjg_hyMGkg@mail.gmail.com>
 <20200125235934.wrs2nryuk3wmtkxr@e107158-lin>
In-Reply-To: <20200125235934.wrs2nryuk3wmtkxr@e107158-lin>
From:   Wei Wang <wei.vince.wang@gmail.com>
Date:   Sat, 25 Jan 2020 22:41:14 -0800
Message-ID: <CAMFybE7eQz60yXJKJfGCuzJXTAS-np0qmz3WWeOAEX6CuXhwDA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Wei Wang <wvw@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 3:59 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 01/24/20 12:55, Wei Wang wrote:
> > > > So I'm pretty sure we *do* want tasks with the default clamps to get iowait
> > > > boost'd. What we don't want are background tasks driving up the frequency,
> > > > and that should be via uclamp.max (as Quentin is suggesting) rather than
> > > > uclamp.min (as is suggested in the patch).
> > > >
> > > > Now, whether that is overloading the usage of uclamp... I'm not sure.
> > > > One of the argument for uclamp was actually frequency selection, so if
> > > > we just make iowait boost respect that, IOW not boost further than
> > > > uclamp.max (which is a bit better than a simple on/off switch), that
> > > > wouldn't be too crazy I think.
> > >
> > > Capping iowait boost value in schedutil based on uclamp makes sense indeed.
> > >
> > > What didn't make sense to me is the use of uclamp as a switch to toggle iowait
> > > boost on/off.
> >
> > Sounds like we all agree on adding a new toggle, so will move forward
> > with that then.
>
> Looking more closely at iowait boost, it's not actually a generic cpufreq
> attribute. Only schedutil and intel_pstate have it. Other governors might
> implement something similar but under a different name.
>
> So I'm not sure how easy it'd be to implement a generic toggle for something
> that probably should be considered an implementation detail of a governor and
> userspace shouldn't care much about.
>
> Of course, the maintainers might have a different opinion. So don't let mine
> discourage you from pursuing this further! :-)
>
Indeed, that's why I was hesitate to add the toggle and wanted to
bring this up for Android common kernel first. :-)

> > For capping iowait boost, it should be a separate patch. I am not sure
> > if we want to apply what's the current max clamp on the rq but I do
> > see the per-task iowait boost makes sense.
>
> It is true the 2 patches are orthogonal, but if you already cap the max
> frequencies the background task can use, by ensuring the iowait_boost in
> schedutil respects the uclamp restrictions then this should solve your problem
> too, no?
>

We haven't tried on 5.4, and there is no uclamp policy placed for
background yet. Also I am not sure it is beneficial to do uclamp
restriction on those kernel threads (e.g. is f2fs's gc), but that is
an interesting experiment on power balance. Also for applying at rq
lever, what if there are foreground tasks (and it could be the case
sometimes).



> The patch below only compile tested.
>
>
>         background/cpu.uclamp.max = 200 # Cap background tasks max frequencies
>
> ---
>
> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> index 9b8916fd00a2..a76c02eecdaf 100644
> --- a/kernel/sched/cpufreq_schedutil.c
> +++ b/kernel/sched/cpufreq_schedutil.c
> @@ -421,7 +421,8 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
>          * into the same scale so we can compare.
>          */
>         boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
> -       return max(boost, util);
> +       boost = max(boost, util);
> +       return uclamp_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
>  }
>
>  #ifdef CONFIG_NO_HZ_COMMON
>
> --
> Qais Yousef
