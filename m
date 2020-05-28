Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9989C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A3120B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgE1IIs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgE1IIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:08:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B86C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:08:47 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jeDam-0001RV-Ep; Thu, 28 May 2020 10:08:44 +0200
Date:   Thu, 28 May 2020 10:08:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 1/2] workqueue: pin the pool while it is managing
Message-ID: <20200528080844.37wgxcy77uu7pmmz@linutronix.de>
References: <20200527194633.1660952-2-bigeasy@linutronix.de>
 <20200528030657.1690-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200528030657.1690-1-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-28 03:06:55 [+0000], Lai Jiangshan wrote:
> So that put_unbound_pool() can ensure all workers in idle,
> no unfinished manager. And it doens't need to wait any manager
> and can go to delete all the idle workers straight away.
> 
> Also removes manager waitqueue, because it is unneeded and as
> Sebastian Andrzej Siewior said:
> 
>   The workqueue code has it's internal spinlock (pool::lock) and also
>   implicit spinlock usage in the wq_manager waitqueue. These spinlocks
>   are converted to 'sleeping' spinlocks on a RT-kernel.
> 
>   Workqueue functions can be invoked from contexts which are truly atomic
>   even on a PREEMPT_RT enabled kernel. Taking sleeping locks from such
>   contexts is forbidden.
> 
>   pool::lock can be converted to a raw spinlock as the lock held times
>   are short. But the workqueue manager waitqueue is handled inside of
>   pool::lock held regions which again violates the lock nesting rules
>   of raw and regular spinlocks.

This seems to work for my test case I had test my chance. And lockdep
didn't complain so…

If you prefer this over my 1/2 what do we do about 2/2? Do you want me
to repost it?

Sebastian
