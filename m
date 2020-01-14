Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F3C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C2D24656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 22:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgANWLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 17:11:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANWLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:11:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EECB24656;
        Tue, 14 Jan 2020 22:11:32 +0000 (UTC)
Date:   Tue, 14 Jan 2020 17:11:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [for-next][PATCH 26/26] tracing: trigger: Replace unneeded
 RCU-list traversals
Message-ID: <20200114171131.04eff860@gandalf.local.home>
In-Reply-To: <20200114210339.492724604@goodmis.org>
References: <20200114210316.450821675@goodmis.org>
        <20200114210339.492724604@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 16:03:42 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> With CONFIG_PROVE_RCU_LIST, I had many suspicious RCU warnings
> when I ran ftracetest trigger testcases.
> 
> -----
>   # dmesg -c > /dev/null
>   # ./ftracetest test.d/trigger
>   ...
>   # dmesg | grep "RCU-list traversed" | cut -f 2 -d ] | cut -f 2 -d " "
>   kernel/trace/trace_events_hist.c:6070
>   kernel/trace/trace_events_hist.c:1760
>   kernel/trace/trace_events_hist.c:5911
>   kernel/trace/trace_events_trigger.c:504
>   kernel/trace/trace_events_hist.c:1810
>   kernel/trace/trace_events_hist.c:3158
>   kernel/trace/trace_events_hist.c:3105
>   kernel/trace/trace_events_hist.c:5518
>   kernel/trace/trace_events_hist.c:5998
>   kernel/trace/trace_events_hist.c:6019
>   kernel/trace/trace_events_hist.c:6044
>   kernel/trace/trace_events_trigger.c:1500
>   kernel/trace/trace_events_trigger.c:1540
>   kernel/trace/trace_events_trigger.c:539
>   kernel/trace/trace_events_trigger.c:584
> -----
> 
> I investigated those warnings and found that the RCU-list
> traversals in event trigger and hist didn't need to use
> RCU version because those were called only under event_mutex.
> 
> I also checked other RCU-list traversals related to event
> trigger list, and found that most of them were called from
> event_hist_trigger_func() or hist_unregister_trigger() or
> register/unregister functions except for a few cases.
> 
> Replace these unneeded RCU-list traversals with normal list
> traversal macro and lockdep_assert_held() to check the
> event_mutex is held.
> 
> Link: http://lkml.kernel.org/r/157680910305.11685.15110237954275915782.stgit@devnote2
> 
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c    | 41 +++++++++++++++++++++--------
>  kernel/trace/trace_events_trigger.c | 20 ++++++++++----
>  2 files changed, 45 insertions(+), 16 deletions(-)
> 


I think I may add this to my urgent branch and mark this for stable.

-- Steve
