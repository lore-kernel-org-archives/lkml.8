Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1F0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6B6F2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388177AbgAPUmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387592AbgAPUmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 15:42:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D00820748;
        Thu, 16 Jan 2020 20:42:17 +0000 (UTC)
Date:   Thu, 16 Jan 2020 15:42:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Unresolved reference for histogram variable
Message-ID: <20200116154216.58ca08eb@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

I'm working on the SQL converter to the ftrace histogram interface, and
while testing the histogram code, I found something strange.

If I write the following:

 # echo 'first u64 start_time u64 end_time pid_t pid u64 delta' >> synthetic_events
 # echo 'hist:keys=pid:start=common_timestamp' > events/sched/sched_waking/trigger 
 # echo 'hist:keys=next_pid:start2=$start,delta=common_timestamp-$start:onmatch(sched.sched_waking).trace(first,$start2,common_timestamp,next_pid,$delta)' > events/sched/sched_switch/trigger

 # cat events/sched/sched_switch/hist 
# event histogram
#
# trigger info: hist:keys=next_pid:vals=hitcount:start2=$start,delta=common_timestamp-$start:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_waking).trace(first,$start2,common_timestamp,next_pid,$delta) [active]
#

{ next_pid:       1337 } hitcount:          1
{ next_pid:         35 } hitcount:          1
{ next_pid:        654 } hitcount:          1
{ next_pid:         20 } hitcount:          1
{ next_pid:       1392 } hitcount:          1
{ next_pid:       1336 } hitcount:          1
{ next_pid:         45 } hitcount:          1
{ next_pid:         15 } hitcount:          1
{ next_pid:        674 } hitcount:          1
{ next_pid:         40 } hitcount:          1
{ next_pid:          7 } hitcount:          1
{ next_pid:         25 } hitcount:          1
{ next_pid:         30 } hitcount:          1
{ next_pid:         12 } hitcount:          1
{ next_pid:       1693 } hitcount:          1
{ next_pid:        206 } hitcount:          1
{ next_pid:         27 } hitcount:          2
{ next_pid:        694 } hitcount:          2
{ next_pid:        438 } hitcount:          2
{ next_pid:       1016 } hitcount:          3
{ next_pid:         53 } hitcount:          4
{ next_pid:       1688 } hitcount:          4
{ next_pid:       1679 } hitcount:          4
{ next_pid:       1066 } hitcount:          6
{ next_pid:       1637 } hitcount:          6
{ next_pid:       1635 } hitcount:         11
{ next_pid:         11 } hitcount:         11
{ next_pid:        196 } hitcount:         12
{ next_pid:       1270 } hitcount:         15
{ next_pid:       1506 } hitcount:         18

Totals:
    Hits: 116
    Entries: 30
    Dropped: 0


All fine and dandy. But if I swap the two variables assignments...

 from: start2=$start,delta=common_timestamp-$start

 to: delta=common_timestamp-$start,start2=$start

Where I assign the delta before start2, I get this:

 # cat events/sched/sched_switch/hist 
# event histogram
#
# trigger info: hist:keys=next_pid:vals=hitcount:delta=common_timestamp-$start,start2=$start:sort=hitcount:size=2048:clock=global:onmatch(sched.sched_waking).trace(first,$start2,common_timestamp,next_pid,$delta) [active]
#


Totals:
    Hits: 0
    Entries: 0
    Dropped: 0


After spending a day placing trace_printk() and printk()s in the code,
I found the culprit, and it has to do with this line here:

in resolve_var_refs():

		if (self || !hist_field->read_once)
			var_val = tracing_map_read_var(var_elt, var_idx);
		else
			var_val = tracing_map_read_var_once(var_elt, var_idx);


It appears that:

  start2=$start

does not set the read_once() to the variable, which allows for the
delta calculation to work. But the delta calculation has:

in parse_expr():

	operand1->read_once = true;
	operand2->read_once = true;

Why is that?

This means that any variable used in an expression can not be use later
on.

Or should the variable be detected that it is used multiple times in
the expression, and have the parser detect this, and just reuse the
same variable multiple times?

-- Steve
