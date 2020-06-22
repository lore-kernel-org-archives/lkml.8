Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF67C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8FED206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgFVJr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:47:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:10509 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbgFVJr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:47:27 -0400
IronPort-SDR: SHlPYQWVyow2dZuSAAJ8BWmqzqPs2OP+VzGts4ZzIUcL76QqMrzy/osYMbyya5Y7jC9thYkni2
 07P8WOEBHRdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="208918015"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="208918015"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 02:47:24 -0700
IronPort-SDR: Zcs8stFnxRye8ugwHmMOqPwlbu8VCJ1C8YjH6XROzc8RYToJc4AH8Ka4tB9aD+TvMIqxRH8aQ8
 q5UFGYOIeXHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="353390286"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2020 02:47:23 -0700
Received: from [10.249.226.81] (abudanko-mobl.ccr.corp.intel.com [10.249.226.81])
        by linux.intel.com (Postfix) with ESMTP id 0D537580583;
        Mon, 22 Jun 2020 02:47:20 -0700 (PDT)
Subject: Re: [PATCH v7 01/13] tools/libperf: introduce notion of static polled
 file descriptors
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20200605105051.GA1404794@krava> <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <bde9bcc3-9ec0-6e37-26f6-139b038ad3de@linux.intel.com>
 <20200615123048.GB2088119@krava>
 <8b29e324-eb8d-2266-562b-ca46aec76a3e@linux.intel.com>
 <20200615165802.GD2088119@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8351b3ee-d345-a394-d687-443f2d2f7ec4@linux.intel.com>
Date:   Mon, 22 Jun 2020 12:47:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615165802.GD2088119@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.2020 19:58, Jiri Olsa wrote:
> On Mon, Jun 15, 2020 at 05:37:53PM +0300, Alexey Budankov wrote:
>>
>> On 15.06.2020 15:30, Jiri Olsa wrote:
>>> On Mon, Jun 15, 2020 at 08:20:38AM +0300, Alexey Budankov wrote:
>>>>
>>>> On 08.06.2020 19:07, Jiri Olsa wrote:
>>>>> On Mon, Jun 08, 2020 at 12:54:31PM +0300, Alexey Budankov wrote:
>>>>>>
>>>>>> On 08.06.2020 11:43, Jiri Olsa wrote:
>>>>>>> On Mon, Jun 08, 2020 at 11:08:56AM +0300, Alexey Budankov wrote:
>>>>>>>>
>>>>>>>> On 05.06.2020 19:15, Alexey Budankov wrote:
>>>>>>>>>
>>>>>>>>> On 05.06.2020 14:38, Jiri Olsa wrote:
>>>> <SNIP>
>>>>>>>>> revents = fdarray_fixed_revents(array, pos);
>>>>>>>>> fdarray__del(array, pos);
>>>>>>>>
>>>>>>>> So how is it about just adding _revents() and _del() for fixed fds with
>>>>>>>> correction of retval to bool for fdarray__add()?
>>>>>>>
>>>>>>> I don't like the separation for fixed and non-fixed fds,
>>>>>>> why can't we make generic?
>>>>>>
>>>>>> Usage models are different but they want still to be parts of the same class
>>>>>> for atomic poll(). The distinction is filterable vs. not filterable.
>>>>>> The distinction should be somehow provided in API. Options are:
>>>>>> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
>>>>>>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
>>>>>> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
>>>>>>    use the type in __filter() and __poll() and, perhaps, other internals;
>>>>>>    expose less API calls in comparison with option 1
>>>>>>
>>>>>> Exposure of pos for filterable fds should be converted to bool since currently
>>>>>> the returned pos can become stale and there is no way in API to check its state.
>>>>>> So it could look like this:
>>>>>>
>>>>>> fdkey = fdarray__add(array, fd, events, type)
>>>>>> type: filterable, nonfilterable, somthing else
>>>>>> revents = fdarray__get_revents(fdkey);
>>>>>> fdarray__del(array, fdkey);
>>>>>
>>>>> I think there's solution without having filterable type,
>>>>> I'm not sure why you think this is needed
>>>>>
>>>>> I'm busy with other things this week, but I think I can
>>>>> come up with some patch early next week if needed
>>>>
>>>> Friendly reminder.
>>>
>>> hm? I believe we discussed this in here:
>>>   https://lore.kernel.org/lkml/20200609145611.GI1558310@krava/
>>
>> Do you want it to be implemented like in the patch posted by the link?
> 
> no idea.. looking for good solution ;-)
> 
> how about switching completely to epoll? I tried and it
> does not look that bad

