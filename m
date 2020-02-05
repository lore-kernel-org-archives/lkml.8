Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11343C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6508217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dLwGEd1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBEQB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:01:26 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41437 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgBEQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:01:25 -0500
Received: by mail-qk1-f195.google.com with SMTP id x82so2293100qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O8tuV021kx8QrtVcPGZDT1GLI5Sk9DSG+x98YpLQzy0=;
        b=dLwGEd1F28YwoaPOI5aCndNrJX9ZsLgVjkgrxubtiTprT8SC963Dkix1QsTwrkVYtw
         dh8xO9v27pg//NkpkhUHJQo7az03R1puWs4S00hjcf6u1NQYdG65xb/Cw72a9iOl+yh3
         9jCm0eBbbuMPs9DOPe/S8U+GbXMoRwKk328ZnZ9CIxevpnXlNSOXtrdVHW6TUZ7bQmLu
         gWysXetvAQss8tXkJ/e4WuJeH0J7hKc8FYclUmkSlDoq3kOmBlN0pdcx9gnqq88YZEeq
         STNvf1ptaFa4EX8kkwU6rrq0hO7LfY6Hxn2l2aD+3Q/XHDa8rW8H+Q9IT2XN/MdexSiv
         ayZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O8tuV021kx8QrtVcPGZDT1GLI5Sk9DSG+x98YpLQzy0=;
        b=TYLZg1v0Chm7d1NGjqJ0h56ibBwD2Th5ATPIiRNL8jNO7+afbHgsExGm8RXMt16vpq
         pzsN5MV5kR9I7oQQw2CYFCUtrM/5a7GE+Ch+CZHNiBqUx3Vi+42rBnF1qAtRuH7VSMEF
         2REqY7/FGjbaFwfy3MZtlagCScascGFfRHjujWA67MD63nB2fN92EAP8W8F1ZOpD2Wsr
         KZ7SAodkYTXNZ8xhL+4LHK1LoqXvgmard4Ld2QEOETtfHR2kxN8bq/FxAt2RPV3hp+Dj
         bO5VPYVm9+Tj2CIGwG5t0WKnN55yAUK5PcNtqCaR8MEMx9OACy7ZxWymQeP3399TcE26
         zWaA==
X-Gm-Message-State: APjAAAX0TpbXpJBWRalrWM+HxEz4Jk9FLLjm0lcMrbarjMFcVoP/0GGl
        ow7xIJlINMJjFYJ9qf2KCChARTkT1GiAWDTVaFRjQA==
X-Google-Smtp-Source: APXvYqwPAMnkiKKLTPYIogi+I82kFBbrTQC1aqhDQCCY862aUiw0MGyo0mhIjY5ZSY8VhdaacGscPUAXJ3Sjn/reyS8=
X-Received: by 2002:a05:620a:1273:: with SMTP id b19mr12481103qkl.482.1580918482634;
 Wed, 05 Feb 2020 08:01:22 -0800 (PST)
MIME-Version: 1.0
References: <20200203015203.27882-1-leo.yan@linaro.org> <20200203015203.27882-3-leo.yan@linaro.org>
In-Reply-To: <20200203015203.27882-3-leo.yan@linaro.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 5 Feb 2020 16:01:11 +0000
Message-ID: <CAJ9a7VhLHo9akNjdOKZvG8tAt=OLrdpyCnY03+PwNNq=K1=mCA@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] perf cs-etm: Continuously record last branch
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2020 at 01:52, Leo Yan <leo.yan@linaro.org> wrote:
>
> Every time synthesize instruction sample, the last branch recording
> will be reset.  This is fine if the instruction period is big enough,
> for example if use the option '--itrace=i100000', the last branch
> array is reset for every sample with 100000 instructions per period;
> before generate the next instruction sample, there has the sufficient
> packets coming to fill the last branch array.
>
> On the other hand, if set a very small period, the packets will be
> significantly reduced between two continuous instruction samples, thus
> the last branch array is almost empty for new instruction sample by
> frequently resetting.
>
> To allow the last branches to work properly for any instruction periods,
> this patch avoids to reset the last branch for every instruction sample
> and only reset it when flush the trace data.  The last branches will
> be reset only for two cases, one is for trace starting, another case
> is for discontinuous trace; other cases can keep recording last branches
> for continuous instruction samples.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 3dd5ba34a2c2..3e28462609e7 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1153,9 +1153,6 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>                         "CS ETM Trace: failed to deliver instruction event, error %d\n",
>                         ret);
>
> -       if (etm->synth_opts.last_branch)
> -               cs_etm__reset_last_branch_rb(tidq);
> -
>         return ret;
>  }
>
> @@ -1488,6 +1485,10 @@ static int cs_etm__flush(struct cs_etm_queue *etmq,
>                 tidq->prev_packet = tmp;
>         }
>
> +       /* Reset last branches after flush the trace */
> +       if (etm->synth_opts.last_branch)
> +               cs_etm__reset_last_branch_rb(tidq);
> +
>         return err;
>  }
>
> --
> 2.17.1
>

Reviewed by: Mike Leach <mike.leach@linaro.org>
-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
