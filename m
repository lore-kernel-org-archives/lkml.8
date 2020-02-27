Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B7FC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615F42469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoHcMXQv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgB0NOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:14:53 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34342 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgB0NOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:14:52 -0500
Received: by mail-qk1-f196.google.com with SMTP id 11so3054150qkd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LNfQ5f9E+T9BcPBBDP1hNq02V7wODK9NJ3l5Z7o3Nh0=;
        b=DoHcMXQvAHtJBQffiuuAEAJh8BgRUquaYVfT4y1Z149VCs6jrM0g0n2uXeXUbEHWQ1
         g/i9NjD2VxVMMk3F3prX6ubMalf+kj4dPcAMuEv+mmsEAK5S+5GIQz59u2gimFd71RQJ
         QD+YV+DJvfKBQ0rmBnstI4h3gBivvGbX9S9ebWWN3WH/ukTzkpf3s95hxY2LZ+mnKUAz
         b9dBDYW4+5PpezGJyxZj3GPly0NE8bp0XjLgpMllzeq1YMquo1tsz4qCuDWbSH8MsMA+
         3y/ha828ct1ZrtJ5Ew02omavZP3gDXvnoj9WoRIYjbfB92ajKziOgPQ0XtQ5QQfWP0Yo
         EDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LNfQ5f9E+T9BcPBBDP1hNq02V7wODK9NJ3l5Z7o3Nh0=;
        b=tGyah9SyqtIvygvkzOe8TEcoRG1HvNcRRGIRyLeE4ehf4ut4RSFpK01Zjs3qW3KZk+
         JGpLIbdZE96miHeTEUMYMM7fQYdbC6E2ncEoePVmro0G6sizmkk1L7k3F65LFOIN74o7
         eh4lCll6h22YA87Qy/mPx1iw/bC3gPLwmtIVzUgVNKIChlRHFzISrf96LPbYPkJu/zZb
         PD302ESnl/EKm6Kuj8jOI2FP4b+4ULlgHFn7EQfMV9aUpKsCo3yGyaltf1Cg8y8vVCyb
         IvC1+0BeuiVQ1GD7shlvvHgZqhZi00uRJWziUXZ67avpKsveaIGWTjh9E5d2l78fb5l/
         VWbw==
X-Gm-Message-State: APjAAAVCVIhzrotvMBH1FnQoMPw63tjJn3p4AHxGKO9pxsBKhmn1C5z3
        hnXF32j42Tl2QXP9spgX6To=
X-Google-Smtp-Source: APXvYqwbXAkKWNMvLiKWXQVu6NquGGPGaSzDqRpnKypZuIho28uj2tAQFJFuD2C3z7xaiLmLS4snAA==
X-Received: by 2002:a05:620a:c:: with SMTP id j12mr5530117qki.356.1582809291441;
        Thu, 27 Feb 2020 05:14:51 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g185sm3038483qkd.16.2020.02.27.05.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:14:50 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9C0D8403AD; Thu, 27 Feb 2020 10:14:48 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:14:48 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, xieyisheng1@huawei.com,
        alexey.budankov@linux.intel.com, treeze.taeung@gmail.com,
        adrian.hunter@intel.com, tmricht@linux.ibm.com,
        namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] perf annotate: Fix --show-total-period for tui/stdio2
Message-ID: <20200227131448.GC9899@kernel.org>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
 <20200213064306.160480-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213064306.160480-3-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 13, 2020 at 12:13:00PM +0530, Ravi Bangoria escreveu:
> perf annotate --show-total-period does not really show total period.
> The reason is we have two separate variables for the same purpose.
> One is in symbol_conf.show_total_period and another is
> annotation_options.show_total_period. We save command line option
> in symbol_conf.show_total_period but uses
> annotation_option.show_total_period while rendering tui/stdio2 browser.
> 
> Though, we copy symbol_conf.show_total_period to
> annotation__default_options.show_total_period but that is not really
> effective as we don't use annotation__default_options once we copy
> default options to dynamic variable annotate.opts in cmd_annotate().
> 
> Instead of all these complication, keep only one variable and use it
> all over. symbol_conf.show_total_period is used by perf report/top as
> well. So let's kill annotation_options.show_total_period.
> 
> On a side note, I've kept annotation_options.show_total_period definition
> because it's still used by perf-config code. Follow up patch to fix
> perf-config for annotate will remove annotation_options.show_total_period.

IIRC this was an attempt to reduce the number of entries in symbol_conf,
that became a hodpodge of options, all global, argh.

But then, making changes like that sticky in a session, i.e. you go
annotate some symbol, toggle some option, then go back to the main
window and go back to annotation and things are the way you left off in
the previous symbol has been over the years considered a nice feature...

So I'll apply your changes, at some point we can sanitize symbol_conf.

Thanks,

- Arnaldo
 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  tools/perf/ui/browsers/annotate.c | 6 +++---
>  tools/perf/util/annotate.c        | 5 ++---
>  tools/perf/util/annotate.h        | 2 +-
>  3 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
> index 0dbbf35e6ed1..7e5b44becb5c 100644
> --- a/tools/perf/ui/browsers/annotate.c
> +++ b/tools/perf/ui/browsers/annotate.c
> @@ -833,13 +833,13 @@ static int annotate_browser__run(struct annotate_browser *browser,
>  			map_symbol__annotation_dump(ms, evsel, browser->opts);
>  			continue;
>  		case 't':
> -			if (notes->options->show_total_period) {
> -				notes->options->show_total_period = false;
> +			if (symbol_conf.show_total_period) {
> +				symbol_conf.show_total_period = false;
>  				notes->options->show_nr_samples = true;
>  			} else if (notes->options->show_nr_samples)
>  				notes->options->show_nr_samples = false;
>  			else
> -				notes->options->show_total_period = true;
> +				symbol_conf.show_total_period = true;
>  			annotation__update_column_widths(notes);
>  			continue;
>  		case 'c':
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index b2a26adeb4cd..c0c3832e3789 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2892,7 +2892,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  			percent = annotation_data__percent(&al->data[i], percent_type);
>  
>  			obj__set_percent_color(obj, percent, current_entry);
> -			if (notes->options->show_total_period) {
> +			if (symbol_conf.show_total_period) {
>  				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
>  			} else if (notes->options->show_nr_samples) {
>  				obj__printf(obj, "%6" PRIu64 " ",
> @@ -2908,7 +2908,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
>  			obj__printf(obj, "%-*s", pcnt_width, " ");
>  		else {
>  			obj__printf(obj, "%-*s", pcnt_width,
> -					   notes->options->show_total_period ? "Period" :
> +					   symbol_conf.show_total_period ? "Period" :
>  					   notes->options->show_nr_samples ? "Samples" : "Percent");
>  		}
>  	}
> @@ -3132,7 +3132,6 @@ void annotation_config__init(void)
>  {
>  	perf_config(annotation__config, NULL);
>  
> -	annotation__default_options.show_total_period = symbol_conf.show_total_period;
>  	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
>  }
>  
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 2f333dfb586d..632e28b67990 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -307,7 +307,7 @@ static inline int annotation__cycles_width(struct annotation *notes)
>  
>  static inline int annotation__pcnt_width(struct annotation *notes)
>  {
> -	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
> +	return (symbol_conf.show_total_period ? 12 : 7) * notes->nr_events;
>  }
>  
>  static inline bool annotation_line__filter(struct annotation_line *al, struct annotation *notes)
> -- 
> 2.24.1
> 

-- 

- Arnaldo
