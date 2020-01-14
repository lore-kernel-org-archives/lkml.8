Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A73CC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FD9207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fqSDkfXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgANJxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:53:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SzSoD7zCa4/4rPUpOhc7k7YrpP9EOsOkg/gX0UD38uU=; b=fqSDkfXBgKr/vaEpLHVLlrf/v
        qwEVjZdmegMZ24c5esSroszL2qSujmuHWmglOlBB14o4Z2x7uuWrlbaLMHPR+3BS2O8XhD1YikIVd
        RK2GwTdGYTeZSKBcuYJXadbG5rFICoccYVRPJOsNCzp177ZVODvczbc4RiEfooBHhkoMWtIZQv2Sc
        8uS7k804qtv5b0ULi0woVNdz0J38peHo2lTNAH4jN5/NimZnfCsyb03+wHOnUaKsgHOsv3tLqQAjs
        nEZmxq8CCxYpAlaY+OQeqLPaL3JvQN0hbzCraMXXPuERpoe4E/zmQ0kHxnI8v6Z04jt/OL7qoDafy
        zARGN2Q/w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irItP-0005f0-TO; Tue, 14 Jan 2020 09:53:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECBFF304123;
        Tue, 14 Jan 2020 10:52:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0C5F20B79C98; Tue, 14 Jan 2020 10:53:45 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:53:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2 5/6] locking/lockdep: Decrement irq context counters
 when removing lock chain
Message-ID: <20200114095345.GB2844@hirez.programming.kicks-ass.net>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216151517.7060-6-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 10:15:16AM -0500, Waiman Long wrote:
> There are currently three counters to track the irq context of a lock
> chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
> They are incremented when a new lock chain is added, but they are
> not decremented when a lock chain is removed. That causes some of the
> statistic counts reported by /proc/lockdep_stats to be incorrect.
> 
> Fix that by decrementing the right counter when a lock chain is removed.
> 
> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
> Signed-off-by: Waiman Long <longman@redhat.com>

Fixes go at the start of a series, because if the depend on prior
patches (as this one does) we cannot apply them.
