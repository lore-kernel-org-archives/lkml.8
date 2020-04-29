Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911B8C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEAB21973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxULsJ5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2SNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726481AbgD2SNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:13:50 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D26C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:13:50 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ep1so1656987qvb.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xTgtmGwxauJTydREgK09WzB6MYiDzB9i7VjPGTpt37U=;
        b=OxULsJ5r5CCmhYeRDREkVhKG6STLXTlbVuo1tpUtqWFJynVd4jBDum0y8GnBOn0/Ea
         mjASoERFgvMOHTPb3TAye72QrcY4lc7+NhAPq/6lTtkdNA8vazAH/TuVyWfsmobpnJvd
         HD+Scip5390cs2hPeMmynSEDhHQR7nSE0xbuglFPghFN1bHNGo1EMivubQ7VMzOivxZ8
         47E9dYOPm1Tw85T6W4Xbd6orp2NByXE9zhxeHCw4m3w07vCkUhtegWLM6WqxwU454/+s
         R3EZeg/WawUoke5ZHRju2kCtHscho5DxiQHK+FMaD/G6zVtOyqblxOez/rhEwo8lwr9V
         dk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xTgtmGwxauJTydREgK09WzB6MYiDzB9i7VjPGTpt37U=;
        b=K/SO2Tca8Ks4t/QQh2URjMcfNYp/niOJIS0nIMMNnDPe3Qprz3oOuivlEyMCmiHuPB
         +up/8KndUGPSTwwgOt8g2BbvDwHgvcbIre7M6bo/pRnDso8b9PxFHk9gU4GWS0f0exl+
         /l/EmcKXV+O0B4y0hZIwpJV0+330eSo+93U9jRQB51rL7I7sTw6Seg6o6SJ3ltQT9+61
         VhsoiMLHftgcSzDBRTkuw1rtcdh8fOCVldekQ7ucyj9Wqs+PZP+F3bFgH/zreusIPG3C
         J3TC8NCkIa8gLIucubuBRN1aF/cx+oY2az8I4YJCsLzlImqK2UGclksI3Pl+Bx2rm3qL
         L34Q==
X-Gm-Message-State: AGi0PuaTX8ztQkTLXQJ7d0Mo/M8668/AsxvcCn2VusnQlhXhtGkW6Wfi
        BZX2Lmc1TGoXETepBSVPMQTEqnibhQx7mg==
X-Google-Smtp-Source: APiQypLQUunEASYCrK9s5Re1XN/UPaJ9Ds5irz5ggXqfTs7Dnb4OTpJovrY1lcBBg+DQAIn3qoZW2w==
X-Received: by 2002:a0c:c603:: with SMTP id v3mr34933774qvi.82.1588184029198;
        Wed, 29 Apr 2020 11:13:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j92sm16382881qtd.58.2020.04.29.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 11:13:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8DCBF409A3; Wed, 29 Apr 2020 15:13:46 -0300 (-03)
Date:   Wed, 29 Apr 2020 15:13:46 -0300
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH v2 2/3] perf tool: fix detecting smt at machines with
 more than 32 cpus
Message-ID: <20200429181346.GF30487@kernel.org>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
 <158817735893.747933.15107805593224835078.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158817735893.747933.15107805593224835078.stgit@buzz>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 29, 2020 at 07:22:43PM +0300, Konstantin Khlebnikov escreveu:
> Cpu bitmap is split into 32 bit words. For system with more than 32 cores
> threads are always in different words thus first word never has two bits:
> cpu0: "0000,00000100,00000001", cpu 79: "8000,00000080,00000000".
> 
> Instead of parsing bitmap read "core_cpus_list" or "thread_siblings_list"
> and simply check presence of ',' or '-' in it.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Fixes: de5077c4e38f ("perf tools: Add utility function to detect SMT status")
> ---
>  tools/perf/util/smt.c |   37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
> index 8481842e9edb..dc37b5abd1c3 100644
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
> @@ -9,39 +10,35 @@ int smt_on(void)
>  {
>  	static bool cached;
>  	static int cached_result;
> +	int active;
>  	int cpu;
>  	int ncpu;
> +	char *str = NULL;
> +	size_t strlen;

Try not to use as the name of a variable the well known name of a
standard C library function, there are cases where some of those names
are used as #define directives and then all hell break loose...

Also doing first the change that makes the use of that new file would
allow me to have processed that patch first, which is way simpler than
this one, i.e. try to leave the more involved changes to the end of the
patchkit, that helps cherry-picking the less complex/smaller parts of
your patchkit.

I've applied the first one, thanks!

- Arnaldo
  
>  	if (cached)
>  		return cached_result;
>  
>  	ncpu = sysconf(_SC_NPROCESSORS_CONF);
>  	for (cpu = 0; cpu < ncpu; cpu++) {
> -		unsigned long long siblings;
> -		char *str;
> -		size_t strlen;
>  		char fn[256];
>  
> -		snprintf(fn, sizeof fn,
> -			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
> -		if (sysfs__read_str(fn, &str, &strlen) < 0) {
> -			snprintf(fn, sizeof fn,
> -				"devices/system/cpu/cpu%d/topology/thread_siblings",
> -				cpu);
> -			if (sysfs__read_str(fn, &str, &strlen) < 0)
> -				continue;
> -		}
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
>  	if (!cached) {
> -		cached_result = 0;
> +		cached_result = active;
>  		cached = true;
>  	}
>  	return cached_result;
> 

-- 

- Arnaldo
