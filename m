Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3981C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D1620BED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxqX+oWx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgGFMhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:37:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40126 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728414AbgGFMhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594039069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ZWpvA/NXX8o3Jj9VGVfbg95tVrVpERu9QVTRsBIkCA=;
        b=BxqX+oWxOoKxZUSU5NxirbHFX2qu7HDOO8x3X0dPyOPdkvsjt0UHfJYBCY38HimK2cGA73
        HNFO2PAYQ2eCetVw7u9ZnEtUQYwctprO7RXeN46Mem1xFRPq1TAS62AFaRaDYOYwk9zbZf
        YYEqaj3Zvau47/CadMannf9h3uhnCMk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-PaXIQJN5NWqfW1xocUYseQ-1; Mon, 06 Jul 2020 08:37:47 -0400
X-MC-Unique: PaXIQJN5NWqfW1xocUYseQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87AC018FF660;
        Mon,  6 Jul 2020 12:37:46 +0000 (UTC)
Received: from krava (unknown [10.40.193.8])
        by smtp.corp.redhat.com (Postfix) with SMTP id BEF11100238E;
        Mon,  6 Jul 2020 12:37:44 +0000 (UTC)
Date:   Mon, 6 Jul 2020 14:37:43 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 11/15] perf stat: implement control commands handling
Message-ID: <20200706123743.GE3401866@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:47:22AM +0300, Alexey Budankov wrote:

SNIP

>  
>  	while (1) {
>  		if (forks)
> @@ -574,11 +610,22 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
>  		if (done || stop || child_exited)
>  			break;
>  
> -		nanosleep(ts, NULL);
> -		if (timeout)
> -			stop = true;
> -		else
> -			stop = handle_interval(interval, times);
> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
> +			if (timeout)
> +				stop = true;
> +			else
> +				stop = handle_interval(interval, times);
> +			time_to_sleep = sleep_time;
> +		} else { /* fd revent */
> +			stop = process_evlist(evsel_list, interval, times);
> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
> +			diff_timespec(&time_diff, &time_stop, &time_start);
> +			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
> +					 time_diff.tv_nsec / NSEC_PER_MSEC;
> +			if (time_to_sleep < 0)
> +				time_to_sleep = 0;

could this computation go to a separate function? something like:

time_to_sleep = compute_tts(time_start, time_stop);

thanks,
jirka

