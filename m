Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A735C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515782082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GPgGS/kF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgDVLjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgDVLje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:39:34 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89870C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9ZYRrFubhKWBZR+DG11ZexWw9V1Lf4rMr1vskSDfSak=; b=GPgGS/kFC6XKQzNVPukF7TtJ4s
        I72GsodKHX3RxXma+WjL/SyZL7NWtr8ab7bnbTlPAGEv9zE4xf3Bhy0ttTXP0gd4UZL8Bsvy1T05m
        zrzJMSo40PKhcsZd7X2hSJAqWcuEwwiTaw8n1nIj05Y/fG7U85UIgbPxWmU9tcRaHcCFRSoGuD/6Y
        8i2H2fqCqzuy6ZVPcH6MZT7b08XoZR4KwJprQxr1h2f6bLwirdrqMS0WUVgm8n6mjaGZQBfgWHhYE
        1Tha3MlV7x3bK+zjCGiBZ7mJd3hP6PlwSpmgZVYyPvF9o8uLMupN8KL1Z3iuRBZeOKWtPV1Ofm+JP
        pU/RPSyA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDib-000753-4F; Wed, 22 Apr 2020 11:39:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DF3BD306831;
        Wed, 22 Apr 2020 13:39:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C8C6F203AA838; Wed, 22 Apr 2020 13:39:03 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:39:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH 17/23] sched,irq: Convert to sched_set_fifo()
Message-ID: <20200422113903.GB20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112832.224090625@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.224090625@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:36PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively no change.

That's ofcourse a flat out lie; I wrote this before I noticed that -1
thing. It most definitely changes that. I also only noticed this while
reading through my own copy after sending :-/

> @@ -1281,13 +1278,12 @@ setup_irq_thread(struct irqaction *new,
>  	} else {
>  		t = kthread_create(irq_thread, new, "irq/%d-s-%s", irq,
>  				   new->name);
> -		param.sched_priority -= 1;
>  	}
