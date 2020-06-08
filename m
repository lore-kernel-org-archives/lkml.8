Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36615C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C351206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgFHOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgFHOhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:37:11 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9C22053B;
        Mon,  8 Jun 2020 14:37:10 +0000 (UTC)
Date:   Mon, 8 Jun 2020 10:37:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Divya Indi <divya.indi@oracle.com>, <linux-kernel@vger.kernel.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Subject: Re: [PATCH] sample-trace-array: Fix sleeping function called from
 invalid context
Message-ID: <20200608103709.39afa15f@gandalf.local.home>
In-Reply-To: <20200608075437.1760242-1-wangkefeng.wang@huawei.com>
References: <20200608075437.1760242-1-wangkefeng.wang@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jun 2020 07:54:37 +0000
Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:935
>  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/5
>  1 lock held by swapper/5/0:
>   #0: ffff80001002bd90 (samples/ftrace/sample-trace-array.c:38){+.-.}-{0:0}, at: call_timer_fn+0x8/0x3e0
>  CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.7.0+ #8
>  Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
>  Call trace:
>   dump_backtrace+0x0/0x1a0
>   show_stack+0x20/0x30
>   dump_stack+0xe4/0x150
>   ___might_sleep+0x160/0x200
>   __might_sleep+0x58/0x90
>   __mutex_lock+0x64/0x948
>   mutex_lock_nested+0x3c/0x58
>   __ftrace_set_clr_event+0x44/0x88
>   trace_array_set_clr_event+0x24/0x38
>   mytimer_handler+0x34/0x40 [sample_trace_array]
> 
> mutex_lock() will be called in interrupt context, using workqueueu to fix it.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 

Divya,

Can you give a Reviewed-by for this?

-- Steve
