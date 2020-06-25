Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07687C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F1F2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FdPjgmbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404595AbgFYMM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:12:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404397AbgFYMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593087146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0d5k1uyW/+te7o3Y+6MyeKrsTLgzk3JPsSgjnWxQ3DM=;
        b=FdPjgmbHnASTzsIiTxlwXWPYPDm1H0bqstx+E3BRlzxYnr4eKFZIApKSQKKKYQXnR6rYuX
        oqRgYg6Ir+IHerW8R/eqs2Qi+zlcos7zRMnT21hR9dWMQMMCb4UIX+Z9/adD8vrpG3okfU
        2EiBnDQKRFPJzVTuqt3AwRBQrdKtc5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-Cj5RPVAHOmiaPvEnCyYFCw-1; Thu, 25 Jun 2020 08:12:22 -0400
X-MC-Unique: Cj5RPVAHOmiaPvEnCyYFCw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C4B7100A8E9;
        Thu, 25 Jun 2020 12:12:21 +0000 (UTC)
Received: from krava (unknown [10.40.193.172])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7280D1019606;
        Thu, 25 Jun 2020 12:12:19 +0000 (UTC)
Date:   Thu, 25 Jun 2020 14:12:18 +0200
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
Message-ID: <20200625121218.GG2719003@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <5ed69a1e-052a-9790-7642-cb9c9a53d786@linux.intel.com>
 <20200623145458.GG2619137@krava>
 <9bf22a7b-0b56-c55f-c8b2-60c8e6ed0ef9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf22a7b-0b56-c55f-c8b2-60c8e6ed0ef9@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 04:39:11PM +0300, Alexey Budankov wrote:
> 
> 
> On 23.06.2020 17:54, Jiri Olsa wrote:
> > On Wed, Jun 17, 2020 at 11:41:30AM +0300, Alexey Budankov wrote:
> >>
> >> Implement handling of 'enable' and 'disable' control commands
> >> coming from control file descriptor. process_evlist() function
> >> checks for events on control fds and makes required operations.
> >> If poll event splits initiated timeout interval then the reminder
> >> is calculated and still waited in the following poll() syscall.
> >>
> >> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >> ---
> >>  tools/perf/builtin-stat.c | 67 +++++++++++++++++++++++++++++----------
> >>  1 file changed, 50 insertions(+), 17 deletions(-)
> >>
> >> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >> index f88d5ee55022..cc56d71a3ed5 100644
> >> --- a/tools/perf/builtin-stat.c
> >> +++ b/tools/perf/builtin-stat.c
> >> @@ -492,6 +492,31 @@ static bool process_timeout(int timeout, unsigned int interval, int *times)
> >>  	return print_interval(interval, times);
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
> >> +			stop = print_interval(interval, times);
> > 
> > why is interval printed in here?
> > 
> >> +			break;
> >> +		case EVLIST_CTL_CMD_DISABLE:
> >> +			stop = print_interval(interval, times);
> > 
> > and here?
> > 
> > it should be called from the main loop when the interval time is elapsed no?
> 
> It is called from the main loop too and it is also additionally called here
> to provide indication and counter values on commands processing times.

so it prints interval out of order?

jirka

