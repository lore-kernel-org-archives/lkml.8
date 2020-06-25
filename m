Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C090F206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LK0MxrJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404614AbgFYMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:17:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47238 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404343AbgFYMR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:17:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593087445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/HWznawKndeUwocK8lVeiz1hj7xtjaPca8SP30WJcfg=;
        b=LK0MxrJ0Ai3EMzl9cgGwZ51f/TAil7Ue2vCQ6GorJdhJ4vW00zXg7Zji/0KoWX5kzEuFMt
        temKITUuET+dyb+jYX764wuLAffRHCwSnMOxCX2wsLopj7JFsEhBnWAU/nK/O2VpLvh4im
        jxg9BVoLDzXfD5gBTz3m/E50gvZ+keE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-NF0RNCAGNIWHj2tiCW1fmA-1; Thu, 25 Jun 2020 08:17:23 -0400
X-MC-Unique: NF0RNCAGNIWHj2tiCW1fmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4640C80400A;
        Thu, 25 Jun 2020 12:17:22 +0000 (UTC)
Received: from krava (unknown [10.40.193.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id 363625D9C5;
        Thu, 25 Jun 2020 12:17:20 +0000 (UTC)
Date:   Thu, 25 Jun 2020 14:17:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 04/13] perf stat: factor out body of event handling
 loop for system wide
Message-ID: <20200625121719.GI2719003@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <eeeff629-925a-530b-9803-f274337ae473@linux.intel.com>
 <20200623145630.GK2619137@krava>
 <51d5511a-e9a7-2865-c81b-57488e820f8d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51d5511a-e9a7-2865-c81b-57488e820f8d@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 05:27:41PM +0300, Alexey Budankov wrote:
> 
> On 23.06.2020 17:56, Jiri Olsa wrote:
> > On Wed, Jun 17, 2020 at 11:37:43AM +0300, Alexey Budankov wrote:
> >>
> >> Introduce process_timeout() and process_interval() functions that
> >> factor out body of event handling loop for attach and system wide
> >> monitoring use cases.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-stat.c | 28 ++++++++++++++++++++--------
> >>  1 file changed, 20 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index 9be020e0098a..31f7ccf9537b 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -475,6 +475,23 @@ static void process_interval(void)
> >>  	print_counters(&rs, 0, NULL);
> >>  }
> >>  
> >> +static bool print_interval(unsigned int interval, int *times)
> >> +{
> >> +	if (interval) {
> >> +		process_interval();
> >> +		if (interval_count && !(--(*times)))
> >> +			return true;
> >> +	}
> >> +	return false;
> >> +}
> >> +
> >> +static bool process_timeout(int timeout, unsigned int interval, int *times)
> >> +{
> >> +	if (timeout)
> >> +		return true;
> >> +	return print_interval(interval, times);
> >> +}
> > 
> > I think it's confusing to keep this together, that
> > process_timeout triggers also interval processing
> > 
> > I think you can keep the timeout separated from interval
> > processing and rename the print_interval to process_interval
> > and process_interval to __process_interval
> 
> Well, ok.
> 
> I will rename process_interval() to __process_interval() and
> then print_interval() to process_interval().
> 
> Regarding timeout let's have it like this:
> 
> static bool process_timeout(int timeout)
> {
> 	return timeout ? true : false;
> }

can't this just stay as value check after finished poll?

	if (timeout)
		break;

and then separate call to process_interval(interval, times)?

jirka

> 
> static bool process_timing_settings(int timeout, unsigned int interval, int *times)
> {
>         bool res = process_timeout(timeout);
>         if (!res)
> 		res = process_interval(interval, times);
> 	return res; 
> }
> 
> Ok?
> 
> ~Alexey
> 
> > 
> > jirka
> > 
> >> +
> >>  static void enable_counters(void)
> >>  {
> >>  	if (stat_config.initial_delay)
> >> @@ -611,6 +628,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>  	struct affinity affinity;
> >>  	int i, cpu;
> >>  	bool second_pass = false;
> >> +	bool stop = false;
> >>  
> >>  	if (interval) {
> >>  		ts.tv_sec  = interval / USEC_PER_MSEC;
> >> @@ -805,17 +823,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>  			psignal(WTERMSIG(status), argv[0]);
> >>  	} else {
> >>  		enable_counters();
> >> -		while (!done) {
> >> +		while (!done && !stop) {
> >>  			nanosleep(&ts, NULL);
> >>  			if (!is_target_alive(&target, evsel_list->core.threads))
> >>  				break;
> >> -			if (timeout)
> >> -				break;
> >> -			if (interval) {
> >> -				process_interval();
> >> -				if (interval_count && !(--times))
> >> -					break;
> >> -			}
> >> +			stop = process_timeout(timeout, interval, &times);
> >>  		}
> >>  	}
> >>  
> >> -- 
> >> 2.24.1
> >>
> >>
> > 
> 

