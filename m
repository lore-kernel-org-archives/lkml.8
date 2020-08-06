Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42B8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6B922DCC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NalefOka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730352AbgHFR1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729546AbgHFRBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B143C08EA0C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fVBnHUcFxQGjvxOa6RZAyjHA4KKJKA6BGBKM0Icu23A=; b=NalefOkaTW/5+O9kt3/ME+A+/S
        wqUiV4ev4go7Gn0R+sqowD4RwjR6/fY09Lha2ZgageW4yhT49toZCiB0ctmdHGDQ4htmOVfFOW5He
        Ycy+PybX6eEJ7jQksDhLlEf+s090tP8vH5/p0X9reCWrOPU/mX7ZqFhc9Ep73xA3fYNh409wkJf85
        iHfPzks0HAK1tJNtbVC95PQaZ7xxetO7SidA9S+0TbA5ffV1e+QEEOdpB7m8ankOAIpommV/iVeNY
        jSZpKkrW7LJ/GRIxJsWn8vtZzBQCrD3WC8WxNe2a329WZr5jaWpibDeHhrc/klaphqDYIg55SDO7r
        lL3XbzBA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3gFy-00043K-8q; Thu, 06 Aug 2020 13:48:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51832301A66;
        Thu,  6 Aug 2020 15:48:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 253CA213C4897; Thu,  6 Aug 2020 15:48:29 +0200 (CEST)
Date:   Thu, 6 Aug 2020 15:48:28 +0200
From:   peterz@infradead.org
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 1/2] membarrier: add
 MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU
Message-ID: <20200806134828.GA165568@hirez.programming.kicks-ass.net>
References: <20200806000859.160882-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806000859.160882-1-posk@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 05:08:58PM -0700, Peter Oskolkov wrote:

Thanks for the Cc!

> + * @MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU:
> + *                          If a thread belonging to the current process
> + *                          is currently in an RSEQ critical section on the
> + *                          CPU identified by flags parameter, restart it.
> + *                          @flags: if @flags >= 0, identifies the CPU to
> + *                                  restart RSEQ CS on; if == -1, restarts
> + *                                  RSEQ CSs on all CPUs.

> +	} else if (cpu_id == -1) {
> +		on_each_cpu(membarrier_rseq_ipi,
> +			    current->group_leader, true);

This is an unpriv IPI the world. That's a big no-no.

Double so because all you want to target is the current process, which
you're defining as CLONE_THREAD, where the rest of this file uses
CLONE_VM to define a process.
