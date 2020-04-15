Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB697C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 886B720774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XEanGyi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732421AbgDOWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbgDOWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:41:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515D2C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MfAhd2AFu2QXH3S4BVwk03/dyFg3ovn8+AyQh0tOOWo=; b=XEanGyi02aSX1Q6E6BFQGYPH+o
        so0waCzAjX38upxvf8opM3+KafQ8WBh/A5eXonqup2pGLoCdVKTwQu3cl8e6yyqC3Qlo8mONhs65D
        QUNAvpSAvTe9UHKXQ3v3RHQR94syVUZMnjEloOUt7yhBalmupeMvM/J6tqtzxnBi6QZfsWI6ibvOw
        baiImdu+qA2ZGZtVmNzeLcy8e83Nt7QFsw4TO/TFKTKVYKiSPfGBCISM9UNu8zP7TAV7veLBsGy5V
        bNrTZbHOlWoUZKNeFIxRtqIr7BMJfDCbwRkJOaTvBvveKLJ4e2Of9B41k48q0ib1OJKMxx1mQE+37
        /M3CjxsA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOqiJ-0006sH-9u; Wed, 15 Apr 2020 22:40:59 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0D61981086; Thu, 16 Apr 2020 00:40:56 +0200 (CEST)
Date:   Thu, 16 Apr 2020 00:40:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     John Stultz <john.stultz@linaro.org>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: On trace_*_rcuidle functions in modules
Message-ID: <20200415224056.GO2483@worktop.programming.kicks-ass.net>
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home>
 <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415161424.584d07d3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 04:14:24PM -0400, Steven Rostedt wrote:
> Which was added because the rcuidle variant called RCU code that was not
> exported either. Which would have the same issue now as
> rcu_irq_exit_irqson() is also not exported. Which would be needed.

Keeping all RCU_NONIDLE code in the core kernel allows us to eventually
clean it all up. Allowing it to escape into modules makes that ever so
much harder :/
