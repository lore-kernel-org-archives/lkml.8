Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F803C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53823207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406965AbgFYSMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 14:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405949AbgFYSMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 14:12:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3803420789;
        Thu, 25 Jun 2020 18:12:42 +0000 (UTC)
Date:   Thu, 25 Jun 2020 14:12:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Korben Rusek <korben@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200625141240.53a4094b@oasis.local.home>
In-Reply-To: <CAPo_bq3Bd4gRTeZHqD0p3KR+-339C=cmqgjgYMz1hvu1f+QAAQ@mail.gmail.com>
References: <20200625094454.732790f7@oasis.local.home>
        <126813531.12266.1593093195147.JavaMail.zimbra@efficios.com>
        <20200625103753.4ac4a9a2@oasis.local.home>
        <CAPo_bq3Bd4gRTeZHqD0p3KR+-339C=cmqgjgYMz1hvu1f+QAAQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 09:42:34 -0700
Korben Rusek <korben@google.com> wrote:

> Great work! I'm not exactly qualified to review the code, but the
> logic seems correct. I'm curious how unlikely a zero delta is now and
> how you quantify it. Also does it negate the patch that I emailed out

Actually, in all my stress testing (where I also add nested
trace_printk()s to read what is happening), I was never once able to
trigger the zero delta path! I only tested it by adding code to inject
the event to force the given race condition.

Note, zero deltas are still there between absolute time stamps and
start of page, but that's still different than a zero delta from the
previous event.

> last week that adds a `force_abs_timestamp` trace/option in an attempt
> to get around this particular issue?
> 
> In reading through, I did notice a couple simple typos in the comments
> that are probably worth pointing out:

Thanks.

-- Steve


> 
> > If preempting an event time update, we may need absolute timestamp.  
> 
> Not a big deal, but it should be "may need *an* absolute timestamp"
> 
> > * Preempted beween C and E:
> > * Lost the previous events time stamp. Just set the
> > * delta to zero, and this will be the same time as
> > * the veent this event preempted. And the events that
> > * came after this will still be correct (as they would
> > * have built their delta on the previous event.  
> 
> Should be "the *event* this event preempted." It also needs a
> parenthesis at the end of the comment to close the parenthetical
> statement.
> 
> Thanks, Korben

