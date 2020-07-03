Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B4EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55AD720826
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593783883;
	bh=2C2Q1ke0Mc8iqmTHDO7NN5axZw4GenhS/cQjZnYw97g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fTU3EXg3ts1CjJnVHJ5+D5RbV6CsYdwMoAsNsB3F+jkpMSQSufden62y9NIH7qrAc
	 JS0dJmrruNCo0J7ghSm99UAG8UZa1TUag6awJZkzXWqxQDJEGlrpxvXJAiEr9S/xRW
	 X14CfwWcuSyXpyOBPWqHsf2BfLkpWQ/kQj5k5bos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGCNol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 09:44:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCNol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 09:44:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id a6so32741090wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 06:44:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIjFP+cYA+OGoBPB7ZmUb3ESSPm6nPtkyeUEBVwIF3I=;
        b=Y/LbKCA2k2SA4QDUEUoO2tTJ0z8uSByAtBjf3kY0jkvvBOzLLbw1CIJsxDGtvAxdCc
         NrwBAYWQkk7kQKIdgbDrYtaotYx+clP2CfbzWyeIGlphav1hWdW+2Le3U6lb2IH6q0zN
         ut2Oef6Il6XeNNe6U5phFlbs1UI8++kMavuZyNA6ZTfYLt5UOAjFbxZWESjaEAQvSGsl
         dtgW+a6Xh3gYXFsSSbz22MNQNVfMR19FMa5MrGHcnbq9MJ2kinZ1uGMJQh6BIKhgJPys
         mYLQA6CqCZadD5BFqAIgpHLwTElSw6mIsgmuAYAOtcBKVJtR8i1GuRd+s+f4xdqcKXlL
         2YVw==
X-Gm-Message-State: AOAM5319bS3C14I+PFoVHy7pD4n7jRoBgOwpPwCrgo6G/8LfDF9W/279
        NG3YkKV+6URekOoOqugY2pf4vUKJyykDcOfs8/k=
X-Google-Smtp-Source: ABdhPJyyTZCAWSR6rLl6ztBJVH4FTiiCma/ek9zKBi+XvfANsiB4ENKaL1VfoJnwjlrbvqDlTb17+Sbs9+NWMTF1my8=
X-Received: by 2002:adf:e901:: with SMTP id f1mr36850794wrm.80.1593783879586;
 Fri, 03 Jul 2020 06:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200703123431.GG1320@kernel.org>
In-Reply-To: <20200703123431.GG1320@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 3 Jul 2020 22:44:28 +0900
Message-ID: <CAM9d7cgGcpnX+cSY0UvYjRkG9PF8X3Yyf_AOy+nGxbPjtjDvxw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf report TUI: Remove needless 'dummy' event from menu
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Jul 3, 2020 at 9:34 PM Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
>
> Please Ack,
>
> - Arnaldo
>
> ----
>
> Fixing the common case of:
>
>   perf record
>   perf report
>
> And getting just the cycles events.
>
> We now have a 'dummy' event to get perf metadata events that take place
> while we synthesize metadata records for pre-existing processes by
> traversing procfs, so we always have this extra 'dummy' evsel, but we
> don't have to offer it as there will be no samples on it, remove this
> distraction.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/ui/browsers/hists.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index 4cd556c1276f..be9c4c0549bc 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3603,6 +3603,23 @@ static int __perf_evlist__tui_browse_hists(struct evlist *evlist,
>                                     hbt, warn_lost_event);
>  }
>
> +static bool perf_evlist__single_entry(struct evlist *evlist)
> +{
> +       int nr_entries = evlist->core.nr_entries;
> +
> +       if (nr_entries == 1)
> +              return true;
> +
> +       if (nr_entries == 2) {
> +               struct evsel *last = evlist__last(evlist);
> +
> +               if (evsel__is_dummy_event(last))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
>                                   struct hist_browser_timer *hbt,
>                                   float min_pcnt,
> @@ -3613,7 +3630,7 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
>         int nr_entries = evlist->core.nr_entries;
>
>  single_entry:
> -       if (nr_entries == 1) {
> +       if (perf_evlist__single_entry(evlist)) {

But I think it cannot cover the event group case below..

Thanks
Namhyung


>                 struct evsel *first = evlist__first(evlist);
>
>                 return perf_evsel__hists_browse(first, nr_entries, help,
> --
> 2.21.3
>
