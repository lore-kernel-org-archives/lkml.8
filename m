Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5D4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE7220723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr7Y0N9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbgFWOyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:54:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732821AbgFWOyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CI+gNtsAWasaiwRnzxNeT04MlAT4zEwkswUsPzr+v14=;
        b=Gr7Y0N9zeOMPUNs87U3uC06hozOJkSzNDm6afCMqrucD6hCSglaBbxEzrfg4EBjdLV509p
        6z0TMiAsojpSIHaotsJ/LQRRIvg6vY0pc8140iiAYR8pVu8PIJwyY/X/UbfTIHiW6kuhXW
        xNDeod+MAQnvagVc1Pu+5qbqOKTPHGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-uPorFCQZM9mHofLiTLeMnw-1; Tue, 23 Jun 2020 10:54:47 -0400
X-MC-Unique: uPorFCQZM9mHofLiTLeMnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2089804001;
        Tue, 23 Jun 2020 14:54:45 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0AD8512FE;
        Tue, 23 Jun 2020 14:54:43 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:54:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 09/13] perf stat: implement control commands handling
Message-ID: <20200623145442.GE2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <5ed69a1e-052a-9790-7642-cb9c9a53d786@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed69a1e-052a-9790-7642-cb9c9a53d786@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:41:30AM +0300, Alexey Budankov wrote:

SNIP

>  
>  	while (1) {
>  		if (forks)
> @@ -581,8 +617,17 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times, st
>  		if (done || stop || child)
>  			break;
>  
> -		nanosleep(ts, NULL);
> -		stop = process_timeout(timeout, interval, times);
> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
> +			stop = process_timeout(timeout, interval, times);
> +			time_to_sleep = sleep_time;
> +		} else { /* fd revent */
> +			stop = process_evlist(evsel_list, interval, times);
> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
> +			diff_timespec(&time_diff, &time_stop, &time_start);
> +			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +
> +					time_diff.tv_nsec / NSEC_PER_MSEC;

should we check time_to_sleep > time_diff first?

jirka

