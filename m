Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80252206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 21:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VcFv5m1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGHVKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 17:10:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32049 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725787AbgGHVKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 17:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594242597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cMkFg65WcVWhHAZNhS/Wx9UvcLXZDDH50bQEnVRsEOE=;
        b=VcFv5m1m8wDT5ZWNCR4gYxF1ZZ+M+vtuoGsi92vE092u9aWJw2Zwnxm5ujJjIEeIfNlzDJ
        WELljzpBpvJuzhy1JAcOnoAkzT0UKNbaPH1SAyKVzNqsGno1PfoQ3rDu6enxjX17V6qJ1G
        7HjCbC7V2sW5e4w/xOJJY1soKmOSY7I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-Kq1Gqdr6Miq_1_OS-_2yFw-1; Wed, 08 Jul 2020 17:09:53 -0400
X-MC-Unique: Kq1Gqdr6Miq_1_OS-_2yFw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F0C2107ACCA;
        Wed,  8 Jul 2020 21:09:52 +0000 (UTC)
Received: from krava (unknown [10.40.195.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id DC3B17F8A1;
        Wed,  8 Jul 2020 21:09:49 +0000 (UTC)
Date:   Wed, 8 Jul 2020 23:09:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, alexey.budankov@linux.intel.com,
        adrian.hunter@intel.com
Subject: Re: [PATCH 2/2] perf record: Support closing siblings' file
 descriptors
Message-ID: <20200708210948.GD3581918@krava>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-3-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708151635.81239-3-alexander.shishkin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 06:16:35PM +0300, Alexander Shishkin wrote:
> This changes perf record to close siblings' file descriptors after they
> are created, to reduce the number of open files. The trick is setting up
> mappings and applying ioctls to these guys before they get closed, which
> means a slight rework to allow these things to happen in the same loop as
> evsel creation.
> 
> Before:
> 
> > $ perf record -e '{dummy,syscalls:*}' -o before.data uname
> > Error:
> > Too many events are opened.
> > Probably the maximum number of open file descriptors has been reached.
> > Hint: Try again after reducing the number of events.
> > Hint: Try increasing the limit with 'ulimit -n <limit>'
> 
> After:
> 
> > $ perf record -e '{dummy,syscalls:*}' -o after.data uname
> > Couldn't synthesize cgroup events.
> > Linux
> > [ perf record: Woken up 5 times to write data ]
> > [ perf record: Captured and wrote 0.118 MB after.data (62 samples) ]

hi,
really nice ;-) some questions/comments below

thanks,
jirka

> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> ---
>  tools/include/uapi/linux/perf_event.h   |  1 +
>  tools/lib/perf/evlist.c                 | 30 +++++++++++++++-
>  tools/lib/perf/evsel.c                  | 21 +++++++++++
>  tools/lib/perf/include/internal/evsel.h |  4 +++
>  tools/perf/builtin-record.c             | 48 +++++++++++++++++++------
>  tools/perf/util/cpumap.c                |  4 +++
>  tools/perf/util/evlist.c                |  4 ++-
>  tools/perf/util/evsel.c                 | 17 ++++++++-
>  tools/perf/util/evsel.h                 |  3 ++
>  9 files changed, 119 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 7b2d6fc9e6ed..90238b8ee2ae 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -1069,6 +1069,7 @@ enum perf_callchain_context {
>  #define PERF_FLAG_FD_OUTPUT		(1UL << 1)
>  #define PERF_FLAG_PID_CGROUP		(1UL << 2) /* pid=cgroup id, per-cpu mode only */
>  #define PERF_FLAG_FD_CLOEXEC		(1UL << 3) /* O_CLOEXEC */
> +#define PERF_FLAG_ALLOW_CLOSE		(1UL << 4) /* XXX */
>  
>  #if defined(__LITTLE_ENDIAN_BITFIELD)
>  union perf_mem_data_src {
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6a875a0f01bb..8aeb5634bc61 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -403,6 +403,7 @@ perf_evlist__mmap_cb_get(struct perf_evlist *evlist, bool overwrite, int idx)
>  }
>  
>  #define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
> +#define OUTPUT(e, x, y) (*(int *)xyarray__entry(e->output, x, y))
>  
>  static int
>  perf_evlist__mmap_cb_mmap(struct perf_mmap *map, struct perf_mmap_param *mp,
> @@ -433,6 +434,11 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		bool overwrite = evsel->attr.write_backward;
>  		struct perf_mmap *map;
>  		int *output, fd, cpu;
> +		bool do_close = false;
> +
> +		/* Skip over not yet opened evsels */
> +		if (!evsel->fd)
> +			continue;
>  
>  		if (evsel->system_wide && thread)
>  			continue;
> @@ -454,6 +460,10 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		}
>  
>  		fd = FD(evsel, cpu, thread);
> +		if (OUTPUT(evsel, cpu, thread) >= 0) {
> +			*output = OUTPUT(evsel, cpu, thread);
> +			continue;
> +		}

this check could be earlier in the loop to save some cycles

>  
>  		if (*output == -1) {
>  			*output = fd;
> @@ -479,6 +489,10 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			if (!idx)
>  				perf_evlist__set_mmap_first(evlist, map, overwrite);
>  		} else {
> +			if (fd < 0) {
> +				fd = -fd;
> +				do_close = true;
> +			}
>  			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
>  				return -1;
>  
> @@ -487,7 +501,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  
>  		revent = !overwrite ? POLLIN : 0;
>  
> -		if (!evsel->system_wide &&
> +		if (!evsel->system_wide && !do_close &&
>  		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
>  			perf_mmap__put(map);
>  			return -1;
> @@ -500,6 +514,13 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  			perf_evlist__set_sid_idx(evlist, evsel, idx, cpu,
>  						 thread);
>  		}
> +
> +		if (do_close) {
> +			close(fd);
> +			perf_mmap__put(map);
> +			FD(evsel, cpu, thread) = -1; /* *output */
> +		}

it's also possible to define new callback in perf_evlist_mmap_ops,
and do the close there.. not sure it'd be nicer


> +		OUTPUT(evsel, cpu, thread) = *output;
>  	}
>  
>  	return 0;
> @@ -587,10 +608,17 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  	evlist->nr_mmaps = perf_evlist__nr_mmaps(evlist);
>  
>  	perf_evlist__for_each_entry(evlist, evsel) {
> +		/* Skip over not yet opened evsels */
> +		if (!evsel->fd)
> +			continue;
> +
>  		if ((evsel->attr.read_format & PERF_FORMAT_ID) &&
>  		    evsel->sample_id == NULL &&
>  		    perf_evsel__alloc_id(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
>  			return -ENOMEM;
> +		if (evsel->output == NULL &&
> +		    perf_evsel__alloc_output(evsel, perf_cpu_map__nr(cpus), threads->nr) < 0)
> +			return -ENOMEM;
>  	}
>  
>  	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
> diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> index 4dc06289f4c7..6661145ca673 100644
> --- a/tools/lib/perf/evsel.c
> +++ b/tools/lib/perf/evsel.c
> @@ -55,6 +55,21 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
>  	return evsel->fd != NULL ? 0 : -ENOMEM;
>  }
>  
> +int perf_evsel__alloc_output(struct perf_evsel *evsel, int ncpus, int nthreads)
> +{
> +	evsel->output = xyarray__new(ncpus, nthreads, sizeof(int));
> +
> +	if (evsel->output) {
> +		int cpu, thread;
> +		for (cpu = 0; cpu < ncpus; cpu++) {
> +			for (thread = 0; thread < nthreads; thread++)
> +				*(int *)xyarray__entry(evsel->output, cpu, thread) = -1;
> +		}
> +	}
> +
> +	return evsel->output != NULL ? 0 : -ENOMEM;
> +}
> +
>  static int
>  sys_perf_event_open(struct perf_event_attr *attr,
>  		    pid_t pid, int cpu, int group_fd,
> @@ -139,6 +154,12 @@ void perf_evsel__free_fd(struct perf_evsel *evsel)
>  	evsel->fd = NULL;
>  }
>  
> +void perf_evsel__free_output(struct perf_evsel *evsel)
> +{
> +	xyarray__delete(evsel->output);
> +	evsel->output = NULL;
> +}
> +
>  void perf_evsel__close(struct perf_evsel *evsel)
>  {
>  	if (evsel->fd == NULL)
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 1ffd083b235e..9bbbec7d92b1 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -42,6 +42,7 @@ struct perf_evsel {
>  	struct perf_thread_map	*threads;
>  	struct xyarray		*fd;
>  	struct xyarray		*sample_id;
> +	struct xyarray		*output;
>  	u64			*id;
>  	u32			 ids;
>  
> @@ -60,4 +61,7 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
>  int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
>  void perf_evsel__free_id(struct perf_evsel *evsel);
>  
> +int perf_evsel__alloc_output(struct perf_evsel *evsel, int ncpus, int nthreads);
> +void perf_evsel__free_output(struct perf_evsel *evsel);

introducing these helpers together with the re-entrancy check
should go to separate patch

> +
>  #endif /* __LIBPERF_INTERNAL_EVSEL_H */
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e108d90ae2ed..7dd7db4ff37a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -837,6 +837,21 @@ static int record__mmap(struct record *rec)
>  	return record__mmap_evlist(rec, rec->evlist);
>  }
>  
> +static int record__apply_filters(struct record *rec)
> +{
> +	struct evsel *pos;
> +	char msg[BUFSIZ];
> +
> +	if (perf_evlist__apply_filters(rec->evlist, &pos)) {
> +		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
> +		       pos->filter, evsel__name(pos), errno,
> +		       str_error_r(errno, msg, sizeof(msg)));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  static int record__open(struct record *rec)
>  {
>  	char msg[BUFSIZ];
> @@ -844,6 +859,7 @@ static int record__open(struct record *rec)
>  	struct evlist *evlist = rec->evlist;
>  	struct perf_session *session = rec->session;
>  	struct record_opts *opts = &rec->opts;
> +	bool late_mmap = true;
>  	int rc = 0;
>  
>  	/*
> @@ -894,6 +910,21 @@ static int record__open(struct record *rec)
>  		}
>  
>  		pos->supported = true;
> +
> +		if (pos->allow_close) {
> +			rc = record__mmap(rec);
> +			if (rc)
> +				goto out;
> +			rc = record__apply_filters(rec);
> +			if (rc)
> +				goto out;
> +			late_mmap = false;
> +		}

I was wondering why to call record__mmap for each evsel,
and why there are all those new re-entrancy checks..

because we want to close those file descriptors along the way,
not after all is open.. it could have been mentioned in some
comment ;-)

with all those re-entrancy checks could we call it just from
here for both allow_close and not allow_close cases and skip
the call below?

> +	}
> +
> +	evlist__for_each_entry(evlist, pos) {
> +		if (pos->core.output)
> +			perf_evsel__free_output(&pos->core);
>  	}
>  
>  	if (symbol_conf.kptr_restrict && !perf_evlist__exclude_kernel(evlist)) {
> @@ -907,18 +938,15 @@ static int record__open(struct record *rec)
>  "even with a suitable vmlinux or kallsyms file.\n\n");
>  	}
>  
> -	if (perf_evlist__apply_filters(evlist, &pos)) {
> -		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
> -			pos->filter, evsel__name(pos), errno,
> -			str_error_r(errno, msg, sizeof(msg)));
> -		rc = -1;
> -		goto out;
> +	if (late_mmap) {
> +		rc = record__mmap(rec);
> +		if (rc)
> +			goto out;
> +		rc = record__apply_filters(rec);
> +		if (rc)
> +			goto out;
>  	}
>  
> -	rc = record__mmap(rec);
> -	if (rc)
> -		goto out;
> -
>  	session->evlist = evlist;
>  	perf_session__set_id_hdr_size(session);
>  out:
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index dc5c5e6fc502..2eac58ada5ab 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -432,6 +432,10 @@ int cpu__setup_cpunode_map(void)
>  	const char *mnt;
>  	int n;
>  
> +	/* Only do this once */
> +	if (cpunode_map)
> +		return 0;
> +

this should go to separate patch

>  	/* initialize globals */
>  	if (init_cpunode_map())
>  		return -1;
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 173b4f0e0e6e..776a8339df99 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -977,7 +977,7 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
>  	int err = 0;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->filter == NULL)
> +		if (evsel->filter == NULL || evsel->filter_applied)
>  			continue;
>  
>  		/*
> @@ -989,6 +989,8 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
>  			*err_evsel = evsel;
>  			break;
>  		}
> +
> +		evsel->filter_applied = true;
>  	}
>  
>  	return err;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 96e5171dce41..696c5d7190e2 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1172,6 +1172,7 @@ int evsel__set_filter(struct evsel *evsel, const char *filter)
>  	if (new_filter != NULL) {
>  		free(evsel->filter);
>  		evsel->filter = new_filter;
> +		evsel->filter_applied = false;
>  		return 0;
>  	}
>  
> @@ -1632,6 +1633,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		pid = evsel->cgrp->fd;
>  	}
>  
> +	if (evsel->leader != evsel)
> +		flags |= PERF_FLAG_ALLOW_CLOSE;
> +
>  fallback_missing_features:
>  	if (perf_missing_features.clockid_wrong)
>  		evsel->core.attr.clockid = CLOCK_MONOTONIC; /* should always work */
> @@ -1641,6 +1645,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	}
>  	if (perf_missing_features.cloexec)
>  		flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> +	if (perf_missing_features.allow_close)
> +		flags &= ~(unsigned long)PERF_FLAG_ALLOW_CLOSE;
>  	if (perf_missing_features.mmap2)
>  		evsel->core.attr.mmap2 = 0;
>  	if (perf_missing_features.exclude_guest)
> @@ -1729,6 +1735,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  				err = -EINVAL;
>  				goto out_close;
>  			}
> +
> +			if (flags & PERF_FLAG_ALLOW_CLOSE) {
> +				FD(evsel, cpu, thread) = -fd;
> +				evsel->allow_close = true;

can't we move allow_close to perf_evsel and use that directly
instead of that -fd thing?

> +			}
>  		}
>  	}
>  
> @@ -1766,7 +1777,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	 * Must probe features in the order they were added to the
>  	 * perf_event_attr interface.
>  	 */
> -        if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
> +	if (!perf_missing_features.allow_close && (flags & PERF_FLAG_ALLOW_CLOSE)) {
> +		perf_missing_features.allow_close = true;
> +		pr_debug2("switching off ALLOW_CLOSE support\n");
> +		goto fallback_missing_features;
> +	} else if (!perf_missing_features.cgroup && evsel->core.attr.cgroup) {
>  		perf_missing_features.cgroup = true;
>  		pr_debug2_peo("Kernel has no cgroup sampling support, bailing out\n");
>  		goto out_close;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 0f963c2a88a5..076a541bb274 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -77,6 +77,8 @@ struct evsel {
>  	bool			forced_leader;
>  	bool			use_uncore_alias;
>  	bool			is_libpfm_event;
> +	bool			filter_applied;

should go to separate patch

> +	bool			allow_close;
>  	/* parse modifier helper */
>  	int			exclude_GH;
>  	int			sample_read;
> @@ -130,6 +132,7 @@ struct perf_missing_features {
>  	bool aux_output;
>  	bool branch_hw_idx;
>  	bool cgroup;
> +	bool allow_close;
>  };
>  
>  extern struct perf_missing_features perf_missing_features;
> -- 
> 2.27.0
> 

