Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758402166E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583319293;
	bh=V4Zb3bev+zrC9R1/l842ahaviM//qj9VZXYUU198J5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gI2tvl06MzNan3i1RIrh3sczsQPRNY08OzSvXig3iXvh2bXgZxzPFvj4tKgpJVwxA
	 ygxZUP+xGFExPAWuo2J1FfimZF1A+kQQ3oH28iZYthBTsbEIbTJGvT93LaX59fLPmy
	 dJxbnwVCLVldXYeJwjQgmPQaTl/MBDwUxLoNiuLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387885AbgCDKyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:54:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51816 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCDKyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:54:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id a132so1502905wme.1;
        Wed, 04 Mar 2020 02:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8rmY1Cgbu7GCf2pLsT+xJoQZFTm6BivpCPBHgYME8v4=;
        b=rchZECzqxPvk79cvZvqm2MKoWBzSxr4OA0LKVr6cpCtsRSS4Co1VkPvNc0gCmkCHDg
         hTRlJ2WVX/MXl42NGruim7bwqM9vdsd9w26hRVb3sMj2selVGFfIJogPRVlNyLl2zvQ0
         ep2QkwJdDzsZK9dQ0Q+OAvt88/lbGGJlGlsh60wysl8x9/bRr80GTHBIPs04iZX1fRqp
         9ak2MQF2KqufCHJEXKbU+I2fO6k2XbuHEuz7pIOOvvjYX1m4bHGhw5ra5bJ1MtamRBHs
         +lL0CUXz+h6VCs4z3MWg+9GUsAXdFnGQMWGp3XmH0vfuvpaQUoXAj/ERCuSBhJ4EJ30d
         oAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8rmY1Cgbu7GCf2pLsT+xJoQZFTm6BivpCPBHgYME8v4=;
        b=YS5I8nov7K2K+Zw2VQp5vIxY8bXZgveyEstknwq2bhJPLY35msE/5fOzVaqgAgmSse
         BOhocLjMK5W51RMHBGvE0hwGrNMbUE3fQwDKwgEQ46Edrjxjvs4Blc5Rvy5Xntx763i0
         zathXkR+XaXm34EkU1zaQy5VtjemFs+INJJJBYTC2IgRY7O3lcSG08VzSoDJK+WcFznE
         4RhN0+zjP36vzKRUpHUKcaYXJbLc1FetANHzgHnIIZ6hQeROd1h3niZBjXy2vr/QLw8/
         N6PU+gAKdbFRPtEfmMuas9LCyhrwTWkq4EL6eOl0ZJWkzAt9VzBqJ27qRT1B8WSOWifr
         h2NA==
X-Gm-Message-State: ANhLgQ2c/ils2jj7KJm5gFegBr1rVxenUHGA8KyZYN2mulm40sDoC+oh
        LVCyB9BiqTXpYqs5ojAeLA8=
X-Google-Smtp-Source: ADFU+vvXPdn3hZXOuf8x7OTTq8bUjfQiSDjvF41LCp3qPX0lpZ7LvNPdfLTDYINlWJp08i4pOZgxhA==
X-Received: by 2002:a05:600c:24b:: with SMTP id 11mr3071983wmj.1.1583319289494;
        Wed, 04 Mar 2020 02:54:49 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 2sm1804272wrf.79.2020.03.04.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:54:48 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:54:46 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20200304105446.GA105264@gmail.com>
References: <20200303194827.6461-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303194827.6461-1-acme@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo/Thomas,
> 
> 	Please consider pulling, mostly from mostly valid complaints by
> the most recent gcc version in my container farm,
> 
> Best regards,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit e0560ba6d92f06dbe13e9d11c921a60c07ea6fcc:
> 
>   perf annotate: Fix segfault with source toggle (2020-02-27 11:47:23 -0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-5.6-20200303
> 
> for you to fetch changes up to b5c0951860ba98cfe1936b5c0739450875d51451:
> 
>   perf symbols: Don't try to find a vmlinux file when looking for kernel modules (2020-03-03 16:20:01 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> perf symbols:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Don't try to find a vmlinux file when looking for kernel modules,
>     fixing symbol resolution in systems with compressed kernel modules.
> 
> perf env:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Do not return pointers to local variables, fixing valid warning from
>     gcc 10 for corner case that stops the build due to -Werror.
> 
> perf tests:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Make global variable static in the bp_account entry to fix build
>     with gcc 10.
> 
> perf parse-events:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Use asprintf() instead of strncpy() to read tracepoint files, addressing
>     compiler warning that stops the build as we use -Werror.
> 
> perf bench:
> 
>   Arnaldo Carvalho de Melo:
> 
>   - Share some global variables to fix build with gcc 10.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (5):
>       perf tests bp_account: Make global variable static
>       perf env: Do not return pointers to local variables
>       perf parse-events: Use asprintf() instead of strncpy() to read tracepoint files
>       perf bench: Share some global variables to fix build with gcc 10
>       perf symbols: Don't try to find a vmlinux file when looking for kernel modules
> 
>  tools/perf/bench/bench.h         |  4 ++++
>  tools/perf/bench/epoll-ctl.c     |  7 +++----
>  tools/perf/bench/epoll-wait.c    | 11 +++++------
>  tools/perf/bench/futex-hash.c    | 12 ++++++------
>  tools/perf/bench/futex-lock-pi.c | 11 +++++------
>  tools/perf/tests/bp_account.c    |  2 +-
>  tools/perf/util/env.c            |  4 ++--
>  tools/perf/util/parse-events.c   | 10 ++--------
>  tools/perf/util/symbol.c         | 13 ++++++-------
>  9 files changed, 34 insertions(+), 40 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
