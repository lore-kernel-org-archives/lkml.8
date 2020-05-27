Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03ACB20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590594296;
	bh=9erfBo44Rs37pnCB4m7wPx90ygvL+5L/Nv3v6kJfPxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yZtHjw33+BycNlTGUeIfUPvjTAam8vQGS471Yz7Ys5fIJ6j8fmdHg3wKny+NqP8GZ
	 rJB6IM4wUjr1bNW1guG/SsstFUgEsWloBKwlF8bB7rV7HW6kEiC2HBonoUiNlvqYd0
	 QnjJdBEJLofqOtDBUGcwxzMWV+2ItLmd81/0ZkTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389602AbgE0Poz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:44:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgE0Poy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:44:54 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED94320873;
        Wed, 27 May 2020 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590594294;
        bh=9erfBo44Rs37pnCB4m7wPx90ygvL+5L/Nv3v6kJfPxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOWOZrFzPI11wHWkq8BgulOudUSZ5hKwcSGTKjX6exyGtQ55xFPey9ZsG8pYXvOTe
         ubzfeMWfbVgiNKaqeyXheXgE21TUT3xKmYTN29ptTWIWH59cy7Ho4gnF+F2W2N7oMw
         p4+viB5t5you4E/+U3xmfE6B9YKmg7VQd2BBixYI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2A94240AFD; Wed, 27 May 2020 12:44:44 -0300 (-03)
Date:   Wed, 27 May 2020 12:44:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 10/15] perf evlist: Disable 'immediate' events last
Message-ID: <20200527154444.GB16490@kernel.org>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-11-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512121922.8997-11-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 03:19:17PM +0300, Adrian Hunter escreveu:
> Events marked as 'immediate' are started before other events to ensure
> that there is context at the start of the main tracing events. The same
> is true at the end of tracing, so disable 'immediate' events after other
> events.

Applied, thanks,

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/evlist.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2a9de6491700..173b4f0e0e6e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -380,22 +380,33 @@ void evlist__disable(struct evlist *evlist)
>  {
>  	struct evsel *pos;
>  	struct affinity affinity;
> -	int cpu, i;
> +	int cpu, i, imm = 0;
> +	bool has_imm = false;
>  
>  	if (affinity__setup(&affinity) < 0)
>  		return;
>  
> -	evlist__for_each_cpu(evlist, i, cpu) {
> -		affinity__set(&affinity, cpu);
> -
> -		evlist__for_each_entry(evlist, pos) {
> -			if (evsel__cpu_iter_skip(pos, cpu))
> -				continue;
> -			if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
> -				continue;
> -			evsel__disable_cpu(pos, pos->cpu_iter - 1);
> +	/* Disable 'immediate' events last */
> +	for (imm = 0; imm <= 1; imm++) {
> +		evlist__for_each_cpu(evlist, i, cpu) {
> +			affinity__set(&affinity, cpu);
> +
> +			evlist__for_each_entry(evlist, pos) {
> +				if (evsel__cpu_iter_skip(pos, cpu))
> +					continue;
> +				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
> +					continue;
> +				if (pos->immediate)
> +					has_imm = true;
> +				if (pos->immediate != imm)
> +					continue;
> +				evsel__disable_cpu(pos, pos->cpu_iter - 1);
> +			}
>  		}
> +		if (!has_imm)
> +			break;
>  	}
> +
>  	affinity__cleanup(&affinity);
>  	evlist__for_each_entry(evlist, pos) {
>  		if (!evsel__is_group_leader(pos) || !pos->core.fd)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
