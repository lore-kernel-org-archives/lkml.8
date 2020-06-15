Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CCBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34F4C20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GFkQ5RL+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgFOTMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731282AbgFOTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:12:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C808C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZUbQNFtJJ5oWctDIi257Z145m0yZxLqv7a/pMBuhmH0=; b=GFkQ5RL++oqCThVe5FU1vNGskh
        DRFJLD7hXu0Av34tBvocuu4kdTII5HLuCCCRFxbzmvc0peqS5sbQRizZME415dOTqOvWb2EPc5bfE
        3SgPZ8BTN1DEr0aFIJlq2KPIOsXru6bKDNVcz+Z1WItRc7lhlaYE84+LFfXLZm2W+vU7LVo2lN5ml
        Ug7d4vzv2lNzsk+FlIegaZfcqnBWtNxjCin2wCskSy6c4byWQNVfpZ9BWRQkLYCOqN3Y0PtX6otpS
        ozGzB2gEO+xGdf3UqFNlPyAMoxGxeTmncjQUaEfLyASWptEMLjRW68d6eic7Up6HbQXroTRe3tV+A
        B7q4x9yQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkuWW-0006U1-Dd; Mon, 15 Jun 2020 19:12:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AA8533028C8;
        Mon, 15 Jun 2020 21:11:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 94F83203D5DCD; Mon, 15 Jun 2020 21:11:58 +0200 (CEST)
Date:   Mon, 15 Jun 2020 21:11:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, frederic@kernel.org
Subject: Re: [PATCH 0/6] sched: TTWU, IPI, and assorted stuff
Message-ID: <20200615191158.GK2531@hirez.programming.kicks-ass.net>
References: <20200615125654.678940605@infradead.org>
 <20200615162330.GF2723@paulmck-ThinkPad-P72>
 <20200615164048.GC2531@hirez.programming.kicks-ass.net>
 <20200615172149.GJ2723@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615172149.GJ2723@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:21:49AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 15, 2020 at 06:40:48PM +0200, Peter Zijlstra wrote:

> > Thanks! I've got 16*TREE03 running since this morning, so far so nothing :/
> > (FWIW that's 16/9 times overcommit, idle time fluctuates around 10%).
> 
> My large system as large remote memory latencies, as in the better part
> of a microsecond.  My small system is old (Haswell).  So, just to grasp
> at the obvious straw, do you have access to a multisocket Haswell system?

I've been running this on a 4 socket haswell ex.
