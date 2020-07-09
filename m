Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD164C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BBFB2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgGIV7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgGIV7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:59:22 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FD8620672;
        Thu,  9 Jul 2020 21:59:21 +0000 (UTC)
Date:   Thu, 9 Jul 2020 17:59:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: simplify the logic by defining next to be
 "lasst + 1"
Message-ID: <20200709175919.1a459e06@oasis.local.home>
In-Reply-To: <20200703020612.12930-2-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
        <20200703020612.12930-2-richard.weiyang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 10:06:09 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> The value to be used and compared in trace_search_list() is "last + 1".
> Let's just define next to be "last + 1" instead of doing the addition
> each time.

Yeah, this is a nice clean up. I'll take this one.

-- Steve

> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  kernel/trace/trace_output.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 47bf9f042b97..b704b3ef4264 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -675,11 +675,11 @@ static LIST_HEAD(ftrace_event_list);
>  static int trace_search_list(struct list_head **list)
>  {
>  	struct trace_event *e;
> -	int last = __TRACE_LAST_TYPE;
> +	int next = __TRACE_LAST_TYPE + 1;
>  
>  	if (list_empty(&ftrace_event_list)) {
>  		*list = &ftrace_event_list;
> -		return last + 1;
> +		return next;
>  	}
>  
>  	/*
> @@ -687,17 +687,17 @@ static int trace_search_list(struct list_head **list)
>  	 * lets see if somebody freed one.
>  	 */
>  	list_for_each_entry(e, &ftrace_event_list, list) {
> -		if (e->type != last + 1)
> +		if (e->type != next)
>  			break;
> -		last++;
> +		next++;
>  	}
>  
>  	/* Did we used up all 65 thousand events??? */
> -	if ((last + 1) > TRACE_EVENT_TYPE_MAX)
> +	if (next > TRACE_EVENT_TYPE_MAX)
>  		return 0;
>  
>  	*list = &e->list;
> -	return last + 1;
> +	return next;
>  }
>  
>  void trace_event_read_lock(void)

