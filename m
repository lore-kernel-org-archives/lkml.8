Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D21FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E5F2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="B4Z8Dja0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgH1HxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:53:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:42936 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728550AbgH1HxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:53:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598601188; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=G2ggMj5USA59n90K2ID7r0Ej+GA28vu9iBfIu7XutmM=;
 b=B4Z8Dja0aghVw4c3omeDvtgd7W0koByj2a7S0BODZAm0KRz3FvoK1Chzx679YCGA8DCan29o
 iklMmFvpnrGbp3NgbdvKmu4m5H+sPFKnjyfQpXq+udmWYSoAOSfNzujbiw525JWqhI+FA0NF
 zidxzcun9yUp3BIZXhHbhYJV0vA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f48b7e34b620c27d30f25d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 28 Aug 2020 07:53:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 84AACC4339C; Fri, 28 Aug 2020 07:53:07 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 52341C433C6;
        Fri, 28 Aug 2020 07:53:06 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Aug 2020 15:53:06 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel-owner@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, abhishekpandit@google.com,
        briannorris@google.com, drinkcat@google.com, tientzu@google.com
Subject: Re: [for-next][PATCH 2/2] tracing: Use temp buffer when filtering
 events
In-Reply-To: <20160504135241.308454993@goodmis.org>
References: <20160504135202.422290539@goodmis.org>
 <20160504135241.308454993@goodmis.org>
Message-ID: <b504b3d7e989cae108669a0cd3072454@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2016-05-04 21:52, Steven Rostedt wrote:
> From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
> 
> Filtering of events requires the data to be written to the ring buffer
> before it can be decided to filter or not. This is because the 
> parameters of
> the filter are based on the result that is written to the ring buffer 
> and
> not on the parameters that are passed into the trace functions.
> 
> The ftrace ring buffer is optimized for writing into the ring buffer 
> and
> committing. The discard procedure used when filtering decides the event
> should be discarded is much more heavy weight. Thus, using a temporary
> filter when filtering events can speed things up drastically.
> 
> Without a temp buffer we have:
> 
>  # trace-cmd start -p nop
>  # perf stat -r 10 hackbench 50
>        0.790706626 seconds time elapsed ( +-  0.71% )
> 
>  # trace-cmd start -e all
>  # perf stat -r 10 hackbench 50
>        1.566904059 seconds time elapsed ( +-  0.27% )
> 
>  # trace-cmd start -e all -f 'common_preempt_count==20'
>  # perf stat -r 10 hackbench 50
>        1.690598511 seconds time elapsed ( +-  0.19% )
> 
>  # trace-cmd start -e all -f 'common_preempt_count!=20'
>  # perf stat -r 10 hackbench 50
>        1.707486364 seconds time elapsed ( +-  0.30% )
> 
> The first run above is without any tracing, just to get a based figure.
> hackbench takes ~0.79 seconds to run on the system.
> 
> The second run enables tracing all events where nothing is filtered. 
> This
> increases the time by 100% and hackbench takes 1.57 seconds to run.
> 
> The third run filters all events where the preempt count will equal 
> "20"
> (this should never happen) thus all events are discarded. This takes 
> 1.69
> seconds to run. This is 10% slower than just committing the events!
> 
> The last run enables all events and filters where the filter will 
> commit all
> events, and this takes 1.70 seconds to run. The filtering overhead is
> approximately 10%. Thus, the discard and commit of an event from the 
> ring
> buffer may be about the same time.
> 
> With this patch, the numbers change:
> 
>  # trace-cmd start -p nop
>  # perf stat -r 10 hackbench 50
>        0.778233033 seconds time elapsed ( +-  0.38% )
> 
>  # trace-cmd start -e all
>  # perf stat -r 10 hackbench 50
>        1.582102692 seconds time elapsed ( +-  0.28% )
> 
>  # trace-cmd start -e all -f 'common_preempt_count==20'
>  # perf stat -r 10 hackbench 50
>        1.309230710 seconds time elapsed ( +-  0.22% )
> 
>  # trace-cmd start -e all -f 'common_preempt_count!=20'
>  # perf stat -r 10 hackbench 50
>        1.786001924 seconds time elapsed ( +-  0.20% )
> 
> The first run is again the base with no tracing.
> 
> The second run is all tracing with no filtering. It is a little slower, 
> but
> that may be well within the noise.
> 
> The third run shows that discarding all events only took 1.3 seconds. 
> This
> is a speed up of 23%! The discard is much faster than even the commit.
> 
> The one downside is shown in the last run. Events that are not 
> discarded by
> the filter will take longer to add, this is due to the extra copy of 
> the
> event.
> 
> Cc: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c               | 154 
> +++++++++++++++++++++++++++++++++++--
>  kernel/trace/trace.h               |  19 ++++-
>  kernel/trace/trace_events.c        |  10 +++
>  kernel/trace/trace_events_filter.c |  10 +++
>  4 files changed, 185 insertions(+), 8 deletions(-)
> 
...
> @@ -1695,8 +1820,23 @@ trace_event_buffer_lock_reserve(struct
> ring_buffer **current_rb,
>  			  unsigned long flags, int pc)
>  {
>  	struct ring_buffer_event *entry;
> +	int val;
> 
>  	*current_rb = trace_file->tr->trace_buffer.buffer;
> +
> +	if ((trace_file->flags &
> +	     (EVENT_FILE_FL_SOFT_DISABLED | EVENT_FILE_FL_FILTERED)) &&
> +	    (entry = this_cpu_read(trace_buffered_event))) {
> +		/* Try to use the per cpu buffer first */
> +		val = this_cpu_inc_return(trace_buffered_event_cnt);
> +		if (val == 1) {
> +			trace_event_setup(entry, type, flags, pc);
> +			entry->array[0] = len;
> +			return entry;
> +		}
> +		this_cpu_dec(trace_buffered_event_cnt);
> +	}
> +
>  	entry = trace_buffer_lock_reserve(*current_rb,
>  					 type, len, flags, pc);
>  	/*
this patch commit id is : 0fc1b09ff1ff404ddf753f5ffa5cd0adc8fdcdc9 which 
has upstream.

how much size is the per cpu buffer?
seems it is initilized in trace_buffered_event_enable,
it is only 1 page size as below:
void trace_buffered_event_enable(void)
{
...
	for_each_tracing_cpu(cpu) {
		page = alloc_pages_node(cpu_to_node(cpu),
					GFP_KERNEL | __GFP_NORETRY, 0);
If the size of buffer to trace is more than 1 page, such as 46680, then 
it trigger kernel crash/panic in my case while run trace-cmd.
After debugging, the trace_file->flags in 
trace_event_buffer_lock_reserve is 0x40b while run trace-cmd, and it is 
0x403 while collecting ftrace log.

Is it have any operation to disable this patch dynamically?
