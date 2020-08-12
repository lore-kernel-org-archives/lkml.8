Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96948C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B572076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HOramXFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgHLILG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgHLILF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:11:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E20BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 01:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=273dSJQbCcOMiq+fFE89MQrcZlFAGUoRnWDb1EWwM7U=; b=HOramXFjmkWvW9CgnJwJPceaQo
        4ivL6jDj9wYcYMgK5eUXLfaLtk/XpBTIb0qAN2G7ZbeaHZCsGFz5cqCq4UlSISCZ0UEvaY1KFkuVo
        Cd78HWN1hJRTsJWqcIWzCEUJjjmplxb+3sf9NGWku5bWTqB79TnSwGy0IyVc7r8Kyk3vzs6TcCLHM
        fuXyHuGoVBMwznnI9mHx+i84WeHpsfwWJ5y5hyF7cDQo4eAyLDMQGsEK8XxAFSRkMu9XCrpStSU1j
        O895kuzbHtxasueKidcxaiBh9MpsKxwWv6dFyU4aKgO1kFvHhrURwQAdNfdlr9rv5PI7tdOiw3Ygg
        QPuKZ8Jw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5lqd-0000V2-Op; Wed, 12 Aug 2020 08:10:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43D913028C8;
        Wed, 12 Aug 2020 10:10:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2F892220F91A1; Wed, 12 Aug 2020 10:10:57 +0200 (CEST)
Date:   Wed, 12 Aug 2020 10:10:57 +0200
From:   peterz@infradead.org
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     mingo@redhat.com, will@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] locking/rwsem: remove redundant semicolon of
 down_write_nest_lock
Message-ID: <20200812081057.GJ2674@hirez.programming.kicks-ass.net>
References: <20200811111852.190209-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811111852.190209-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 01:18:52PM +0200, Christian König wrote:
> From: Guchun Chen <guchun.chen@amd.com>
> 
> Otherwise, braces are needed when using it.
> 
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks!
