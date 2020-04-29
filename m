Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECB4C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9051E2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgD2K7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:59:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:60296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgD2K7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:59:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 788E7AB8F;
        Wed, 29 Apr 2020 10:59:43 +0000 (UTC)
Date:   Wed, 29 Apr 2020 12:59:41 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [RFC][PATCH] x86/mm: Sync all vmalloc mappings before text_poke()
Message-ID: <20200429105941.GQ30814@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429054857.66e8e333@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On Wed, Apr 29, 2020 at 05:48:57AM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Tzvetomir was adding a feature to trace-cmd that would allow the user
> to specify filtering on process IDs within a tracing instance (or
> buffer). When he added this feature and tested it on tracing PIDs 1 and
> 2, it caused his kernel to hang.
> 
> He sent me his code and I was able to reproduce the hang as well. I
> bisected it down to this commit 763802b53a42 ("x86/mm: split
> vmalloc_sync_all()"). It was 100% reproducible. With the commit it
> would hang, and reverting the commit, it would work.
> 
> Adding a bunch of printk()s, I found where it locked up. It was after
> the recording was finished, and a write of "0" to
> tracefs/instance/foo/events/enable. And in the code, it was:
> 
> (you may skip to the end of the chain)
> 
> system_enable_write() {
>   __ftrace_set_clr_event() {
>     __ftrace_set_clr_event_nolock() {
>       ftrace_event_enable_disable() {
>         __ftrace_event_enable_disable() {
>           call->class->reg() <trace_event_reg()> {
>             trace_point_probe_unregister() {
>               tracepoint_remove_func() {
>                 static_key_slow_dec() {
>                   __static_key_slow_dec() {
> 
>     <continued>
> 
>   __static_key_slow_dec_cpus_locked() {
>     jump_label_update() {
>       __jump_label_update()
>         arch_jump_label_transform() {
>           jump_label_transform() {
>             __jump_label_transform() {
>               text_poke_bp() {
>                 text_poke_bp_batch() {
>                   text_poke() {
>                     __text_poke() {
> 
>     <continued> (This is where you want to see)
> 
>   use_temporary_mm() {
>     switch_mm_irqs_off() {
>       load_new_mm_cr3() {
>         write_cr3() <<--- Lock up!

I don't see how it could lock up in write_cr3(), at least on bare-metal.
What is the environment this happens, 32 or 64 bit, in a VM or
bare-metal?

I think it is more likely that your lockup is actually a page-fault
loop, where the #PF handler does not map the faulting address correctly.

But I have to look closer into how text_poke() works before I can say
more.

Btw, in case it happens on x86-64, does it also happen without
vmalloc-stacks?

Regards,

	Joerg
