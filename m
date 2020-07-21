Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A39C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D17F206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595335236;
	bh=zhtZfIB5BknCY+2bjoZCAiIbHEgljW5xXcIqk2SSHKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e/TbNursUYqY/Vqv/IwHXQ78rSRs7VBCQo+uEYp8YExqhNdcLP5ctg1hvYtHNz5yw
	 cvctTyLHMaSzjAHfGrhZY4jL2ohpM9NHqIHeYqqe+rqoiWPuwbNIwXFYDaZbnetBYF
	 YF/+xJ7wL56MEIHIb7oLDNCZn9i9kgWnIaDJ/9WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgGUMkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726904AbgGUMke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 08:40:34 -0400
Received: from quaco.ghostprotocols.net (unknown [177.158.183.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C111206E3;
        Tue, 21 Jul 2020 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595335233;
        bh=zhtZfIB5BknCY+2bjoZCAiIbHEgljW5xXcIqk2SSHKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D0wW7qRFmK73FBm5LYU2Fjxhk7CtdTXjM0+Hlwol6FL+EOBGffa6UDmfG4ryhGEQb
         DnFzh8nKSIg20b31y9LaK0ZpSM9W2gntOa4e2CUKtP424bN7CvehJoOeR7mrnmRxA8
         VXlR2dOnsx4urAheU661pVYGdfoM685hh8qCFzWc=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 85769404B1; Tue, 21 Jul 2020 09:40:31 -0300 (-03)
Date:   Tue, 21 Jul 2020 09:40:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 01/15] tools/libperf: avoid internal moving of
 fdarray fds
Message-ID: <20200721124031.GF77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <676844f8-55d3-c628-23db-aa163a81519e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <676844f8-55d3-c628-23db-aa163a81519e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 09:59:12AM +0300, Alexey Budankov escreveu:
> 
> Avoid moving of fds by fdarray__filter() so fds indices returned
> by fdarray__add() can be used for access and processing of
> objects at struct pollfd *entries.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/api/fd/array.c   | 11 +++++------
>  tools/perf/tests/fdarray.c | 20 ++------------------
>  2 files changed, 7 insertions(+), 24 deletions(-)
> 
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
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
