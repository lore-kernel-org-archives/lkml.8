Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C409C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BA0206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 09:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FJwVClrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725797AbgIKJGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 05:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgIKJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 05:06:40 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB24C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 02:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2g5bF1yRhH4FB829TyXJnoHJ3SYJycvpB6cTDH7QYXE=; b=FJwVClrtg9ndy3uiHQfp6a7QhG
        wJ5jIa5oogPBFB6bGnxnaYOeLlTCOp5+8566y3MNjpkqAy6p56wtw02BH0eL2FibMkr63ivVKJGEO
        hVf1zPQWn6D7RXJgN+Vx7lfZToNDWytcz26wLVX6zjnQxWqq2W9mE6qI/kdgMjwjRVA14OVGANKvi
        OJn77pemSlkwfxAySh2PFpD3cCp4YR9L2fjIvdF1IYlwUYeoOacNgCWWNeS/+/PZHdxEZRDfbfx8y
        CpMQaTX/ZFMj2i+0i6TD8Ina9hzgSQx43e/NygkUlzc0qy07u721GhqHNx0BYuIjtLTGgJyvWqXie
        g19f4PKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGf0s-00082h-IT; Fri, 11 Sep 2020 09:06:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E21903012DC;
        Fri, 11 Sep 2020 11:06:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7BA22B06B001; Fri, 11 Sep 2020 11:06:32 +0200 (CEST)
Date:   Fri, 11 Sep 2020 11:06:32 +0200
From:   peterz@infradead.org
To:     qianjun.kernel@gmail.com
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com
Subject: Re: [PATCH 1/1] kernel/sched:use the enum code replace of the int
 variable
Message-ID: <20200911090632.GC1362448@hirez.programming.kicks-ass.net>
References: <20200907130502.44200-1-qianjun.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907130502.44200-1-qianjun.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:05:02PM +0800, qianjun.kernel@gmail.com wrote:
> From: jun qian <qianjun.kernel@gmail.com>
> 
> It is hard to understand what the meaning of the value from
> the return value of wakeup_preempt_entity, so I fix it.

> @@ -6822,9 +6828,9 @@ static unsigned long wakeup_gran(struct sched_entity *se)
>   *         g
>   *      |<--->|c
>   *
> - *  w(c, s1) = -1
> - *  w(c, s2) =  0
> - *  w(c, s3) =  1
> + *  w(c, s1) = NO_NEED_PREEMPT
> + *  w(c, s2) = MAY_NEED_PREEMPT
> + *  w(c, s3) = NEED_PREEMPT
>   *
>   */

Yeah, I don't think so. The function is a simple C style compare,
where negative is less, 0 is equal and positive is more than.


