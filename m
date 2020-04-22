Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8CEC55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436D6205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCvnxBmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgDVIPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:15:08 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVIPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587543306;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ITY3i0QoM/MjrCnE9An+Wh6SpNycaBOoOywPH74eoN8=;
        b=WCvnxBmOxQ+mWoyXOvi4Rn+wWczQ3gy8+aP02yMBEnSNzmafxIslWKPzI90hWxcjEtFrNI
        gUhTrGx6mDZkTpNEYIHfNDMVOkKo+nZkxgfNQRuYo4685kf/DNahn2ej7DNttoWsc5pjTr
        ZkhOQI9T23xeznQHJFhh2rb4oevyAFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-lFLMM1Z0MCWbLyqn7hugyQ-1; Wed, 22 Apr 2020 04:14:57 -0400
X-MC-Unique: lFLMM1Z0MCWbLyqn7hugyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C241107ACC7;
        Wed, 22 Apr 2020 08:14:55 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ADAB176E9D;
        Wed, 22 Apr 2020 08:14:51 +0000 (UTC)
Date:   Wed, 22 Apr 2020 10:14:48 +0200
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
        Tony Jones <tonyj@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf/record: add num-synthesize-threads option
Message-ID: <20200422081448.GD962614@krava>
References: <20200416001303.96841-1-irogers@google.com>
 <20200420075919.GA718574@krava>
 <CAP-5=fUsdWOG6Xw_mcTA-HOg81GQxWe56h6dBZ2m7fygVN3W6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUsdWOG6Xw_mcTA-HOg81GQxWe56h6dBZ2m7fygVN3W6w@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 05:31:41PM -0700, Ian Rogers wrote:

SNIP

> > > +{
> > > +     static pthread_mutex_t synth_lock = PTHREAD_MUTEX_INITIALIZER;
> > > +     int ret;
> > > +
> > > +     pthread_mutex_lock(&synth_lock);
> > > +     ret = process_synthesized_event(tool, event, sample, machine);
> > > +     pthread_mutex_unlock(&synth_lock);
> >
> > hum, so how much faster is the synthesizing with threads in record,
> > given that we serialize it on every event that goes to the file?
> 
> We see long synthesis times of the order seconds on loaded >100 core
> servers. I've not been able to create a reproduction on my desktop.
> You are right that making synthesis multithreaded will suffer from
> Amdahl's law if the write is a synchronization point. Measuring with
> the following patch in place:
> https://lore.kernel.org/lkml/20200415054050.31645-4-irogers@google.com/
> without threads the portion that needs a lock is less than 1.5% of
> execution time and so there's plenty to still run in parallel:
> ...
>       - 32.59% __perf_event__synthesize_threads
>          - 32.54% __event__synthesize_thread
>             + 22.13% perf_event__synthesize_mmap_events
>             + 6.68% perf_event__get_comm_ids.constprop.0
>             + 1.49% process_synthesized_event
>             + 1.29% __GI___readdir64
>             + 0.60% __opendir
> ...
> 
> The multi-threaded benchmark in this patch (pass -t):
> https://lore.kernel.org/lkml/20200415054050.31645-2-irogers@google.com/
> shows:
> 
> Computing performance of multi threaded perf event synthesis by
> synthesizing events on CPU 0:
>  Number of synthesis threads: 1
>    Average synthesis took: 127729.000 usec (+- 3372.880 usec)
>    Average num. events: 21548.600 (+- 0.306)
>    Average time per event 5.927 usec
>  Number of synthesis threads: 2
>    Average synthesis took: 88863.500 usec (+- 385.168 usec)
>    Average num. events: 21552.800 (+- 0.327)
>    Average time per event 4.123 usec
>  Number of synthesis threads: 3
>    Average synthesis took: 83257.400 usec (+- 348.617 usec)
>    Average num. events: 21553.200 (+- 0.327)
>    Average time per event 3.863 usec
>  Number of synthesis threads: 4
>    Average synthesis took: 75093.000 usec (+- 422.978 usec)
>    Average num. events: 21554.200 (+- 0.200)
>    Average time per event 3.484 usec
>  Number of synthesis threads: 5
>    Average synthesis took: 64896.600 usec (+- 353.348 usec)
>    Average num. events: 21558.000 (+- 0.000)
>    Average time per event 3.010 usec
>  Number of synthesis threads: 6
>    Average synthesis took: 59210.200 usec (+- 342.890 usec)
>    Average num. events: 21560.000 (+- 0.000)
>    Average time per event 2.746 usec
>  Number of synthesis threads: 7
>    Average synthesis took: 54093.900 usec (+- 306.247 usec)
>    Average num. events: 21562.000 (+- 0.000)
>    Average time per event 2.509 usec
>  Number of synthesis threads: 8
>    Average synthesis took: 48938.700 usec (+- 341.732 usec)
>    Average num. events: 21564.000 (+- 0.000)
>    Average time per event 2.269 usec
> 
> The event logic there is using an atomic rather than a lock and the
> scaling isn't linear as not all the logic is threaded. Still with 8
> threads we see things going about 2.6 times faster. On a large loaded
> machine that may bring 10 seconds of event synthesis down to less than
> 4. On a desktop there's no measurable difference and the
> --num-thread-synthesize is defaulted to 1.

ok, nice ;) sorry I did not get to this before you posted v2,
but could you plz send v3 with above in the changelog?

thanks,
jirka

