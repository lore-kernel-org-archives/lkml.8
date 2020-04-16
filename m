Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4796C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5720774
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKlcSTBO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgDPNwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 09:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2897376AbgDPNhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:37:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158AEC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:37:00 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t11so5604760lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwBByiAv3HXmeAVixqGHcJ2QpuSnLZEjcGbMG0rBWiQ=;
        b=nKlcSTBO8GkCKIkCf8/N+OMHUq2yJYsqJGYD/0xJeirmiL64DS1GL7ARltujhYVJCj
         dUcAkGooLg9w7Fuy+DNQJD2FFRtk0QD57uBCP94rYqxGvIPCvKR1dw+XyStjOb2YoAIl
         PwdoynVoOS9JWj3oNz4rDpHm2mwiLLDuy0685MPer49Pl2VzWtr5+7AHZ0owr7GSU2Vw
         Dx4+edpy7ydLHo4deZyEk3HcgSrgU4jl57t7L1kVq6AvvsEqujV7hZOY0EHmgzsbwUir
         KvceFCIP5jh/EonIzK2rfMaLEHcFLOao5FM/mJFsc+ZypqihrCRzBvizg+3e1qUDVRwt
         1Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwBByiAv3HXmeAVixqGHcJ2QpuSnLZEjcGbMG0rBWiQ=;
        b=aNqX6bL24G3rGLgDvRXtzDgK/UeVjH3Nf7p76xSeNct71zgsgkhIwksY16bU+s4lMh
         am9pyiKnpXeMVlWDrS/KTfGvL6Yyuys38w6vhVxh3Dqz2INLKydzUzNzfwbxOnMb0H/5
         LG8QWoTw8jJjzsW2DJnhXHkQkAgYB/gJxR7lKUigG6sr7jMcFM0K7DdDxRRNSk/J6L5i
         NVj5fYmJ9cL7CkKr2KUXmePD9xwcRGAAZIRDo8i2WxRBtgYv4hjGFZJCtQOub9+l8hNY
         sw08OnThW+aEa5ksqp3kPhtftaAD619xc5LItO4iE4dRyqRoBeV0SJcotS+kdA/6NImi
         CRGA==
X-Gm-Message-State: AGi0PuYi2cRJkDH0NPnr2RH3VMKAEJVJ9zWTTR5IWILRjOU0PXsCbv3L
        qOk7EEo4B3R/1uI7uHhKT8JumRwz9yO2XIZHriXteQ==
X-Google-Smtp-Source: APiQypLmaDu06MvhRiFlvEJ/ov7gw/I0ZklH5i188LmiqNllxsyeo5Ed3VdGtvtxCNaWeQh4QttNyhq118LSIysiZXQ=
X-Received: by 2002:ac2:51c9:: with SMTP id u9mr6422380lfm.184.1587044218400;
 Thu, 16 Apr 2020 06:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200415210512.805-1-valentin.schneider@arm.com>
 <20200415210512.805-10-valentin.schneider@arm.com> <CAKfTPtBDGzrvG=YhjBZBEgfx5EtM-rTC-dWX5phqh4bOY5XqgA@mail.gmail.com>
 <jhj4ktjpw2z.mognet@arm.com> <d508a6a5-c04f-087f-8767-6fb397b70055@arm.com>
In-Reply-To: <d508a6a5-c04f-087f-8767-6fb397b70055@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 16 Apr 2020 15:36:46 +0200
Message-ID: <CAKfTPtD5x_NQ1KfHhTiAR3eNA85+k13nfSR-9_PKLp6FgVu08A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] sched/topology: Define and use shortcut pointers
 for wakeup sd_flag scan
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Apr 2020 at 15:04, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 16.04.20 12:24, Valentin Schneider wrote:
> >
> > On 16/04/20 08:46, Vincent Guittot wrote:
> >>> @@ -6657,7 +6646,19 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
> >>>
> >>>         rcu_read_lock();
> >>>
> >>> -       sd = highest_flag_domain(cpu, sd_flag);
> >>> +       switch (wake_flags & (WF_TTWU | WF_FORK | WF_EXEC)) {
> >>> +       case WF_TTWU:
> >>> +               sd_flag = SD_BALANCE_WAKE;
> >>> +               sd = rcu_dereference(per_cpu(sd_balance_wake, cpu));
> >>
> >> It's worth having a direct pointer for the fast path which we always
> >> try to keep short but the other paths are already slow and will not
> >> get any benefit of this per cpu pointer.
> >> We should keep the loop for the slow paths
> >>
> >
> > Which fast/slow paths are you referring to here? want_affine vs
> > !want_affine? If so, do you then mean that we should do the switch case
> > only when !want_affine, and otherwise look for the domain via the
> > for_each_domain() loop?
>
> Coming back to the v2 discussion on this patch
>
> https://lore.kernel.org/r/20200311181601.18314-10-valentin.schneider@arm.com
>
> SD_BALANCE_WAKE is not used in mainline anymore, so wakeups are always
> fast today.
>
> I.e. you wouldn't need a per_cpu(sd_balance_wake, cpu) since it's always
> NULL.
>
> I.e. want_affine logic and the 'for_each_domain(cpu, tmp)' isn't needed
> anymore.
>
> This will dramatically simplify the code in select_task_rq_fair().
>
> But I guess Vincent wants to keep the functionality so we're able to
> enable SD_BALANCE_WAKE on certain sd's?

I looked too quickly what was done by this patch. I thought that it
was adding a per_cpu pointer for all cases including the fast path
with wake affine but it only skips the for_each_domain loop for the
slow paths which don't need it because they are already slow.

It would be better to keep the for_each_domain loop for slow paths and
to use a per_cpu pointer for fast_path/wake affine. Regarding the
wake_affine path, we don't really care about looping all domains and
we could directly use the highest domain because wake_affine() that is
used in the loop, only uses the imbalance_pct of the sched domain for
wake_affine_weight() and it should not harm to use only the highest
domain and then select_idle_sibling doesn't use it but the llc or
asym_capacity pointer instead.
