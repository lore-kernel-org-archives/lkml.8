Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CFEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A072074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 22:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFEWCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgFEWCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 18:02:24 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75A91206FA;
        Fri,  5 Jun 2020 22:02:23 +0000 (UTC)
Date:   Fri, 5 Jun 2020 18:02:22 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Masami Hiramatsu" <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Jiri Olsa" <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] perf/core: allow ftrace for functions in
 kernel/event/core.c
Message-ID: <20200605180222.6cc3b34c@oasis.local.home>
In-Reply-To: <595AB855-8E84-4367-AEEC-C140F035C9B4@fb.com>
References: <20200526212826.4097888-1-songliubraving@fb.com>
        <20200526213913.GG2483@worktop.programming.kicks-ass.net>
        <A9B20D93-748B-4789-801E-91720E2D4F28@fb.com>
        <20200526215415.GH2483@worktop.programming.kicks-ass.net>
        <20200526180437.45aed950@gandalf.local.home>
        <595AB855-8E84-4367-AEEC-C140F035C9B4@fb.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 21:58:48 +0000
Song Liu <songliubraving@fb.com> wrote:

> 
> How does this work in your tests? 

I started it, but got distracted by other work. It did not crash with
the little testing I did do. I wanted to also look at my patch that
adds tracing to the ftrace directory too.

I'll try to remember to address this some more next week. Feel free to
ping me again then.

-- Steve

