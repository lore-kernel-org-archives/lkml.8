Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D9623119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PRI5tz1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgHFRKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgHFRFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DA1C03460E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P6qNlBkvQK38nzWUjveHhnAF0NGDmv9N0Zynt0nU5t8=; b=PRI5tz1IQQhX/xPAWyOweJIlTg
        6k7lzo+ye+6vBBhBZzLQg1PE10oWeu2DD2nzMbE9ubTPZpqw/vCg581NoAcKJwdYLN9E1L+FKayES
        YN2wWuc7NuBhSlyXX4pkgl9+A1IBlIyHq3ePsOSnFmmPuyGFC0BdC16tAJuOOId34zN5aZ569aQtw
        fwNqGbE07KimU9grnGpg3o+h4b/riFehPU/WnoRB+N8KJAfGmFRC7Xt3YKTMGAPoX/yel/RRRt3jy
        cNGjDECRY1VGdgol/p7VL9BHYGjINK0rVbtblUEPoPjPk0rNUdIkUvvbbCQlqz5BqZ2HE37ClmKdf
        DcUl6mdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3fK8-0001HA-Ab; Thu, 06 Aug 2020 12:48:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 00D43300446;
        Thu,  6 Aug 2020 14:48:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E633F213C48B6; Thu,  6 Aug 2020 14:48:42 +0200 (CEST)
Date:   Thu, 6 Aug 2020 14:48:42 +0200
From:   peterz@infradead.org
To:     Will Deacon <will@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/2] sched: membarrier: cover kthread_use_mm
Message-ID: <20200806124842.GB2674@hirez.programming.kicks-ass.net>
References: <20200728160010.3314-1-mathieu.desnoyers@efficios.com>
 <20200728160010.3314-2-mathieu.desnoyers@efficios.com>
 <20200804145145.GM2657@hirez.programming.kicks-ass.net>
 <1708074166.39992.1596553173337.JavaMail.zimbra@efficios.com>
 <20200804170153.GO2657@hirez.programming.kicks-ass.net>
 <20200805105920.GB35926@hirez.programming.kicks-ass.net>
 <498869868.209.1596640956570.JavaMail.zimbra@efficios.com>
 <20200806080351.GA31889@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806080351.GA31889@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:13:46PM +0100, Will Deacon wrote:
> I'm not sure I really see the benefit of the rename, to be honest with you,
> especially if smp_mb__after_spinlock() doesn't disappear at the same time.

The reason I proposed a rename is because:

	mutex_lock(&foo);
	smp_mb__after_spinlock();

looks weird. But, afaict, it will work as expected. As the only possible
way to implement any lock() is with atomic*_acquire() or stronger.

Another possible name would be: smp_mb__after_lock().
