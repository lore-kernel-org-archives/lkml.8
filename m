Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDD6C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9101524672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgB2XtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:59540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726786AbgB2XtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:49:17 -0500
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F73B20828;
        Sat, 29 Feb 2020 23:49:15 +0000 (UTC)
Date:   Sat, 29 Feb 2020 18:49:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 03/13] kprobes: Add symbols for kprobe insn pages
Message-ID: <20200229184913.4e13e516@oasis.local.home>
In-Reply-To: <20200229134947.839096dbc8321cfdca980edb@kernel.org>
References: <20200228135125.567-1-adrian.hunter@intel.com>
        <20200228135125.567-4-adrian.hunter@intel.com>
        <20200228233600.5f5c733584eac08b8a4a2b70@kernel.org>
        <20200228172004.GI5451@krava>
        <20200229134947.839096dbc8321cfdca980edb@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Feb 2020 13:49:47 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Fri, 28 Feb 2020 18:20:04 +0100
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > > BTW, it seems to pretend to be a module, but is there no concern of
> > > confusing users? Shouldn't it be [*kprobes] so that it is non-exist
> > > module name?  
> > 
> > note we already have bpf symbols as [bpf] module  
> 
> Yeah, and this series adds [kprobe(s)] and [ftrace] too.
> I simply concern that the those module names implicitly become
> special word (rule) and embedded in the code. If such module names
> are not exposed to users, it is OK (but I hope to have some comments).
> However, it is under /proc, which means users can notice it.

I share Masami's concerns. It would be good to have something
differentiate local functions that are not modules. That's one way I
look to see if something is a module or built in, is to see if kallsyms
has it as a [].

Perhaps prepend with: '&' ?

-- Steve

