Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A794C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F2C20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkSXYp5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIBQJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBQJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:09:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5996C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:09:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so5112974wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bAD951MtFR8PiKHQakVGUsQgm4liMaqYZ8a7kiQ8hQ=;
        b=qkSXYp5f6Nta8tLAJuPuP3oakOIwH4vS8Pt5ihP9mv+UriC8dfFqZOn2X7kMMRNe29
         r6A8Gb1tD2BcD9rBBuKw37RI9328fbpbCBJckWrQKm2DhwpxRD9WRE8A6Pq8HAhiL/qB
         0KpTYNgQCBsXv/qOBpcUyGDNYozOdVeLfoP7685ln2nVPoTQCzaKNWbJ5aEhZbQ5nvtN
         0jqi+LvFHOldhqfGxaOEzd/tSilI0ugQ+VLzIwuPpe2p00kAdM1rOlm82HD6fOXm/1P2
         a6oBRfgQNmKKsUDO5wPW2Ot2I1sLFYtfWkAWizupk6FRLScQTQAXyFLNB67C6Sr2ZiGA
         gGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bAD951MtFR8PiKHQakVGUsQgm4liMaqYZ8a7kiQ8hQ=;
        b=Db8iVCJlxmVGSL18TkWbmZE/+24fDrj64rdPbUhb3khiSkanHaZbzqeUs/T0IuzsvD
         2kQvVqCMh6jOzNSz1UNbTDDEQkpX6qKFA/WihqERvaaNRmeFjwblQn2RC1e8FtaCvISh
         UnnVeLbBfegRvG7KLB2ngOnQH145CzVl+hej2Cy4kqvJoLCq52ceXb0ByiiQbQzT1LgL
         PnV3X0DuwBQAo8ZIMjs+hhpBAuOlH8C1U4+QNWosVFiYCtNCRjZElDs61bLgy7oMf9RB
         C7o0wm8ayQBDBizs33DcbTPpSagIbAAoKjY33TO6vnMsEEUfkg4bhCGIv5ahZijtUHdH
         Wqew==
X-Gm-Message-State: AOAM530vRv2HtPnXluoms8DnL5bNiQWfupHyA99U5DIbyMd7CTvHNi1n
        guKfmxZ1m8NrLIBJ2DWsKKHXe0XKkGnKQ+zxt2h0lQ==
X-Google-Smtp-Source: ABdhPJz1hJck6/pRToXomv72lx48bASBe/si2Hn0WUtTWdPeREnE077WZ+I0FQQz48gcg9UGjEnxKm2OjnRmxYwpVIU=
X-Received: by 2002:a1c:7314:: with SMTP id d20mr1367747wmb.76.1599062983315;
 Wed, 02 Sep 2020 09:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200902140526.26916-1-yuehaibing@huawei.com>
In-Reply-To: <20200902140526.26916-1-yuehaibing@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 2 Sep 2020 09:09:31 -0700
Message-ID: <CAP-5=fWQ1-=a5pcYqkP7c_rQkKByfGkfXQ2O6pcAibeDjRVnDA@mail.gmail.com>
Subject: Re: [PATCH -next] perf bench: fix return value check in do_run_multi_threaded()
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 7:06 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> In case of error, the function perf_session__new() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR()
>
> Fixes: 13edc237200c ("perf bench: Add a multi-threaded synthesize benchmark")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/bench/synthesize.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
> index 8d624aea1c5e..e39daa609db2 100644
> --- a/tools/perf/bench/synthesize.c
> +++ b/tools/perf/bench/synthesize.c
> @@ -162,8 +162,8 @@ static int do_run_multi_threaded(struct target *target,
>         init_stats(&event_stats);
>         for (i = 0; i < multi_iterations; i++) {
>                 session = perf_session__new(NULL, false, NULL);
> -               if (!session)
> -                       return -ENOMEM;
> +               if (IS_ERR(session)) {
> +                       return PTR_ERR(session);
>
>                 atomic_set(&event_count, 0);
>                 gettimeofday(&start, NULL);
> --
> 2.17.1
>
>
