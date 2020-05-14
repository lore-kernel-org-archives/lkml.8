Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4095C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76ADE20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEwkl6gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgENNtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726066AbgENNtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:49:41 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032C5C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:49:40 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y22so3008970qki.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MPN/pi3mIuGBZTmwZblH3Kev5+LoREIBCBfUF3nM8x0=;
        b=KEwkl6gvaZEI02lsbHvNiWoVvLKXgVJv9Nr0Gxntr+h7ryZ1Bj/mxh7s4ocx/9APLC
         TDmFJqQbSzmZHEQsEydGUGyToYfw2QQZAznflctGcwruXXYS5t+M4Tyftv8iXJ8pYaJ5
         WgJBjvTBLU7MRKr7ap5OGuSJd5UQ33yL336aGg6ryZvdjKiDqq4GxisDMXez9rao3tdW
         +DD75azbfDtoFDh4BnLbjuzXhiMu43qStPVAKWVU14NCTo5LsDGylvAOHde/khEkD6Ye
         M45vjNLJ9zb7cefRvAZeqi+WRACabn5Kax+EATuqj/7jI7NEHMxLy9cPhgJ3UJN06Uyb
         mvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MPN/pi3mIuGBZTmwZblH3Kev5+LoREIBCBfUF3nM8x0=;
        b=a6JyscjFJS6LyqQ7tyEIayV9xsnlRi6MQMiQ5y7cUNPVDjKva+nNaRuTbgWLQX1Eg9
         EVjIaweJrD4gUOrmLRog6wofDoyPlx5CdEScCxEIJQEFIIZn+nWOh2axVMiPkUmtLOMo
         WV4dFab7CQf3PrML4Orn2dqpr7MpvYm4jPVIyXpmpVvtDc89Y+y637+zhC06DO/MWkX+
         B3sczZUbWSxbPGVz/oo+VJ0D6s2zVjO/Q6Lg3HVGK9Xgry7Ion0Vq2AbRfMX9sceLVQy
         cakcgsq0d9xfBPhiYr0L8glsWf1OTtVUkR+2CUAPzhoxOW4MNTgA6L0eERXjaWvPKRKX
         LJxg==
X-Gm-Message-State: AOAM531FAAT2HjaMrG1jE9+1yj8ddJgKxztKmDsx1QBEw1RIoAiIevqD
        00OfxBlgHNLfInmG7CNU/Wk=
X-Google-Smtp-Source: ABdhPJxeA/PXcqK6xlnymeAHCqixmIv3pwLYvDdpQqlWe+gTLR/d/C1QYrg63opKHPQ6mpnTnrYRgQ==
X-Received: by 2002:a05:620a:759:: with SMTP id i25mr4797339qki.118.1589464179942;
        Thu, 14 May 2020 06:49:39 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id k3sm2656102qkb.112.2020.05.14.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 06:49:39 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 931D640AFD; Thu, 14 May 2020 10:49:36 -0300 (-03)
Date:   Thu, 14 May 2020 10:49:36 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2] perf parse-events: Make add PMU verbose output clearer
Message-ID: <20200514134936.GN5583@kernel.org>
References: <20200513220635.54700-1-irogers@google.com>
 <20200514082115.GI3343750@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514082115.GI3343750@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 14, 2020 at 10:21:15AM +0200, Jiri Olsa escreveu:
> On Wed, May 13, 2020 at 03:06:35PM -0700, Ian Rogers wrote:
> 
> SNIP
> 
> > found event unc_iio_data_req_of_cpu.mem_read.part3
> > adding {unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.mem_read.part3}:W,{unc_iio_data_req_of_cpu.mem_read.part0,unc_iio_data_req_of_cpu.mem_read.part1,unc_iio_data_req_of_cpu.mem_read.part2,unc_iio_data_req_of_cpu.mem_read.part3}:W
> > intel_pt default config: tsc,mtc,mtc_period=3,psb_period=3,pt,branch
> > Attempting to add event pmu 'uncore_iio_free_running_5' with 'unc_iio_data_req_of_cpu.mem_read.part0,' that may result in non-fatal errors
> > After aliases, add event pmu 'uncore_iio_free_running_5' with 'fc_mask,ch_mask,umask,event,' that may result in non-fatal errors
> > Attempting to add event pmu 'uncore_iio_free_running_3' with 'unc_iio_data_req_of_cpu.mem_read.part0,' that may result in non-fatal errors
> > After aliases, add event pmu 'uncore_iio_free_running_3' with 'fc_mask,ch_mask,umask,event,' that may result in non-fatal errors
> > Attempting to add event pmu 'uncore_iio_free_running_1' with 'unc_iio_data_req_of_cpu.mem_read.part0,' that may result in non-fatal errors
> > After aliases, add event pmu 'uncore_iio_free_running_1' with 'fc_mask,ch_mask,umask,event,' that may result in non-fatal errors
> > Multiple errors dropping message: unknown term 'fc_mask' for pmu 'uncore_iio_free_running_3' (valid terms: event,umask,config,config1,config2,name,period,percore)
> > ...
> > 
> > So before you see a 'WARNING: multiple event parsing errors' and
> > 'Invalid event/parameter'. After you see 'Attempting... that may result
> > in non-fatal errors' then 'Multiple errors...' with details that
> > 'fc_mask' wasn't known to a free running counter. While not completely
> > clean, this makes it clearer that an error hasn't really occurred.
> > 
> > v2. addresses review feedback from Jiri Olsa <jolsa@redhat.com>.
> > 
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
