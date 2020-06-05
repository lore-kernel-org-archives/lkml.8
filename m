Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7600C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B08207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fkS2cr5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgFEHmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEHmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:42:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8AAC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 00:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WfTFm3/eB1+NUrxat4uJLZB17ECFEZtaFdMoB+Mi/pk=; b=fkS2cr5F6InIKXBE9MIE9gbAFt
        9hO+4u+MuyiA+SRxrltZctmJing1US6hE+BO6/kPjwmiguewSTrzg/yB7sSoVH3KM41J+MnJdK+k4
        Ra6YNbXAy39UuY+VXcwYnkGwuHZWcoIWi90n8ENI7PxqU8C9LDjtRXV2zYZqrEtE0U3QlITLyahAa
        ApVfE8KdtGuM3qUdn1/Wl0RyJ+zz0oRI9KySc6I76EM5FGf/tbvWiKJLvMY8qiYIpB7n6hMeE8Du0
        9DgAYS/+kob/88gL9oekuZNqNj6u7AS63lT4G6sFFXk8s6ECV71T8Tyk2XqvF7A5Gpd+YO++/CBvJ
        RpPsBdTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jh6zF-0004sG-QX; Fri, 05 Jun 2020 07:41:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0724F301ABC;
        Fri,  5 Jun 2020 09:41:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA3C320707D3B; Fri,  5 Jun 2020 09:41:54 +0200 (CEST)
Date:   Fri, 5 Jun 2020 09:41:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200605074154.GB2750@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605002433.GA148196@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 05:24:33PM -0700, Eric Biggers wrote:
> On Thu, Jun 04, 2020 at 07:18:37AM -0700, Guenter Roeck wrote:
> > On Tue, May 26, 2020 at 06:11:04PM +0200, Peter Zijlstra wrote:
> > > The recent commit: 90b5363acd47 ("sched: Clean up scheduler_ipi()")
> > > got smp_call_function_single_async() subtly wrong. Even though it will
> > > return -EBUSY when trying to re-use a csd, that condition is not
> > > atomic and still requires external serialization.
> > > 
> > > The change in ttwu_queue_remote() got this wrong.
> > > 
> > > While on first reading ttwu_queue_remote() has an atomic test-and-set
> > > that appears to serialize the use, the matching 'release' is not in
> > > the right place to actually guarantee this serialization.
> > > 
> > > The actual race is vs the sched_ttwu_pending() call in the idle loop;
> > > that can run the wakeup-list without consuming the CSD.
> > > 
> > > Instead of trying to chain the lists, merge them.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > ...
> > > +	/*
> > > +	 * Assert the CSD_TYPE_TTWU layout is similar enough
> > > +	 * for task_struct to be on the @call_single_queue.
> > > +	 */
> > > +	BUILD_BUG_ON(offsetof(struct task_struct, wake_entry_type) - offsetof(struct task_struct, wake_entry) !=
> > > +		     offsetof(struct __call_single_data, flags) - offsetof(struct __call_single_data, llist));
> > > +
> > 
> > There is no guarantee in C that
> > 
> > 	type1 a;
> > 	type2 b;
> > 
> > in two different data structures means that offsetof(b) - offsetof(a)
> > is the same in both data structures unless attributes such as
> > __attribute__((__packed__)) are used.
> > 
> > As result, this does and will cause a variety of build errors depending
> > on the compiler version and compile flags.
> > 
> > Guenter
> 
> Yep, this breaks the build for me.

-ENOCONFIG
