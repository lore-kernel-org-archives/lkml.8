Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228A3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DDD2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CHym8wYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgG0MiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgG0MiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:38:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=61Z9n5/dz4PPk59nykd8q+jpgUyvwUkxJM/Wz2QE8Nw=; b=CHym8wYjWZwDnBenqnoTe40Pv3
        08Llb3R1qsue1NQSwk/pDcIqxKj0+YLN7c+P8PqL4sdOQPYoc5BCOfU9vxnQ/gLUIfBt5oBpKKGNs
        9URHuqOxzfsD/dZKzdlJFZwIvH2M/RFyVBzwJTgk0yIkoHaRRrGqCPYCqRhz0X9W4WvG+3IYyU/MB
        f0K1wtDpTAPGv1Ue4fTNE/xa9uOSjkdlPcdj5Ij/5jfgo5ZAKwsBp+dAAE7Yfy4pXhqD/sZUc1A8G
        w6IaVhlZhKC/B1S57rxzNA2W4lxpVmC8kEN1Zg7JIiw5zjNlMg6rAHauGuKBTpaZsAj4s9Gn7QXFd
        9q111rWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k02OI-0007WG-Nk; Mon, 27 Jul 2020 12:38:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2246030411F;
        Mon, 27 Jul 2020 14:38:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C17A829DC04EC; Mon, 27 Jul 2020 14:38:01 +0200 (CEST)
Date:   Mon, 27 Jul 2020 14:38:01 +0200
From:   peterz@infradead.org
To:     vincent.donnefort@arm.com
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:59:24AM +0100, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Introducing two macro helpers u64_32read() and u64_32read_set_copy() to
> factorize the u64 vminruntime and last_update_time read on a 32-bits
> architecture. Those new helpers encapsulate smp_rmb() and smp_wmb()
> synchronization and therefore, have a small penalty in set_task_rq_fair()
> and init_cfs_rq().
> 
> The choice of using a macro over an inline function is driven by the
> conditional u64 variable copy declarations.
> 
>   #ifndef CONFIG_64BIT
>      u64 [vminruntime|last_update_time]_copy;
>   #endif

This lacks a *why*... why did you get up this morning and wrote us this
patch.


