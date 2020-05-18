Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BCFB20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALbu9AKM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgERPXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:23:55 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C96C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:23:55 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id fb16so4841559qvb.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 08:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/HaS0VGvwKKZo+c1KgVtIA1x0dYcpqRG0Gw5Sc4Ij8I=;
        b=ALbu9AKM9aD2Et0awLVWZ7YlF1bR0sagosp8l49E4A1HqakAGlNXhkID6Y0PSlGfmc
         64zPOLjdI+IroAOHc78MfQmJf+9976TvBq9m4KworNNxGaz35grRGIK0OIGFyDBw8m//
         lXAnFxj+/6fWlZo/N527HM9OGQ0DUbA4m8t3r9PLee8feaX7koPcRD5KYi4zUa487tFo
         Hjtjoxxjw+FwGk6GO6lVk5Lwr+TuR/sQJ8m3rniQZi4ITXNgZMLjsYWGA//zWPtI9zMK
         m0wM09PLiOvNcwRrlCTHSXFwSweL+uwigBnu5Su6woVU/JD4EPjdV2pdTP2F3S1/H2uT
         rztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/HaS0VGvwKKZo+c1KgVtIA1x0dYcpqRG0Gw5Sc4Ij8I=;
        b=LugKD1Ntm4htXncvqypCONNH+2YL/p8767W82RBvWr8gGQUf5GunAZr6KcOzXGr8Wh
         4RLKoB+sw+TlVt//k+ITh9LggGHAzoW5pWsBV34I2vVQxJPiNLqqlPdE9BuX70FjRyBt
         5AbQ3e/MWpIxIET5JFJ4r1kL6FMK/x2CX4E5xoqrkDfcpdrHq+jsaKKw2xOBzfGOLsWt
         +R5zInli1WJnF8ZKEBLqaIH7OyYY2tOTRN8Uo3Lko3DX8HeAP/UWHTH+S3Lesvx51juu
         TCgE2kFplYtR5cgZlQNhISdKLVm/FcFm3CU5GLTF+9tOY2CDP0sfFZ3rQo09OWfJL4Z9
         GGmA==
X-Gm-Message-State: AOAM532IcH85OYdP+eZ7olpeorGBP1rCklne9DfDBGdfGwcG9rdW2HNV
        eYHCXEJyd9mRqYuB68cjLLsw3tdOmE4=
X-Google-Smtp-Source: ABdhPJxcmhgFiytTCNY1wCphE8NKrmwlKWLf934eRAUeadjjFLQpW4TM5N1yzSrqf5XQNsVpxlM3Kg==
X-Received: by 2002:a0c:aed7:: with SMTP id n23mr10402724qvd.179.1589815434540;
        Mon, 18 May 2020 08:23:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d82sm8430176qke.81.2020.05.18.08.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 08:23:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F14C940AFD; Mon, 18 May 2020 12:23:51 -0300 (-03)
Date:   Mon, 18 May 2020 12:23:51 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf stat: Fix duration_time value for higher intervals
Message-ID: <20200518152351.GD24211@kernel.org>
References: <20200518131445.3745083-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518131445.3745083-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 18, 2020 at 03:14:45PM +0200, Jiri Olsa escreveu:
> Joakim reported wrong duration_time value for interval bigger
> than 4000 [1].
> 
> The problem is in the interval value we pass to update_stats
> function, which is typed as 'unsigned int' and overflows when
> we get over 2^32 (happens between intervals 4000 and 5000).
> 
> Retyping the passed value to unsigned long long.

Thanks, applied and added this:

Fixes: b90f1333ef08 ("perf stat: Update walltime_nsecs_stats in interval mode")

Ok?

- Arnaldo

> [1] https://www.spinics.net/lists/linux-perf-users/msg11777.html
> 
> Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e0c1ad23c768..4deb2d46a343 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -367,7 +367,7 @@ static void process_interval(void)
>  	}
>  
>  	init_stats(&walltime_nsecs_stats);
> -	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
> +	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000ULL);
>  	print_counters(&rs, 0, NULL);
>  }
>  
> -- 
> 2.25.4
> 

-- 

- Arnaldo
