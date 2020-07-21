Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E473C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539932073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595335995;
	bh=0ZbQ3/acG7EX8uhkRPR8i0SgHSIlAkQpnWCTXqjl3X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bLp/a7tUgcud0AMRH4ni9ihWk4fZGfmefiKqtHJGG+LX0yppxO0Ey32JAxDT0ppPm
	 yiGylUa22tRkyes/F0y3TarZWBs5oSNWW3PqLHH0dZVTeTp5LPuzivMUOU13V6woZ0
	 T69zmgxale4mRBi9kBzrYHoY6uzXGJgCXw7i7Sbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGUMxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgGUMxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:53:13 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.183.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC36C20792;
        Tue, 21 Jul 2020 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595335992;
        bh=0ZbQ3/acG7EX8uhkRPR8i0SgHSIlAkQpnWCTXqjl3X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lweiM25QZkG6k7c5x6GWgnf4UIi6lXEaRU1+TbLc+ju7Tw1BtCJFHEa43qjSapCfQ
         JZbg5WNYrezcBYtPILpj/tauAIDbVT/eFxNpdP0YxPrd14SUiS69G9gcuYrH9G9kxX
         xB3UwoLYJPq/bw42iNA0ri1s5yilHMsPEpg0UMMU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E94AD404B1; Tue, 21 Jul 2020 09:53:10 -0300 (-03)
