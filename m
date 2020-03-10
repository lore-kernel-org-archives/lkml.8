Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268A0C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E285D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8DlPjp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728787AbgCJNUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:20:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42642 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgCJNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:06:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id e11so12531175qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wtZPzv0PpHZZsSK2suMlhJIQwEBEu63FKkpnzKmgZ7k=;
        b=A8DlPjp/LYe12G192gRwGVz2RgHtqcDU1CVBDy5Z+ca79bLTRoNPz1peaHjabz/5T9
         IT11ro5uifJu/ZGhxGzogPCcfr7nxz8FQTCaaQsTonJ2fZ5/i7iMcW62ghfvtTDqo4tr
         vxQJgZU5q4qe/s9Chowo/5Nye7EJawtBJa7CPkTZ9Qt570bMFLGl0Jfa7/iESS6yBgn3
         K5LevGW6U1kHpBsyj8aCjCsTVR8/JCIVe2GtyUgy1FxFs8Q852HgksEaNnKs+nVp9M1B
         7lmD42ilLbMHJM9a1P7Bo954DvQuPSXP23r2K///CKlniHN08u/UvubacxHg+J63vNwR
         XBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wtZPzv0PpHZZsSK2suMlhJIQwEBEu63FKkpnzKmgZ7k=;
        b=Qdbopx2G+Y7o3kveHNR3FQDeN2JyI8y4lFHI28ybA+s3I6gCexeRDw51x45oCOgiz3
         9APPGOs/Fwpe/mQUeiI1SrO/VLmHp/HlonSd+WxVPrK/bEEk6dj38cfaIFONgxaMyx57
         FKZ6KI/uveIYkInHmKRqZlLsU/oc4WNV6+zSM5IKw98uh60NPH3FIochcAn3Rvfj8Bdi
         VsQ3XDKGDhoLz3GjZklMIoRMShK9vmI1MfQ4Y4rKOG9gmBc2/pNHv3SEpNkX3AzArqwj
         atM+3oyH/7cKaBCsKxURZSlEU6tUUjEGUAYYMvKzLIkqC2u2Ll+tNVZ1eoM3mvaxKj3V
         o9RA==
X-Gm-Message-State: ANhLgQ3r0lgqHXoNItK0ihUXLeFgf2pprHRLUOxDWGLMjJMez5WFD4Vu
        R4cy+pGilGGwLje9l7XsiXY=
X-Google-Smtp-Source: ADFU+vukhNkRKpi0/WuJY6v2qxUakq13M6cofiPIAG0Zj1Sx08lkmIOWVo9MMzDKxi9SagvhSCLLQg==
X-Received: by 2002:a37:62d1:: with SMTP id w200mr14309578qkb.399.1583845610829;
        Tue, 10 Mar 2020 06:06:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m1sm937534qtk.16.2020.03.10.06.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:06:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A28FB40009; Tue, 10 Mar 2020 10:06:44 -0300 (-03)
Date:   Tue, 10 Mar 2020 10:06:44 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V2 1/9] perf pmu: Add support for PMU capabilities
Message-ID: <20200310130644.GC15931@kernel.org>
References: <20200309174639.4594-1-kan.liang@linux.intel.com>
 <20200309174639.4594-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309174639.4594-2-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 09, 2020 at 10:46:31AM -0700, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The PMU capabilities information, which is located at
