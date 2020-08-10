Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433D1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DB820678
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDrvFkZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHJOF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbgHJOF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:05:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1DDC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZBc+/YOmjIeOWsaVl88aN/V8Z9J1FCPxp/62QmQAdJY=; b=SDrvFkZbH4Sie6NNE30e4trK6Q
        qfPOYOmzAR4zUXiaxzxZy50j0k07m78fl8nNzTfDp1Z6nnCJTq9XyFgY49ujw5w20tubOrqNFArCD
        C5B/WrckmaKiNoTLKy1zqN9G9lr3TDtpcT41u1pwGscBfKP+pBGsPxfkgTCTw+W9Nu4F0/zO3Fmpt
        Trx6QeEwP8gzw/mz7lPOrzm34wF8gdUeOVqvbikVzJO4cz4WNOyWw+7OVmchqOET3/Q60TC9yMnRU
        AFqxwnJm7hS3jGZNxroG9rajZVlyUh4cd87zSoPGRIMv+2lnpyQDKX6Nwg9/XqnBHCQ0LPUe/HkK6
        WTyx66nA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k58QR-0002Oc-7j; Mon, 10 Aug 2020 14:05:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C30DA300DAE;
        Mon, 10 Aug 2020 16:05:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 95AC5200D415D; Mon, 10 Aug 2020 16:05:15 +0200 (CEST)
Date:   Mon, 10 Aug 2020 16:05:15 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, vincent.guittot@linaro.org, mgorman@suse.de,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        patrick.bellasi@matbug.com, tglx@linutronix.de, rostedt@goodmis.org
Subject: Re: [PATCH] sched/fair: Fix wrong negative conversion in
 find_energy_efficient_cpu()
Message-ID: <20200810140515.GY2674@hirez.programming.kicks-ass.net>
References: <20200810083004.26420-1-lukasz.luba@arm.com>
 <jhjy2mmhhq6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjy2mmhhq6.mognet@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:18:25PM +0100, Valentin Schneider wrote:
> 
> On 10/08/20 09:30, Lukasz Luba wrote:
> > In find_energy_efficient_cpu() 'cpu_cap' could be less that 'util'.
> > It might be because of RT, DL (so higher sched class than CFS), irq or
> > thermal pressure signal, which reduce the capacity value.
> > In such situation the result of 'cpu_cap - util' might be negative but
> > stored in the unsigned long. Then it might be compared with other unsigned
> > long when uclamp_rq_util_with() reduced the 'util' such that is passes the
> > fits_capacity() check.
> >
> > Prevent this situation and make the arithmetic more safe.
> >
> > Fixes: 1d42509e475cd ("sched/fair: Make EAS wakeup placement consider
> > uclamp restrictions")
> 
> I was going to say that might even go as far back as:
> 
>   732cd75b8c92 ("sched/fair: Select an energy-efficient CPU on task wake-up")
> 
> but we had a capacity fitness check in the right place back then, which I
> screwed over with that uclamp_rq_util_with() :/
> 
> LGTM, thanks for figuring that one out.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks guys!
