Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2F620656
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EOlCI3+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgFJK1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFJK1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:27:41 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB27C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y9sJ0nqLw2D9SJ2n4c46d26MrVBrK5KaVaZ6pcAxgx4=; b=EOlCI3+YvBmmB+KvdmPeCgZprd
        DtFxQ1lEdq7MuB0PSpRId1UfPHS2UQCskTsOdBtUa0Jt53VvLt3mzZV/XpsFgZooIWJrLuOKrZkRm
        ZvX/2spsKfUv3xzKGtZdkIDaytGhDQn4MDYc/vlJK2Hok1Xj0+48G84C2UzWP4IY9YU1B6gqVObiG
        qFb7uTNAt1NIia+Zp/9wgzsC71Nw6RuDoVnl/ENN6E4kPuUO404jT4denIPKWw2nazIXxiCiaABMF
        M+0GuciBQZ1B66Yy+GWn+dWBlxr7GOTCwPmr6TgecYxTj1qIeye95OhH0OVEdLc67mdoH6Zpy1qTW
        wHP9v/9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jixwd-00021W-V3; Wed, 10 Jun 2020 10:26:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CACBE3011DD;
        Wed, 10 Jun 2020 12:26:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3748203EE205; Wed, 10 Jun 2020 12:26:52 +0200 (CEST)
Date:   Wed, 10 Jun 2020 12:26:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] Capacity awareness for SCHED_DEADLINE
Message-ID: <20200610102652.GH2531@hirez.programming.kicks-ass.net>
References: <20200520134243.19352-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520134243.19352-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:42:38PM +0200, Dietmar Eggemann wrote:
> Dietmar Eggemann (2):
>   sched/deadline: Optimize dl_bw_cpus()
>   sched/deadline: Add dl_bw_capacity()
> 
> Luca Abeni (3):
>   sched/deadline: Improve admission control for asymmetric CPU
>     capacities
>   sched/deadline: Make DL capacity-aware
>   sched/deadline: Implement fallback mechanism for !fit case
> 
>  kernel/sched/cpudeadline.c | 24 ++++++++++
>  kernel/sched/deadline.c    | 89 ++++++++++++++++++++++++++++++--------
>  kernel/sched/sched.h       | 21 +++++++--
>  3 files changed, 113 insertions(+), 21 deletions(-)

Thanks!
