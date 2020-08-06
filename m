Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D54C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0373B22D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735177;
	bh=m16MT79olmaa7abBr/5LqaDwmt0YlsS+xqXWUX0QNaE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C+OoejGG/91SSVc8VbcfC4vLLc7Z6Old1YFZvEhvYycdyKyt+k9nSg21BahsNebiR
	 FVcv8q0KAnrhzWP7q4xUjGmkGlqYVv7Kii4DUAkMMNtcLAFQyBjLQ3P6CaYkZG5iFF
	 zn5N7dzR2284xCDxQdw6l5VWdKdFImjksC7WE1RA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgHFRcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbgHFRcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:32:05 -0400
Received: from quaco.ghostprotocols.net (unknown [179.162.129.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48A1D22D70;
        Thu,  6 Aug 2020 12:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596716098;
        bh=m16MT79olmaa7abBr/5LqaDwmt0YlsS+xqXWUX0QNaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zRVBf93Ri71TRAetiYxoE8JIOQrmypZHCdqTW4lW9X2BdGGR2qAkpDq5FhayVAXsf
         RA5zLJ/ll6jmZd/C0WixhECssjCV0VDOu0joM8KTTJRTXQpIkP91HS6fQOg2RI94Rw
         uQ9pCfYblkm8+NeuH+bhopH9+4ZroK2dkJdt9Ljg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D393D40524; Thu,  6 Aug 2020 09:14:55 -0300 (-03)
Date:   Thu, 6 Aug 2020 09:14:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf: extend message to mention CAP_SYS_PTRACE and
 perf security doc link
Message-ID: <20200806121455.GF16189@kernel.org>
References: <6f8a7425-6e7d-19aa-1605-e59836b9e2a6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8a7425-6e7d-19aa-1605-e59836b9e2a6@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 05, 2020 at 10:31:20AM +0300, Alexey Budankov escreveu:
> 
> Adjust limited access message to mention CAP_SYS_PTRACE capability
> for processes of unprivileged users. Add link to perf security
> document in the end of the section about capabilities.
> The change has been inspired by this discussion:
> https://lore.kernel.org/lkml/20200722113007.GI77866@kernel.org/

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/evsel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9aa51a65593d..e241ee773ccb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2500,8 +2500,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  
>  		return scnprintf(msg + printed, size - printed,
>  		 "Consider adjusting /proc/sys/kernel/perf_event_paranoid setting to open\n"
> -		 "access to performance monitoring and observability operations for users\n"
> -		 "without CAP_PERFMON or CAP_SYS_ADMIN Linux capability.\n"
> +		 "access to performance monitoring and observability operations for processes\n"
> +		 "without CAP_PERFMON, CAP_SYS_PTRACE or CAP_SYS_ADMIN Linux capability.\n"
> +		 "More information can be found at 'Perf events and tool security' document:\n"
> +		 "https://www.kernel.org/doc/html/latest/admin-guide/perf-security.html\n"
>  		 "perf_event_paranoid setting is %d:\n"
>  		 "  -1: Allow use of (almost) all events by all users\n"
>  		 "      Ignore mlock limit after perf_event_mlock_kb without CAP_IPC_LOCK\n"
> -- 
> 2.24.1

-- 

- Arnaldo
