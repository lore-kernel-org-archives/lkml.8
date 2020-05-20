Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28911C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E678C207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 13:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3ha7/j71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgETNwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 09:52:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45330 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 09:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yBybNw2E8Wk9T2bxznOviopA8hXH53LZwxJyPHMtaDE=; b=3ha7/j71/xP3wJoW7+nDofZrSi
        PPVOmUHmIdooz2qhok0HrC0KDAo6KNsgHowMQ0jA0uZV4DfvJFJa/pgqx8BFXn4O9rF27ze9AUa1E
        hD0d9AuQyltjP3jFj9biw0x3OGlJ+lP+AFwXdAXvGu36VjpiSnw1l2bif+PTexmjcdJWJTys5iASI
        SxQJa9K+3xn8UDseoXoYXunmEU5HZdWpnX1+iGO922sMh1TaufOu6i2/ZgrSyZmutryGAX+/fvrbW
        +uJG7iMGh/RLO71rrVYSzfyANsUj3DCHPj9MHC24bjWepzgmt4DDHE9bBmtEPZs9w+NHmTalb4XmB
        qEWc6mFQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbP8X-0001wC-Jw; Wed, 20 May 2020 13:51:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6638B305EEE;
        Wed, 20 May 2020 15:51:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51F4C29DB5073; Wed, 20 May 2020 15:51:56 +0200 (CEST)
Date:   Wed, 20 May 2020 15:51:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wojciech Kudla <wk.kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <namit@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] smp: generic ipi_raise tracepoint
Message-ID: <20200520135156.GO317569@hirez.programming.kicks-ass.net>
References: <02b57f31-fc0c-df35-57bf-e0a297a7e6c4@gmail.com>
 <20200520133350.GN317569@hirez.programming.kicks-ass.net>
 <a9fbbf7d-28cd-2119-8519-2f1cd045acda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9fbbf7d-28cd-2119-8519-2f1cd045acda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 02:42:10PM +0100, Wojciech Kudla wrote:
> On 20/05/2020 14:33, Peter Zijlstra wrote:
> > We have bright shiny links like: https://lkml.kernel.org/r/$MSG-ID for
> > that. they allow me to go find the email in my local archive without
> > having to use a browser.
> 
> Apologies, beginner's mistake.
> 
> >> +static const char *ipi_reason_missing __tracepoint_string = "";
> > 
> > That is a pretty crap reason ;-)
> > 
> 
> I knew this was a long shot. There is no obvious way to 
> get/infer ipi reason in generic smp code at the moment.
> Any suggestions what we can put here in the meantime?
> Would "none" be more appropriate?

Depends a bit on what you actually want to achieve here.

For actual proper debugging this stuff I think I'd find it more useful
to have tracepoints one level up. So instead of tracing the IPIs, trace
the actual remote function call requests.

And in that case, trace the mask and the symbol name from csd->func.

And if you have that, who cares about the actual IPIs.
