Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EDBC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EE1320724
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkgqACIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBLNk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:40:29 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46696 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLNk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:40:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so1510047qkh.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 05:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnBjhKKPWWjwGlSdDsblfiubmy6FG0ISMeKtWk1WU4E=;
        b=KkgqACIe+Rj0gkGSWF6P69W+lldwdj7XkVvjVgjEApytFDFrpRce0JrHzrpqlFW2yY
         knUrrcX3ltS+iUcv5p7lhttaiQnqP1zgMCjN9KI1qPVHjFbaE3GPSAPJQ/pCFj2YYn6J
         f6kkCrcqJt0eI7KCibEQ33BJTAk0Q5XYRi1m1TlK+iNP/YrBjHn8VexfnQ+6h9SX0wKD
         sDE4/4OOdekJuOQ/jkKqwxsVfyBRDBRFOqZ+RqjXdlLHXO064vBL3tNffWfD5q41jApW
         XSIY6rPbfI5CA7ycihdZdzQutFBJNbqsSdSk06FJIGGpZiNXx1Y8CVCzOsvIoHPKeJ97
         jCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnBjhKKPWWjwGlSdDsblfiubmy6FG0ISMeKtWk1WU4E=;
        b=EeSL5IM6BwhQS5urC+40oWgmo/pYDhaQxyBbxvqWTVxl/ma0ft4n1vpZ84dl4Hlg1f
         GIg6UkLGKgBzNKlBFne15E2q0hRWd6l9kliP5rHqWOOUjw5Sxh+Cnd0TJf5RA7kzNMob
         ctKBlx864UIlDrBRwsb9XzfzqltYao2OYLGXjMnmwkexziBESm71vPS34KSFoFwXDxT1
         0dabzFfFuegDeIro+U8Y5f/5j0hHatrKIuuorImO6tihCn4tKhB13VQz2dldvtu7kQcP
         /7gycy9TuCws843n67UjxTZW2jyZulax9znLJ3ECbxjGpwDXkQoMfjEco9m5B46MI1qO
         LYog==
X-Gm-Message-State: APjAAAUl5fD/UeoBUH5y9LWqop9pfb38N6M4UrumXylJ2hDpMIpiNzkK
        dpcY0qLEfNMFT2FL0Wu808s=
X-Google-Smtp-Source: APXvYqwrRxHx2AdyEmKMxhW63A53NQaWTCqIqaIIJs+TU6vH3sYmirigvrmt8L3l4gduv/0udNyg6g==
X-Received: by 2002:a05:620a:1210:: with SMTP id u16mr10229390qkj.179.1581514827592;
        Wed, 12 Feb 2020 05:40:27 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w53sm154509qtb.91.2020.02.12.05.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 05:40:26 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9370140A7D; Wed, 12 Feb 2020 10:40:24 -0300 (-03)
Date:   Wed, 12 Feb 2020 10:40:24 -0300
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf tools: Add arm64 version of get_cpuid()
Message-ID: <20200212134024.GC22501@kernel.org>
References: <1576245255-210926-1-git-send-email-john.garry@huawei.com>
 <1005f572-e32a-a90e-1572-c85a2f202fdf@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1005f572-e32a-a90e-1572-c85a2f202fdf@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 07, 2020 at 09:13:43AM +0000, John Garry escreveu:
> On 13/12/2019 13:54, John Garry wrote:
> 
> Hi Arnaldo,
> 
> Do we need some reviews on this? Or was it missed/still catching up?

Got lost in the holidays, devconf.cz, vacations, sorry, picking it up
now, together with a Tested-by by Shaokun Zhang, some issues with the
formatting of the patch:

- Avoid starting lines with '#' as those will vanish when I use 'git am'

- Separate the commit log message from the diff using a '---' at the
  begining of the line, otherwise 'git am' fails

I fixed those up now, will test with my build containers, thanks.

- Arnaldo
 
> Cheers,
> John
> 
> > Add an arm64 version of get_cpuid(), which is used for various annotation
> > and headers - for example, I now get the CPUID in "perf report --header",
> > as shown in this snippet:
> > 
> > # hostname : ubuntu
> > # os release : 5.5.0-rc1-dirty
> > # perf version : 5.5.rc1.gbf8a13dc9851
> > # arch : aarch64
> > # nrcpus online : 96
> > # nrcpus avail : 96
> > # cpuid : 0x00000000480fd010
> > 
> > Since much of the code to read the MIDR is already in get_cpuid_str(),
> > factor out this code.
> > 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > 
> > diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> > index a32e4b72a98f..d730666ab95d 100644
> > --- a/tools/perf/arch/arm64/util/header.c
> > +++ b/tools/perf/arch/arm64/util/header.c
> > @@ -1,8 +1,10 @@
> >   #include <stdio.h>
> >   #include <stdlib.h>
> >   #include <perf/cpumap.h>
> > +#include <util/cpumap.h>
> >   #include <internal/cpumap.h>
> >   #include <api/fs/fs.h>
> > +#include <errno.h>
> >   #include "debug.h"
> >   #include "header.h"
> > @@ -12,26 +14,21 @@
> >   #define MIDR_VARIANT_SHIFT      20
> >   #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
> > -char *get_cpuid_str(struct perf_pmu *pmu)
> > +static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
> >   {
> > -	char *buf = NULL;
> > -	char path[PATH_MAX];
> >   	const char *sysfs = sysfs__mountpoint();
> > -	int cpu;
> >   	u64 midr = 0;
> > -	struct perf_cpu_map *cpus;
> > -	FILE *file;
> > +	int cpu;
> > -	if (!sysfs || !pmu || !pmu->cpus)
> > -		return NULL;
> > +	if (!sysfs || sz < MIDR_SIZE)
> > +		return EINVAL;
> > -	buf = malloc(MIDR_SIZE);
> > -	if (!buf)
> > -		return NULL;
> > +	cpus = perf_cpu_map__get(cpus);
> > -	/* read midr from list of cpus mapped to this pmu */
> > -	cpus = perf_cpu_map__get(pmu->cpus);
> >   	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
> > +		char path[PATH_MAX];
> > +		FILE *file;
> > +
> >   		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
> >   				sysfs, cpus->map[cpu]);
> > @@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
> >   		break;
> >   	}
> > -	if (!midr) {
> > +	perf_cpu_map__put(cpus);
> > +
> > +	if (!midr)
> > +		return EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +int get_cpuid(char *buf, size_t sz)
> > +{
> > +	struct perf_cpu_map *cpus = perf_cpu_map__new(NULL);
> > +	int ret;
> > +
> > +	if (!cpus)
> > +		return EINVAL;
> > +
> > +	ret = _get_cpuid(buf, sz, cpus);
> > +
> > +	perf_cpu_map__put(cpus);
> > +
> > +	return ret;
> > +}
> > +
> > +char *get_cpuid_str(struct perf_pmu *pmu)
> > +{
> > +	char *buf = NULL;
> > +	int res;
> > +
> > +	if (!pmu || !pmu->cpus)
> > +		return NULL;
> > +
> > +	buf = malloc(MIDR_SIZE);
> > +	if (!buf)
> > +		return NULL;
> > +
> > +	/* read midr from list of cpus mapped to this pmu */
> > +	res = _get_cpuid(buf, MIDR_SIZE, pmu->cpus);
> > +	if (res) {
> >   		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
> >   		free(buf);
> >   		buf = NULL;
> >   	}
> > -	perf_cpu_map__put(cpus);
> >   	return buf;
> >   }
> > 
> 

-- 

- Arnaldo
