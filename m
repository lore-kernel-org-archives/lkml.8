Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A58C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A52020578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="naCnImY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgC3QbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:31:03 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:35384 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbgC3QbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:31:03 -0400
Received: by mail-qv1-f67.google.com with SMTP id q73so9247736qvq.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rq/IlQzGR2cD1ve+1iHARCrW3EqcmKFaUl438BeLBGs=;
        b=naCnImY1JqCnFa5NmFXyBMpmSrDQBh2ud4bDUmRJgHQZivfHrLcztd+UQdkyV2fPIm
         IqecoomNAo5R+Ydrr2J0mxaFstlRIkxPXgK+HoDvEwyKe8794qRjSByPAxNSBUXYzfnW
         xQZB9We6GDNyKeXvNiuazNSg6N8stfa+g2gp5UhJW4tpRur5ciSYmEP6IHOVa07Jglyl
         8bJ3suSeLbx/DzR+h4CZIfEbbb3Dn1i2ZlN7ZfFoUKAtzx5FEN9U5bzNTp7eIbHMGIRb
         9T1ig98XLvSwgS3YvJQ7PEqb36VfdEQD8+pQZ+k0TaEByCpltCDKCHFehm10LIhnBTrH
         A7jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rq/IlQzGR2cD1ve+1iHARCrW3EqcmKFaUl438BeLBGs=;
        b=UznUZfXCDf4vQA77FNBTSjvoAeYX3WzgUh1spenzYEpP9A6segzv9jzy2D9S11QhhS
         6LrwUog1zx+1hbWsnHQM9zGBqNU4cMvdnGtso0GVyjLCaFtuNEEbmfmH5s8tFe1AXzzY
         MhJqfjznnsKV4ZOTZ0euhQXgJicZfu0joz+kl5cIsyJMvcnNfdZNeL/mC44NEBTwsj3C
         7frWKdhIfaZQ1xn0nRETf0LtE8IL2gPlgjwQOiGLAaQTMa9vSD/KJsbQ6GfZhP9wlm6e
         AaiY8ytLekU2A6cFq+D9Mac7UKUzAWuCjEqpiAzk2XlpZ0WeuxyRYqSavXSTqvsdCJPo
         frKQ==
X-Gm-Message-State: ANhLgQ1+zNOK9G7o85Ge+9/K44a0cCu7MG2vDk/60gVnpTtFeJbe0Gl1
        Nsa+RyYqbDRF0cnAjmbfW0E=
X-Google-Smtp-Source: ADFU+vu2XGj3mG8JQ07bEAh4RYyLf2DNSHDwnLwDF8Zqr7APMErTajc27FHkwE+pNWqVNrbc3c0+oQ==
X-Received: by 2002:a05:6214:7e6:: with SMTP id bp6mr12636128qvb.47.1585585861069;
        Mon, 30 Mar 2020 09:31:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x17sm7890420qkb.87.2020.03.30.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:31:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 304CD409A3; Mon, 30 Mar 2020 13:30:58 -0300 (-03)
Date:   Mon, 30 Mar 2020 13:30:58 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 6/9] perf record: Support synthesizing cgroup events
Message-ID: <20200330163058.GC4576@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-7-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325124536.2800725-7-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:45:33PM +0900, Namhyung Kim escreveu:
> Synthesize cgroup events by iterating cgroup filesystem directories.
> The cgroup event only saves the portion of cgroup path after the mount
> point and the cgroup id (which actually is a file handle).

Breaks the build on alpine linux (musl libc):

  CC       /tmp/build/perf/util/srccode.o
  CC       /tmp/build/perf/util/synthetic-events.o
util/synthetic-events.c: In function 'perf_event__synthesize_cgroup':
util/synthetic-events.c:427:22: error: field 'fh' has incomplete type
   struct file_handle fh;
                      ^
util/synthetic-events.c:441:6: error: implicit declaration of function 'name_to_handle_at' [-Werror=implicit-function-declaration]
  if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
      ^
util/synthetic-events.c:441:2: error: nested extern declaration of 'name_to_handle_at' [-Werror=nested-externs]
  if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
  ^
  CC       /tmp/build/perf/util/data.o
cc1: all warnings being treated as errors
mv: can't rename '/tmp/build/perf/util/.synthetic-events.o.tmp': No such file or directory


