Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A88C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0A721744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k3tYxhUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgBDMsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:48:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:36082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgBDMsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5fwobFPVYN213YdlVAmil0OJKWX6BVgg2KRIst+6wT8=; b=k3tYxhUQAvDE80kMRro9n/8rhb
        WpCetLg2fS9WIEGYedeVBhOPhST+lNVq+Bnp8aYadyVVcHhZ+Mjv7/CGBM2sGZDoqlyJFT2/qKTUJ
        7p704Un/oNZgpsE3tretoQ9/9OBfrG8lEIdsiN8j8YFtHlR9x8A0MCT23Izy/PQMtiyspXilhD0Gm
        He9PRPZxvB4fvThevPU8QHMlp5Q1fIX8I0oRA1uB9k/wDFTj9fJU1GIEwbiNZCIOb0N0ZI71Z0HZ7
        Xjv2LoohEZ3bj1KzlY9P+1Axw/qFRgUVAv4Ft8w9tBS1QuJDKq4W0kNsa+L3Dow13COP4PAdj0wbM
        QqpJzcVA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyxcX-0002J5-Ln; Tue, 04 Feb 2020 12:48:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59A3E304C21;
        Tue,  4 Feb 2020 13:46:14 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CE5042B76A662; Tue,  4 Feb 2020 13:47:59 +0100 (CET)
Date:   Tue, 4 Feb 2020 13:47:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 7/7] locking/lockdep: Add a fast path for chain_hlocks
 allocation
Message-ID: <20200204124759.GP14914@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-8-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203164147.17990-8-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 11:41:47AM -0500, Waiman Long wrote:
> When alloc_chain_hlocks() is called, the most likely scenario is
> to allocate from the primordial chain block which holds the whole
> chain_hlocks[] array initially. It is the primordial chain block if its
> size is bigger than MAX_LOCK_DEPTH. As long as the number of entries left
> after splitting is still bigger than MAX_CHAIN_BUCKETS it will remain
> in bucket 0. By splitting out a sub-block at the end, we only need to
> adjust the size without changing any of the existing linkage information.
> This optimized fast path can reduce the latency of allocation requests.
> 
> This patch does change the order by which chain_hlocks entries are
> allocated. The original code allocates entries from the beginning of
> the array. Now it will be allocated from the end of the array backward.

Cute; but why do we care? Is there any measurable performance indicator?
