Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF76C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E6B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 11:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KN7athog"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgHJLoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgHJLoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 07:44:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7627C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 04:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dCq63aAsnYpPi+BbUUGumNHkJsEFdrzn5bunN7eRJEs=; b=KN7athogTCeWhdM/XptnAhX0Ls
        01qULyxQqA8zpYNxgfGH77DNgJaoFcdplPA6fYGl74B0CEeW8CsI7W3iQNIZ9hJNctzLeNxvzUfku
        oh5rs/DwGUm3EBacGnYz0TjBpGAc/zS1ngFPfUtgyAOjarqBuweK9MJYaweOdDwb1uRBJRxmuMhpT
        SpEIw8AxqDaQZNO4rpRHMn++7oHGl4pIeK3m6SR2jaD7gkCEWHGWJOdJ1B8oAZvzFA90d/2N3X0Uv
        Ep/lehedvkjhxzvEQEpMlPa3f484xqxv8bBJZVxReW5JtS4MsLhhmNpUXj5AWltVyEGMn6Ge+x4yZ
        COnWTUwQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k56Do-0005Dc-A0; Mon, 10 Aug 2020 11:44:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 268E73003E5;
        Mon, 10 Aug 2020 13:44:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 18E4923D39366; Mon, 10 Aug 2020 13:44:07 +0200 (CEST)
Date:   Mon, 10 Aug 2020 13:44:07 +0200
From:   peterz@infradead.org
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH] kernel: update callers of task_work_add() to use
 TWA_RESUME
Message-ID: <20200810114407.GT2674@hirez.programming.kicks-ass.net>
References: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10debfb3-25f2-20ed-d4f3-1d95ba4c2129@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 03:43:50PM -0600, Jens Axboe wrote:
> Any pre-existing caller of this function uses 'true' to signal to use
> notifications or not, but we now also have signaled notifications.
> Update existing callers that specify 'true' for notify to use the
> updated TWA_RESUME instead.
> 
> This was noted in the original commit as well:
> 
> e91b48162332 ("task_work: teach task_work_add() to do signal_wake_up()")
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

How do you want to route this?
