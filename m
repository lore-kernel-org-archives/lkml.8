Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E62BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5B90206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFCLjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:39:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:12461 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCLjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:39:04 -0400
IronPort-SDR: wC+cIayyy/7m63iPkqmHk7HmR2JhHBbiv5dpT4A5ZAaeYZV5jvMyDsEWlVzbTLxEIgP3Xl0v2X
 tU1IjbyBXMiA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:39:03 -0700
IronPort-SDR: cG/RksiWjsjYxU9NvELT5AQnhGYAc8QtBKG9YvnF43ZPxOIgzKmBiVKgC/2W54REw2zltDltj4
 G2VlR4YTVyZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269049933"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.157]) ([10.237.72.157])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 04:39:00 -0700
Subject: Re: [PATCH v6 01/13] tools/libperf: introduce notion of static polled
 file descriptors
To:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <f8e3a714-d9b1-4647-e1d2-9981cbaa83ec@linux.intel.com>
 <40643542-6676-e0bc-2d10-165dfde41e29@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <33c91520-7040-bd6b-b176-004ddbec2a63@intel.com>
Date:   Wed, 3 Jun 2020 14:38:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <40643542-6676-e0bc-2d10-165dfde41e29@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/06/20 11:05 pm, Alexey Budankov wrote:
> 
> Implement adding of file descriptors by fdarray__add_stat() to
> fix-sized (currently 1) stat_entries array located at struct fdarray.
> Append added file descriptors to the array used by poll() syscall
> during fdarray__poll() call. Copy poll() result of the added
> descriptors from the array back to the storage for separate analysis.

Why not instead call evlist__add_pollfd() before other fds are added, so
the fda->entries[] position is always fixed. Then this patch is not needed.

> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c                 | 42 +++++++++++++++++++++++-
>  tools/lib/api/fd/array.h                 |  7 ++++
>  tools/lib/perf/evlist.c                  | 11 +++++++
>  tools/lib/perf/include/internal/evlist.h |  2 ++
>  4 files changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 58d44d5eee31..b0027f2169c7 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -11,10 +11,16 @@
>  
>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>  {
> +	int i;
> +
>  	fda->entries	 = NULL;
>  	fda->priv	 = NULL;
>  	fda->nr		 = fda->nr_alloc = 0;
>  	fda->nr_autogrow = nr_autogrow;
> +
> +	fda->nr_stat = 0;
> +	for (i = 0; i < FDARRAY__STAT_ENTRIES_MAX; i++)
> +		fda->stat_entries[i].fd = -1;
>  }
>  
>  int fdarray__grow(struct fdarray *fda, int nr)
> @@ -83,6 +89,20 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>  	return pos;
>  }
>  
> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents)
> +{
> +	int pos = fda->nr_stat;
> +
> +	if (pos >= FDARRAY__STAT_ENTRIES_MAX)
> +		return -1;
> +
> +	fda->stat_entries[pos].fd = fd;
> +	fda->stat_entries[pos].events = revents;
> +	fda->nr_stat++;
> +
> +	return pos;
> +}
> +
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
>  		    void *arg)
> @@ -113,7 +133,27 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  
>  int fdarray__poll(struct fdarray *fda, int timeout)
>  {
> -	return poll(fda->entries, fda->nr, timeout);
> +	int nr, i, pos, res;
> +
> +	nr = fda->nr;
> +
> +	for (i = 0; i < fda->nr_stat; i++) {
> +		if (fda->stat_entries[i].fd != -1) {
> +			pos = fdarray__add(fda, fda->stat_entries[i].fd,
> +					   fda->stat_entries[i].events);
> +			if (pos >= 0)
> +				fda->priv[pos].idx = i;
> +		}
> +	}
> +
> +	res = poll(fda->entries, fda->nr, timeout);
> +
> +	for (i = nr; i < fda->nr; i++)
> +		fda->stat_entries[fda->priv[i].idx] = fda->entries[i];
> +
> +	fda->nr = nr;
> +
> +	return res;
>  }
>  
>  int fdarray__fprintf(struct fdarray *fda, FILE *fp)
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index b39557d1a88f..9bca72e80b09 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -3,6 +3,7 @@
>  #define __API_FD_ARRAY__
>  
>  #include <stdio.h>
> +#include <poll.h>
>  
>  struct pollfd;
>  
> @@ -16,6 +17,9 @@ struct pollfd;
>   *	  I.e. using 'fda->priv[N].idx = * value' where N < fda->nr is ok,
>   *	  but doing 'fda->priv = malloc(M)' is not allowed.
>   */
> +
> +#define FDARRAY__STAT_ENTRIES_MAX	1
> +
>  struct fdarray {
>  	int	       nr;
>  	int	       nr_alloc;
> @@ -25,6 +29,8 @@ struct fdarray {
>  		int    idx;
>  		void   *ptr;
>  	} *priv;
> +	int	       nr_stat;
> +	struct pollfd  stat_entries[FDARRAY__STAT_ENTRIES_MAX];
>  };
>  
>  void fdarray__init(struct fdarray *fda, int nr_autogrow);
> @@ -34,6 +40,7 @@ struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
>  void fdarray__delete(struct fdarray *fda);
>  
>  int fdarray__add(struct fdarray *fda, int fd, short revents);
> +int fdarray__add_stat(struct fdarray *fda, int fd, short revents);
>  int fdarray__poll(struct fdarray *fda, int timeout);
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6a875a0f01bb..e68e4c08e7c2 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -317,6 +317,17 @@ int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
>  	return pos;
>  }
>  
> +int perf_evlist__add_pollfd_stat(struct perf_evlist *evlist, int fd,
> +			         short revent)
> +{
> +	int pos = fdarray__add_stat(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
> +
> +	if (pos >= 0)
> +		fcntl(fd, F_SETFL, O_NONBLOCK);
> +
> +	return pos;
> +}
> +
>  static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
>  					 void *arg __maybe_unused)
>  {
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 74dc8c3f0b66..2b3b4518c05e 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -46,6 +46,8 @@ struct perf_evlist_mmap_ops {
>  int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
>  int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
>  			    void *ptr, short revent);
> +int perf_evlist__add_pollfd_stat(struct perf_evlist *evlist, int fd,
> +			         short revent);
>  
>  int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  			  struct perf_evlist_mmap_ops *ops,
> 

