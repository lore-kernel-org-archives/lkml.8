Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E267C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20282074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730340AbgFONNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:13:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:33628 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730075AbgFONNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:13:36 -0400
IronPort-SDR: 4kSRMzHNlQ9gkxiypi2GLZnwvaM3m3fUiMFmB7XMb7pQ7dPXuccPKWLl3j4hSJ8DXkq15LZjEg
 Fbggw7QMn1jA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 06:13:35 -0700
IronPort-SDR: NJqPkN0kqeTuwemoxk0Ahd7ftMC+zfcTC/yhoS4ePB2kaub2zh5ZrqWXDPF0OcOBGIgyGzVgZ4
 J15L6+o2onPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476028794"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2020 06:13:35 -0700
Received: from [10.249.225.172] (abudanko-mobl.ccr.corp.intel.com [10.249.225.172])
        by linux.intel.com (Postfix) with ESMTP id 2AB045804B4;
        Mon, 15 Jun 2020 06:13:32 -0700 (PDT)
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
References: <3c92a0ad-d7d3-4e78-f0b8-1d3a7122c69e@linux.intel.com>
 <20200605105051.GA1404794@krava> <20200605113834.GC1404794@krava>
 <be40edeb-0cb9-5e11-2a22-8392316cdced@linux.intel.com>
 <49eca46e-4d0e-2ae5-d7d9-e37a4d680270@linux.intel.com>
 <20200608084344.GA1520715@krava>
 <2d80a43a-54cf-3d12-92fd-066217c95d76@linux.intel.com>
 <20200608160758.GD1558310@krava>
 <345e3f6e-627d-89fc-364d-59f76071ccaa@linux.intel.com>
 <6a861ce4-3769-fc2a-5f9d-3003238a9736@linux.intel.com>
 <20200609145611.GI1558310@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <c001fb0b-d9aa-2d45-8582-277de0d9baaf@linux.intel.com>
Date:   Mon, 15 Jun 2020 16:13:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609145611.GI1558310@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.06.2020 17:56, Jiri Olsa wrote:
> On Mon, Jun 08, 2020 at 08:18:20PM +0300, Alexey Budankov wrote:
> 
> SNIP
> 
>>>>>>> So how is it about just adding _revents() and _del() for fixed fds with
>>>>>>> correction of retval to bool for fdarray__add()?
>>>>>>
>>>>>> I don't like the separation for fixed and non-fixed fds,
>>>>>> why can't we make generic?
>>>>>
>>>>> Usage models are different but they want still to be parts of the same class
>>>>> for atomic poll(). The distinction is filterable vs. not filterable.
>>>>> The distinction should be somehow provided in API. Options are:
>>>>> 1. expose separate API calls like __add_nonfilterable(), __del_nonfilterable();
>>>>>    use nonfilterable quality in __filter() and __poll() and, perhaps, other internals;
>>>>> 2. extend fdarray__add(, nonfilterable) with the nonfilterable quality
>>>>>    use the type in __filter() and __poll() and, perhaps, other internals;
>>>>>    expose less API calls in comparison with option 1
>>>>>
>>>>> Exposure of pos for filterable fds should be converted to bool since currently
>>>>> the returned pos can become stale and there is no way in API to check its state.
>>>>> So it could look like this:
>>>>>
>>>>> fdkey = fdarray__add(array, fd, events, type)
>>>>> type: filterable, nonfilterable, somthing else
>>>>> revents = fdarray__get_revents(fdkey);
>>>>> fdarray__del(array, fdkey);
>>>>
>>>> I think there's solution without having filterable type,
> 
> so with the changes I proposed it could no longer be called fdarray ;-)
> which I think was the idea at the begning.. just an array of fds
> 
> I'd like to have fully flaged events object.. but that's bigger change
> 
>>>
>>> and still making the atomic fdarray__poll()?
>>
>> How is it about design like this?
>>
>>     int fdarray__poll(struct fdarray *fda, int timeout)
>>
>> with additional external array of fds to simultaneously poll() on:
>>
>>     int fdarray__poll(struct fdarray *fda, int timeout,
>>                       int *fds, size_t fds_size)
>>
>> fds would be added to array just prior poll() call.
> 
> yep, I was considering something like this, having:
> 
>   fdarray__poll2(fda1, fda2)
>   fdarray__pollx(fda, ...)
> 
> but it would need to create an pollfd array and write
> the poll results back to arrays.. might be expensive
> 
> another idea is to forbid filter to screw the array
> and return only remaining number, like below

