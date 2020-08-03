Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40F6F20578
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 04:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596427221;
	bh=QtbzBBeqxsA6cTIjHuopDbhXVYCvdD/1TOukVsTAhm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QNyZfiKyWAjK58C+hmOJ5v7kEpJBeBGq2qDJKix1RlJAu1MYBMGS9L99pVESvvazC
	 B5ekOCUovuZd4KL3dGzZ12jvhzMoChdjUnNx2/wyohv1y6tLd93sAl51zUfA+ZjbqK
	 SEBpCWtae5/00qyg9I02yeoneZ1rbJuFgCQ1Pm60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgHCEAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 00:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgHCEAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 00:00:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6C5C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 21:00:19 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so6809520pjr.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 21:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9BdHn/k7ykaHwWWI4X0FvccCvOk86APOZ2sIxzL6XY=;
        b=YrD/wkulL3RHWOKxlwJ9MAwrs21HxG3RIpFTMRyrD+fP/sDQSP7wOPV4FcVEaPixDl
         3dvMm6s3xa6coQV+kICBL0XaTE4du3mYLAUqHgYyKWOo7JtmDYKJr8jZpXl9zVD6zB05
         Uej/Kq8QuCebcCOJEsMFWIXOBsIJiqQhsE69bB9NE7vveZhJ1qAhQNB84kw6hw6C+Tql
         +QvrmmEN0M9rTvF9+7OG1UNQxGLjgrm9jftnWA3dWyw9kWGpOpHgbGaSZ3z1afifd9yE
         qqc2iP3vk82zitmiIKNiVcdUPpD4N2qEmxR0tt2VK0ilmYlBQlUDHdSbjzhEgmdQW93A
         f7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=h9BdHn/k7ykaHwWWI4X0FvccCvOk86APOZ2sIxzL6XY=;
        b=ZMqRdh5V85DmRdXFh3zikxrBrxvtH6HWDyi9f4NrO2ygT0YuWRe+3JrAg9pZsx4LZX
         0ddwbpl6MstLorO0QGELK2IlPADDuntOHhn0ZgohimOFdy/0sdO9oPiBD7jFqKQGX11L
         dQQ3C5gR1sGZk/BHAP1hE9lUQnms/Rd0TZ0pj0+05ve6mDiPpx6YMnLv2zEn71SksvFP
         3aHcBybYQhGUriEH9oYYIU0S+EWXd6bB2wAaNyZUp0E1Gy5GGFt3lv+ZzSzXUMCdJMvC
         I6LmNGmgIX5K37oHCuWvU4AnW1aiwy5N9MtPI9OeUIGIjtmwTACAjBujXr8VO4G/gFlp
         i3WA==
X-Gm-Message-State: AOAM533jXzNPtrgRp0pTjHYhmKNHZxLh57Da2/koHrBZSn7aJbjlhuWe
        gkuX1mbJxjBxvhBVK4afX9w=
X-Google-Smtp-Source: ABdhPJxcc10NP63QcSlQeYjs70zRXRgshU03v1+vKPetWwnpqhSa8RtbBHzcnCdE9oRGntR9Tw1oLA==
X-Received: by 2002:a17:90b:252:: with SMTP id fz18mr7372447pjb.48.1596427218619;
        Sun, 02 Aug 2020 21:00:18 -0700 (PDT)
Received: from google.com ([112.159.19.5])
        by smtp.gmail.com with ESMTPSA id b185sm18067427pfg.71.2020.08.02.21.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 21:00:17 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:00:12 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?utf-8?Q?Genevi=C3=A8ve?= Bastien <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: Re: [PATCH 4/6] perf tools: Add support to store time of day in CTF
 data conversion
Message-ID: <20200803040012.GB686281@google.com>
References: <20200730213950.1503773-1-jolsa@kernel.org>
 <20200730213950.1503773-5-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730213950.1503773-5-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:39:48PM +0200, Jiri Olsa wrote:
> Adding support to convert and store time of day in CTF
> data conversion for 'perf data convert' subcommand.
> 
> The perf.data used for conversion needs to have clock data
> information - must be recorded with -k/--clockid option).
> 
> New --tod option is added to 'perf data convert' subcommand
> to convert data with timestamps converted to wall clock time.
> 
> Record data with clockid set:
>   # perf record -k CLOCK_MONOTONIC kill
>   kill: not enough arguments
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.033 MB perf.data (8 samples) ]
> 
> Convert data with TOD timestamps:
>   # perf data convert --tod --to-ctf ./ctf
>   [ perf data convert: Converted 'perf.data' into CTF data './ctf' ]
>   [ perf data convert: Converted and wrote 0.000 MB (8 samples) ]
> 
> Display data in perf script:
>   # perf script -F+tod --ns
>             perf 262150 2020-07-13 18:38:50.097678523 153633.958246159:          1 cycles: ...
>             perf 262150 2020-07-13 18:38:50.097682941 153633.958250577:          1 cycles: ...
>             perf 262150 2020-07-13 18:38:50.097684997 153633.958252633:          7 cycles: ...
>   ...

I believe this belongs to a later patch.

Thanks
Namhyung

> 
> Display data in babeltrace:
>   # babeltrace --clock-date  ./ctf
>   [2020-07-13 18:38:50.097678523] (+?.?????????) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
>   [2020-07-13 18:38:50.097682941] (+0.000004418) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
>   [2020-07-13 18:38:50.097684997] (+0.000002056) cycles: { cpu_id = 0 }, { perf_ip = 0xFFF ...
>   ...
> 
> It's available only for recording with clockid specified,
> because it's the only case where we can get reference time
> to wallclock time. It's can't do that with perf clock yet.
> 
> Error is display if you want to use --tod on data without
> clockid specified:
> 
>   # perf data convert --tod --to-ctf ./ctf
>   Can't provide --tod time, missing clock data. Please record with -k/--clockid option.
>   Failed to setup CTF writer.
>   Error during conversion setup.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Documentation/perf-data.txt |  3 ++
>  tools/perf/builtin-data.c              |  1 +
>  tools/perf/util/data-convert-bt.c      | 56 +++++++++++++++++---------
>  tools/perf/util/data-convert.h         |  1 +
>  4 files changed, 41 insertions(+), 20 deletions(-)
