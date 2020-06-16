Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EBC2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F4B20679
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgFPO7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbgFPO7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:59:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8682220644;
        Tue, 16 Jun 2020 14:59:02 +0000 (UTC)
Date:   Tue, 16 Jun 2020 10:59:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Lichao Liu <liulichao@loongson.cn>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt: Don't active rt throtting when no running cfs
 task
Message-ID: <20200616105900.5cb0671d@oasis.local.home>
In-Reply-To: <20200616140158.GY2531@hirez.programming.kicks-ass.net>
References: <20200616123729.153430-1-liulichao@loongson.cn>
        <20200616095027.1a2048d0@oasis.local.home>
        <20200616140158.GY2531@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 16:01:58 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jun 16, 2020 at 09:50:27AM -0400, Steven Rostedt wrote:
> > On Tue, 16 Jun 2020 20:37:29 +0800
> > Lichao Liu <liulichao@loongson.cn> wrote:
> >   
> > > Active rt throtting will dequeue rt_rq from rq at least 50ms,
> > > When there is no running cfs task, do we still active it?
> > >   
> > 
> > This is something I would like to have.
> > 
> > Peter, what's your thought on this?  
> 
> I'd love to just delete all of this.. that said, I'm not sure this
> change makes sense, because it doesn't deal sanely with the case where
> the task will appear right after we did this.

I haven't looked closely at the surrounding code, but wouldn't it get
throttled in the next period? Do we care if a task has to wait a bit
longer?

> 
> The right thing to do is that fair deadline server thing.

But we've been saying that for years now.

-- Steve
