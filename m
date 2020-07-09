Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13827C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8F0C2076A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 22:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGIWE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 18:04:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgGIWE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:04:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD7720720;
        Thu,  9 Jul 2020 22:04:25 +0000 (UTC)
Date:   Thu, 9 Jul 2020 18:04:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] tracing: save one trace_event->type by using
 __TRACE_LAST_TYPE
Message-ID: <20200709180424.12c1a41b@oasis.local.home>
In-Reply-To: <20200703020612.12930-3-richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
        <20200703020612.12930-3-richard.weiyang@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 10:06:10 +0800
Wei Yang <richard.weiyang@linux.alibaba.com> wrote:

> Static defined trace_event->type stops at (__TRACE_LAST_TYPE - 1) and
> dynamic trace_event->type starts from (__TRACE_LAST_TYPE + 1).
> 
> To save one trace_event->type index, let's use __TRACE_LAST_TYPE.

When I wrote this code, I purposely had a gap there. But I guess it's
not really needed. I'll take your patch.

Thanks,

-- Steve


> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  kernel/trace/trace_output.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index b704b3ef4264..818f0c9d10c5 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -20,7 +20,7 @@ DECLARE_RWSEM(trace_event_sem);
>  
>  static struct hlist_head event_hash[EVENT_HASHSIZE] __read_mostly;
>  
> -static int next_event_type = __TRACE_LAST_TYPE + 1;
> +static int next_event_type = __TRACE_LAST_TYPE;
>  
>  enum print_line_t trace_print_bputs_msg_only(struct trace_iterator *iter)
>  {
> @@ -675,7 +675,7 @@ static LIST_HEAD(ftrace_event_list);
>  static int trace_search_list(struct list_head **list)
>  {
>  	struct trace_event *e;
> -	int next = __TRACE_LAST_TYPE + 1;
> +	int next = __TRACE_LAST_TYPE;
>  
>  	if (list_empty(&ftrace_event_list)) {
>  		*list = &ftrace_event_list;

