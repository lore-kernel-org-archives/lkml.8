Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E4EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCE020781
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgC3PI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:08:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbgC3PI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:08:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF78620780;
        Mon, 30 Mar 2020 15:08:56 +0000 (UTC)
Date:   Mon, 30 Mar 2020 11:08:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ftrace not showing the process names for all processes on
 syscall events
Message-ID: <20200330110855.437fe854@gandalf.local.home>
In-Reply-To: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 14:28:01 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> I've just updated one of my systems to 5.6.0-rc7+ (end of last week).
> ftrace in showing <...>-3179 in the system call events for a couple
> of threads of the active processes.
> Other threads of the same processes are fine.
> The scheduler process switch events also show the full name.
> 
> Is this a known regression?


Well, that code hasn't changed in years. But can you explain more of what
you did? Was this the "trace" file, or "trace_pipe" file? The command names
are cached in an array (see /sys/kernel/tracing/saved_cmdlines) of the size
that is defined by the saved_cmdlines_size file.

The cmdlines get updated via the sched_switch and sched_waking trace
events. The update is protected by a spinlock, which is only taken with a
"trylock", if the lock fails, then it does not get updated (we don't want
to hold back the running code just to cache the name of an event), but it
will try at the next sched event until it succeeds. This means that under
strong contention, it may fail to cache certain names.

This is not a regression, it's really just the work load that can cause
event names to be missed. I could work on something that if you have the
sched events enabled, that the output side could do its own caching to get
better results.

-- Steve
