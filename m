Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B585AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E892080D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pobi59e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgGVXat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVXas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:30:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4E5C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=de/tJeQhP65ikK83iH/wSqO/5k0FS3pQV+HdHxLvnEg=; b=pobi59e4n6D+xl1d+h1ViKa8z5
        v3JY4S9nNKWB0o2eTmrLGbzIQN6uf5OMCSP82LgC/QHO2jBdrbOhongwdQmUNStaL7K6Ho4y/Usim
        BI/xK8Ib3t+MfTD9BSi7zZhfon6u63pWMA5MRJEldt5gWbLOMTd4qg5b02DK6g3iOMy08M/uali3B
        YMbZY7dxz9w13wZ2KVZsQ7mIkLwNtJawNwQ5qVEI4qlnvGuYS7Q4SeTvtsZJWQE9+mbQU4X860nn/
        4NIDZ5imBB6HZZMoSqe4SMZo66h6px7dw8AIYNteSb+Gs9VQ/HEKD1WLj/sbObSnI2Izw96ozZrTN
        4eYi+o/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyOC0-0008Fn-Vc; Wed, 22 Jul 2020 23:30:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D9483006D0;
        Thu, 23 Jul 2020 01:30:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A4832B22AB90; Thu, 23 Jul 2020 01:30:31 +0200 (CEST)
Date:   Thu, 23 Jul 2020 01:30:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, will@kernel.org, hch@lst.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, davem@davemloft.net,
        kuba@kernel.org, fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 0/9] smp: irq_work / smp_call_function rework
Message-ID: <20200722233031.GQ10769@hirez.programming.kicks-ass.net>
References: <20200722150149.525408253@infradead.org>
 <20200722205153.GB23360@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722205153.GB23360@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:51:53PM -0700, Paul E. McKenney wrote:
> And scftorture doesn't much like the full set of patches.  Though this
> is early enough during boot that I am not sure that scftorture had much
> chance to do any real damage.

Thanks for taking them for a spin; I've only barely boot tested them. I
figured I'd ask for feedback before sinking too much time into it.

I'll go look at the fail in the morning.
