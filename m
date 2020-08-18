Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41672C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 189A2206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8MxrtiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHRSNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHRSNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:13:22 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20B1C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:13:21 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a79so10352654pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPoLhWCuLlQUnGgkEzwWtnOhSRQmEhC1TsY+WB80aKc=;
        b=U8MxrtiMjqpFFaQCHDS9rCBze3AlW09ghWWFKCMIPFTSVqEpViPeAhaVKCcTB8o05X
         EtgOeHGeutGGY6dvi2+tEvlbyvYt0BlbUfFyrxRdocV4NPTY5EB/OLrQdrhG5ZLZNa2e
         5zrHyFxQqhyIuGfsRMJ8QOZYr9vvLbXYFH36Ax6iWdYN9QB7Uwtx4Y1C1J17+2jXgBjT
         qIWDvUYJe5k/qTHlXl1FGbwlPuxMZ8Eti9ePpmtGrkGnmgN1jFn9Bh5ksziJY+8BD/vW
         gzThbyvsCKuLQim4aC2JG0FW14+DDY2Pa2sh+hhswLuX7w9PaqMF0d+qxMA5nfQxHfo3
         FgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPoLhWCuLlQUnGgkEzwWtnOhSRQmEhC1TsY+WB80aKc=;
        b=VTTF/NIGqwC1Av6PQR+SJ/kPekB/ozsvEjbkd3ychqVd8MIQm0nYErf8F3Ih0lJaS+
         Jt0RwuRcgexZqZrhiZLjWTfDUURRWe7/YFJPkDd9Fq4ZKJ0MyraUmIHapSkvFQ6qJ79R
         SP/Um3GqjjLDLZH/mVSe7t5YnK1JlQ4q8Bl9CpXLUsIAHnQjrGKnh9Hyaq++Jn0ZAMRT
         dIQyJamHA8YgA47Ggnp+bBpEVhvmMtFsKzSFfhQF5KZUv2HO7jjhvMDM6vw55U76MEDQ
         Yct+l3z+FTGTImioYjO9HgYQTj8SCOt3c+FatfR0ECMGBg+eYPvnxPSkieCDQR3do5H5
         f9NQ==
X-Gm-Message-State: AOAM533NSMxBW0t1DhBz9Ew+E31w3Cr/XT6nBKsp0EnsDrQa+YJpfJSN
        toYbnDCCQBHS0KBrFjqqhJPX6sthbotrud+AoQcTIWb/kss=
X-Google-Smtp-Source: ABdhPJy65D+w4GlpCgLmKF3fxX6AYxslK3vUHfaskdTjQH6k+Ivr7OLN81qH/LD5+sh62JIMdgX64pXSMGqVLxIYl9c=
X-Received: by 2002:a05:6a00:14d0:: with SMTP id w16mr15947397pfu.39.1597774401186;
 Tue, 18 Aug 2020 11:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200818170337.805624-1-alex.dewar90@gmail.com>
In-Reply-To: <20200818170337.805624-1-alex.dewar90@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Aug 2020 11:13:10 -0700
Message-ID: <CAKwvOdk2fynn=-FGUniYLG+hCOkEFppRnAaTYe8DW=YRrT-siQ@mail.gmail.com>
Subject: Re: [PATCH] sched/cputime: Mark function as __maybe_unused
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 10:04 AM Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> Depending on config options, account_other_time() may not be called
> anywhere. Add __maybe_unused flag to fix clang warning.

Just curious, would moving this definition to be within an existing
preprocessor guard for a particular config also fix the issue? If so,
prefer that. If not, __maybe_unused is the way to go.

>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  kernel/sched/cputime.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index 5a55d2300452..43ede0d6661c 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -252,7 +252,7 @@ static __always_inline u64 steal_account_process_time(u64 maxtime)
>  /*
>   * Account how much elapsed time was spent in steal, irq, or softirq time.
>   */
> -static inline u64 account_other_time(u64 max)
> +static inline u64 __maybe_unused account_other_time(u64 max)
>  {
>         u64 accounted;
>
> --
> 2.28.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200818170337.805624-1-alex.dewar90%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
