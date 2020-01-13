Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B654C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A44D214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578934116;
	bh=I3pCwFrEYhOyoSeIyVb525rkGpVzdanvyIQ5HUTW1xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2s8+ILczvQtfVHcb5iyhjhhHlCk7kws5o3L7ArgXD5J0d3gFAILBSQxk2e0DNerhJ
	 pSZq1cyTonax2pGreRfWL7beV0VRh8772sNzYH6RQELdten8IyVcPlPBoLs1kJVhhF
	 gEfpPvwrNjcmRkfpu39aaesD4sNpgv4OuAnIicqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbgAMQsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgAMQsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:48:35 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7D8720678;
        Mon, 13 Jan 2020 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578934114;
        bh=I3pCwFrEYhOyoSeIyVb525rkGpVzdanvyIQ5HUTW1xM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDmGLcYwmjusySW/+wTtAxLrekFoWM+e9Zb+fN9bdnwubkxlnXOVx0aeta5n1vet5
         4s6N6zNutce+C3GH6JFKtPCcWUl+GF4H7R4IxFvt0Ju0VIx2ZkmSPZ1fn9qiTwD95N
         JfZe3ca0EOLiF8HxM0fvH/zYdkXrTnoi7xOeTCt0=
Date:   Mon, 13 Jan 2020 16:48:29 +0000
From:   Will Deacon <will@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, yezengruan <yezengruan@huawei.com>
Subject: Re: [PATCH v3] locking/osq: Use optimized spinning loop for arm64
Message-ID: <20200113164828.GF4458@willie-the-truck>
References: <20200113150735.21956-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113150735.21956-1-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 10:07:35AM -0500, Waiman Long wrote:
> Arm64 has a more optimized spinning loop (atomic_cond_read_acquire)
> using wfe for spinlock that can boost performance of sibling threads
> by putting the current cpu to a wait state that is broken only when
> the monitored variable changes or an external event happens.
> 
> OSQ has a more complicated spinning loop. Besides the lock value, it
> also checks for need_resched() and vcpu_is_preempted(). The check for
> need_resched() is not a problem as it is only set by the tick interrupt
> handler. That will be detected by the spinning cpu right after iret.
> 
> The vcpu_is_preempted() check, however, is a problem as changes to the
> preempt state of of previous node will not affect the wait state. For
> ARM64, vcpu_is_preempted is not currently defined and so is a no-op.
> Will has indicated that he is planning to para-virtualize wfe instead
> of defining vcpu_is_preempted for PV support. So just add a comment in
> arch/arm64/include/asm/spinlock.h to indicate that vcpu_is_preempted()
> should not be defined as suggested.
> 
> On a 2-socket 56-core 224-thread ARM64 system, a kernel mutex locking
> microbenchmark was run for 10s with and without the patch. The
> performance numbers before patch were:
> 
> Running locktest with mutex [runtime = 10s, load = 1]
> Threads = 224, Min/Mean/Max = 316/123,143/2,121,269
> Threads = 224, Total Rate = 2,757 kop/s; Percpu Rate = 12 kop/s
> 
> After patch, the numbers were:
> 
> Running locktest with mutex [runtime = 10s, load = 1]
> Threads = 224, Min/Mean/Max = 334/147,836/1,304,787
> Threads = 224, Total Rate = 3,311 kop/s; Percpu Rate = 15 kop/s
> 
> So there was about 20% performance improvement.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/arm64/include/asm/spinlock.h |  9 +++++++++
>  kernel/locking/osq_lock.c         | 17 ++++-------------
>  2 files changed, 13 insertions(+), 13 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
