Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AC7C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FD61214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldKvjMxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgD2NDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgD2NDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:03:24 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531CFC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:03:24 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id s63so1807701qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tAl7syPo2yQlu/PZKqGcqSBESjyxy3P84yTs4WkPbbI=;
        b=ldKvjMxfAeMsB1TvRmUleq48K0nxf19ST9h6diloFfJWh3HPYhCMUKRlKzh7FwvNOQ
         5SYYkIyuSZAkFneigxihGQZaR5NktSzjVkX8Xg8La8z3selDht56kpMa/BZCKSrQWCYC
         rsHfc9y1lHkJaqeaUCzvaJDN7o+cxGmRcFPq1CxU7mlVia2IhD9tdt62EOO/2o3ty9oa
         iGex5q2Da3ZOBYquP5sQ7+v0aXrHv8HS43SYIIZ+KVazzJIsQMG2V9bKiHKFnMM8ONgr
         7xmHDc4HJUZtACuVtWbz/xdr1qXQ08CQSkY2399enuvuFR5s9Zp2CGCfOfoAdd2DmQkB
         eUZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tAl7syPo2yQlu/PZKqGcqSBESjyxy3P84yTs4WkPbbI=;
        b=ZmePE5Bp3FIrOxb31oTtv+iGyVIcMLOBLAIVIAlzzpPdeUetZVm31gru/AfVk9qaUI
         zcToXPuY3YzbhU6w0y+X+iVFxlAMZR20K3herpd9S7WerKUnWu0gScR/z7cINWZhG4SP
         7U71JgN/pXvpHmrNRrkGhBjCGBNZ02KgxD9P54PiW4d2HCbnXX8ECRMRipFuhuQUkATJ
         1UWoZMyM6jMNBeVKoS3fgWZuHOwxjS7ZfP4Xq6t9Qt1iO9ORf6VHsALau+py+Z+5WtTB
         jFFB0anlZV0wi2/RcoVkDKmHXc8OTSNf4iufiIuOb1wxcwmbeuiw7Ufi7Q0JmBTHwj4/
         Jq6w==
X-Gm-Message-State: AGi0PuZSKtQFK969wvg9t2PrdDAICyaOW3P7tlLr1Loiy7xi/xGuNVX8
        FDax7dF5DKoowpCxNDHHU/A=
X-Google-Smtp-Source: APiQypKD8/dClGE1LyoInBqoNn90Qcp8wHGLsI7jLus/Ar6FJeTFj7vMGtyQm4YvYEzkG5QMzoKhJQ==
X-Received: by 2002:a05:620a:1222:: with SMTP id v2mr32258356qkj.463.1588165403279;
        Wed, 29 Apr 2020 06:03:23 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g6sm16174937qtc.52.2020.04.29.06.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:03:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 326F4409A3; Wed, 29 Apr 2020 10:03:20 -0300 (-03)
Date:   Wed, 29 Apr 2020 10:03:20 -0300
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] perf tool: fix detection of active SMT
Message-ID: <20200429130320.GG5460@kernel.org>
References: <158815443969.303706.11130341357699244442.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158815443969.303706.11130341357699244442.stgit@buzz>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 01:00:39PM +0300, Konstantin Khlebnikov escreveu:
> SMT now could be disabled via "/sys/devices/system/cpu/smt/control".
> Status shown in "/sys/devices/system/cpu/smt/active" simply as "0" / "1".
> 
> If this knob isn't here fallback to checking topology but fix couple bugs:

In these cases, please break the patch into two, the first looking at
this new /sys/devices/system/cpu/smt/active file, then you go and do the
fix, and if its more than one, please break those fixes also in separate
patches.

Also you forgot to add all the people that worked on the fixed csets in
the CC list, so that they could review your work and give their Acked-by
or Reviewed-by, I'm adding the missing one, Andi Kleen, to this
response,

Thanks,

- Arnaldo
 
> Check access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK) fails,
> unless current directory is "/sys". Simply try read this file first.
> 
> Cpu bitmap is split into 32 bit words. For system with more than 32 cores
> threads are always in different words thus first word never has two bits:
> cpu0: "0000,00000100,00000001", cpu 79: "8000,00000080,00000000".
> 
> Instead of parsing bitmap read "core_cpus_list" or "thread_siblings_list"
> and simply check presence of ',' or '-' in it.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: de5077c4e38f ("perf tools: Add utility function to detect SMT status")
> Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
> ---
>  tools/perf/util/smt.c |   41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 3b791ef2cd50..c398528d1006 100644
> --- a/tools/perf/util/smt.c
> +++ b/tools/perf/util/smt.c
> @@ -1,6 +1,7 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <string.h>
>  #include <linux/bitops.h>
>  #include "api/fs/fs.h"
>  #include "smt.h"
> @@ -9,39 +10,39 @@ int smt_on(void)
>  {
>  	static bool cached;
>  	static int cached_result;
> +	int active;
>  	int cpu;
>  	int ncpu;
> +	char *str = NULL;
> +	size_t strlen;
>  
>  	if (cached)
>  		return cached_result;
>  
> +	if (sysfs__read_int("devices/system/cpu/smt/active", &active) > 0)
> +		goto done;
> +
>  	ncpu = sysconf(_SC_NPROCESSORS_CONF);
>  	for (cpu = 0; cpu < ncpu; cpu++) {
> -		unsigned long long siblings;
> -		char *str;
> -		size_t strlen;
>  		char fn[256];
>  
> -		snprintf(fn, sizeof fn,
> -			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
> -		if (access(fn, F_OK) == -1) {
> -			snprintf(fn, sizeof fn,
> -				"devices/system/cpu/cpu%d/topology/thread_siblings",
> -				cpu);
> -		}
> -		if (sysfs__read_str(fn, &str, &strlen) < 0)
> -			continue;
> -		/* Entry is hex, but does not have 0x, so need custom parser */
> -		siblings = strtoull(str, NULL, 16);
> -		free(str);
> -		if (hweight64(siblings) > 1) {
> -			cached_result = 1;
> -			cached = true;
> +		snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
> +			 cpu, "core_cpus_list");
> +		if (sysfs__read_str(fn, &str, &strlen) > 0)
> +			break;
> +
> +		snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
> +			 cpu, "thread_siblings_list");
> +		if (sysfs__read_str(fn, &str, &strlen) > 0)
>  			break;
> -		}
>  	}
> +
> +	active = str && (strchr(str, ',') != NULL || strchr(str, '-') != NULL);
> +	free(str);
> +
> +done:
>  	if (!cached) {
> -		cached_result = 0;
> +		cached_result = active;
>  		cached = true;
>  	}
>  	return cached_result;
> 

-- 

- Arnaldo
