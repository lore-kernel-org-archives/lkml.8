Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AB9C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054DA2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579216101;
	bh=RzdHsvb0dmyx5pMQeWPi5Wl7q2YHHnKJ8ATlccE8thE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=KSAc7PazHFAgLpftkBCI0APUdYhwICphlSpdNNFxiXvPmy01w1nCUuB8vfrauRhI7
	 /Dv8DJVypLtIE7WuS6wTTfv88hNq6aGSwppP/Kx7YLZTIEcMcluTX2pciMYYxBc5bL
	 P0jXN3KO/Kg236NZY7p8ABPEwf3zx+C3+KAhTt9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390360AbgAPXIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729925AbgAPXIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:08:19 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B641E2077B;
        Thu, 16 Jan 2020 23:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216098;
        bh=RzdHsvb0dmyx5pMQeWPi5Wl7q2YHHnKJ8ATlccE8thE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZHPfgQWbFv9eMFg5n9gPuZaZNFgrVkfg5aa2UW/xp/BnWVbrblIuTqKyCA3+IsQkQ
         J/p31vtD2zup8e/JAN9xQ+1fILY/Pofwz4WxBZH+g3vt0sHc1eJ+vEakkSxOUVywJH
         K05c7AkRtMvrW/vMQRlowwnSVXht8Oqs+fR2kgSw=
Message-ID: <1579216096.8397.34.camel@kernel.org>
Subject: Re: Unresolved reference for histogram variable
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 16 Jan 2020 17:08:16 -0600
In-Reply-To: <20200116154216.58ca08eb@gandalf.local.home>
References: <20200116154216.58ca08eb@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 2020-01-16 at 15:42 -0500, Steven Rostedt wrote:
> Hi Tom,
> 
> I'm working on the SQL converter to the ftrace histogram interface,
> and
> while testing the histogram code, I found something strange.
> 
> If I write the following:
> 
>  # echo 'first u64 start_time u64 end_time pid_t pid u64 delta' >>
> synthetic_events
>  # echo 'hist:keys=pid:start=common_timestamp' >
> events/sched/sched_waking/trigger 
>  # echo 'hist:keys=next_pid:start2=$start,delta=common_timestamp-
> $start:onmatch(sched.sched_waking).trace(first,$start2,common_timesta
> mp,next_pid,$delta)' > events/sched/sched_switch/trigger
> 
>  # cat events/sched/sched_switch/hist 
> # event histogram
> #
> # trigger info:
> hist:keys=next_pid:vals=hitcount:start2=$start,delta=common_timestamp
> -$start:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_waki
> ng).trace(first,$start2,common_timestamp,next_pid,$delta) [active]
> #
> 
> { next_pid:       1337 } hitcount:          1
> { next_pid:         35 } hitcount:          1
> { next_pid:        654 } hitcount:          1
> { next_pid:         20 } hitcount:          1
> { next_pid:       1392 } hitcount:          1
> { next_pid:       1336 } hitcount:          1
> { next_pid:         45 } hitcount:          1
> { next_pid:         15 } hitcount:          1
> { next_pid:        674 } hitcount:          1
> { next_pid:         40 } hitcount:          1
> { next_pid:          7 } hitcount:          1
> { next_pid:         25 } hitcount:          1
> { next_pid:         30 } hitcount:          1
> { next_pid:         12 } hitcount:          1
> { next_pid:       1693 } hitcount:          1
> { next_pid:        206 } hitcount:          1
> { next_pid:         27 } hitcount:          2
> { next_pid:        694 } hitcount:          2
> { next_pid:        438 } hitcount:          2
> { next_pid:       1016 } hitcount:          3
> { next_pid:         53 } hitcount:          4
> { next_pid:       1688 } hitcount:          4
> { next_pid:       1679 } hitcount:          4
> { next_pid:       1066 } hitcount:          6
> { next_pid:       1637 } hitcount:          6
> { next_pid:       1635 } hitcount:         11
> { next_pid:         11 } hitcount:         11
> { next_pid:        196 } hitcount:         12
> { next_pid:       1270 } hitcount:         15
> { next_pid:       1506 } hitcount:         18
> 
> Totals:
>     Hits: 116
>     Entries: 30
>     Dropped: 0
> 
> 
> All fine and dandy. But if I swap the two variables assignments...
> 
>  from: start2=$start,delta=common_timestamp-$start
> 
>  to: delta=common_timestamp-$start,start2=$start
> 
> Where I assign the delta before start2, I get this:

Yeah, what's happening is that after being used the $start variable
gets 'unset', and then start2 is assigned to that unset variable so is
also unset, and then the onmatch sees that $start2 is unset so results
in the trigger not firing because it sees start2 as unset.

In the first case, that doesn't happen, because start2 is assigned
first, and is still set when the onmatch happens.

I think you're right and it should just refer to the same variable
multiple times before it get unset.

> 
>  # cat events/sched/sched_switch/hist 
> # event histogram
> #
> # trigger info:
> hist:keys=next_pid:vals=hitcount:delta=common_timestamp-
> $start,start2=$start:sort=hitcount:size=2048:clock=global:onmatch(sch
> ed.sched_waking).trace(first,$start2,common_timestamp,next_pid,$delta
> ) [active]
> #
> 
> 
> Totals:
>     Hits: 0
>     Entries: 0
>     Dropped: 0
> 
> 
> After spending a day placing trace_printk() and printk()s in the
> code,
> I found the culprit, and it has to do with this line here:
> 
> in resolve_var_refs():
> 
> 		if (self || !hist_field->read_once)
> 			var_val = tracing_map_read_var(var_elt,
> var_idx);
> 		else
> 			var_val = tracing_map_read_var_once(var_elt,
> var_idx);
> 
> 
> It appears that:
> 
>   start2=$start
> 
> does not set the read_once() to the variable, which allows for the
> delta calculation to work. But the delta calculation has:

In this case, the start2=$start happens before the expression that
unsets it, so works, but when it happens afterwards, the read_once() in
the expression causes the value to be unset, so results in the start2
being unset.

> 
> in parse_expr():
> 
> 	operand1->read_once = true;
> 	operand2->read_once = true;
> 
> Why is that?
> 
> This means that any variable used in an expression can not be use
> later
> on.

The read_once is a a shortcut to prevent expressions from using
uninitialized variables, so if any are unset, they cause any actions
referring to unset variables to not be triggered, and after being read
once the variables are unset.  It's better described in
Documentation/histogram.rst:

"A variable's value is normally available to any subsequent event until
it is set to something else by a subsequent event.  The one exception
to that rule is that any variable used in an expression is essentially
'read-once' - once it's used by an expression in a subsequent event,
it's reset to its 'unset' state, which means it can't be used again
unless it's set again.  This ensures not only that an event doesn't
use an uninitialized variable in a calculation, but that that variable
is used only once and not for any unrelated subsequent match."

The assumption was that expressions would generally be used that way
e.g. like the common_timestamp-$ts0, where a bogus $ts0 would mean
disaster.

> 
> Or should the variable be detected that it is used multiple times in
> the expression, and have the parser detect this, and just reuse the
> same variable multiple times?

Yeah, I think that makes sense - I'll look at your patch and see if
that's the best way to do it.

Thanks,

Tom

> 
> -- Steve
