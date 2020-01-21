Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF82BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A1624655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAUWfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:35:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUWfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:35:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD8624653;
        Tue, 21 Jan 2020 22:35:50 +0000 (UTC)
Date:   Tue, 21 Jan 2020 17:35:49 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: remove unused ret
Message-ID: <20200121173549.3de146d5@gandalf.local.home>
In-Reply-To: <1579586083-45359-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1579586083-45359-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 13:54:43 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> No body care the variable 'ret' in function unregister_field_var_hists,
> better to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Steven Rostedt <rostedt@goodmis.org> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  kernel/trace/trace_events_hist.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index f62de5f43e79..0acfac95ca2a 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5712,12 +5712,11 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
>  	struct trace_event_file *file;
>  	unsigned int i;
>  	char *cmd;
> -	int ret;
>  
>  	for (i = 0; i < hist_data->n_field_var_hists; i++) {
>  		file = hist_data->field_var_hists[i]->hist_data->event_file;
>  		cmd = hist_data->field_var_hists[i]->cmd;
> -		ret = event_hist_trigger_func(&trigger_hist_cmd, file,
> +		event_hist_trigger_func(&trigger_hist_cmd, file,

I pulled in some of your other patches (removing unused macros), but
these that remove 'ret' I prefer not to take. Yes, we currently do not
use ret here, but the compiler will easily remove its existence. I'm
thinking if anything, we should report an error if they do return
something other than success.

-- Steve



>  					      "!hist", "hist", cmd);
>  	}
>  }

