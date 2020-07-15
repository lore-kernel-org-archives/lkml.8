Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38454C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F81920663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOErAk1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGORBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgGORBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:01:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257CC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:01:49 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so3389129wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=miAzuq9MwC1O619PaqzC/i3ymDnyFm/MdhV0rUKfJ2Q=;
        b=HOErAk1bkfXtfMriGPrsT9YVFG+OojXqlEi25Wh3/PgOD2jvIsw8wOBd0PwrGDvdPa
         438b47TmdJxhDvBb/W7n9A8ekgcpIieOh8M66B5Z02oxBBHGGhCkNHc+vsAoR6skh8M3
         0CA0A5YDZ423yE2ybqO//jV9GxJXDWnvW50aKdtLCBIYrFMT/qUidDbm35AiOwdVNbK6
         K0Z7F747Gc6YzeykUExDQVeXcyeZ8lFgPm30F/qx/ijJ2BSxumHVZOsHwJsDba87cpZG
         sjygNelMPFwZKVwBzwViUaMdXHHg6FajY0FNG8XO+EkiEyL5O961izsfOWwfKbz0ifIL
         DLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=miAzuq9MwC1O619PaqzC/i3ymDnyFm/MdhV0rUKfJ2Q=;
        b=WZ0g5j3aak7snX5IpmwEkgg4EHDq0cvlJzbLc2CpCHm1lvZOQLw180JQRl1CBaP8mh
         juyX/lx/68FbrMyiZ0WKxkOjNi10XoASV8Z+lA7eqgVvT/KsFb04rn7J3JRbcEtaD7xe
         c7pDP7bXkYYveHDEK2lrzd6YZTiA+wN+tZ/IGA+zGmMbCrbpIQQxo3ri1IXRhZInlS+1
         CJCE2mm8u6dBterm0wM0V2XKFa8Gpe0wOese9kZodwqBFL8hPcBHrMgDA7jmjVVX4aeX
         ykS72LM7geBEqCEqFzrShQ335rurszubJpTHOrpBOvZQKQSpNP0rM8xq+Om1fUp7cuRB
         FIDw==
X-Gm-Message-State: AOAM533312MxBGGxdiyRIdLmynkLmo5dpNdsdB6+NgpHv/WExgvTTTg7
        TIFeClSNfqKR1srZbidDwmtwIdhj0YQy/mibj3GnDg==
X-Google-Smtp-Source: ABdhPJzWlXR2emSZ8HLWbCck07An/U4Mxo5ISOE9eGh2vLT7zy7W28FxIyO/2jOBHJpI6LMo+qdbrlzGEUXuxhjMteo=
X-Received: by 2002:adf:e40e:: with SMTP id g14mr311759wrm.271.1594832507886;
 Wed, 15 Jul 2020 10:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200712132634.138901-1-jolsa@kernel.org> <20200712132634.138901-16-jolsa@kernel.org>
