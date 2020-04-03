Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A70C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899AC20675
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 19:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbgDCT3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 15:29:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40905 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgDCT3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 15:29:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jKRzy-00030I-6W; Fri, 03 Apr 2020 21:29:02 +0200
Date:   Fri, 3 Apr 2020 21:29:02 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, LKP <lkp@lists.01.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2] workqueue: Remove the warning in wq_worker_sleeping()
Message-ID: <20200403192902.ws33fhs5mrxg6dvo@linutronix.de>
References: <20200327074308.GY11705@shao2-debian>
 <20200327175350.rw5gex6cwum3ohnu@linutronix.de>
 <20200327232959.rpylymw2edhtxuwr@linutronix.de>
 <20200403145326.GA162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200403145326.GA162390@mtj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-03 10:53:26 [-0400], Tejun Heo wrote:
> Hello,
Hello Tejun,

> This is not a usual control flow, right? 

The worker is blocked on something and while invoking schedule() it
needs to be preempted by an interrupt which opens interrupts and invokes
schedule() as well.
Interrupt handler are not allowed to enable interrupts in general.
Page-fault handler do so by they happen only while the calling context
triggered a page-fault. Since the kernel is always mapped, this does not
happen.
The async page fault handler is any exception here. I don't find
anything else while looking over x86's idtentry. So this makes it highly
unusual control flow, yes.

> Can we annotate this case specifically
> instead of weakening santiy check for generic cases?

puh. So if this
  do_async_page_fault() -> do_page_fault()

never happens but only
  do_async_page_fault() -> kvm_async_pf_task_wait()

then kvm_async_pf_task_wait() could invoke preempt_schedule() instead.
This would avoid the worker part (and the warning) but is only available
for PREEMPTION kernels. And I think the former case might happen.

> Thanks.
> 

Sebastian
