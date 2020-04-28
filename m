Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06C2C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2C720656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2rsBDfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgD1QcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgD1QcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:32:18 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37648C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5uyd2eLu8s5hnJZSJX3BCGNVOndrJ/C5Uia7R47Di8w=; b=g2rsBDfrZNJp5W0zDBWLuafwQ4
        Z8uZL9X+NC2vJj+ZQmUnLTnErfxQcseH7mI6tEDZYOzsMKNI604Ql0BtFG1tV/zWvPRUo58InM81g
        L0I/LLIx0CCl1pFJHtk3CKRCF0Ad+0CLZdLI989wkmDGElVWqQVqPGKymxFggMUcN8seftVcv1D1X
        uVPC7ONeI+/qSDFNNwsZKiY1qCR+y5OlAQL+BguWMwfb5OfxT79nvcC+stl4SsQszGmHeFjNX6nDo
        ErPtH2WFbxABZGgUgqDO7lh81SApA6OB3kP0gtb/eNn9AKKw3YmD2FzP33IEZ3A8DQXJy1Pa8mmcc
        L3o24tjg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTT8r-0002Z1-De; Tue, 28 Apr 2020 16:31:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C013D30477A;
        Tue, 28 Apr 2020 18:31:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 92E1D2042736C; Tue, 28 Apr 2020 18:31:25 +0200 (CEST)
Date:   Tue, 28 Apr 2020 18:31:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     mingo@redhat.com, hannes@cmpxchg.org, will@kernel.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        ben.dooks@codethink.co.uk, cl@rock-chips.com, ke.wang@unisoc.com,
        shakeelb@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] kthread: break dependency between worker->lock and
 task_struct->pi_lock
Message-ID: <20200428163125.GC16910@hirez.programming.kicks-ass.net>
References: <20200427184358.191624-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427184358.191624-1-surenb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:43:58AM -0700, Suren Baghdasaryan wrote:
> A number of kthread-related functions indirectly take task_struct->pi_lock
> while holding worker->lock in the call chain like this:
>     spin_lock(&worker->lock)
>     kthread_insert_work
>     wake_up_process
>     try_to_wake_up
>     raw_spin_lock_irqsave(&p->pi_lock, flags)
> 
> This lock dependency exists whenever kthread_insert_work is called either
> directly or indirectly via __kthread_queue_delayed_work in the following
> functions:
>     kthread_queue_work
>     kthread_delayed_work_timer_fn
>     kthread_queue_delayed_work
>     kthread_flush_work
>     kthread_mod_delayed_work
> 
> This creates possibilities for circular dependencies like the one reported
> at: https://lkml.org/lkml/2020/4/24/954

Please, do not use lkml.org links.

Also, ideally, we'd pull that kthread_queue_delayed_work() out from
under rq->lock.

In fact, looking at it, WTH is the delayed branch of
kthread_queue_delayed_work() under that lock? That whole
delayed_work_list thing smells like bong-hits.
