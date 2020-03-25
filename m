Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0184C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8429F20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N4BlLzeN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCYLJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:09:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:29974 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgCYLJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585134545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZzVib+XMCENErpWLWFN6YmFibjOIg91gwzlR3wW18B8=;
        b=N4BlLzeNNM44WQFFVHjTKUgAUX8eVFCi0akGNgaik2jpODOID0sjkCCIPy+FfWYqCAah/E
        4YazwqruGMz43L7/fkQOen9a0DhpeNUjye6PUrodfwgpI4za0LiWpZbPadsL547YXABvRE
        LB3V6n4T7pPBNsOS+7C5LCyE7a59qwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-JP4jV16sOIycpUQ-MCCuzQ-1; Wed, 25 Mar 2020 07:09:03 -0400
X-MC-Unique: JP4jV16sOIycpUQ-MCCuzQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A82D8017CC;
        Wed, 25 Mar 2020 11:09:02 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D4411001938;
        Wed, 25 Mar 2020 11:09:00 +0000 (UTC)
Date:   Wed, 25 Mar 2020 12:08:57 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@elte.hu,
        acme@redhat.com, irogers@google.com
Subject: Re: [PATCH] perf/tools: fix perf_evsel__fallback() for paranoid=2
 and -b
Message-ID: <20200325110857.GB1856035@krava>
References: <20200324181020.229914-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324181020.229914-1-eranian@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:10:20AM -0700, Stephane Eranian wrote:
> When perf_event_paranoid=2, regular users are prevented from sampling
> at the kernel level. However, it the user passes an event without
> a privilege level, the tool will force :u when it detects paranoid>1.
> This works well, except when branch sampling is requested. It has a more
> stringent requirement especially with exclude_hv.
> $ perf record ls
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.001 MB /tmp/perf.data ]
> 
> But:
> $ perf record -b ls
> Error:
> You may not have permission to collect stats.
> 
> Consider tweaking /proc/sys/kernel/perf_event_paranoid,
> which controls use of the performance events system by
> unprivileged users (without CAP_SYS_ADMIN).
> 
> The current value is 2:
> 
>       -1: Allow use of (almost) all events by all users
>     >= 0: Disallow raw tracepoint access by users without CAP_IOC_LOCK
>     >= 1: Disallow CPU event access by users without CAP_SYS_ADMIN
>     >= 2: Disallow kernel profiling by users without CAP_SYS_ADMIN
> 
> To make this setting permanent, edit /etc/sysctl.conf too, e.g.:
> 
>     kernel.perf_event_paranoid = -1
> 
> The problem is that in the fallback cod only exclude_kernel is checked and
> if set, then exclude_hv is not forced to 1. When branch sampling is enabled
> exclude_hv must be set.
> 
> This patch fixes the bug in the fallback code by considering the value of
> exclude_hv and not just exclude_kernel. We prefer this approach to give a
> chance to exclude_hv=0.
> 
> Signed-off-by: Stephane Eranian <eranian@google.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/util/evsel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 816d930d774e7..db0e6112992e5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2424,7 +2424,8 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
>  
>  		zfree(&evsel->name);
>  		return true;
> -	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
> +	} else if (err == EACCES &&
> +		   (!evsel->core.attr.exclude_kernel || !evsel->core.attr.exclude_hv) &&
>  		   (paranoid = perf_event_paranoid()) > 1) {
>  		const char *name = perf_evsel__name(evsel);
>  		char *new_name;
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