In-Reply-To: <20200712132634.138901-16-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 15 Jul 2020 10:01:36 -0700
Message-ID: <CAP-5=fV_Hnhcc1Z=xvjkKzjtz+xkUw+q1DG0ov2eOhmagD50PQ@mail.gmail.com>
Subject: Re: [PATCH 15/18] perf metric: Add DCache_L2 to metric parse test
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test that compute DCache_L2 metrics with other related metrics in it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This feels familiar :-)

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
>  tools/perf/tests/parse-metric.c | 71 +++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index 28f33893338b..b50e2a3f3b73 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -36,6 +36,27 @@ static struct pmu_event pme_test[] = {
>         .metric_expr    = "(dcache_miss_cpi + icache_miss_cycles)",
>         .metric_name    = "cache_miss_cycles",
>  },
> +{
> +       .metric_expr    = "L2_RQSTS.DEMAND_DATA_RD_HIT + L2_RQSTS.PF_HIT + L2_RQSTS.RFO_HIT",
> +       .metric_name    = "DCache_L2_All_Hits",
> +},
> +{
> +       .metric_expr    = "max(L2_RQSTS.ALL_DEMAND_DATA_RD - L2_RQSTS.DEMAND_DATA_RD_HIT, 0) + "
> +                         "L2_RQSTS.PF_MISS + L2_RQSTS.RFO_MISS",
> +       .metric_name    = "DCache_L2_All_Miss",
> +},
> +{
> +       .metric_expr    = "DCache_L2_All_Hits + DCache_L2_All_Miss",
> +       .metric_name    = "DCache_L2_All",
> +},
> +{
> +       .metric_expr    = "d_ratio(DCache_L2_All_Hits, DCache_L2_All)",
> +       .metric_name    = "DCache_L2_Hits",
> +},
> +{
> +       .metric_expr    = "d_ratio(DCache_L2_All_Miss, DCache_L2_All)",
> +       .metric_name    = "DCache_L2_Misses",
> +},
>  };
>
>  static struct pmu_events_map map = {
> @@ -194,10 +215,60 @@ static int test_cache_miss_cycles(void)
>         return 0;
>  }
>
> +
> +/*
> + * DCache_L2_All_Hits = L2_RQSTS.DEMAND_DATA_RD_HIT + L2_RQSTS.PF_HIT + L2_RQSTS.RFO_HI
> + * DCache_L2_All_Miss = MAX(L2_RQSTS.ALL_DEMAND_DATA_RD - L2_RQSTS.DEMAND_DATA_RD_HIT, 0) +
> + *                      L2_RQSTS.PF_MISS + L2_RQSTS.RFO_MISS
> + * DCache_L2_All      = DCache_L2_All_Hits + DCache_L2_All_Miss
> + * DCache_L2_Hits     = d_ratio(DCache_L2_All_Hits, DCache_L2_All)
> + * DCache_L2_Misses   = d_ratio(DCache_L2_All_Miss, DCache_L2_All)
> + *
> + * L2_RQSTS.DEMAND_DATA_RD_HIT = 100
> + * L2_RQSTS.PF_HIT             = 200
> + * L2_RQSTS.RFO_HI             = 300
> + * L2_RQSTS.ALL_DEMAND_DATA_RD = 400
> + * L2_RQSTS.PF_MISS            = 500
> + * L2_RQSTS.RFO_MISS           = 600
> + *
> + * DCache_L2_All_Hits = 600
> + * DCache_L2_All_Miss = MAX(400 - 100, 0) + 500 + 600 = 1400
> + * DCache_L2_All      = 600 + 1400  = 2000
> + * DCache_L2_Hits     = 600 / 2000  = 0.3
> + * DCache_L2_Misses   = 1400 / 2000 = 0.7
> + */
> +static int test_dcache_l2(void)
> +{
> +       double ratio;
> +       struct value vals[] = {
> +               { .event = "L2_RQSTS.DEMAND_DATA_RD_HIT", .val = 100 },
> +               { .event = "L2_RQSTS.PF_HIT",             .val = 200 },
> +               { .event = "L2_RQSTS.RFO_HIT",            .val = 300 },
> +               { .event = "L2_RQSTS.ALL_DEMAND_DATA_RD", .val = 400 },
> +               { .event = "L2_RQSTS.PF_MISS",            .val = 500 },
> +               { .event = "L2_RQSTS.RFO_MISS",           .val = 600 },
> +               { 0 },
> +       };
> +
> +       TEST_ASSERT_VAL("failed to compute metric",
> +                       compute_metric("DCache_L2_Hits", vals, &ratio) == 0);
> +
> +       TEST_ASSERT_VAL("DCache_L2_Hits failed, wrong ratio",
> +                       ratio == 0.3);
> +
> +       TEST_ASSERT_VAL("failed to compute metric",
> +                       compute_metric("DCache_L2_Misses", vals, &ratio) == 0);
> +
> +       TEST_ASSERT_VAL("DCache_L2_Misses failed, wrong ratio",
> +                       ratio == 0.7);
> +       return 0;
> +}
> +
>  int test__parse_metric(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
>         TEST_ASSERT_VAL("IPC failed", test_ipc() == 0);
>         TEST_ASSERT_VAL("frontend failed", test_frontend() == 0);
>         TEST_ASSERT_VAL("cache_miss_cycles failed", test_cache_miss_cycles() == 0);
> +       TEST_ASSERT_VAL("DCache_L2 failed", test_dcache_l2() == 0);
>         return 0;
>  }
> --
> 2.25.4
>
