Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D680C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 023C121473
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgDXAlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:41:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:54538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728151AbgDXAlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:41:24 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16DCD20724;
        Fri, 24 Apr 2020 00:41:23 +0000 (UTC)
Date:   Thu, 23 Apr 2020 20:41:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched: make p->prio independent of p->mm
Message-ID: <20200423204122.4c19b835@gandalf.local.home>
In-Reply-To: <20200424003028.14800-1-hdanton@sina.com>
References: <20200423040128.6120-1-hdanton@sina.com>
        <20200423092620.GR20730@hirez.programming.kicks-ass.net>
        <20200423141609.5224-1-hdanton@sina.com>
        <20200424003028.14800-1-hdanton@sina.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 08:30:28 +0800
Hillf Danton <hdanton@sina.com> wrote:

> > I believe Peter meant axing the double check, not the check together.
> > 
> > That is, instead of:
> > 
> > 	if (p->flags & PF_KTHREAD) {
> > 		if (attr->sched_priority > MAX_RT_PRIO - 1)
> > 			return -EINVAL;
> > 	} else {
> > 		if (attr->sched_priority > MAX_USER_RT_PRIO - 1)
> > 			return -EINVAL;
> > 	}
> > 
> > Just have:
> > 
> > 	if (attr->sched_priority > MAX_RT_PRIO -1)
> > 		return -EINVAL;
> >   
> Got it, thank you :) Spin in couple of days.

I still think getting rid of MAX_USER_RT_PRIO would be good too.

-- Steve
