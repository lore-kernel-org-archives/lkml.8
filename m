Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C73C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F22F2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594913795;
	bh=TXWQ7PJ4FaO3GvnSM/6Ywjc/SETPXxQPqMa7IlASHw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N9WLfIFApSOmBT6TSrG10pboAQCloVRCJbdpZdSIXr9WjWX43MYfEtsKtNI7m6wQM
	 lSQ9CklSt2iWEqaAyqauvEWlGZbJCFs5thOe/QnqeWVeEj324sSiBgaQ7GzuqI8W/Q
	 m0OF63iIvG3zs7X+ORNqckLmR4PiAgXe40zcjMuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgGPPgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbgGPPgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:36:33 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B4E62076A;
        Thu, 16 Jul 2020 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594913792;
        bh=TXWQ7PJ4FaO3GvnSM/6Ywjc/SETPXxQPqMa7IlASHw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hp2R5CmNy++pACit8wvHR6pZ//aK/fdFMkyktXRfWOV3uNMem15k/ttJIpmJrCx9S
         C02ZBq4MY98OAELZwxgA2qHVe4p0jOxFRDZN70z36H8pAu/pRU3A3CRAgPglpy4PBk
         iWYhSLyWRNLh6gBiDPxGbnYrEfvXruGHSRKV+CXs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 73612403C7; Thu, 16 Jul 2020 12:36:30 -0300 (-03)
Date:   Thu, 16 Jul 2020 12:36:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/17] perf ftrace: add option -t/--tid to filter by
 thread id
Message-ID: <20200716153630.GD374956@kernel.org>
References: <20200711124035.6513-1-changbin.du@gmail.com>
 <20200711124035.6513-4-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711124035.6513-4-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 11, 2020 at 08:40:21PM +0800, Changbin Du escreveu:
> This allows us to trace single thread instead of the whole process.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/Documentation/perf-ftrace.txt | 4 ++++
>  tools/perf/builtin-ftrace.c              | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index d79560dea19f..e204bf6d50d8 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -38,6 +38,10 @@ OPTIONS
>  --pid=::
>  	Trace on existing process id (comma separated list).
>  
> +-t::
> +--tid=::
> +	Trace on existing thread id (comma separated list).
> +


Humm, I just  tried:

[root@five ~]# yes > /dev/null &
[1] 18265
[root@five ~]# perf ftrace --tid 18265
^C[root@five ~]#

After waiting for a while, nothing, what am I doing wrong?

- Arnaldo


>  -a::
>  --all-cpus::
>  	Force system-wide collection.  Scripts run without a <command>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 244cc8e6bd60..1188b82c6541 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -515,6 +515,8 @@ int cmd_ftrace(int argc, const char **argv)
>  		    "Show available functions to filter"),
>  	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
>  		   "trace on existing process id"),
> +	OPT_STRING('t', "tid", &ftrace.target.tid, "tid",
> +		   "trace on existing thread id (exclusive to --pid)"),
>  	OPT_INCR('v', "verbose", &verbose,
>  		 "be more verbose"),
>  	OPT_BOOLEAN('a', "all-cpus", &ftrace.target.system_wide,
> -- 
> 2.25.1
> 

-- 

- Arnaldo
