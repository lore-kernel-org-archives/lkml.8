Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60410C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34A2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 23:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgAXXpF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 18:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729147AbgAXXpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 18:45:05 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70267206D4;
        Fri, 24 Jan 2020 23:45:04 +0000 (UTC)
Date:   Fri, 24 Jan 2020 18:45:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHES] constifying ftrace globs
Message-ID: <20200124184502.6e4683f3@gandalf.local.home>
In-Reply-To: <20150205194914.GR29656@ZenIV.linux.org.uk>
References: <20150205194914.GR29656@ZenIV.linux.org.uk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Seems that this series fell through the cracks. Is it worth
resurrecting?

-- Steve


On Thu, 5 Feb 2015 19:49:14 +0000
Al Viro <viro@ZenIV.linux.org.uk> wrote:

> 	We don't really need to NUL-terminate the substring we are
> matching against; all it takes is introducing memmem(3) and using it
> instead of str[n]str().
> 
> 	It's not that much work - see vfs.git#ftrace_glob.  The reason
> I went there is rather amusing; it all started with making do_execve()
> take arrays of const strings for argv and envp.  After all, we never
> change them *and* we often enough pass arrays of string literals that
> way.  It exploded into a series of 75 commits, with the final ripple
> being argv_split() and argv_free().  OK, turns out that ftrace is
> using those as well, fortunately it's done to get arrays of regexes,
> so it should be trivial to constify as well, right?  Imagine the amount of
> swearing when I noticed that it *does* modify the resulting strings...
> 
> 	This series deals with that problem, providing the missing prereq for
> the patchbomb from hell...
> 
> 	Could you review #ftrace_glob?  It's not large - seven commits,
> boiling down to
>  include/linux/ftrace.h             |  8 ++---
>  include/linux/string.h             |  1 +
>  kernel/trace/ftrace.c              | 68 ++++++++++++++++++--------------------
>  kernel/trace/trace.h               |  2 +-
>  kernel/trace/trace_events_filter.c | 26 +++++++++------
>  lib/string.c                       | 34 ++++++++++++-------
>  6 files changed, 75 insertions(+), 64 deletions(-)
> 
> Patches in followups.

