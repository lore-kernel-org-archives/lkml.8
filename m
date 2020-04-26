Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F48C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ACBB20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgDZQcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgDZQcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:32:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8B2C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 09:32:07 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jSkCC-0005h7-K4; Sun, 26 Apr 2020 18:31:56 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 7405C100605; Sun, 26 Apr 2020 18:31:55 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] locking/rtmutex: optimize rt_mutex_cmpxchgs
In-Reply-To: <1587135032-188866-2-git-send-email-alex.shi@linux.alibaba.com>
References: <1587135032-188866-1-git-send-email-alex.shi@linux.alibaba.com> <1587135032-188866-2-git-send-email-alex.shi@linux.alibaba.com>
Date:   Sun, 26 Apr 2020 18:31:55 +0200
Message-ID: <87k122ryx0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <alex.shi@linux.alibaba.com> writes:

> Checking l->owner first to skip time cost cmpxchgs.

I don't see what that buys.

It actually adds an extra conditional in the non-contended case, which
is the case we are optimizing for.

In the contended case, i.e. when l->owner != c the cmpxchg cost is
completely irrelevant compared to the slowpath costs.

>  #ifndef CONFIG_DEBUG_RT_MUTEXES
> -# define rt_mutex_cmpxchg_acquire(l,c,n) (cmpxchg_acquire(&l->owner, c, n) == c)
> -# define rt_mutex_cmpxchg_release(l,c,n) (cmpxchg_release(&l->owner, c, n) == c)
> +# define rt_mutex_cmpxchg_acquire(l, c, n)	\
> +			(l->owner == c && cmpxchg_acquire(&l->owner, c, n) == c)
> +# define rt_mutex_cmpxchg_release(l, c, n)	\
> +			(l->owner == c && cmpxchg_release(&l->owner, c, n) == c)

This kind of micro-optimizing is more than dubious especially w/o
numbers backing up the benefit.

Thanks,

        tglx
