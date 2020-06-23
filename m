Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C58C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3FD21548
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="seG8hXT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392676AbgFWUrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403862AbgFWUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:47:07 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2310AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sa3zU/E2E+o3LzbXQSq1d8ASG89gLQ+b6CLyD1I/MBY=; b=seG8hXT4NqAZvw/1mnzbkZNPAg
        RbtlmqHk+oTwn+iwx73W/h9Mc05VwHyX2korERXw+rexNiXWOzvUtrf9xoYxyD6IicUnx00dz138V
        iaz9EfQr+20tBly7oOdlyKehpuMx1IZ4wcEzP8w3rQcUQseHxLMB5wz6uB7VXWomf7G75xGsMuaeK
        U7VHynYSoh9fu15LMnbS3LLPTL8lPd6T4Via4rut0twAmfqk+iNSj8iKM9fy0eUCthmsP9s1dmKya
        xfo5fkndq5OT3VXrru+MajbGau+vqTKREmb1Oyn4s1jMK4FXcydu/ZiPPsqmjWkygCK+0wHji6tn2
        yczndSpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnpod-0004zR-4d; Tue, 23 Jun 2020 20:46:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 450AD983A87; Tue, 23 Jun 2020 22:46:46 +0200 (CEST)
Date:   Tue, 23 Jun 2020 22:46:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     tglx@linutronix.de, x86@kernel.org, elver@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        will@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com
Subject: Re: [PATCH 2/9] rcu: Fixup noinstr warnings
Message-ID: <20200623204646.GF2483@worktop.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603114051.896465666@infradead.org>
 <20200615154905.GZ2531@hirez.programming.kicks-ass.net>
 <20200615155513.GG2554@hirez.programming.kicks-ass.net>
 <20200615162427.GI2554@hirez.programming.kicks-ass.net>
 <20200615171404.GI2723@paulmck-ThinkPad-P72>
 <20200619221555.GA12280@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619221555.GA12280@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 03:15:55PM -0700, Paul E. McKenney wrote:

> Just following up because I don't see this anywhere.  If I am supposed
> to take this (which is more plausible now that v5.8-rc1 is out), please
> let me know.

Sorry, I got distracted by that NULL ptr thing, but that seems sorted
now. If you don't mind taking it through your rcu/urgent tree for -rc3
or so that would be awesome.
