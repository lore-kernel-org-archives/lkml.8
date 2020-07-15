Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDCEC433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66C2820663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNU/a8gN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGOP32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgGOP31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:29:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34BC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:29:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k5so2523958plk.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NsVTKMQHcXz6J3A/ypoemuJWhWH2WwbAKe23Gvck/ck=;
        b=JNU/a8gNW+TVfbkVVJCH/zzGboANW0f0Aivs77jtY4RL70rWi8EYd3KVrtjkqM+Z43
         lIbI6Nw0ybwGLCzsPwpbWZ5TkWy6va6fIHFVQd6428zfTJx5C69QNzzfmPHLmN6uacov
         Wg97CauW0P+vaavlZUhGTAdFQwQaB1OvzYuDxusyHkiqQhghX8lip6Qht3Bdio2j88KH
         vYSLb4kAXy7ee/2mzwYQF0RP8x7FanyDhNksNvHzjcSN4BtIJ9+G72uxXDMoqiHjrdqz
         lK5MnbssJXW/Flloh4BIoLIljqJZCY+mbdDXUknB+M3dUO24rdUg96JHXLRz0dSg5ESw
         nu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NsVTKMQHcXz6J3A/ypoemuJWhWH2WwbAKe23Gvck/ck=;
        b=NFeiK//86lzXgpwR3LZXT6J80EYZ91g2LmL5GhKg2bChfHaHZppT3oPDdXr2EipzLY
         vEPBvA9uf4zmQZ6rORuyoTQ1n+V+ayFSVPbNRNrDbFgPomdFW3RmIOXDevje9uZ/chDu
         k4I1QL6TEC2ss7j8AajfsH0TnZhBRtrRMya1ST0oXLTQikQtxUeHMRZQ+roavfQF627P
         5xC4pWFyCLd26dc4Dazqk40YrrFOvzfAJvx0zv/16+kcZqj9ke/Zzxu9DP6OBXRsow8T
         Nhl7iam69icMqZ4l2lAj/5MXIz24MGNiXUEcDlpOD2yqlgUhJrA1yNXp2QX0E7hxhGX9
         h1Zg==
X-Gm-Message-State: AOAM5327B04zkxO3i4G9kiO4VrAA0fe2qpOwelB6lteodzQ1yXWmY0FY
        Qo/LJM17iOtqsjoya9whyyimUQ==
X-Google-Smtp-Source: ABdhPJxzTaKNDlcz2zjfD88yUXssxaBjVRKDiPgJK+zFwF5K7oQ1ISDCauWXQbDuS83OA5zix+z2NA==
X-Received: by 2002:a17:90b:33cc:: with SMTP id lk12mr188497pjb.194.1594826967281;
        Wed, 15 Jul 2020 08:29:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l191sm2285102pfd.149.2020.07.15.08.29.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 08:29:26 -0700 (PDT)
Date:   Wed, 15 Jul 2020 23:29:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        John Ogness <jogness@linutronix.de>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] time/sched_clock: Use raw_read_seqcount_latch()
Message-ID: <20200715152926.GA16686@leoy-ThinkPad-X240s>
References: <20200715095220.GH10769@hirez.programming.kicks-ass.net>
 <20200715115901.515956-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715115901.515956-1-a.darwish@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter, Ahmed,

On Wed, Jul 15, 2020 at 01:59:01PM +0200, Ahmed S. Darwish wrote:
> sched_clock uses seqcount_t latching to switch between two storage
> places protected by the sequence counter. This allows it to have
> interruptible, NMI-safe, seqcount_t write side critical sections.
> 
> Since 7fc26327b756 ("seqlock: Introduce raw_read_seqcount_latch()"),
> raw_read_seqcount_latch() became the standardized way for seqcount_t
> latch read paths. Due to the dependent load, it also has one read
> memory barrier less than the currently used raw_read_seqcount() API.
> 
> Use raw_read_seqcount_latch() for the seqcount_t latch read path.
> 
> Link: https://lkml.kernel.org/r/20200625085745.GD117543@hirez.programming.kicks-ass.net
> Link: https://lkml.kernel.org/r/20200715092345.GA231464@debian-buster-darwi.lab.linutronix.de
> References: 1809bfa44e10 ("timers, sched/clock: Avoid deadlock during read from NMI")
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> ---
>  kernel/time/sched_clock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index fa3f800d7d76..ea007928d681 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -100,7 +100,7 @@ unsigned long long notrace sched_clock(void)
>  	struct clock_read_data *rd;
> 
>  	do {
> -		seq = raw_read_seqcount(&cd.seq);
> +		seq = raw_read_seqcount_latch(&cd.seq);

Understand this is doing the same thing with __ktime_get_fast_ns() and
I saw Peter acked to make change for this.

Just want to confirm, since this patch introduces conflict with the
patch set "arm64: perf: Proper cap_user_time* support" [1], I should
rebase the patch set on top of this patch, right?

Thanks,
Leo

[1] https://patchwork.kernel.org/cover/11664031/

>  		rd = cd.read_data + (seq & 1);
> 
>  		cyc = (rd->read_sched_clock() - rd->epoch_cyc) &
> --
> 2.20.1
