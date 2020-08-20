Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E412EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE4B2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SMJtlG6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgHTNqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgHTNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:44:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E639C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NvYnWgOAVLeS0ww2FKkz6JZjgCUOG8nfY5k3KGZFesw=; b=SMJtlG6gpmxu9BR7hWA/m82WXN
        Gp4BkEsPanIZnDHmi6WqwCfovEFuUhHFowE3Y4G07xPsqUl2pM3rq7nwEk6THep2JZgwjy4FR7Ezh
        lrWsDoLGK6VnoJ8C3EVBDZrm7Imfi9zdg1JEnaD1v2J8aImBsL8OL2Cj5+clMBkD341FWQdlyEIK1
        u2Jhyn7p5oHTXX+Oiy9p5VGQy169OzEu7DnV9gvQoyLpg3pTlqkwZiRT5AESMCzXS3+TA7g9E+hqj
        01oiqKAYaign+LU8pNogATAof0a8ckQ7Sao4pvuH6lFWvnkUDY3DUHXyqFuEx2Grwcv1x2FDIVKvc
        DzLQfyRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8kr2-0006fX-Ds; Thu, 20 Aug 2020 13:43:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFED3303271;
        Thu, 20 Aug 2020 15:43:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 986F62BE72362; Thu, 20 Aug 2020 15:43:41 +0200 (CEST)
Date:   Thu, 20 Aug 2020 15:43:41 +0200
From:   peterz@infradead.org
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Jiang Biao <benbjiang@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE
 task
Message-ID: <20200820134341.GW2674@hirez.programming.kicks-ass.net>
References: <20200820120025.74460-1-benbjiang@tencent.com>
 <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net>
 <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> That's been said, not compensating the vruntime for a sched_idle task
> makes sense for me. Even if that will only help for others task in the
> same cfs_rq

Yeah, but it is worth the extra pointer chasing and branches?

Then again, I suppose we started all that with the idle_h_nr_running
nonsense :/
