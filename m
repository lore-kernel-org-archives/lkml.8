Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B52C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2886D24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 23:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAUXel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 18:34:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgAUXel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:34:41 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20A0E24125;
        Tue, 21 Jan 2020 23:34:40 +0000 (UTC)
Date:   Tue, 21 Jan 2020 18:34:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace/kprobe: remove MAX_KPROBE_CMDLINE_SIZE
Message-ID: <20200121183438.635b0ff7@gandalf.local.home>
In-Reply-To: <1579586075-45132-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1579586075-45132-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami,

With your new bootconfig work, will you be utilizing
MAX_KPROBE_CMDLINE_SIZE, or should it be removed?

-- Steve


On Tue, 21 Jan 2020 13:54:35 +0800
Alex Shi <alex.shi@linux.alibaba.com> wrote:

> This limitation are never lunched from introduce commit 970988e19eb0
> ("tracing/kprobe: Add kprobe_event= boot parameter")
> 
> Could we remove it if no intention to implement it?
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Steven Rostedt <rostedt@goodmis.org> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  kernel/trace/trace_kprobe.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 7f890262c8a3..eafa90d0f760 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -22,7 +22,6 @@
>  
>  #define KPROBE_EVENT_SYSTEM "kprobes"
>  #define KRETPROBE_MAXACTIVE_MAX 4096
> -#define MAX_KPROBE_CMDLINE_SIZE 1024
>  
>  /* Kprobe early definition from command line */
>  static char kprobe_boot_events_buf[COMMAND_LINE_SIZE] __initdata;

