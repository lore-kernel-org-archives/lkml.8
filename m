Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E87EC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3B324677
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgBSPvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:51:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgBSPvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:51:01 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE58624671;
        Wed, 19 Feb 2020 15:50:59 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:50:58 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: Re: [PATCH v3 09/22] sched,rcu,tracing: Avoid tracing before
 in_nmi() is correct
Message-ID: <20200219105058.3b844e10@gandalf.local.home>
In-Reply-To: <20200219150744.888917422@infradead.org>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.888917422@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 15:47:33 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> If we call into a tracer before in_nmi() becomes true, the tracer can
> no longer detect it is called from NMI context and behave correctly.
> 
> Therefore change nmi_{enter,exit}() to use __preempt_count_{add,sub}()
> as the normal preempt_count_{add,sub}() have a (desired) function
> trace entry.
> 
> This fixes a potential issue with current code; AFAICT when the
> function-tracer has stack-tracing enabled __trace_stack() will
> malfunction when it hits the preempt_count_add() function entry from
> NMI context.
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>


-- Steve
