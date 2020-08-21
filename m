Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66F2C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598008430;
	bh=Q2OJPNVv8D0Bkrc+kM7MKWSuNVHxls/8c/7E13LWptQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1YlJLLsLDMRocbh/VbyAhBgGmJdn9cu3vHKDgvnOjohHDXraTuBrPL0JTBngBOnlb
	 dToZkEJpw8ugL5v0gqV5X8wHoIQzYnHhIOhQpLHw8/Ahp/1AVFQKgb269XQeQKh/Nn
	 LrYmfzn/DtO3FLQQcNxAKUXt4tmL9gKSMkWf0914=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHULNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 07:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgHULNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:13:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BF9F20738;
        Fri, 21 Aug 2020 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598008427;
        bh=Q2OJPNVv8D0Bkrc+kM7MKWSuNVHxls/8c/7E13LWptQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bE9KJFqTqSYya11xWvMaoCsgKI0ikMQrsCD+2nxyAZg3KH9Am4bqWab3vbqIJbC2/
         yEDvYPsNuyD1Im3+PjBdVW6a5u3kEi8SsQPqubTCojn5/A62Oje4TteuTYpn8Vtzeb
         f06ICC8/BazpGf4M39LCtTBUMWqIa8OiRbXVAWu8=
Date:   Fri, 21 Aug 2020 12:13:44 +0100
From:   Will Deacon <will@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/percpu-rwsem: Remove WQ_FLAG_EXCLUSIVE flags
Message-ID: <20200821111343.GC20455@willie-the-truck>
References: <20200701055720.38092-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701055720.38092-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 01:57:20PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Remove WQ_FLAG_EXCLUSIVE from "wq_entry.flags", using function
> __add_wait_queue_entry_tail_exclusive substitution.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  kernel/locking/percpu-rwsem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
> index 8bbafe3e5203..48e1c55c2e59 100644
> --- a/kernel/locking/percpu-rwsem.c
> +++ b/kernel/locking/percpu-rwsem.c
> @@ -148,8 +148,8 @@ static void percpu_rwsem_wait(struct percpu_rw_semaphore *sem, bool reader)
>  	 */
>  	wait = !__percpu_rwsem_trylock(sem, reader);
>  	if (wait) {
> -		wq_entry.flags |= WQ_FLAG_EXCLUSIVE | reader * WQ_FLAG_CUSTOM;
> -		__add_wait_queue_entry_tail(&sem->waiters, &wq_entry);
> +		wq_entry.flags |= reader * WQ_FLAG_CUSTOM;
> +		__add_wait_queue_entry_tail_exclusive(&sem->waiters, &wq_entry);
>  	}
>  	spin_unlock_irq(&sem->waiters.lock);

Seems straightforward enough:

Acked-by: Will Deacon <will@kernel.org>

Will
