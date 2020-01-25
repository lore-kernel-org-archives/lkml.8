Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4181B2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 16:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qS4S/Vqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgAYQSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 11:18:32 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55750 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgAYQSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 11:18:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so2444828wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 08:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZlsAftyq5iS2hR1O0neb2MbWS0wfE4U4gNf5rByKrFI=;
        b=qS4S/VqqS5pYImifnzZO3ac8ClJovr8GVU7WRkgYk9WZt2nzcE6gDaLtWByMmLw/Zk
         R7E89eHoc7s3ZlOTkKIl9ezZTC/2RCw4j4yJKnUgp4eyTQXCb1GjPzm3ddJxLfxOLoHa
         yCMdLVCNlaMLCMV+wJEhiFsJ43V9mRK8y6P4kDJvbPzknJ5yTYI/jDjuJ5KOk+oxc/lH
         QoKbL49M5nIReMMNX3trP0OZ7jBKU+CWvQ9d8PwGDp9cEu7t2AH+tahwNIpLwsu9WOB6
         mQDkfHXldLQ6b45kYRUcD5eqJGns37TjU5Kzvnz7Ok+llwG+Y0MVyJjRilauKGwP1TzL
         XJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlsAftyq5iS2hR1O0neb2MbWS0wfE4U4gNf5rByKrFI=;
        b=X/83Ez5XTwqYTU0nbauRgmgs/Do9yye45X19mY2YoLYMH1DIEL29ld6QF0/LTewM17
         5p0LfpQIyS+NqcpAski3AJjwntjVz+YNYKZzFO6l+gTWfGdinXT1eFDb3TkDg9y74VHj
         f2gztimo1KSjPwP4qj6Qc82Skh2Z4lo3pHy57a6tHxuDVlaRkvk/3r36MdxjqCiPItr2
         9i/YPmR7ZxMyahpL92EJFxriISV2eKCOgTodP6HM/nFJHJZMfVyH7pS8nGMon7OXyNEY
         Op5lZXAkuioTSL3b/y0fiHhc12Z/a++UEprqbwOxWFMXbipTO7O00iwylWqneKyCaa3R
         h6rQ==
X-Gm-Message-State: APjAAAWLFfZeOr9orwuXEaFJ6pGxugDQynfskvLn88pTZdna6H+RlQqc
        MSglE/jeaRBirKGfhXybGfy1mjqq
X-Google-Smtp-Source: APXvYqy9CkXgQhyuwNzZF2NrWNO+5g+4FIgJRHRz5nodZXYnNV6vtc/VRKPtDqj74RvZyezMwLmHVQ==
X-Received: by 2002:a1c:20c4:: with SMTP id g187mr4633411wmg.29.1579969108157;
        Sat, 25 Jan 2020 08:18:28 -0800 (PST)
Received: from quaco.ghostprotocols.net ([147.229.117.36])
        by smtp.gmail.com with ESMTPSA id 25sm10884425wmi.32.2020.01.25.08.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jan 2020 08:18:27 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 431C740DFD; Sat, 25 Jan 2020 17:18:26 +0100 (CET)
Date:   Sat, 25 Jan 2020 17:18:26 +0100
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf evswitch: Add
 --switch-on-delay/--switch-off-delay
Message-ID: <20200125161826.GD26877@kernel.org>
References: <157996865709.8036.5145089242955353200.stgit@buzz>
 <157996865889.8036.14494483070194089718.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157996865889.8036.14494483070194089718.stgit@buzz>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jan 25, 2020 at 07:10:58PM +0300, Konstantin Khlebnikov escreveu:
> Events set by --switch-on/--switch-off make effect immediately. This patch
> adds controllable delay for them. Repeated switch event restarts delay.
> This allows collect samples while periodic signal pulses (switch-off-delay)
> or start when pulse stops beating (switch-on-delay).
> 
> This example highlights where IRQs are disabled longer than for 5ms.
> Cycles is a NMI samples by PMU and cpu-clock is a software timer samples:
> when cpu-clock stops ticking this means IRQs are disabled.
> 
> # perf top -C 0 --event cycles --event cpu-clock --switch-on cpu-clock
>  --switch-on-delay 5 --switch-off cpu-clock --sort symbol -g -F 1000 -d 10