I'm trying to fix
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c        |   5 ++
>  tools/perf/util/synthetic-events.c | 113 +++++++++++++++++++++++++++++
>  tools/perf/util/synthetic-events.h |   1 +
>  tools/perf/util/tool.h             |   1 +
>  4 files changed, 120 insertions(+)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 4c301466101b..2802de9538ff 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1397,6 +1397,11 @@ static int record__synthesize(struct record *rec, bool tail)
>  	if (err < 0)
>  		pr_warning("Couldn't synthesize bpf events.\n");
>  
> +	err = perf_event__synthesize_cgroups(tool, process_synthesized_event,
> +					     machine);
> +	if (err < 0)
> +		pr_warning("Couldn't synthesize cgroup events.\n");
> +
>  	err = __machine__synthesize_threads(machine, tool, &opts->target, rec->evlist->core.threads,
>  					    process_synthesized_event, opts->sample_address,
>  					    1);
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index f72d80999506..24975470ed5c 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -16,6 +16,7 @@
>  #include "util/synthetic-events.h"
>  #include "util/target.h"
>  #include "util/time-utils.h"
> +#include "util/cgroup.h"
>  #include <linux/bitops.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
> @@ -414,6 +415,118 @@ int perf_event__synthesize_mmap_events(struct perf_tool *tool,
>  	return rc;
>  }
>  
> +static int perf_event__synthesize_cgroup(struct perf_tool *tool,
> +					 union perf_event *event,
> +					 char *path, size_t mount_len,
> +					 perf_event__handler_t process,
> +					 struct machine *machine)
> +{
> +	size_t event_size = sizeof(event->cgroup) - sizeof(event->cgroup.path);
> +	size_t path_len = strlen(path) - mount_len + 1;
> +	struct {
> +		struct file_handle fh;
> +		uint64_t cgroup_id;
> +	} handle;
> +	int mount_id;
> +
> +	while (path_len % sizeof(u64))
> +		path[mount_len + path_len++] = '\0';
> +
> +	memset(&event->cgroup, 0, event_size);
> +
> +	event->cgroup.header.type = PERF_RECORD_CGROUP;
> +	event->cgroup.header.size = event_size + path_len + machine->id_hdr_size;
> +
> +	handle.fh.handle_bytes = sizeof(handle.cgroup_id);
> +	if (name_to_handle_at(AT_FDCWD, path, &handle.fh, &mount_id, 0) < 0) {
> +		pr_debug("stat failed: %s\n", path);
> +		return -1;
> +	}
> +
> +	event->cgroup.id = handle.cgroup_id;
> +	strncpy(event->cgroup.path, path + mount_len, path_len);
> +	memset(event->cgroup.path + path_len, 0, machine->id_hdr_size);
> +
> +	if (perf_tool__process_synth_event(tool, event, machine, process) < 0) {
> +		pr_debug("process synth event failed\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int perf_event__walk_cgroup_tree(struct perf_tool *tool,
> +					union perf_event *event,
> +					char *path, size_t mount_len,
> +					perf_event__handler_t process,
> +					struct machine *machine)
> +{
> +	size_t pos = strlen(path);
> +	DIR *d;
> +	struct dirent *dent;
> +	int ret = 0;
> +
> +	if (perf_event__synthesize_cgroup(tool, event, path, mount_len,
> +					  process, machine) < 0)
> +		return -1;
> +
> +	d = opendir(path);
> +	if (d == NULL) {
> +		pr_debug("failed to open directory: %s\n", path);
> +		return -1;
> +	}
> +
> +	while ((dent = readdir(d)) != NULL) {
> +		if (dent->d_type != DT_DIR)
> +			continue;
> +		if (!strcmp(dent->d_name, ".") ||
> +		    !strcmp(dent->d_name, ".."))
> +			continue;
> +
> +		/* any sane path should be less than PATH_MAX */
> +		if (strlen(path) + strlen(dent->d_name) + 1 >= PATH_MAX)
> +			continue;
> +
> +		if (path[pos - 1] != '/')
> +			strcat(path, "/");
> +		strcat(path, dent->d_name);
> +
> +		ret = perf_event__walk_cgroup_tree(tool, event, path,
> +						   mount_len, process, machine);
> +		if (ret < 0)
> +			break;
> +
> +		path[pos] = '\0';
> +	}
> +
> +	closedir(d);
> +	return ret;
> +}
> +
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	union perf_event event;
> +	char cgrp_root[PATH_MAX];
> +	size_t mount_len;  /* length of mount point in the path */
> +
> +	if (cgroupfs_find_mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
> +		pr_debug("cannot find cgroup mount point\n");
> +		return -1;
> +	}
> +
> +	mount_len = strlen(cgrp_root);
> +	/* make sure the path starts with a slash (after mount point) */
> +	strcat(cgrp_root, "/");
> +
> +	if (perf_event__walk_cgroup_tree(tool, &event, cgrp_root, mount_len,
> +					 process, machine) < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
>  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process,
>  				   struct machine *machine)
>  {
> diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
> index baead0cdc381..e7a3e9589738 100644
> --- a/tools/perf/util/synthetic-events.h
> +++ b/tools/perf/util/synthetic-events.h
> @@ -45,6 +45,7 @@ int perf_event__synthesize_kernel_mmap(struct perf_tool *tool, perf_event__handl
>  int perf_event__synthesize_mmap_events(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine, bool mmap_data);
>  int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_namespaces(struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
> +int perf_event__synthesize_cgroups(struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
>  int perf_event__synthesize_stat_config(struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
>  int perf_event__synthesize_stat_events(struct perf_stat_config *config, struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 472ef5eb4068..3fb67bd31e4a 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -79,6 +79,7 @@ struct perf_tool {
>  	bool		ordered_events;
>  	bool		ordering_requires_timestamps;
>  	bool		namespace_events;
> +	bool		cgroup_events;
>  	bool		no_warn;
>  	enum show_feature_header show_feat_hdr;
>  };
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
