Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A24C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676C7207DE
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597714185;
	bh=zLKUn7ABDz9nyJFymvZUwUrOdxY+aVEubAV556WYCkE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CaGqKua7lxnIKC0KRWqXp8H7rJlVPjy13ZsMkeT7zPeLj89pEGdi6Nndq5uAC2WOj
	 OH9Rmn2qSg4ZXthBCjRrHxeyvNfHPq8bW1DC92dlHAi4z5eufIQRKeyFUOW3hE1Mc+
	 qYHTmLcMOR4HKjXlQ6vQ3iuIWVtePHlva2gYe6pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHRB3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:29:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34845 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHRB3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:29:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id f1so16707960wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53qE5jIbW6gkAH4EEEhNHGrju++qf+gtzDfgUxgJJs4=;
        b=rHD2uGiaNjeT1ysJFA5u4uvM95/Xjvi6Z2T7VBYhMNIXXSk8+PKbROv87ppsw6vr/v
         OpiNR4EAFQmsYP81N4QpdBRc78j+1kUyxCj1STTT/cWyXfcJ+Ti1vebedcMZ+Yrm3fnI
         CwpbapmYJB9zUAR/1m6bW+WYZef7fqwwfiOZuJL3NsOsaFisvhTtNr8YuViF6JjeeeIt
         IIWGXC4DCgtQeCpai7gzF22J5jmD3fnRclAJP1Ns2ReQpIbGnHtp4rgmVVu4FzJwjnP/
         ZdUARN3gJbLatsYIt10tOUcNi7vlqyVlVmbcOe83iXQKz5e9Qrk7pw7h3fLzu8HITSSZ
         6OwQ==
X-Gm-Message-State: AOAM531bWN6+qjKP4gX127C17JGrdsHGuMgtbeYz5HxYQK1VIHVy6MU/
        Fr9bw0kRE91/eKx665nKXXr9ZCjGCb95j6IqgTVVAU5OosU=
X-Google-Smtp-Source: ABdhPJxIfmd1ZgApgM5BQRvhxgDX4PI+ryX1CWfJvAEaW4llkXFWNRbYbyQoj06lUGNtJcDsQAbYV+87l3m1wlGSoBw=
X-Received: by 2002:adf:dfc7:: with SMTP id q7mr17783555wrn.80.1597714180509;
 Mon, 17 Aug 2020 18:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200817170943.1486-1-dsahern@kernel.org>
In-Reply-To: <20200817170943.1486-1-dsahern@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 18 Aug 2020 10:29:29 +0900
Message-ID: <CAM9d7chxJ9hkCsL+PnJSFfKHwbjg6=D+RVDT6E7GWKwedwzGiQ@mail.gmail.com>
Subject: Re: [PATCH v2] perf sched timehist: Fix use of CPU list with summary option
To:     David Ahern <dsahern@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Aug 18, 2020 at 2:09 AM David Ahern <dsahern@kernel.org> wrote:
>
> Do not update thread stats or show idle summary unless CPU is in
> the list of interest.
>
> Fixes: c30d630d1bcf ("perf sched timehist: Add support for filtering on CPU")
> Signed-off-by: David Ahern <dsahern@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

> ---
> v2
> - check that cpu_list is set before checking cpu_bitmap in timehist_print_summary
>
>  tools/perf/builtin-sched.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 0c7d599fa555..e6fc297cee91 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -2584,7 +2584,8 @@ static int timehist_sched_change_event(struct perf_tool *tool,
>         }
>
>         if (!sched->idle_hist || thread->tid == 0) {
> -               timehist_update_runtime_stats(tr, t, tprev);
> +               if (!cpu_list || test_bit(sample->cpu, cpu_bitmap))
> +                       timehist_update_runtime_stats(tr, t, tprev);
>
>                 if (sched->idle_hist) {
>                         struct idle_thread_runtime *itr = (void *)tr;
> @@ -2857,6 +2858,9 @@ static void timehist_print_summary(struct perf_sched *sched,
>
>         printf("\nIdle stats:\n");
>         for (i = 0; i < idle_max_cpu; ++i) {
> +               if (cpu_list && !test_bit(i, cpu_bitmap))
> +                       continue;
> +
>                 t = idle_threads[i];
>                 if (!t)
>                         continue;
> --
> 2.17.1
>