Which option does it want to be? Just like below?
If yes then how does it distinguish event fds from the others?
This is required to return correct value from fdarray__filter().
Could you please clarify more?

Thanks,
Alexey

> 
> jirka
> 
> 
> ---
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 58d44d5eee31..89f9a2193c2d 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  		return 0;
>  
>  	for (fd = 0; fd < fda->nr; ++fd) {
> +		if (!fda->entries[fd].events)
> +			continue;
> +
>  		if (fda->entries[fd].revents & revents) {
>  			if (entry_destructor)
>  				entry_destructor(fda, fd, arg);
>  
> +			fda->entries[fd].revents = fda->entries[fd].events = 0;
>  			continue;
>  		}
>  
> -		if (fd != nr) {
> -			fda->entries[nr] = fda->entries[fd];
> -			fda->priv[nr]	 = fda->priv[fd];
> -		}
> -
>  		++nr;
>  	}
>  
> -	return fda->nr = nr;
> +	return nr;
>  }
>  
>  int fdarray__poll(struct fdarray *fda, int timeout)
> diff --git a/tools/perf/tests/fdarray.c b/tools/perf/tests/fdarray.c
> index c7c81c4a5b2b..d0c8a05aab2f 100644
> --- a/tools/perf/tests/fdarray.c
> +++ b/tools/perf/tests/fdarray.c
> @@ -12,6 +12,7 @@ static void fdarray__init_revents(struct fdarray *fda, short revents)
>  
>  	for (fd = 0; fd < fda->nr; ++fd) {
>  		fda->entries[fd].fd	 = fda->nr - fd;
> +		fda->entries[fd].events  = revents;
>  		fda->entries[fd].revents = revents;
>  	}
>  }
> @@ -29,7 +30,7 @@ static int fdarray__fprintf_prefix(struct fdarray *fda, const char *prefix, FILE
>  
>  int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_unused)
>  {
> -	int nr_fds, expected_fd[2], fd, err = TEST_FAIL;
> +	int nr_fds, err = TEST_FAIL;
>  	struct fdarray *fda = fdarray__new(5, 5);
>  
>  	if (fda == NULL) {
> @@ -55,7 +56,6 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
>  
>  	fdarray__init_revents(fda, POLLHUP);
>  	fda->entries[2].revents = POLLIN;
> -	expected_fd[0] = fda->entries[2].fd;
>  
>  	pr_debug("\nfiltering all but fda->entries[2]:");
>  	fdarray__fprintf_prefix(fda, "before", stderr);
> @@ -66,17 +66,9 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
>  		goto out_delete;
>  	}
>  
> -	if (fda->entries[0].fd != expected_fd[0]) {
> -		pr_debug("\nfda->entries[0].fd=%d != %d\n",
> -			 fda->entries[0].fd, expected_fd[0]);
> -		goto out_delete;
> -	}
> -
>  	fdarray__init_revents(fda, POLLHUP);
>  	fda->entries[0].revents = POLLIN;
> -	expected_fd[0] = fda->entries[0].fd;
>  	fda->entries[3].revents = POLLIN;
> -	expected_fd[1] = fda->entries[3].fd;
>  
>  	pr_debug("\nfiltering all but (fda->entries[0], fda->entries[3]):");
>  	fdarray__fprintf_prefix(fda, "before", stderr);
> @@ -88,14 +80,6 @@ int test__fdarray__filter(struct test *test __maybe_unused, int subtest __maybe_
>  		goto out_delete;
>  	}
>  
> -	for (fd = 0; fd < 2; ++fd) {
> -		if (fda->entries[fd].fd != expected_fd[fd]) {
> -			pr_debug("\nfda->entries[%d].fd=%d != %d\n", fd,
> -				 fda->entries[fd].fd, expected_fd[fd]);
> -			goto out_delete;
> -		}
> -	}
> -
>  	pr_debug("\n");
>  
>  	err = 0;
> 
