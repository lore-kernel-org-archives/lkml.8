Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3509AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FED1206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2zIRqCMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732021AbgDOW00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731967AbgDOW0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:26:15 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57785C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=b9F4BdIxe6qjhLUpVkXmq95ni4gC5HWLpSiA/A8w8L4=; b=2zIRqCMnzqAW2UBfRln+N04zcU
        HMSK+FUQfTLziLe+Dd7z2SKH3jhxN4EFGOgp5+xKNMOgCEOnvwzZgDeivYkPoYfRYeA6MKR/BwKaX
        NdwmTb2Ee0Hp5eVKVEae6/Q5ahTjAcYp7l6sA47xSLGQe2dJITJawF9FIeVHpVvNj/SoWXgDBn0QQ
        +0JXJi0KibH876hpeFmDgDAEx1S94/ciSE/ZTsiTMjvDNT3GSco2q8zFu0TaNkAuxRkF92rkIjaqe
        /dkXUW2vl6Cni4Qau1u3Jtg/ND8Hub9/h+etECL0Sze82MQFYMSnz2oMnsuzRyggw9a3tOG8K5B8r
        rah6DDnA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOqTb-0001Pu-0K; Wed, 15 Apr 2020 22:25:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6ED46981086; Thu, 16 Apr 2020 00:25:45 +0200 (CEST)
Date:   Thu, 16 Apr 2020 00:25:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Qian Cai <cai@lca.pw>,
        Eiichi Tsukata <devel@etsukata.com>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Tyler Hicks <tyhicks@canonical.com>
Subject: Re: [PATCH 1/1] cpu: Add annotation inside clear_tasks_mm_cpumask()
Message-ID: <20200415222545.GN2483@worktop.programming.kicks-ass.net>
References: <20200415184937.32373-1-jbi.octave@gmail.com>
 <20200415184937.32373-2-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415184937.32373-2-jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 07:49:37PM +0100, Jules Irenge wrote:
> Sparse reports a warning
> 
> warning: context imbalance in clear_tasks_mm_cpumask() - different lock contexts for basic block

Does this sparse crap actually ever catch a real problem, or does it
only result in horrible code like this?

> The root cause is the missing annotation inside clear_tasks_mm_cpumask()
> 
> Add the missing __acquire(&t->alloc_lock) annotation.

That's just wrong; the actual cause is find_lock_task_mm() not being
annotated, and the reason for that is because __cond_lock() is a
horrible piece of crap.

Barring any evidence that these annotations actually help anybody, can't
we just remove it all instead of making an ever bigger mess of things?

> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  kernel/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 9c706af713fb..d8c452a8dd09 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -834,6 +834,7 @@ void clear_tasks_mm_cpumask(int cpu)
>  		t = find_lock_task_mm(p);
>  		if (!t)
>  			continue;
> +		__acquire(&t->alloc_lock);
>  		cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
>  		task_unlock(t);
>  	}
> -- 
> 2.24.1
> 
