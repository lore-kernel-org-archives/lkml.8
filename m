Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE15C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554622076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416216AbgDOQqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416207AbgDOQqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:46:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DF7C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 09:46:30 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jOlBE-0006ny-Gl; Wed, 15 Apr 2020 18:46:28 +0200
Date:   Wed, 15 Apr 2020 18:46:28 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Matt Fleming <matt@codeblueprint.co.uk>
Cc:     linux-rt@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH RT] signal: Prevent double-free of user struct
Message-ID: <20200415164628.2dgrj4ghvtev45sy@linutronix.de>
References: <20200407095413.30039-1-matt@codeblueprint.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407095413.30039-1-matt@codeblueprint.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-07 10:54:13 [+0100], Matt Fleming wrote:
> The way user struct reference counting works changed significantly with,
> 
>   fda31c50292a ("signal: avoid double atomic counter increments for user accounting")
> 
> Now user structs are only freed once the last pending signal is
> dequeued. Make sigqueue_free_current() follow this new convention to
> avoid freeing the user struct multiple times and triggering this
> warning:
> 
>  refcount_t: underflow; use-after-free.
>  WARNING: CPU: 0 PID: 6794 at lib/refcount.c:288 refcount_dec_not_one+0x45/0x50
>  Call Trace:
>   refcount_dec_and_lock_irqsave+0x16/0x60
>   free_uid+0x31/0xa0
>   ? schedule_hrtimeout_range_clock+0x104/0x110
>   __dequeue_signal+0x17c/0x190
>   dequeue_signal+0x5a/0x1b0
>   do_sigtimedwait+0x208/0x250
>   __x64_sys_rt_sigtimedwait+0x6f/0xd0
>   do_syscall_64+0x72/0x200
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe

While all this sounds reasonable, may I ask what did you do to trigger
this?
This is v5.6 only, correct?

Sebastian
