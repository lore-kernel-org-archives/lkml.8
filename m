Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B7DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A982070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZzVXBxj9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgEULtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:49:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:42853 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729002AbgEULtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590061747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rD9nUKjKetPNgFJJMbeB1cCRB1Q4uLpwzABIKxJBRI4=;
        b=ZzVXBxj95GDlsNsKaCoFaUGjoi4brsXfFHsZ/DiqcQ1wppNKlIAZn4fqCY7bM2NwH3D0NG
        VsYVh+YWKenzjb29U75oWCoDKbNvYih9he0tBVaGmpIAGiGk2KfB797FWzX7d+qwT/38cV
        k0ZG/q8BuZpG6bv/j6C33NqdB3lHo2c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-32XGUhsBM8yfJVKvXScDxA-1; Thu, 21 May 2020 07:49:03 -0400
X-MC-Unique: 32XGUhsBM8yfJVKvXScDxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8669C80183C;
        Thu, 21 May 2020 11:49:02 +0000 (UTC)
Received: from krava (unknown [10.40.195.217])
        by smtp.corp.redhat.com (Postfix) with SMTP id BCCE75C1B0;
        Thu, 21 May 2020 11:49:00 +0000 (UTC)
Date:   Thu, 21 May 2020 13:48:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/9] perf stat: factor out event handling loop into a
 function
Message-ID: <20200521114859.GU157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <dcb0b0f5-4c92-3027-a508-c3946c51f3d1@linux.intel.com>
 <20200520123850.GI157452@krava>
 <a03c1c18-6e87-692f-87a5-bd4124d56bc9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a03c1c18-6e87-692f-87a5-bd4124d56bc9@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 06:17:40PM +0300, Alexey Budankov wrote:

SNIP

> >> @@ -675,16 +708,9 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>  		perf_evlist__start_workload(evsel_list);
> >>  		enable_counters();
> >>  
> >> -		if (interval || timeout) {
> >> -			while (!waitpid(child_pid, &status, WNOHANG)) {
> >> -				nanosleep(&ts, NULL);
> >> -				if (timeout)
> >> -					break;
> >> -				process_interval();
> >> -				if (interval_count && !(--times))
> >> -					break;
> >> -			}
> >> -		}
> >> +		if (interval || timeout)
> >> +			handle_events(child_pid, &stat_config);
> >> +
> >>  		if (child_pid != -1) {
> >>  			if (timeout)
> >>  				kill(child_pid, SIGTERM);
> >> @@ -701,18 +727,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >>  			psignal(WTERMSIG(status), argv[0]);
> >>  	} else {
> >>  		enable_counters();
> >> -		while (!done) {
> >> -			nanosleep(&ts, NULL);
> >> -			if (!is_target_alive(&target, evsel_list->core.threads))
> >> -				break;
> >> -			if (timeout)
> >> -				break;
> >> -			if (interval) {
> >> -				process_interval();
> >> -				if (interval_count && !(--times))
> >> -					break;
> >> -			}
> >> -		}
> >> +		handle_events(-1, &stat_config);
> > 
> > this makes me worried.. I'm not sure if it's good idea
> > to squash these 2 looops into one, because they are already
> > complex as they are.. and one of you following patches is
> > making it even more complex
> 
> Loops bodies are mostly identical. The only difference is in events
> they wait for and API used for that. Adding of more events will
> complicate further. The code is duplicated, thus needs refactoring.
> If the following patch complicates lets organize the patch it into
> several smaller functions.

yea, that might help

jirka

> 
> > 
> > wouldn't it be better if you just add single call into
> > each of them.. that would poll on your fd and process the
> > commands if needed?
> 
> That's of course possible, but doesn't manage existing complexity
> at the first place - __run_perf_stat().
> 
> Let's still have handle_events() as a general dispatcher and implement
> handlers for different events as separate functions?
> 
> ~Alexey
> 

