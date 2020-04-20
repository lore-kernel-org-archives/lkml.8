Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9EFC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4326206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsHSu285"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgDTIfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:35:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587371701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q8SyLdCyQ5C49TDi5iG4iio2t5+05Pe2nt33yebSNlw=;
        b=FsHSu285PZU9VHyEtGqhgEm4I/3eHXuGshbJDYKqE8ZpH1K/y8doa442CavPyfE6qt4xUR
        5fn5/+91WLIjNiSnmPUGDlCsAewac+0FqtcD6hMcxhop07LzilJq0dHcePh1To61xk3cm+
        JdBAtSH1W64dttUUK3SWSc4DbGcWKfk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-AytGWphQOr6hAzJqBQGrfw-1; Mon, 20 Apr 2020 04:34:57 -0400
X-MC-Unique: AytGWphQOr6hAzJqBQGrfw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12799800D53;
        Mon, 20 Apr 2020 08:34:55 +0000 (UTC)
Received: from krava (unknown [10.40.192.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E902E5D9CD;
        Mon, 20 Apr 2020 08:34:50 +0000 (UTC)
Date:   Mon, 20 Apr 2020 10:34:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Tony Jones <tonyj@suse.de>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf/record: add num-synthesize-threads option
Message-ID: <20200420075919.GA718574@krava>
References: <20200416001303.96841-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416001303.96841-1-irogers@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:13:03PM -0700, Ian Rogers wrote:

SNIP

> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 1ab349abe904..2f97d0c32a75 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -43,6 +43,7 @@
>  #include "util/time-utils.h"
>  #include "util/units.h"
>  #include "util/bpf-event.h"
> +#include "util/util.h"
>  #include "asm/bug.h"
>  #include "perf.h"
>  
> @@ -50,6 +51,7 @@
>  #include <inttypes.h>
>  #include <locale.h>
>  #include <poll.h>
> +#include <pthread.h>
>  #include <unistd.h>
>  #include <sched.h>
>  #include <signal.h>
> @@ -503,6 +505,20 @@ static int process_synthesized_event(struct perf_tool *tool,
>  	return record__write(rec, NULL, event, event->header.size);
>  }
>  
> +static int process_locked_synthesized_event(struct perf_tool *tool,
> +				     union perf_event *event,
> +				     struct perf_sample *sample __maybe_unused,
> +				     struct machine *machine __maybe_unused)
> +{
> +	static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> +	int ret;
> +
> +	pthread_mutex_lock(&synth_lock);
> +	ret = process_synthesized_event(tool, event, sample, machine);
> +	pthread_mutex_unlock(&synth_lock);

hum, so how much faster is the synthesizing with threads in record,
given that we serialize it on every event that goes to the file?

> +	return ret;
> +}
> +
>  static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>  {
>  	struct record *rec = to;
> @@ -1288,6 +1304,8 @@ static int record__synthesize(struct record *rec, bool tail)
>  	struct perf_tool *tool = &rec->tool;
>  	int fd = perf_data__fd(data);
>  	int err = 0;
> +	int (*f)(struct perf_tool *, union perf_event *, struct perf_sample *,
> +		struct machine *) = process_synthesized_event;

there's event_op typedef in util/tools.h

jirka