Well, epoll() is perhaps possible but why does it want switching to epoll()?
What are the benefits and/or specific task being solved by this switch? 

> 
> there might be some loose ends (interface change), but
> I think this would solve our problems with fdarray

Your first patch accomodated in v8 actually avoids fds typing
and solves pos (=fdarray__add()) staleness issue with fdarray.

Thanks,
Alexey

> 
> I'll be able to get back to it by the end of the week,
> but if you want to check/finish this patch earlier go ahead
> 
> jirka
> 
> 
> ---
>  tools/lib/perf/evlist.c                  | 134 +++++++++++++++++------
>  tools/lib/perf/include/internal/evlist.h |   9 +-
>  tools/perf/builtin-kvm.c                 |   8 +-
>  tools/perf/builtin-record.c              |  14 ++-
>  4 files changed, 120 insertions(+), 45 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 6a875a0f01bb..8569cdd8bbd8 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -23,6 +23,7 @@
>  #include <perf/cpumap.h>
>  #include <perf/threadmap.h>
>  #include <api/fd/array.h>
> +#include <sys/epoll.h>
>  
>  void perf_evlist__init(struct perf_evlist *evlist)
>  {
> @@ -32,7 +33,10 @@ void perf_evlist__init(struct perf_evlist *evlist)
>  		INIT_HLIST_HEAD(&evlist->heads[i]);
>  	INIT_LIST_HEAD(&evlist->entries);
>  	evlist->nr_entries = 0;
> -	fdarray__init(&evlist->pollfd, 64);
> +	INIT_LIST_HEAD(&evlist->poll_data);
> +	evlist->poll_cnt = 0;
> +	evlist->poll_act = 0;
> +	evlist->poll_fd = -1;
>  }
>  
>  static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
> @@ -120,6 +124,23 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
>  	evlist->nr_entries = 0;
>  }
>  
> +struct poll_data {
> +	int		  fd;
> +	void		 *ptr;
> +	struct list_head  list;
> +};
> +
> +static void perf_evlist__exit_pollfd(struct perf_evlist *evlist)
> +{
> +	struct poll_data *data, *tmp;
> +
> +	if (evlist->poll_fd != -1)
> +		close(evlist->poll_fd);
> +
> +	list_for_each_entry_safe(data, tmp, &evlist->poll_data, list)
> +		free(data);
> +}
> +
>  void perf_evlist__exit(struct perf_evlist *evlist)
>  {
>  	perf_cpu_map__put(evlist->cpus);
> @@ -128,7 +149,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
>  	evlist->cpus = NULL;
>  	evlist->all_cpus = NULL;
>  	evlist->threads = NULL;
> -	fdarray__exit(&evlist->pollfd);
> +	perf_evlist__exit_pollfd(evlist);
>  }
>  
>  void perf_evlist__delete(struct perf_evlist *evlist)
> @@ -285,56 +306,105 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  
>  int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
>  {
> -	int nr_cpus = perf_cpu_map__nr(evlist->cpus);
> -	int nr_threads = perf_thread_map__nr(evlist->threads);
> -	int nfds = 0;
> -	struct perf_evsel *evsel;
> -
> -	perf_evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->system_wide)
> -			nfds += nr_cpus;
> -		else
> -			nfds += nr_cpus * nr_threads;
> -	}
> +	int poll_fd;
>  
> -	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
> -	    fdarray__grow(&evlist->pollfd, nfds) < 0)
> -		return -ENOMEM;
> +	poll_fd = epoll_create1(EPOLL_CLOEXEC);
> +	if (!poll_fd)
> +		return -1;
>  
> +	evlist->poll_fd = poll_fd;
>  	return 0;
>  }
>  
> -int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
> -			    void *ptr, short revent)
> +static int __perf_evlist__add_pollfd(struct perf_evlist *evlist,
> +				     struct poll_data *data,
> +				     short revent)
>  {
> -	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
> +	struct epoll_event *events, ev = {
> +		.data.ptr = data,
> +		.events   = revent | EPOLLERR | EPOLLHUP,
> +	};
> +	int err;
> +
> +	err = epoll_ctl(evlist->poll_fd, EPOLL_CTL_ADD, data->fd, &ev);
> +	if (err)
> +		return err;
>  
> -	if (pos >= 0) {
> -		evlist->pollfd.priv[pos].ptr = ptr;
> -		fcntl(fd, F_SETFL, O_NONBLOCK);
> +	events = realloc(evlist->poll_events, sizeof(ev) * evlist->poll_cnt);
> +	if (events) {
> +		evlist->poll_events = events;
> +		evlist->poll_cnt++;
>  	}
>  
> -	return pos;
> +	return events ? 0 : -ENOMEM;
>  }
>  
> -static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
> -					 void *arg __maybe_unused)
> +int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
> +			    void *ptr, short revent)
>  {
> -	struct perf_mmap *map = fda->priv[fd].ptr;
> +	struct poll_data *data = zalloc(sizeof(*data));
> +	int err;
>  
> -	if (map)
> -		perf_mmap__put(map);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->fd  = fd;
> +	data->ptr = ptr;
> +
> +	err = __perf_evlist__add_pollfd(evlist, data, revent);
> +	if (!err)
> +		list_add_tail(&data->list, &evlist->poll_data);
> +
> +	return err;
>  }
>  
>  int perf_evlist__filter_pollfd(struct perf_evlist *evlist, short revents_and_mask)
>  {
> -	return fdarray__filter(&evlist->pollfd, revents_and_mask,
> -			       perf_evlist__munmap_filtered, NULL);
> +	struct epoll_event *events = evlist->poll_events;
> +	int i, removed = 0;
> +
> +	for (i = 0; i < evlist->poll_act; i++) {
> +		if (events[i].events & revents_and_mask) {
> +			struct poll_data *data = events[i].data.ptr;
> +
> +			if (data->ptr)
> +				perf_mmap__put(data->ptr);
> +
> +			epoll_ctl(evlist->poll_fd, EPOLL_CTL_DEL, data->fd, &events[i]);
> +
> +			list_del(&data->list);
> +			free(data);
> +			removed++;
> +		}
> +	}
> +
> +	return evlist->poll_cnt -= removed;
> +}
> +
> +bool perf_evlist__pollfd_data(struct perf_evlist *evlist, int fd)
> +{
> +	int i;
> +
> +	if (evlist->poll_act < 0)
> +		return false;
> +
> +	for (i = 0; i < evlist->poll_act; i++) {
> +		struct poll_data *data = evlist->poll_events[i].data.ptr;
> +
> +		if (data->fd == fd)
> +			return true;
> +	}
> +
> +	return false;
>  }
>  
>  int perf_evlist__poll(struct perf_evlist *evlist, int timeout)
>  {
> -	return fdarray__poll(&evlist->pollfd, timeout);
> +	evlist->poll_act = epoll_wait(evlist->poll_fd,
> +				      evlist->poll_events,
> +				      evlist->poll_cnt,
> +				      timeout);
> +	return evlist->poll_act;
>  }
>  
>  static struct perf_mmap* perf_evlist__alloc_mmap(struct perf_evlist *evlist, bool overwrite)
> @@ -593,7 +663,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
>  			return -ENOMEM;
>  	}
>  
> -	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
> +	if (evlist->poll_fd == -1 && perf_evlist__alloc_pollfd(evlist) < 0)
>  		return -ENOMEM;
>  
>  	if (perf_cpu_map__empty(cpus))
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 74dc8c3f0b66..39b08a04b992 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -3,7 +3,6 @@
>  #define __LIBPERF_INTERNAL_EVLIST_H
>  
>  #include <linux/list.h>
> -#include <api/fd/array.h>
>  #include <internal/evsel.h>
>  
>  #define PERF_EVLIST__HLIST_BITS 8
> @@ -12,6 +11,7 @@
>  struct perf_cpu_map;
>  struct perf_thread_map;
>  struct perf_mmap_param;
> +struct epoll_event;
>  
>  struct perf_evlist {
>  	struct list_head	 entries;
> @@ -22,7 +22,11 @@ struct perf_evlist {
>  	struct perf_thread_map	*threads;
>  	int			 nr_mmaps;
>  	size_t			 mmap_len;
> -	struct fdarray		 pollfd;
> +	int			 poll_fd;
> +	int			 poll_cnt;
> +	int			 poll_act;
> +	struct epoll_event	*poll_events;
> +	struct list_head	 poll_data;
>  	struct hlist_head	 heads[PERF_EVLIST__HLIST_SIZE];
>  	struct perf_mmap	*mmap;
>  	struct perf_mmap	*mmap_ovw;
> @@ -124,4 +128,5 @@ int perf_evlist__id_add_fd(struct perf_evlist *evlist,
>  			   struct perf_evsel *evsel,
>  			   int cpu, int thread, int fd);
>  
> +bool perf_evlist__pollfd_data(struct perf_evlist *evlist, int fd);
>  #endif /* __LIBPERF_INTERNAL_EVLIST_H */
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index 95a77058023e..decc75745395 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -940,7 +940,7 @@ static int perf_kvm__handle_stdin(void)
>  
>  static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>  {
> -	int nr_stdin, ret, err = -EINVAL;
> +	int ret, err = -EINVAL;
>  	struct termios save;
>  
>  	/* live flag must be set first */
> @@ -971,8 +971,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>  	if (evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
>  		goto out;
>  
> -	nr_stdin = evlist__add_pollfd(kvm->evlist, fileno(stdin));
> -	if (nr_stdin < 0)
> +	if (evlist__add_pollfd(kvm->evlist, fileno(stdin)))
>  		goto out;
>  
>  	if (fd_set_nonblock(fileno(stdin)) != 0)
> @@ -982,7 +981,6 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>  	evlist__enable(kvm->evlist);
>  
>  	while (!done) {
> -		struct fdarray *fda = &kvm->evlist->core.pollfd;
>  		int rc;
>  
>  		rc = perf_kvm__mmap_read(kvm);
> @@ -993,7 +991,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
>  		if (err)
>  			goto out;
>  
> -		if (fda->entries[nr_stdin].revents & POLLIN)
> +		if (perf_evlist__pollfd_data(&kvm->evlist->core, fileno(stdin)))
>  			done = perf_kvm__handle_stdin();
>  
>  		if (!rc && !done)
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index e108d90ae2ed..a49bf4186aab 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1576,12 +1576,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  		status = -1;
>  		goto out_delete_session;
>  	}
> -	err = evlist__add_pollfd(rec->evlist, done_fd);
> -	if (err < 0) {
> -		pr_err("Failed to add wakeup eventfd to poll list\n");
> -		status = err;
> -		goto out_delete_session;
> -	}
>  #endif // HAVE_EVENTFD_SUPPORT
>  
>  	session->header.env.comp_type  = PERF_COMP_ZSTD;
> @@ -1624,6 +1618,14 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>  	}
>  	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
>  
> +#ifdef HAVE_EVENTFD_SUPPORT
> +	err = evlist__add_pollfd(rec->evlist, done_fd);
> +	if (err < 0) {
> +		pr_err("Failed to add wakeup eventfd to poll list\n");
> +		goto out_child;
> +	}
> +#endif // HAVE_EVENTFD_SUPPORT
> +
>  	if (rec->opts.kcore) {
>  		err = record__kcore_copy(&session->machines.host, data);
>  		if (err) {
> 