Cool stuff, I'm travelling, so will take some time to process, but
thanks for working on this!

- Arnaldo
 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  tools/perf/Documentation/perf-report.txt |    6 ++++++
>  tools/perf/Documentation/perf-script.txt |    6 ++++++
>  tools/perf/Documentation/perf-top.txt    |    6 ++++++
>  tools/perf/Documentation/perf-trace.txt  |    6 ++++++
>  tools/perf/builtin-report.c              |    2 +-
>  tools/perf/builtin-script.c              |    2 +-
>  tools/perf/builtin-top.c                 |    2 +-
>  tools/perf/builtin-trace.c               |    2 +-
>  tools/perf/util/evswitch.c               |   22 ++++++++++++++++++----
>  tools/perf/util/evswitch.h               |    9 ++++++++-
>  10 files changed, 54 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 8dbe2119686a..b83c0f700345 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -448,6 +448,12 @@ OPTIONS
>  --switch-off EVENT_NAME::
>  	Stop considering events after this event is found.
>  
> +--switch-on-delay::
> +	Msecs to delay switch-on after last ocurrence of on-event.
> +
> +--switch-off-delay::
> +	Msecs to delay switch-off after last ocurrence of off-event.
> +
>  --show-on-off-events::
>  	Show the --switch-on/off events too. This has no effect in 'perf report' now
>  	but probably we'll make the default not to show the switch-on/off events
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 2599b057e47b..ba3dbe64f1e5 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -423,6 +423,12 @@ include::itrace.txt[]
>  --switch-off EVENT_NAME::
>  	Stop considering events after this event is found.
>  
> +--switch-on-delay::
> +	Msecs to delay switch-on after last ocurrence of on-event.
> +
> +--switch-off-delay::
> +	Msecs to delay switch-off after last ocurrence of off-event.
> +
>  --show-on-off-events::
>  	Show the --switch-on/off events too.
>  
> diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
> index 5596129a71cf..0fe1795f62fb 100644
> --- a/tools/perf/Documentation/perf-top.txt
> +++ b/tools/perf/Documentation/perf-top.txt
> @@ -297,6 +297,12 @@ Default is to monitor all CPUS.
>  --switch-off EVENT_NAME::
>  	Stop considering events after this event is found.
>  
> +--switch-on-delay::
> +	Msecs to delay switch-on after last ocurrence of on-event.
> +
> +--switch-off-delay::
> +	Msecs to delay switch-off after last ocurrence of off-event.
> +
>  --show-on-off-events::
>  	Show the --switch-on/off events too. This has no effect in 'perf top' now
>  	but probably we'll make the default not to show the switch-on/off events
> diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
> index abc9b5d83312..df9e9333fc39 100644
> --- a/tools/perf/Documentation/perf-trace.txt
> +++ b/tools/perf/Documentation/perf-trace.txt
> @@ -191,6 +191,12 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
>  --switch-off EVENT_NAME::
>  	Stop considering events after this event is found.
>  
> +--switch-on-delay::
> +	Msecs to delay switch-on after last ocurrence of on-event.
> +
> +--switch-off-delay::
> +	Msecs to delay switch-off after last ocurrence of off-event.
> +
>  --show-on-off-events::
>  	Show the --switch-on/off events too.
>  
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index f03120c641c0..451bf03120b7 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -261,7 +261,7 @@ static int process_sample_event(struct perf_tool *tool,
>  	if (rep->cpu_list && !test_bit(sample->cpu, rep->cpu_bitmap))
>  		return 0;
>  
> -	if (evswitch__discard(&rep->evswitch, evsel))
> +	if (evswitch__discard(&rep->evswitch, evsel, sample->time))
>  		return 0;
>  
>  	if (machine__resolve(machine, &al, sample) < 0) {
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e2406b291c1c..ba7b08126e72 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1861,7 +1861,7 @@ static void process_event(struct perf_script *script,
>  	if (!show_event(sample, evsel, thread, al))
>  		return;
>  
> -	if (evswitch__discard(&script->evswitch, evsel))
> +	if (evswitch__discard(&script->evswitch, evsel, sample->time))
>  		return;
>  
>  	++es->samples;
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 795e353de095..daea6934a97b 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1151,7 +1151,7 @@ static int deliver_event(struct ordered_events *qe,
>  	assert(evsel != NULL);
>  
>  	if (event->header.type == PERF_RECORD_SAMPLE) {
> -		if (evswitch__discard(&top->evswitch, evsel))
> +		if (evswitch__discard(&top->evswitch, evsel, sample.time))
>  			return 0;
>  		++top->samples;
>  	}
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 46a72ecac427..51478d64752e 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3083,7 +3083,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
>  		return;
>  	}
>  
> -	if (evswitch__discard(&trace->evswitch, evsel))
> +	if (evswitch__discard(&trace->evswitch, evsel, sample->time))
>  		return;
>  
>  	trace__set_base_time(trace, evsel, sample);
> diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
> index 3ba72f743d3c..6573e91fabdc 100644
> --- a/tools/perf/util/evswitch.c
> +++ b/tools/perf/util/evswitch.c
> @@ -3,26 +3,40 @@
>  
>  #include "evswitch.h"
>  #include "evlist.h"
> +#include <linux/time64.h>
>  
> -bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
> +bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel, u64 time)
>  {
> -	if (evswitch->on && evswitch->discarding) {
> +	bool discard = evswitch->discarding ||
> +		perf_time__skip_sample(&evswitch->time_range, time);
> +
> +	if (evswitch->on && discard) {
>  		if (evswitch->on != evsel)
>  			return true;
>  
>  		evswitch->discarding = false;
>  
> +		if (evswitch->on_delay) {
> +			evswitch->time_range.start = time +
> +				evswitch->on_delay * NSEC_PER_MSEC;
> +			evswitch->time_range.end = 0;
> +		}
> +
>  		if (!evswitch->show_on_off_events)
>  			return true;
>  
>  		return false;
>  	}
>  
> -	if (evswitch->off && !evswitch->discarding) {
> +	if (evswitch->off && !discard) {
>  		if (evswitch->off != evsel)
>  			return false;
>  
> -		evswitch->discarding = true;
> +		if (evswitch->off_delay)
> +			evswitch->time_range.end = time +
> +				evswitch->off_delay * NSEC_PER_MSEC;
> +		else
> +			evswitch->discarding = true;
>  
>  		if (!evswitch->show_on_off_events)
>  			return true;
> diff --git a/tools/perf/util/evswitch.h b/tools/perf/util/evswitch.h
> index fd30460b6218..2746082c7dc9 100644
> --- a/tools/perf/util/evswitch.h
> +++ b/tools/perf/util/evswitch.h
> @@ -5,6 +5,7 @@
>  
>  #include <stdbool.h>
>  #include <stdio.h>
> +#include "util/time-utils.h"
>  
>  struct evsel;
>  struct evlist;
> @@ -12,19 +13,25 @@ struct evlist;
>  struct evswitch {
>  	struct evsel *on, *off;
>  	const char   *on_name, *off_name;
> +	unsigned int on_delay, off_delay;
>  	bool	     discarding;
> +	struct perf_time_interval time_range;
>  	bool	     show_on_off_events;
>  };
>  
>  int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp);
>  
> -bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel);
> +bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel, u64 time);
>  
>  #define OPTS_EVSWITCH(evswitch)								  \
>  	OPT_STRING(0, "switch-on", &(evswitch)->on_name,				  \
>  		   "event", "Consider events after the ocurrence of this event"),	  \
>  	OPT_STRING(0, "switch-off", &(evswitch)->off_name,				  \
>  		   "event", "Stop considering events after the ocurrence of this event"), \
> +	OPT_UINTEGER(0, "switch-on-delay", &(evswitch)->on_delay,			  \
> +		   "ms to delay switch-on after last ocurrence of on-event"),	  \
> +	OPT_UINTEGER(0, "switch-off-delay", &(evswitch)->off_delay,			  \
> +		   "ms to delay switch-off after last ocurrence of off-event"),  \
>  	OPT_BOOLEAN(0, "show-on-off-events", &(evswitch)->show_on_off_events,		  \
>  		    "Show the on/off switch events, used with --switch-on and --switch-off")
>  
> 

-- 

- Arnaldo
