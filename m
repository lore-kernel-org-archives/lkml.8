Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D73CC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA07620704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgDXMnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:43:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgDXMnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:43:41 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AF8D2064C;
        Fri, 24 Apr 2020 12:43:40 +0000 (UTC)
Date:   Fri, 24 Apr 2020 08:43:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: make p->prio independent of p->mm
Message-ID: <20200424084339.189d4ee6@gandalf.local.home>
In-Reply-To: <20200424021231.13676-1-hdanton@sina.com>
References: <20200423040128.6120-1-hdanton@sina.com>
        <20200423092620.GR20730@hirez.programming.kicks-ass.net>
        <20200423141609.5224-1-hdanton@sina.com>
        <20200424003028.14800-1-hdanton@sina.com>
        <20200424021231.13676-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 10:12:31 +0800
Hillf Danton <hdanton@sina.com> wrote:

> Yes and if you agree, we send it home during the 5.8 cycle, or not before
> fifo is reclaimed from modules.
> 
> In the spin it now looks like
> 
> --- a/include/linux/sched/prio.h
> +++ b/include/linux/sched/prio.h
> @@ -12,15 +12,12 @@
>   * tasks are in the range MAX_RT_PRIO..MAX_PRIO-1. Priority
>   * values are inverted: lower p->prio value means higher priority.
>   *
> - * The MAX_USER_RT_PRIO value allows the actual maximum
> - * RT priority to be separate from the value exported to
> - * user-space.  This allows kernel threads to set their
> - * priority to a value higher than any user task. Note:
> - * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
> + * Note: MAX_USER_RT_PRIO will be removed as early as 5.8,
> + * don't use it in new code.
>   */
>  
> -#define MAX_USER_RT_PRIO	100
> -#define MAX_RT_PRIO		MAX_USER_RT_PRIO
> +#define MAX_RT_PRIO		100
> +#define MAX_USER_RT_PRIO	MAX_RT_PRIO
>  
>  #define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
>  #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)

No one has used it in years, I don't think we need this change. Just delete
it in one go.

Is making p->prio independent from p->mm needed for other changes? If not,
then we can hold off this change until we do so, otherwise, I would keep
your original patch as is, and then remove the extra check when we remove
MAX_USER_RT_PRIO.

-- Steve
