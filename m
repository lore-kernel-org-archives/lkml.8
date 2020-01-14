Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FC9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BBF2465B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o/xjIevW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgANKCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:02:42 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41060 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbgANKCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DyoJ2hA1fU1X63Qmz1hq0mnr1uqWmaszLSaW5lT0+iI=; b=o/xjIevWfUgEeraf8BCj8KgN3
        YkxD+ytudJ1eE7zpSCVU/jnmToR85ngrnVeb87obRoSGaIbr1tb8xIEdBzQuDzzK3iBbIuC09Aj4n
        rNRIFAZx8dEyQ7qa9nq/VKMa57fF/KONbVUbXtdTNQJ2o2XHE9cAmBgzcYLBfCSbD3PbRrk1wbWL/
        7LMHJBTg+6m+86p8GW6cGfNSB5TzX9ekTKQ8gGaAOdyjh0pf1fKJ41zx/wMqtXWUbPEIv914jgJkV
        NSZ9GHlp1SEEbflQFHRzugy8DuajSukBxpb0MgfN5FkFpCNupyrQs7b0GsGDnW7ow/+ntTLEeGz7m
        Cb0NtJJcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irJ1m-0003IE-TS; Tue, 14 Jan 2020 10:02:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E66793058B4;
        Tue, 14 Jan 2020 11:00:48 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6E1A12B6AFB83; Tue, 14 Jan 2020 11:02:24 +0100 (CET)
Date:   Tue, 14 Jan 2020 11:02:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Hewenliang <hewenliang4@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idle: fix spelling mistake "iterrupts" -> "interrupts"
Message-ID: <20200114100224.GC2844@hirez.programming.kicks-ass.net>
References: <20200110025604.34373-1-hewenliang4@huawei.com>
 <20200113160413.5afcfbd7@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113160413.5afcfbd7@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:04:13PM -0500, Steven Rostedt wrote:
> 
> Peter,
> 
> I guess you could just pull this into one of your queues.

Only because you replied, otherwise I tend to ignore such patches.

