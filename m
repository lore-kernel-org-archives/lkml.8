Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD74C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A175D206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mz/40O3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCMNVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:21:16 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38999 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbgCMNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:21:16 -0400
Received: by mail-lj1-f195.google.com with SMTP id f10so10482192ljn.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RJLnTnm7s04iW7LrJXTv+qyavcLzxiqAnsbMJS83S3g=;
        b=Mz/40O3Mx7TdmfcBvwwu9RMoDrLqwnVjTPMYE47Srzdebk24tCWbcU3QwxNiEgbIZe
         FLzTBRQSzx90vg36icDMO7NafRQ/Tx5//800cXxFOt4ne5yIBSlxtIf8jS4zuOAdJ0a5
         mHMkhbbBRUK3GCXNZhymDIIAPRRiH9Zgtr39+EqDb/2ImYthNs53LcK99QRliW2eY/DO
         hRHZm5fUc6++gIdeECY61EbTHHM77+TMCF6TxLtsmBNcNhZsWXrD9cE3VeqNyjDfIOYS
         fDK2kdYq1aR+OYmacB6WueRd/DF550WX1x/O9LTquNpMS7uu3YLpZOosf2HW/sifLgms
         O/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RJLnTnm7s04iW7LrJXTv+qyavcLzxiqAnsbMJS83S3g=;
        b=Xdzv4OsfX5Zw+gYgqH7O2kvw2+LTMWeemjimXmy+Xf9BFoD+ZdTasRV+a4xPDnGko1
         HErcbzh1wjXOco1HomhRJeONQulaUzdmSN5ruRKX3YCE08A9hFt0a0nvtz8IfGMNEYDn
         xt0ZBi14FYBQ3uETi491XsGt3r9x2X5WPZ+0eFzU5GKa8oE/rx4dzWr61sdq0SmYo4Ho
         LigruswopwUlmNH5bY+7oH4KKsOuzOLlx2nY90M9hc+vDSpIiC0ZlQ1Dp4tfpS3iaVhL
         WLMleMc9C/o49/jGiCJnTIOzIYRnpy68KX5znBpZqrLdr/MFFQgvyO6+LTA6dcbdCllI
         ixKw==
X-Gm-Message-State: ANhLgQ0xyLadKR6BtsDMGDdFJyc2iAQC/hdzCAClF8x2eiS9iBx7hdcv
        VdXdNm51632GnsdgEprEI1rgAgHTegAqBEeYltDVFg==
X-Google-Smtp-Source: ADFU+vvOQ69ccftOQOxCbEnu2XesSFMM2nDgZ4cUXoOg6ATf6alJEQkwaaAK6WNKJOw5T9uGoAOD/UEHr8axYthMuUU=
X-Received: by 2002:a2e:8112:: with SMTP id d18mr8088951ljg.137.1584105673499;
 Fri, 13 Mar 2020 06:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200311202625.13629-1-daniel.lezcano@linaro.org>
 <CAKfTPtAqeHhVCeSgE1DsaGGkM6nY-9oAvGw_6zWvv1bKyE85JQ@mail.gmail.com>
 <e6e8ff94-64f2-6404-e332-2e030fc7e332@linaro.org> <CAKfTPtBU1fyxWhR04QTCbvn07KgTqAHRVOt18D3TxmZSeiHQQQ@mail.gmail.com>
 <ee3bbfeb-ddd5-e4dc-3999-39370e7a6c73@linaro.org> <CAKfTPtDUmqYB1i7UcYXxcNjnQOoGufsB9do-9NxTMeWdJAfP2w@mail.gmail.com>
 <c652094b-83bf-1f4c-4b9a-ff911864125f@linaro.org>
In-Reply-To: <c652094b-83bf-1f4c-4b9a-ff911864125f@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 14:21:02 +0100
Message-ID: <CAKfTPtBYDOypA1sMdtNniiTw_C7fNieWXXwPe7oDOzPUW0PW_Q@mail.gmail.com>
Subject: Re: [PATCH V2] sched: fair: Use the earliest break even
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 14:17, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 13/03/2020 14:15, Vincent Guittot wrote:
> > On Fri, 13 Mar 2020 at 13:15, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>
> [ ... ]
>
> >>>>>> +
> >>>>>> +       if (idle_state)
> >>>>>> +               idle_set_break_even(rq, ktime_get_ns() +
> >>>>>
> >>>>> What worries me a bit is that it adds one ktime_get call each time =
a
> >>>>> cpu enters idle
> >>>>
> >>>> Right, we can improve this in the future by folding the local_clock(=
) in
> >>>> cpuidle when entering idle with this ktime_get.
> >>>
> >>> Using local_clock() would be more latency friendly
> >>
> >> Unfortunately we are comparing the deadline across CPUs, so the
> >> local_clock() can not be used here.
> >>
> >> But if we have one ktime_get() instead of a local_clock() + ktime_get(=
),
> >> that should be fine, no?
> >
> > Can't this computation of break_even be done in cpuidle framework
> > while computing other statistics for selecting the idle state instead
> > ? cpuidle already uses ktime_get for next hrtimer as an example.
> > So cpuidle compute break_even and make it available to scheduler like
> > exit_latency. And I can imagine that system wide time value will also
> > be needed when looking at next wakeup event of cluster/group of CPUs
>
> Ok, so you suggest to revisit and consolidate the whole time capture in
> cpuidle? I think that makes sense.

Yes

>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
