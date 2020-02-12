Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536A1C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A4A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHieW51i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBLNfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:35:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38677 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgBLNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:35:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id f3so1456498qtc.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 05:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ugXtyh0yqkVQHyvHMxbHhHFf3dGGd0T39RMzBP1EvyU=;
        b=fHieW51iWr9OIEh60xrG9smqAN7YLFaOS9omwWD+xTSwwuG1XP6cWrzp5IDCK9c9LO
         KSOHJi/S/mDJEGKaWXvHf8ml+BOPy7WZgjX4AgUGYxDl+RqHvo/DqFfiOl7V0pMoPK9x
         EEGOjur/Ro78yyBMV7Xn1CSasgJiNVTPzTazR8Bo74cLGUl201ZUgpdcoeCkaQdcLYd4
         jrdywINJ3QYFAFOJJhFcY8MiDNz3Uci/cOu78IR25w1wEFd5fTaDaUPNPdK29Q/4qqLL
         0mgSSkOrTJo8u1erNubwOKBzAdiuGkVFh0WOfGTTVBSUT+WmrKIdTCeYjQssq7OGRwzv
         bDjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ugXtyh0yqkVQHyvHMxbHhHFf3dGGd0T39RMzBP1EvyU=;
        b=ELHcD+KxKpuiD6bzz3sVgB92JcUEuH02cFWmh8VWXLncHVVwhBaDiKVnDCgm4n37SQ
         7j47w6UBVZ6r+sYB0uueFno5NRF9znw9aRiLu6n6aq98uHTNXC3B0hoo89+kKpGYcBZV
         w4QVfDQGonXADo5yP+ZbTLBiP1d5+walC6VSRhnT5HgIV7t6SeNdhKpZlajXvEIig4TX
         Fh8i0lrZlW9vXEQIa1kZDWcB/4kRXT+RliwbqjdxIP/BoTEjTAQQZXNwOyynGAZnuhTy
         Pxh+DiFa2ocGr9m6ARTnSJkGYwqAA4SY6GBxP4m+bfb2WMQsEeAN+m6RkJdbIjAKT7uY
         W8Rw==
X-Gm-Message-State: APjAAAVufZVFIyAMP1gWASXG4naeFLf1W7IggWfQ3baGJM9vYSMFiMUp
        Iol/L1IG0EP8aqN1RyUK/DM=
X-Google-Smtp-Source: APXvYqzk18X3OP/n2wdyru1kY9ADi8LO9zSdJDlGtPRzLYODvuW3VflbLKR7LCqBMCguDlyze4JIzg==
X-Received: by 2002:ac8:60d5:: with SMTP id i21mr7088024qtm.341.1581514505626;
        Wed, 12 Feb 2020 05:35:05 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 205sm185751qkd.61.2020.02.12.05.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 05:35:04 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 335BC40A7D; Wed, 12 Feb 2020 10:35:02 -0300 (-03)
Date:   Wed, 12 Feb 2020 10:35:02 -0300
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf tools: Add arm64 version of get_cpuid()
Message-ID: <20200212133502.GB22501@kernel.org>
References: <1576245255-210926-1-git-send-email-john.garry@huawei.com>
 <4ccf4455-b33d-441b-50ed-28211dd87c7c@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ccf4455-b33d-441b-50ed-28211dd87c7c@hisilicon.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 12, 2020 at 05:30:56PM +0800, Shaokun Zhang escreveu:
> Hi John,
> 
> I tested this patch on my new ARM64 Kunpeng 920 server.
> [root@node1 zsk]# ./perf --version
> perf version 5.6.rc1.g2cdb955b7252
> 
> Both perf list and perf stat can work.
> 
> Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Thanks for the test and for (re)bringing this patch to my attention, I'll
process it now.

Thanks!

- Arnaldo
 
> Thanks,
> Shaokun
> 
> On 2019/12/13 21:54, John Garry wrote:
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
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <perf/cpumap.h>
> > +#include <util/cpumap.h>
> >  #include <internal/cpumap.h>
> >  #include <api/fs/fs.h>
> > +#include <errno.h>
> >  #include "debug.h"
> >  #include "header.h"
> >  
> > @@ -12,26 +14,21 @@
> >  #define MIDR_VARIANT_SHIFT      20
> >  #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
> >  
> > -char *get_cpuid_str(struct perf_pmu *pmu)
> > +static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
> >  {
> > -	char *buf = NULL;
> > -	char path[PATH_MAX];
> >  	const char *sysfs = sysfs__mountpoint();
> > -	int cpu;
> >  	u64 midr = 0;
> > -	struct perf_cpu_map *cpus;
> > -	FILE *file;
> > +	int cpu;
> >  
> > -	if (!sysfs || !pmu || !pmu->cpus)
> > -		return NULL;
> > +	if (!sysfs || sz < MIDR_SIZE)
> > +		return EINVAL;
> >  
> > -	buf = malloc(MIDR_SIZE);
> > -	if (!buf)
> > -		return NULL;
> > +	cpus = perf_cpu_map__get(cpus);
> >  
> > -	/* read midr from list of cpus mapped to this pmu */
> > -	cpus = perf_cpu_map__get(pmu->cpus);
> >  	for (cpu = 0; cpu < perf_cpu_map__nr(cpus); cpu++) {
> > +		char path[PATH_MAX];
> > +		FILE *file;
> > +
> >  		scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
> >  				sysfs, cpus->map[cpu]);
> >  
> > @@ -57,12 +54,48 @@ char *get_cpuid_str(struct perf_pmu *pmu)
> >  		break;
> >  	}
> >  
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
> >  		pr_err("failed to get cpuid string for PMU %s\n", pmu->name);
> >  		free(buf);
> >  		buf = NULL;
> >  	}
> >  
> > -	perf_cpu_map__put(cpus);
> >  	return buf;
> >  }
> > 
> 

-- 

- Arnaldo
