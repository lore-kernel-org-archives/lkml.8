Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08665C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95E120723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3RcxQYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732976AbgFWO4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21245 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732961AbgFWO4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hIIVI2IVwxufkOdRkONfj/5M92J90slWUkJGgrwHoh4=;
        b=D3RcxQYTrjobIlXAJLnRDQV0+mRP18QWUGjpf/phu0bRXUHEKaTOFLD3iy87i73en4cSf7
        9DIyFvbKVknwyc1gp1aigCvCYKB9NJ6v4wC0jZ6D7RzoPzRwaOoUk1rqiwT1SLkXBn/1on
        seYDGFVYHAMH6M5TBUD9mB/zpzIE2Rs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-xnFlv3hTPIWa_ocKGfuBxA-1; Tue, 23 Jun 2020 10:56:27 -0400
X-MC-Unique: xnFlv3hTPIWa_ocKGfuBxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A23D0A0C0B;
        Tue, 23 Jun 2020 14:56:25 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9186E512FE;
        Tue, 23 Jun 2020 14:56:23 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:56:22 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 07/13] perf stat: factor out event handling loop into
 dispatch_events()
Message-ID: <20200623145622.GJ2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <4d90938c-429a-586c-0cc7-767f804c6bce@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d90938c-429a-586c-0cc7-767f804c6bce@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:40:03AM +0300, Alexey Budankov wrote:
> 
> Consolidate event dispatching loops for fork, attach and system
> wide monitoring use cases into common dispatch_events() function.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/builtin-stat.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 3bc538576607..39749c290508 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -557,6 +557,27 @@ static bool is_target_alive(struct target *_target,
>  	return false;
>  }
>  
> +static int dispatch_events(bool forks, int timeout, int interval, int *times, struct timespec *ts)
> +{
> +	bool stop = false;
> +	int child = 0, status = 0;
> +
> +	while (1) {
> +		if (forks)
> +			child = waitpid(child_pid, &status, WNOHANG);
> +		else
> +			child = !is_target_alive(&target, evsel_list->core.threads) ? 1 : 0;

please renme child to something more accurate, so the condition
below makes more sense, like child_stoped or such

jirka

> +
> +		if (done || stop || child)
> +			break;
> +
> +		nanosleep(ts, NULL);
> +		stop = process_timeout(timeout, interval, times);
> +	}
> +
> +	return status;
> +}
> +

SNIP