Date:   Tue, 21 Jul 2020 09:53:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 02/15] tools/libperf: add flags to fdarray fds objects
Message-ID: <20200721125310.GG77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <6b7d43ff-0801-d5dd-4e90-fcd86b17c1c8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b7d43ff-0801-d5dd-4e90-fcd86b17c1c8@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 09:59:45AM +0300, Alexey Budankov escreveu:
> 
> Store flags per struct pollfd *entries object in a bitmap of int size.
> Implement fdarray_flag__nonfilterable flag to skip object from counting
> by fdarray__filter(). Fixed fdarray test issue reported by kernel test
> robot.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> ---
>  tools/lib/api/fd/array.c                 |  9 +++++++--
>  tools/lib/api/fd/array.h                 | 16 ++++++++++++----
>  tools/lib/perf/evlist.c                  |  6 +++---
>  tools/lib/perf/include/internal/evlist.h |  2 +-
>  tools/perf/tests/fdarray.c               |  2 +-
>  tools/perf/util/evlist.c                 |  2 +-
>  6 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 89f9a2193c2d..01b3b89f9797 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -8,6 +8,7 @@
>  #include <poll.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <string.h>
>  
>  void fdarray__init(struct fdarray *fda, int nr_autogrow)
>  {
> @@ -19,7 +20,7 @@ void fdarray__init(struct fdarray *fda, int nr_autogrow)
>  
>  int fdarray__grow(struct fdarray *fda, int nr)
>  {
> -	void *priv;
> +	struct priv *priv;
>  	int nr_alloc = fda->nr_alloc + nr;
>  	size_t psize = sizeof(fda->priv[0]) * nr_alloc;
>  	size_t size  = sizeof(struct pollfd) * nr_alloc;
> @@ -34,6 +35,9 @@ int fdarray__grow(struct fdarray *fda, int nr)
>  		return -ENOMEM;
>  	}
>  
> +	memset(&entries[fda->nr_alloc], 0, sizeof(struct pollfd) * nr);
> +	memset(&priv[fda->nr_alloc], 0, sizeof(fda->priv[0]) * nr);
> +
>  	fda->nr_alloc = nr_alloc;
>  	fda->entries  = entries;
>  	fda->priv     = priv;
> @@ -69,7 +73,7 @@ void fdarray__delete(struct fdarray *fda)
>  	free(fda);
>  }
>  
> -int fdarray__add(struct fdarray *fda, int fd, short revents)
> +int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags)
>  {
>  	int pos = fda->nr;
>  
> @@ -79,6 +83,7 @@ int fdarray__add(struct fdarray *fda, int fd, short revents)
>  
>  	fda->entries[fda->nr].fd     = fd;
>  	fda->entries[fda->nr].events = revents;
> +	fda->priv[fda->nr].flags = flags;
>  	fda->nr++;
>  	return pos;
>  }
> diff --git a/tools/lib/api/fd/array.h b/tools/lib/api/fd/array.h
> index b39557d1a88f..7fcf21a33c0c 100644
> --- a/tools/lib/api/fd/array.h
> +++ b/tools/lib/api/fd/array.h
> @@ -21,19 +21,27 @@ struct fdarray {
>  	int	       nr_alloc;
>  	int	       nr_autogrow;
>  	struct pollfd *entries;
> -	union {
> -		int    idx;
> -		void   *ptr;
> +	struct priv {
> +		union {
> +			int    idx;
> +			void   *ptr;
> +		};
> +		unsigned int flags;
>  	} *priv;
>  };
>  
> +enum fdarray_flags {
> +	fdarray_flag__default	    = 0x00000000,
> +	fdarray_flag__nonfilterable = 0x00000001
> +};
> +
>  void fdarray__init(struct fdarray *fda, int nr_autogrow);
>  void fdarray__exit(struct fdarray *fda);
>  
>  struct fdarray *fdarray__new(int nr_alloc, int nr_autogrow);
>  void fdarray__delete(struct fdarray *fda);
>  
> -int fdarray__add(struct fdarray *fda, int fd, short revents);
> +int fdarray__add(struct fdarray *fda, int fd, short revents, enum fdarray_flags flags);
>  int fdarray__poll(struct fdarray *fda, int timeout);
>  int fdarray__filter(struct fdarray *fda, short revents,
>  		    void (*entry_destructor)(struct fdarray *fda, int fd, void *arg),
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6a875a0f01bb..2208444ecb44 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -305,9 +305,9 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
>  }
>  
>  int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
> -			    void *ptr, short revent)
> +			    void *ptr, short revent, enum fdarray_flags flags)
>  {
> -	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
> +	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP, flags);
>  
>  	if (pos >= 0) {
>  		evlist->pollfd.priv[pos].ptr = ptr;
> @@ -488,7 +488,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
>  		revent = !overwrite ? POLLIN : 0;
>  
>  		if (!evsel->system_wide &&
> -		    perf_evlist__add_pollfd(evlist, fd, map, revent) < 0) {
> +		    perf_evlist__add_pollfd(evlist, fd, map, revent, fdarray_flag__default) < 0) {
>  			perf_mmap__put(map);
>  			return -1;
>  		}
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 74dc8c3f0b66..2d0fa02b036f 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -45,7 +45,7 @@ struct perf_evlist_mmap_ops {
>  
>  int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
>  int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
> -			    void *ptr, short revent);
> +			    void *ptr, short revent, enum fdarray_flags flags);
>  
>  int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  			  struct perf_evlist_mmap_ops *ops,
> diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
> index d0c8a05aab2f..d9eca8e86a6b 100644
> --- a/tools/perf/tests/fdarray.c
> +++ b/tools/perf/tests/fdarray.c
> @@ -112,7 +112,7 @@ int test__fdarray__add(struct test *test __maybe_unused, int subtest __maybe_unu
>  	}
>  
>  #define FDA_ADD(_idx, _fd, _revents, _nr)				   \
> -	if (fdarray__add(fda, _fd, _revents) < 0) {			   \
> +	if (fdarray__add(fda, _fd, _revents, fdarray_flag__default) < 0) { \
>  		pr_debug("\n%d: fdarray__add(fda, %d, %d) failed!",	   \
>  			 __LINE__,_fd, _revents);			   \
>  		goto out_delete;					   \
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 1b884695b4d3..bcbe0cb8482e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -497,7 +497,7 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
>  
>  int evlist__add_pollfd(struct evlist *evlist, int fd)
>  {
> -	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN);
> +	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN, fdarray_flag__default);
>  }
>  
>  int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
