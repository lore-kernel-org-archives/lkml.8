Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DAC4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D8C6206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 08:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EfJ17X+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgFEIKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 04:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgFEIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 04:10:54 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0203AC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 01:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LYbrvHl+6WGEwIJSwoPQG9jzYvDaEq0yN9w5xqYNTiM=; b=EfJ17X+OT8Hy1PtSBIVdh/CyUL
        AMq23Ad0Hv4Y3bwVg/LQRXnq9y9C2FOm0piheCNLeibLBtCSETEE+7oFFlYkeRzgG9Ytj5nQyvEsM
        b+F6LWh/R2WeK8J7QsIwyOjiO/iDI+Xyw9NMWVFV5z/h40dFEyg6kGp5v1v3lawLB9UDX67Bwz56a
        mukBjxFqaHOhH/wFa+V4c3dyO3beZzVvmdhL+ViFt7lQH006Sm0uvAytJdkZ6JtL9MN2LOB7kYGSf
        +ZkUTUXV0FF5F4YqRpvmEedwspx57BwoqwWy03/Acnb4DkbOdyaSOhP/1vwhLNKYc6TP4ra9IIqL/
        pxS6scWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jh7Qt-0002Sa-Tr; Fri, 05 Jun 2020 08:10:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 15018304BDF;
        Fri,  5 Jun 2020 10:10:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F28D020CC3FCD; Fri,  5 Jun 2020 10:10:28 +0200 (CEST)
Date:   Fri, 5 Jun 2020 10:10:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     tglx@linutronix.de, frederic@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, cai@lca.pw,
        mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200605081028.GC2750@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604141837.GA179816@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
> On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:

> > +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> > +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> > +
> 
> There is no guarantee in C that
> 
> 	type1 a;
> 	type2 b;
> 
> in two different data structures means that offsetof(b) - offsetof(a)
> is the same in both data structures unless attributes such as
> __attribute__((__packed__)) are used.

Do tell more; the alignment requirements and size of the types remains
the same, this resulting in different layout is unlikely.

I found this excellent quote on Hacker News this morning:

 "I think the attitude of compiler writers is a good reason to fix the
  spec so they can't keep ratfucking developers trying to get work done."

> As result, this does and will cause a variety of build errors depending
> on the compiler version and compile flags.

The only thing I can think of that's actually a problem is that retarded
struct randomization stuff.

Anyway, I'll move cleaning it up a little higher on the todo list.
