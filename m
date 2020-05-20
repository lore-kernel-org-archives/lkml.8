Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1725C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7505A206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HACMClLg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgETLDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETLDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:03:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52835C061A0E;
        Wed, 20 May 2020 04:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VNz0a2EJj80b4yeRQXHVRRn3nEHHKr03ijj9QvQzWgw=; b=HACMClLgVKLQEUF7EKFXvEb1cy
        1Lk9V8pnMfXwLY407L0lnny9mSZtKC8kQ7gw1b+b+D8D0SBJWuLPqCm8Pr5cuCVy6Brer5QF5bUx6
        8rGK+97dKCunJglGFg6pLAP66awTkvWhqgMKUxv/EYi4YdTN19YiUGU9E3MhxA8IsvpO7nEzI+8nn
        dbQGU9XfqCPcjfN8EUHXFQlRUGVL1UWH8VvFBUuZfZLkdZTwK4l1VASFU9VPPsFZm+IPvmPJbAKyt
        fa/tK6UrAQyhCU09gXfUrmNcRbVwYKn5rihAXcnAY3OQf3bMS/DwlXg2/E4w8P+gm+Iysk6XWZqRc
        voQxD5jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbMVI-0004qO-T0; Wed, 20 May 2020 11:03:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 152FD306089;
        Wed, 20 May 2020 13:03:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F1A6629D896D8; Wed, 20 May 2020 13:03:14 +0200 (CEST)
Date:   Wed, 20 May 2020 13:03:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Evgeniy Polyakov <zbr@ioremap.net>, netdev@vger.kernel.org
Subject: Re: [PATCH 6/8] connector/cn_proc: Protect send_msg() with a local
 lock
Message-ID: <20200520110314.GI317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-7-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:10PM +0200, Sebastian Andrzej Siewior wrote:
> @@ -40,10 +41,11 @@ static struct cb_id cn_proc_event_id = { CN_IDX_PROC, CN_VAL_PROC };
>  
>  /* proc_event_counts is used as the sequence number of the netlink message */
>  static DEFINE_PER_CPU(__u32, proc_event_counts) = { 0 };
> +static DEFINE_LOCAL_LOCK(send_msg_lock);

Put it in a struct ?
