Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E29AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50CAB2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHTOgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbgHTOgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:36:46 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE66D2076E;
        Thu, 20 Aug 2020 14:36:44 +0000 (UTC)
Date:   Thu, 20 Aug 2020 10:36:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rjw@rjwysocki.net, joel@joelfernandes.org,
        svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200820103643.1b9abe88@oasis.local.home>
In-Reply-To: <20200820073031.886217423@infradead.org>
References: <20200820073031.886217423@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I tested this series on top of tip/master and triggered the below
warning when running the irqsoff tracer boot up test (config attached).

-- Steve

 Testing tracer irqsoff: 
 
 =============================
 WARNING: suspicious RCU usage
 5.9.0-rc1-test+ #92 Not tainted
 -----------------------------
 include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
 
 other info that might help us debug this:
 
 
 rcu_scheduler_active = 2, debug_locks = 1
 RCU used illegally from extended quiescent state!
 no locks held by swapper/2/0.
 
 stack backtrace:
 CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.9.0-rc1-test+ #92
 Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
 Call Trace:
  dump_stack+0x8d/0xc0
  lock_acquire.cold+0x23/0x2c
  ? default_idle_call+0x4d/0x210
  _raw_spin_lock_irqsave+0x50/0xa0
  ? check_critical_timing+0x69/0x160
  check_critical_timing+0x69/0x160
  ? default_idle_call+0x4d/0x210
  stop_critical_timings+0xdd/0xf0
  default_idle_call+0x4d/0x210
  do_idle+0x1f6/0x260
  cpu_startup_entry+0x19/0x20
  start_secondary+0x110/0x140
  secondary_startup_64+0xb6/0xc0