> /sys/bus/event_source/devices/<dev>/caps, is required by perf tool.
> For example, the max LBR information is required to stitch LBR call
> stack.
> 
> Add perf_pmu__caps_parse() to parse the PMU capabilities information.
> The information is stored in a list.
> 
> Add perf_pmu__scan_caps() to scan the capabilities one by one.
> 
> The following patch will store the capabilities information in perf
> header.
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/util/pmu.c | 87 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.h | 12 ++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8b99fd312aae..13634ca09096 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -844,6 +844,7 @@ static struct perf_pmu *pmu_lookup(const char *name)
>  
>  	INIT_LIST_HEAD(&pmu->format);
>  	INIT_LIST_HEAD(&pmu->aliases);
> +	INIT_LIST_HEAD(&pmu->caps);
>  	list_splice(&format, &pmu->format);
>  	list_splice(&aliases, &pmu->aliases);
>  	list_add_tail(&pmu->list, &pmus);
> @@ -1565,3 +1566,89 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
>  	va_end(args);
>  	return ret;
>  }
> +
> +static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
> +{
> +	struct perf_pmu_caps *caps;
> +
> +	caps = zalloc(sizeof(*caps));
> +	if (!caps)
> +		return -ENOMEM;
> +

So here you check if zalloc fails and returns a proper error

> +	caps->name = strdup(name);
> +	caps->value = strndup(value, strlen(value) - 1);

But then you don't check strdup()?

> +	list_add_tail(&caps->list, list);
> +	return 0;
> +}
> +
> +/*
> + * Reading/parsing the given pmu capabilities, which should be located at:
> + * /sys/bus/event_source/devices/<dev>/caps as sysfs group attributes.
> + * Return the number of capabilities
> + */
> +int perf_pmu__caps_parse(struct perf_pmu *pmu)
> +{
> +	struct stat st;
> +	char caps_path[PATH_MAX];
> +	const char *sysfs = sysfs__mountpoint();
> +	DIR *caps_dir;
> +	struct dirent *evt_ent;
> +	int nr_caps = 0;
> +
> +	if (!sysfs)
> +		return -1;
> +
> +	snprintf(caps_path, PATH_MAX,
> +		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
> +
> +	if (stat(caps_path, &st) < 0)
> +		return 0;	/* no error if caps does not exist */
> +
> +	caps_dir = opendir(caps_path);
> +	if (!caps_dir)
> +		return -EINVAL;
> +
> +	while ((evt_ent = readdir(caps_dir)) != NULL) {
> +		char path[PATH_MAX + NAME_MAX + 1];
> +		char *name = evt_ent->d_name;
> +		char value[128];
> +		FILE *file;
> +
> +		if (!strcmp(name, ".") || !strcmp(name, ".."))
> +			continue;
> +
> +		snprintf(path, sizeof(path), "%s/%s", caps_path, name);
> +
> +		file = fopen(path, "r");
> +		if (!file)
> +			break;
> +
> +		if (!fgets(value, sizeof(value), file) ||
> +		    (perf_pmu__new_caps(&pmu->caps, name, value) < 0)) {
> +			fclose(file);
> +			break;
> +		}
> +
> +		nr_caps++;
> +		fclose(file);
> +	}
> +
> +	closedir(caps_dir);
> +
> +	return nr_caps;
> +}
> +
> +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
> +					  struct perf_pmu_caps *caps)
> +{
> +	if (!pmu)
> +		return NULL;
> +
> +	if (!caps)
> +		caps = list_prepare_entry(caps, &pmu->caps, list);
> +
> +	list_for_each_entry_continue(caps, &pmu->caps, list)
> +		return caps;
> +
> +	return NULL;
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 6737e3d5d568..a228e27ae462 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -21,6 +21,12 @@ enum {
>  
>  struct perf_event_attr;
>  
> +struct perf_pmu_caps {
> +	char *name;
> +	char *value;
> +	struct list_head list;
> +};
> +
>  struct perf_pmu {
>  	char *name;
>  	__u32 type;
> @@ -32,6 +38,7 @@ struct perf_pmu {
>  	struct perf_cpu_map *cpus;
>  	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
>  	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
> +	struct list_head caps;    /* HEAD struct perf_pmu_caps -> list */
>  	struct list_head list;    /* ELEM */
>  };
>  
> @@ -102,4 +109,9 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
>  
>  int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
>  
> +int perf_pmu__caps_parse(struct perf_pmu *pmu);
> +
> +struct perf_pmu_caps *perf_pmu__scan_caps(struct perf_pmu *pmu,
> +					  struct perf_pmu_caps *caps);
> +
>  #endif /* __PMU_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
