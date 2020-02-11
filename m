Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF24C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F602086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3lKc31l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgBKLoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:44:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57376 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbgBKLoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:44:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=yb5GHOYrvDrCPir3S3dAXtord7YBH2nReoEjVbLnpig=; b=M3lKc31lknavQUHl06nQY2QRQO
        qlGAI27iPRTxB+Id872djWTSS4ech519C/GmkV0ux837l/B0ikq1+3HwIl8k9wG62YFv8KcNZOGsu
        y+6M0KTIuc9Mjer5oTwcFw85F+X04LrJqzZtDmmAp4/TPXxKavDwPetpPYLznkxGeawDA5+H2U0P5
        V1gAijwgQKCGfIf20X0shkg8h832U6Id+F5IfykQaNdbr8lowCMXO/c8OnS2gvssx0wk0OP4xzPtx
        L489J/7ZRwoXzlJv3LKXCRsgJ4veqAE/1Ldx94+r/smA4BhidxIvmt7l4gnHD+/FlhPvNxsWnf030
        JRJBSFTg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1TxJ-0001GO-0D; Tue, 11 Feb 2020 11:43:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ABE56300446;
        Tue, 11 Feb 2020 12:42:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 55D832B88D75A; Tue, 11 Feb 2020 12:43:50 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:43:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?utf-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] why can't dynamic isolation just like the static way
Message-ID: <20200211114350.GJ14914@hirez.programming.kicks-ass.net>
References: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fed10a26-7423-23b5-316c-c74d354870dd@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:17:34PM +0800, 王贇 wrote:
> Hi, folks
> 
> We are dealing with isolcpus these days and try to do the isolation
> dynamically.
> 
> The kernel doc lead us into the cpuset.sched_load_balance, it's fine
> to achieve the dynamic isolation with it, however we got problem with
> the systemd stuff.

Then don't use systemd :-) Also, if systemd is the problem, why are you
bugging us?
