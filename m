Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2967C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894D3208DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b85Q+wHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbgFSJx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731048AbgFSJx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:53:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB1C06174E;
        Fri, 19 Jun 2020 02:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vNFT0Sjkn3Ns/7UfmeMa4BFlK6XwuyyvTy4lSWmOyOA=; b=b85Q+wHeQcNdxG/dTULcLBKUsI
        sPBb3JkAlAK1dDJl1iVeX4cqP45n5LN3HJgb5ga3rV+3YsW1zJQfZQjgXjbiO7k41C41fr5OWSLKJ
        SpuMUBc85F8ZYo58ibVFe19JhCYxCXXD3felRoSi5ZqrC8PbZ4cRwxkzRa6OZ4Hjhw3+tTeAM6m2b
        OGhP4o8lEN47X+wym4zafTtvRnnJswLrzlieWzWAH+8xdcATCh3ePd9Ru8qAEEov7S4dV8yAtW6Jn
        ybFGb6kaTaXG5rLJVLtymMK+j6LSlMbGJBkDIxBCk+L2D2NJDuw1zQXuh8AgWDLRArZM+SHrlQguZ
        eNC7FzDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jmDiT-0006DN-KM; Fri, 19 Jun 2020 09:53:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0DD9A3003E5;
        Fri, 19 Jun 2020 11:53:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC999203C0359; Fri, 19 Jun 2020 11:53:42 +0200 (CEST)
Date:   Fri, 19 Jun 2020 11:53:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, bp@alien8.de, devel@etsukata.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: INFO: trying to register non-static key in is_dynamic_key
Message-ID: <20200619095342.GT576905@hirez.programming.kicks-ass.net>
References: <00000000000004a76305a8624d22@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000004a76305a8624d22@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:17:15PM -0700, syzbot wrote:

> INFO: trying to register non-static key.
> the code is fine but needs lockdep annotation.
> turning off the locking correctness validator.
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xf6/0x16e lib/dump_stack.c:118
>  assign_lock_key kernel/locking/lockdep.c:894 [inline]
>  register_lock_class+0x1442/0x17e0 kernel/locking/lockdep.c:1206
>  arch_stack_walk+0x81/0xf0 arch/x86/kernel/stacktrace.c:25
>  lock_downgrade+0x720/0x720 kernel/locking/lockdep.c:4624
>  is_dynamic_key+0x1b0/0x1b0 kernel/locking/lockdep.c:1176
>  trace_hardirqs_off+0x50/0x1f0 kernel/trace/trace_preemptirq.c:83
>  __lock_acquire+0x101/0x6270 kernel/locking/lockdep.c:4259
>  save_stack+0x32/0x40 mm/kasan/common.c:50

So I'm thinking this is in fact:

	spin_lock_irqsave(&depot_lock, flags);

from lib/stackdepot.c:stack_depot_save(), which has gone missing from
the stack due to tail-call optimizations.

Now depot_lock is declared thusly:

  static DEFINE_SPINLOCK(depot_lock);

and I'm trying to figure out how lockdep manages to conclude that isn't
static storage.... most odd.
