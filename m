Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1ABC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598CE20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgDXNsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:48:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbgDXNsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:48:25 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 608AB20728;
        Fri, 24 Apr 2020 13:48:24 +0000 (UTC)
Date:   Fri, 24 Apr 2020 09:48:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] tracing: Make tracing_snapshot_instance_cond()
 static
Message-ID: <20200424094822.5ae268fb@gandalf.local.home>
In-Reply-To: <1587614905-48692-1-git-send-email-zou_wei@huawei.com>
References: <1587614905-48692-1-git-send-email-zou_wei@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 12:08:25 +0800
Zou Wei <zou_wei@huawei.com> wrote:

> Fix the following sparse warning:
> 
> kernel/trace/trace.c:950:6: warning: symbol 'tracing_snapshot_instance_cond'
> was not declared. Should it be static?

Thanks, I'll add it to my queue.

-- Steve

> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  kernel/trace/trace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8d2b988..1424a89 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -947,7 +947,8 @@ int __trace_bputs(unsigned long ip, const char *str)
>  EXPORT_SYMBOL_GPL(__trace_bputs);
>  
>  #ifdef CONFIG_TRACER_SNAPSHOT
> -void tracing_snapshot_instance_cond(struct trace_array *tr, void *cond_data)
> +static void tracing_snapshot_instance_cond(struct trace_array *tr,
> +					   void *cond_data)
>  {
>  	struct tracer *tracer = tr->current_trace;
>  	unsigned long flags;

