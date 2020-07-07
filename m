Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7742BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9222065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a20ar7j6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgGGQFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:05:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53087 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727079AbgGGQFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594137933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PV1Zv3wedXPjVcacFn30QT0jXu7s+Wi04VyjzqEYQvs=;
        b=a20ar7j6p9z5STiVDCDEKZ/pgOxhrXx29pxz7jzrKvTszocRqKnCZK9z+ssM+Xr4Ji9u6c
        eo6Ci0NDElUnOwVKNddS4jFhfE3/rTIb4mCGeBO7Y+ONa0lKC+2qerkWQplDdDr8RKMSVM
        KjOIY7s56kj99y6Z854Pb84EasEGk1U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-NUGhbUbXPUOBmBp4hto9fQ-1; Tue, 07 Jul 2020 12:05:28 -0400
X-MC-Unique: NUGhbUbXPUOBmBp4hto9fQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A9B310059AB;
        Tue,  7 Jul 2020 16:05:27 +0000 (UTC)
Received: from krava (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7510D60C87;
        Tue,  7 Jul 2020 16:05:25 +0000 (UTC)
Date:   Tue, 7 Jul 2020 18:05:24 +0200
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
Message-ID: <20200707160524.GA3524217@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
 <20200706123436.GD3401866@krava>
 <6cf91811-ea6a-3c7c-8bbf-7f96bfa1fc82@linux.intel.com>
 <20200706193418.GB3424581@krava>
 <b28806b9-b66e-aa2e-5425-4d9f00341387@linux.intel.com>
 <20200707131403.GD3424581@krava>
 <865ad42a-6085-41d6-06d5-730cb9904ce8@linux.intel.com>
 <20200707142351.GE3424581@krava>
 <44f494d6-b4a5-2d56-001e-b3289cbeedaa@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44f494d6-b4a5-2d56-001e-b3289cbeedaa@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:55:14PM +0300, Alexey Budankov wrote:

SNIP

> process_evlist() now looks suboptimal since record mode code directly calls evlist__ctlfd_process()
> and then handles returned command specifically to the mode. So in v10 I replaced process_evlist()
> call with direct evlist__ctlfd_process() call and then handling the returned command by printing
> command msg tag and counter values in the required order. Like this:
> 
> +		clock_gettime(CLOCK_MONOTONIC, &time_start);
> +		if (!(evlist__poll(evsel_list, time_to_sleep) > 0)) { /* poll timeout or EINTR */
> +			if (timeout)
> +				break;
> +			else
> +				stop = handle_interval(interval, times);
> +			time_to_sleep = sleep_time;
> +		} else { /* fd revent */
> +			if (evlist__ctlfd_process(evsel_list, &cmd) > 0) {
> +				if (interval) {
> +					switch (cmd) {
> +					case EVLIST_CTL_CMD_ENABLE:
> +						pr_info(EVLIST_ENABLED_MSG);
> +						process_interval();
> +						break;
> +					case EVLIST_CTL_CMD_DISABLE:
> +						process_interval();
> +						pr_info(EVLIST_DISABLED_MSG);
> +						break;
> +					case EVLIST_CTL_CMD_ACK:
> +					case EVLIST_CTL_CMD_UNSUPPORTED:
> +					default:
> +						break;
> +					}
> +				}
> +			}
> +			clock_gettime(CLOCK_MONOTONIC, &time_stop);
> +			compute_tts(&time_start, &time_stop, &time_to_sleep);
> +		}


hum, why not just get the bool from process_evlist like below?

jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5021f7286422..32dd3de93f35 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -485,20 +485,20 @@ static bool handle_interval(unsigned int interval, int *times)
 	return false;
 }
 
-static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
+static bool process_evlist(struct evlist *evlist)
 {
-	bool stop = false;
 	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
+	bool display = false;
 
 	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
 		switch (cmd) {
 		case EVLIST_CTL_CMD_ENABLE:
 			pr_info(EVLIST_ENABLED_MSG);
-			stop = handle_interval(interval, times);
+			display = true;
 			break;
 		case EVLIST_CTL_CMD_DISABLE:
-			stop = handle_interval(interval, times);
 			pr_info(EVLIST_DISABLED_MSG);
+			display = true;
 			break;
 		case EVLIST_CTL_CMD_ACK:
 		case EVLIST_CTL_CMD_UNSUPPORTED:
@@ -507,7 +507,7 @@ static bool process_evlist(struct evlist *evlist, unsigned int interval, int *ti
 		}
 	}
 
-	return stop;
+	return display;
 }
 
 static void enable_counters(void)
@@ -618,7 +618,8 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
 				stop = handle_interval(interval, times);
 			time_to_sleep = sleep_time;
 		} else { /* fd revent */
-			stop = process_evlist(evsel_list, interval, times);
+			if (process_evlist(evsel_list))
+				stop = handle_interval(interval, times);
 			clock_gettime(CLOCK_MONOTONIC, &time_stop);
 			diff_timespec(&time_diff, &time_stop, &time_start);
 			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +

