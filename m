Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B27302073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405511AbgFXRT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:19:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:20253 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405471AbgFXRTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:19:37 -0400
IronPort-SDR: 9oph/+HDGuYFZ87eUyVxdC0snCmcigtAfi4nb/juQ34TTjPRCzsWWbvzRZaPGiH8fEvpUSHtfA
 6a7mgcB2YkkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="124213834"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="124213834"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 10:19:36 -0700
IronPort-SDR: hnm2hrv0XNwbJK7PtXcsR6UU2l6CfeEIiOLT1+FvIpgLywnaA7CxgfxLbIjeaiRAtGWD1PcIjQ
 FLZ2Z5xlbAgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="452713404"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 24 Jun 2020 10:19:35 -0700
Received: from [10.249.228.248] (abudanko-mobl.ccr.corp.intel.com [10.249.228.248])
        by linux.intel.com (Postfix) with ESMTP id 49AF35805B5;
        Wed, 24 Jun 2020 10:19:33 -0700 (PDT)
Subject: Re: [PATCH v8 01/13] tools/libperf: avoid moving of fds at
 fdarray__filter() call
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <3d36dc7a-4249-096c-7554-80e6d290eac5@linux.intel.com>
Organization: Intel Corp.
Message-ID: <fada6325-2e6a-0de4-918f-0bc7d1410c52@linux.intel.com>
Date:   Wed, 24 Jun 2020 20:19:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <3d36dc7a-4249-096c-7554-80e6d290eac5@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17.06.2020 11:35, Alexey Budankov wrote:
> 
> Skip fds with zeroed revents field from count and avoid fds moving
> at fdarray__filter() call so fds indices returned by fdarray__add()
> call stay the same and can be used for direct access and processing
> of fd revents status field at entries array of struct fdarray object.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/lib/api/fd/array.c   | 11 +++++------
>  tools/perf/tests/fdarray.c | 20 ++------------------
>  2 files changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index 58d44d5eee31..97843a837370 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -93,22 +93,21 @@ int fdarray__filter(struct fdarray *fda, short revents,
>  		return 0;
>  
>  	for (fd = 0; fd < fda->nr; ++fd) {
> +		if (!fda->entries[fd].revents)
> +			continue;
> +

So it looks like this condition also filters out non signaling events fds, not only
control and others fds, and this should be somehow avoided so such event related fds
would be counted. Several options have been proposed so far:

1) Explicit typing of fds via API extension and filtering based on the types:
   a) with separate fdarray__add_stat() call
   b) with type arg of existing fdarray__add() call
   c) various memory management design is possible

2) Playing tricks with fd positions inside entries and assumptions on fdarray API calls ordering
   - looks more like a hack than a designed solution

3) Rewrite of fdarray class to allocate separate object for every added fds
   - can be replaced with nonscrewing of fds by __filter()

4) Distinct between fds types at fdarray__filter() using .revents == 0 condition
   - seems to have corner cases and thus not applicable

5) Extension of fdarray__poll(, *arg_ptr, arg_size) with arg of fds array to atomically poll
   on fdarray_add()-ed fds and external arg fds and then external arg fds processing

6) Rewrite of fdarray class on epoll() call basis
   - introduces new scalability restrictions for Perf tool

7) Anything else ...

~Alexey

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
