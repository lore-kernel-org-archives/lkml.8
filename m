Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009FFC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6BD0217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580917057;
	bh=Wh2b6DVd1shfgI0Kbv5AvxSLUygA72NcMLb333+3XJ8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FqDym/Ojg0jtAELR62rOX3b5y7C/5jUPLH7LoIWtGdmWQzGFroaS5jmxY4ZXwm6bH
	 m9VhzTNEoCo3sjPGe88EA6r6gNeZUMf5Cwhb+uADbb/UE9E7oBK6rUEiLto3KooHbm
	 tps5ZMOKUwjp2EwE1jbArknqJLc91718e/2Hzq7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgBEPhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:37:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbgBEPhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:37:36 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31B8320730;
        Wed,  5 Feb 2020 15:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580917056;
        bh=Wh2b6DVd1shfgI0Kbv5AvxSLUygA72NcMLb333+3XJ8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dy5BfasroV5bfLYX5gvhhFsJcu1ep5tplPCJbzcZR1kwljIJEbdWr3BmfNyt7Gs6H
         vzl1DmOYiiiaZmqqk+QV0gJ6HeOu2uWsOQdN3BNJMcH1FvBxquH8dJz4CA3ZiBQGfU
         B2B2lyMBGFdo6sK93XciVXqesyDqovihfNK9gSWM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id F093A35227F6; Wed,  5 Feb 2020 07:37:35 -0800 (PST)
Date:   Wed, 5 Feb 2020 07:37:35 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     andreyknvl@google.com, glider@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcsan: Fix 0-sized checks
Message-ID: <20200205153735.GY2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200205101419.149903-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205101419.149903-1-elver@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 11:14:19AM +0100, Marco Elver wrote:
> Instrumentation of arbitrary memory-copy functions, such as user-copies,
> may be called with size of 0, which could lead to false positives.
> 
> To avoid this, add a comparison in check_access() for size==0, which
> will be optimized out for constant sized instrumentation
> (__tsan_{read,write}N), and therefore not affect the common-case
> fast-path.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Queued, thank you!

							Thanx, Paul

> ---
>  kernel/kcsan/core.c |  7 +++++++
>  kernel/kcsan/test.c | 10 ++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> index e3c7d8f34f2ff..82c2bef827d42 100644
> --- a/kernel/kcsan/core.c
> +++ b/kernel/kcsan/core.c
> @@ -455,6 +455,13 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
>  	atomic_long_t *watchpoint;
>  	long encoded_watchpoint;
>  
> +	/*
> +	 * Do nothing for 0 sized check; this comparison will be optimized out
> +	 * for constant sized instrumentation (__tsan_{read,write}N).
> +	 */
> +	if (unlikely(size == 0))
> +		return;
> +
>  	/*
>  	 * Avoid user_access_save in fast-path: find_watchpoint is safe without
>  	 * user_access_save, as the address that ptr points to is only used to
> diff --git a/kernel/kcsan/test.c b/kernel/kcsan/test.c
> index cc6000239dc01..d26a052d33838 100644
> --- a/kernel/kcsan/test.c
> +++ b/kernel/kcsan/test.c
> @@ -92,6 +92,16 @@ static bool test_matching_access(void)
>  		return false;
>  	if (WARN_ON(matching_access(9, 1, 10, 1)))
>  		return false;
> +
> +	/*
> +	 * An access of size 0 could match another access, as demonstrated here.
> +	 * Rather than add more comparisons to 'matching_access()', which would
> +	 * end up in the fast-path for *all* checks, check_access() simply
> +	 * returns for all accesses of size 0.
> +	 */
> +	if (WARN_ON(!matching_access(8, 8, 12, 0)))
> +		return false;
> +
>  	return true;
>  }
>  
> -- 
> 2.25.0.341.g760bfbb309-goog
> 
