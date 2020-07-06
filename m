Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35A9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F07206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 19:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EdxCvHcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGFTe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 15:34:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgGFTe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 15:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594064066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bwhDvsBFpkoE63Zo/8f2dh1QQHupPc5tzT39aRxKMfg=;
        b=EdxCvHcFXRD8nv0BNQCku0HSLBFzZWTjy5zt0/H8mLMt8nGPcy4SlqRy3jSGPvnBlQRBzN
        qNRmqpQrx/v7VqDwhYSCd4zgee18bhxiLRhT4RKcTR27mLPUC/PeGiWrpt+0dWFzfLPXrg
        VA1fs6y6PHlUar0L5m1K6jQA6lzvz1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-0wMXFbHMM_-rR_R5fzUPUg-1; Mon, 06 Jul 2020 15:34:22 -0400
X-MC-Unique: 0wMXFbHMM_-rR_R5fzUPUg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42D4E8005B0;
        Mon,  6 Jul 2020 19:34:21 +0000 (UTC)
Received: from krava (unknown [10.40.192.6])
        by smtp.corp.redhat.com (Postfix) with SMTP id 32E6210013D0;
        Mon,  6 Jul 2020 19:34:18 +0000 (UTC)
Date:   Mon, 6 Jul 2020 21:34:18 +0200
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
Message-ID: <20200706193418.GB3424581@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
 <20200706123436.GD3401866@krava>
 <6cf91811-ea6a-3c7c-8bbf-7f96bfa1fc82@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf91811-ea6a-3c7c-8bbf-7f96bfa1fc82@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:47:54PM +0300, Alexey Budankov wrote:
> 
> On 06.07.2020 15:34, Jiri Olsa wrote:
> > On Fri, Jul 03, 2020 at 10:47:22AM +0300, Alexey Budankov wrote:
> >>
> >> Implement handling of 'enable' and 'disable' control commands
> >> coming from control file descriptor. process_evlist() function
> >> checks for events on control fds and makes required operations.
> >> If poll event splits initiated timeout interval then the reminder
> >> is calculated and still waited in the following poll() syscall.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-stat.c | 75 ++++++++++++++++++++++++++++-----------
> >>  1 file changed, 55 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 9e4288ecf2b8..5021f7286422 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -485,6 +485,31 @@ static bool handle_interval(unsigned int interval, int *times)
> >>  	return false;
> >>  }
> >>  
> >> +static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
> >> +{
> >> +	bool stop = false;
> >> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> >> +
> >> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
> >> +		switch (cmd) {
> >> +		case EVLIST_CTL_CMD_ENABLE:
> >> +			pr_info(EVLIST_ENABLED_MSG);
> >> +			stop = handle_interval(interval, times);
> >> +			break;
> >> +		case EVLIST_CTL_CMD_DISABLE:
> >> +			stop = handle_interval(interval, times);
> > 
> > I still don't understand why you call handle_interval in here
> > 
> > I don't see it being necessary.. you enable events and handle_interval,
> > wil be called in the next iteration of dispatch_events, why complicate
> > this function with that?
> 
> Printing event counts at the moment of command processing lets scripts
> built on top of stat output to provide more plain and accurate metrics.
> Otherwise it may get spikes in the beginning of the next time interval
> because not all counts lay inside [Events enabled, Events disable]
> If -I interval is large tail event count can be also large. Compare the
> output below with the output in the cover letter. Either way is possible
> but the latter one likely complicates the scripts I mentioned above.
> 
> perf=tools/perf/perf
> ${perf} stat -D -1 -e cpu-cycles -a -I 1000       \
>              --control fd:${ctl_fd},${ctl_fd_ack} \
>              -- sleep 40 &
> 
> Events disabled
> #           time             counts unit events
>      1.001100723      <not counted>      cpu-cycles                                                  
>      2.003146566      <not counted>      cpu-cycles                                                  
>      3.005073317      <not counted>      cpu-cycles                                                  
>      4.006337062      <not counted>      cpu-cycles                                                  
> Events enabled
> enable acked(ack)
>      5.011182000         54,128,692      cpu-cycles <===                                                 
>      6.012300167      3,648,804,827      cpu-cycles                                                  
>      7.013631689        590,438,536      cpu-cycles                                                  
>      8.015558583        406,935,663      cpu-cycles                                                  
>      9.017455505        407,806,862      cpu-cycles                                                  
>     10.019300780        399,351,824      cpu-cycles                                                  
>     11.021180025        404,584,417      cpu-cycles                                                  
>     12.023033661        537,787,981      cpu-cycles                                                  
>     13.024422354        699,395,364      cpu-cycles                                                  
>     14.026325749        397,871,324      cpu-cycles                                                  
> disable acked()
> Events disabled
>     15.027857981        396,956,159      cpu-cycles <===
>     16.029279264      <not counted>      cpu-cycles                                                  
>     17.031131311      <not counted>      cpu-cycles                                                  
>     18.033010580      <not counted>      cpu-cycles                                                  
>     19.034918883      <not counted>      cpu-cycles                                                  
> enable acked(ack)
> Events enabled
>     20.036758793        183,544,975      cpu-cycles <===                                             
>     21.038163289        419,054,544      cpu-cycles                                                  
>     22.040108245        413,993,309      cpu-cycles                                                  
>     23.042042365        403,584,493      cpu-cycles                                                  
>     24.043985381        416,512,094      cpu-cycles                                                  
>     25.045925682        401,513,429      cpu-cycles                                                  
> #           time             counts unit events
>     26.047822238        461,205,096      cpu-cycles                                                  
>     27.049784263        414,319,162      cpu-cycles                                                  
>     28.051745360        403,706,915      cpu-cycles                                                  
>     29.053674600        416,502,883      cpu-cycles                                                  
> disable acked()
> Events disabled
>     30.054750685        414,184,409      cpu-cycles <===

ok, but we could still take handle_interval out of process_evlist
and the interval process will be more clear for me (with some
additional comments in the code) ... perhaps something like below?

thanks,
jirka


---
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5021f7286422..af83bf6b2db0 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -485,19 +485,18 @@ static bool handle_interval(unsigned int interval, int *times)
 	return false;
 }
 
-static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
+static bool process_evlist(struct evlist *evlist)
 {
-	bool stop = false;
 	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
+	bool enabled = false;
 
 	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
 		switch (cmd) {
 		case EVLIST_CTL_CMD_ENABLE:
 			pr_info(EVLIST_ENABLED_MSG);
-			stop = handle_interval(interval, times);
+			enabled = true;
 			break;
 		case EVLIST_CTL_CMD_DISABLE:
-			stop = handle_interval(interval, times);
 			pr_info(EVLIST_DISABLED_MSG);
 			break;
 		case EVLIST_CTL_CMD_ACK:
@@ -507,7 +506,7 @@ static bool process_evlist(struct evlist *evlist, unsigned int interval, int *ti
 		}
 	}
 
-	return stop;
+	return enabled;
 }
 
 static void enable_counters(void)
@@ -618,7 +617,8 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
 				stop = handle_interval(interval, times);
 			time_to_sleep = sleep_time;
 		} else { /* fd revent */
-			stop = process_evlist(evsel_list, interval, times);
+			if (process_evlist(evsel_list))
+				stop = handle_interval(interval, times);
 			clock_gettime(CLOCK_MONOTONIC, &time_stop);
 			diff_timespec(&time_diff, &time_stop, &time_start);
 			time_to_sleep -= time_diff.tv_sec * MSEC_PER_SEC +

