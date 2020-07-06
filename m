Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE0E020715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrFauHm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgGFM10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:27:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37286 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729051AbgGFM10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594038445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPXvApqxqLDntBlzk8IwXZWQao6uBNHUfWsS3vG9Elo=;
        b=hrFauHm6jgAwA1c64O6HFCdbv+1wTUG8dqMg5uwqiwl1umDOqnnaqHMeW26i1Z4HGJdnY3
        0CMCOFym+fV0KKlsb1Wt0wvNwHSxHIIlW1nHd4aaVC69/HDFxOmjXVCpaVj9NkdzC6icqU
        p2RZaty/I8Zy+2u+OM2dhSuq++E5w7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-NGyHy7JrNNmXy0KXnq_DCg-1; Mon, 06 Jul 2020 08:27:21 -0400
X-MC-Unique: NGyHy7JrNNmXy0KXnq_DCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D157A18FE871;
        Mon,  6 Jul 2020 12:27:19 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id 156727B410;
        Mon,  6 Jul 2020 12:27:17 +0000 (UTC)
Date:   Mon, 6 Jul 2020 14:27:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 09/15] perf stat: factor out event handling loop into
 dispatch_events()
Message-ID: <20200706122717.GC3401866@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <e4ccb3e9-5f5e-36bf-4a87-dd9d7098d83b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4ccb3e9-5f5e-36bf-4a87-dd9d7098d83b@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:46:15AM +0300, Alexey Budankov wrote:
> 
> Consolidate event dispatching loops for fork, attach and system
> wide monitoring use cases into common dispatch_events() function.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 42 +++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3e11f854ffc8..723f1fe27d63 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -550,6 +550,30 @@ static bool is_target_alive(struct target *_target,
>  	return false;
>  }
>  
> +static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
> +{
> +	bool stop = false;
> +	int child_exited = 0, status = 0;
> +
> +	while (1) {
> +		if (forks)
> +			child_exited = waitpid(child_pid, &status, WNOHANG);
> +		else
> +			child_exited = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;
> +
> +		if (done || stop || child_exited)
> +			break;

can (done || stop) be in the while condition and
we'd check just child_exited in here?

> +
> +		nanosleep(ts, NULL);
> +		if (timeout)
> +			stop = true;

can we just break out in here? like the original code?
I don't think we need the extra iteration

> +		else
> +			stop = handle_interval(interval, times);

same here..?


thanks,
jirka


> +	}
> +
> +	return status;
> +}
> +

SNIP

