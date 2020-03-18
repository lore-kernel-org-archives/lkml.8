Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC53C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA420754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXmbj6hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCRTr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:47:29 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46715 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgCRTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:47:29 -0400
Received: by mail-qk1-f193.google.com with SMTP id f28so40932449qkk.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G6mRJbMU/E+7wacrEarsO4/RKUbGugJhENPynDA6Q04=;
        b=iXmbj6hhkjvHNyDs4El8jcNC4hdRJQIR9FfmsPX0Q0PDvqjGEldsjXZpLATJ0732Mw
         trc79QXi8dkpbArgikepb31mu+2IUyUXpFlhZOlg5xgVd3gh6Lfnm5yKIe3La/XMjCzk
         KvRveNNUwOwXAxPj0ZOexZHruBRGiA6+IInjj4/ByN13jQr4KEf/W1Xt9Fziyi+WS6IO
         YaxpXQLDb02X14zXiDzHKyFM7PqQQ9wfhs0wjfCZE1cpbPhjNGjDvYi8sqdb5J9m3XLK
         3mnRMFL6fdYS1TZwbrVrWAKoPvIo2ue/N7JI00hMxqvCZOuCOFc+AW5XXskuA8qvkpcq
         KSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G6mRJbMU/E+7wacrEarsO4/RKUbGugJhENPynDA6Q04=;
        b=RPN75qYo1d4KYchz8KLBon3yXgbvoW28JoEUMHozntXtDuba4qlw7AcMitOH1CC8+a
         90Gt/3g2V4dsRbEi+hVMVdMlv5JNI0n8jqzrSeAGhsi7qXBbKCXOgKk3l/SCWelQEh6W
         tOuWCTsJMN2j0xj715L5w2DNx5uy4RQTHrWuEJLHClCqI4iKyC8Hah+1/FDn2VpsqBiO
         v3/nDt5DzlEMgoEHu+w9OsgF8uLKC5bsA12GXH8t5b15yDUtbtmT137aYE7SxYA8Uxm+
         Bun7hVFOMGOmZN8zMZfYpkQvUmMnR8tyFEytJb2xQa6d2T+M1GyWZlnepXeYZ4wi5T28
         Ho1w==
X-Gm-Message-State: ANhLgQ1Wj22ejSzKWMzS63Qe+VK1gfdxhcWhiSnBg7zsuVwcMkAg9LXp
        m/CeuX1wSSlrsasxbc7CWtM=
X-Google-Smtp-Source: ADFU+vt4WHrjzyaq8E+RxhbcDIMBk37Qxjk3H6/muQKswezoleq0LipdxoFffalkTU7Aa3UcAt+/6Q==
X-Received: by 2002:a05:620a:1304:: with SMTP id o4mr5623816qkj.56.1584560846432;
        Wed, 18 Mar 2020 12:47:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x11sm4600775qkf.67.2020.03.18.12.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:47:25 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F532404E4; Wed, 18 Mar 2020 16:47:22 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:47:22 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, mathieu.poirier@linaro.org,
        ravi.bangoria@linux.ibm.com, alexey.budankov@linux.intel.com,
        vitaly.slobodskoy@intel.com, pavel.gerasimov@intel.com,
        mpe@ellerman.id.au, eranian@google.com, ak@linux.intel.com
Subject: Re: [PATCH V3 01/17] perf pmu: Add support for PMU capabilities
Message-ID: <20200318194722.GR11531@kernel.org>
References: <20200313183319.17739-1-kan.liang@linux.intel.com>
 <20200313183319.17739-2-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313183319.17739-2-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 13, 2020 at 11:33:03AM -0700, kan.liang@linux.intel.com escreveu:
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
>  tools/perf/util/pmu.c | 98 +++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/pmu.h | 12 ++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 8b99fd312aae..4cdfbb669567 100644
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
> @@ -1565,3 +1566,100 @@ int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt,
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

Since there will be a v4 for other reasons, please combine the
declaration plus assignment when possible, like above, i.e. make it:

+	struct perf_pmu_caps *caps = zalloc(sizeof(*caps));
+
+	if (!caps)
+		return -ENOMEM;

> +
> +	caps->name = strdup(name);
> +	if (!caps->name)
> +		goto free_caps;
> +	caps->value = strndup(value, strlen(value) - 1);
> +	if (!caps->value)
> +		goto free_name;
> +	list_add_tail(&caps->list, list);
> +	return 0;
> +
> +free_name:
> +	free(caps->name);

In these cases I think this is preferred:

	zfree(&caps->name);

> +free_caps:
> +	free(caps);
> +
> +	return -ENOMEM;
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

I haven't looked at what is in such directories that would justify still
returning whatever was read so far when failing to read one of its
files, is this sensible? Care to explain a bit why you think so? Looks
fishy :-\

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

Why not:

	return caps ? list_next_entry(caps) : list_first_entry(&pmu->caps, struct perf_pmu_caps, list);

Nah, it'll return the head after the last entry, not NULL, argh.

Anyway, looks like a confusing API :-\

I'll see how it is used in the following patches...

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
