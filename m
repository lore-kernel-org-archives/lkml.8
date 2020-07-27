Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3045DC433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 113B422B4B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgG0Uwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgG0Uwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:52:34 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC47420792;
        Mon, 27 Jul 2020 20:52:33 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:52:32 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Ingo Molnar <mingo@redhat.com>, <kernel@axis.com>,
        <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Remove outdated comment in stack handling
Message-ID: <20200727165232.7495ed57@oasis.local.home>
In-Reply-To: <20200727092840.18659-1-vincent.whitchurch@axis.com>
References: <20200727092840.18659-1-vincent.whitchurch@axis.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 11:28:40 +0200
Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:

> This comment describes the behaviour before commit 2a820bf74918
> ("tracing: Use percpu stack trace buffer more intelligently").  Since
> that commit, interrupts and NMIs do use the per-cpu stacks so the
> comment is no longer correct.  Remove it.
> 

Thanks, I'll queue this up for the next merge window.

-- Steve

> (Note that the FTRACE_STACK_SIZE mentioned in the comment has never
> existed, it probably should have said FTRACE_STACK_ENTRIES.)
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
