Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2EF42067D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 13:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sghZv8z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgHDNUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbgHDNUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:20:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C543C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MtCQkCAi8tOvg3cozmvELDGXYEwt15BDLWA0YjCUoqc=; b=sghZv8z6Lb1uYMsRSi5N2ghTxo
        sWZ6Epljy0yudgxb8BPdrJbVZ/afdvUqBjsQtxkV1fNnbfSNzz4EN2x6Dtr+/7BtZOXGNHkJsX7Qd
        xGX6q8PKRzJMnsLN4c1V6+0RHy9BMVPGo00N3PyiO2yTET/+a1l0r8rmvmrAZQDHHVQyM5uNFzqqW
        MNe/x4OTaMFg9L9rZHpxXHpXoS4N3fcUyHWpFnwqO+Pv1LwO25AAce6tnsv+bolACV4svm0BxDwW9
        qAbBz9TrLLqUopEFFGgLvYPEk0D+5cI3A+yYQdZRm0Zq+Ee1jMxht+XZpYq5VN3RliKZovdGir0Gr
        +XoUk8qQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2wrn-0005vr-5z; Tue, 04 Aug 2020 13:20:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B98B5301A66;
        Tue,  4 Aug 2020 15:20:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A81612B622ECF; Tue,  4 Aug 2020 15:20:28 +0200 (CEST)
Date:   Tue, 4 Aug 2020 15:20:28 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [patch V3 0/3] posix-cpu-timers: Move expiry into task work
 context
Message-ID: <20200804132028.GJ2657@hirez.programming.kicks-ass.net>
References: <20200730101404.956367860@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730101404.956367860@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 12:14:04PM +0200, Thomas Gleixner wrote:

>  arch/x86/Kconfig               |    1 
>  include/linux/posix-timers.h   |   17 +++
>  include/linux/sched.h          |    4 
>  include/linux/seccomp.h        |    3 
>  kernel/entry/common.c          |    4 
>  kernel/time/Kconfig            |    9 +
>  kernel/time/posix-cpu-timers.c |  216 ++++++++++++++++++++++++++++++++++++-----
>  kernel/time/timer.c            |    1 
>  8 files changed, 227 insertions(+), 28 deletions(-)

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
