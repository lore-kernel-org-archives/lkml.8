Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF19C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FF020838
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975167;
	bh=zEwPK0BV/NwL0nC1Y6+ce9fnXei85wOocO9JfQP/vpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uxot8amfUmLX0z9nU/0e0Bx7rXs5l/isy6f7odmjA7WrT1KZxRzmHkVkdhDMCngHi
	 sAV+rENT2j503Df3vQ4zD5PffXpMhWfNeQIvJ7mjoexPCB6+Uj55NdQyLHgzjdQe/H
	 LZdBOlkzoacBWzhxJ4grjQjJvnz+oajPYtRrT780=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFLPTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:19:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35400 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgFLPTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:19:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id q25so8674440wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 08:19:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cajqpKXE8yQj5rlg6u/javkCEuVr1o97RawpHhA99Xk=;
        b=IyCREDWTGGLE9QbGkAyyN5vdIRNT54ev/59UGBUKgwuwGVNhe7NNFL8ej9AANFBr1q
         utJ+dW3TysHSJ2R2b5rLw7QexEzul8GNmGrNpLh1DxvvjipI+C2ADs70ZpVB8b0pNG70
         mpA5F/2Icr9Wg2M2gzzaJR7ZUVFDgJ7zVKFGPgY/cBh2jxsK3iScwfdzALX4nj3bU6Jl
         LsXegN8CdQnIycz9DhoEYScWxEhH7JyUxc9bUpVPw95iZEoNMZ1IuYOXgAoSRD7lB3JD
         0Tn9oHa7AO6FZO0JS/ufyEP7u/fTsj7iB7B7LlPeXqs2pdilPolu3yR9EXRvGvZTMZ4B
         14PQ==
X-Gm-Message-State: AOAM531dP0tRV9v9HpOWCgYbCuQ6io3Q3Em7U3InNBvUX/nXO96Z2QlS
        aTt4+t6p1hko3C6kmLtjY9e7gzPsxpvbPKJgyB0=
X-Google-Smtp-Source: ABdhPJy5ice4DbxqXMPtV97fp0rqVz0wSNur9rojU7EDuSu40OHJKFs8sMIbNay/5W5T0A9Kf0HAgKpQMryh7hi9dtw=
X-Received: by 2002:a7b:cf2c:: with SMTP id m12mr13870562wmg.70.1591975161316;
 Fri, 12 Jun 2020 08:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200612094322.39565-1-liwei391@huawei.com>
In-Reply-To: <20200612094322.39565-1-liwei391@huawei.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 13 Jun 2020 00:19:10 +0900
Message-ID: <CAM9d7cjK=TN8-0kaWtMo2vPq_AzsmFwM9z=f_ni7qD2r9-8FDQ@mail.gmail.com>
Subject: Re: [PATCH] perf report TUI: Fix segmentation fault in perf_evsel__hists_browse()
To:     Wei Li <liwei391@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, guohanjun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Jun 12, 2020 at 6:58 PM Wei Li <liwei391@huawei.com> wrote:
>
> The segmentation fault can be reproduced as following steps:
> 1) Executing perf report in tui.
> 2) Typing '/xxxxx' to filter the symbol to get nothing matched.
> 3) Pressing enter with no entry selected.
> Then it will report a segmentation fault.
>
> It is caused by the lack of check of browser->he_selection when
> accessing it's member res_samples in perf_evsel__hists_browse().
>
> These processes are meaningful for specified samples, so we can
> skip these when nothing is selected.
>
> Fixes: 4968ac8fb7c3 ("perf report: Implement browsing of individual samples")
> Signed-off-by: Wei Li <liwei391@huawei.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung


> ---
>  tools/perf/ui/browsers/hists.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 487e54ef56a9..2101b6b770d8 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -2288,6 +2288,11 @@ static struct thread *hist_browser__selected_thread(struct hist_browser *browser
>         return browser->he_selection->thread;
>  }
>
> +static struct res_sample *hist_browser__selected_res_sample(struct hist_browser *browser)
> +{
> +       return browser->he_selection ? browser->he_selection->res_samples : NULL;
> +}
> +
>  /* Check whether the browser is for 'top' or 'report' */
>  static inline bool is_report_browser(void *timer)
>  {
> @@ -3357,16 +3362,16 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
>                                              &options[nr_options], NULL, NULL, evsel);
>                 nr_options += add_res_sample_opt(browser, &actions[nr_options],
>                                                  &options[nr_options],
> -                                hist_browser__selected_entry(browser)->res_samples,
> -                                evsel, A_NORMAL);
> +                                                hist_browser__selected_res_sample(browser),
> +                                                evsel, A_NORMAL);
>                 nr_options += add_res_sample_opt(browser, &actions[nr_options],
>                                                  &options[nr_options],
> -                                hist_browser__selected_entry(browser)->res_samples,
> -                                evsel, A_ASM);
> +                                                hist_browser__selected_res_sample(browser),
> +                                                evsel, A_ASM);
>                 nr_options += add_res_sample_opt(browser, &actions[nr_options],
>                                                  &options[nr_options],
> -                                hist_browser__selected_entry(browser)->res_samples,
> -                                evsel, A_SOURCE);
> +                                                hist_browser__selected_res_sample(browser),
> +                                                evsel, A_SOURCE);
>                 nr_options += add_switch_opt(browser, &actions[nr_options],
>                                              &options[nr_options]);
>  skip_scripting:
> --
> 2.17.1
>
