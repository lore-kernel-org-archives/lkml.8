Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067EDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D285E206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KFpZMzyA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgGVKGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:06:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87578C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zvDXvWKN3zUxUN9NPxae6SQN6/r9Wqh96dOTNzhzezU=; b=KFpZMzyAejTxIV0DxHMIlR1Mji
        LTkweEvNuhLQT3Q+ucI+QtJFkWeTAnWo4wbiHv+P9Km2T9lnbXhRFklzHxVEMdEMBV8KpMwQ9sPXB
        nPxLIf/+uaxtrerZUe8AhD68eIje8hVTbEWkLX+x98tiMlBubd/jfdp1bYkga4RdEqBG+/Erb0Kii
        UbQzIxzQwxh8Xx76GgKdEZGmge1YP2rdYIpIykNTiwRCNeU8oyiXEjx/0wBLilZImHqwKDJaM1eL6
        jpnOSrtBQx4UQMknGJYYqHTvCx16NVxuxGIMo8knD91KP3Pcmdb6YbQ2C8A96RaaN/pszkQIE6D+f
        63WsB+SQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyBe3-0003gS-D1; Wed, 22 Jul 2020 10:06:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 596D2303A02;
        Wed, 22 Jul 2020 12:06:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3F88C203C9761; Wed, 22 Jul 2020 12:06:37 +0200 (CEST)
Date:   Wed, 22 Jul 2020 12:06:37 +0200
From:   peterz@infradead.org
To:     Qian Cai <cai@lca.pw>
Cc:     mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] fork: silence a false postive warning in __mmdrop
Message-ID: <20200722100637.GR119549@hirez.programming.kicks-ass.net>
References: <20200604150344.1796-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604150344.1796-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 11:03:44AM -0400, Qian Cai wrote:
> The linux-next commit bf2c59fce407 ("sched/core: Fix illegal RCU from
> offline CPUs") delayed,
> 
> idle->active_mm = &init_mm;
> 
> into finish_cpu() instead of idle_task_exit() which results in a false
> positive warning that was originally designed in the commit 3eda69c92d47
> ("kernel/fork.c: detect early free of a live mm").
> 
>  WARNING: CPU: 127 PID: 72976 at kernel/fork.c:697
>  __mmdrop+0x230/0x2c0
>  do_exit+0x424/0xfa0
>  Call Trace:
>  do_exit+0x424/0xfa0
>  do_group_exit+0x64/0xd0
>  sys_exit_group+0x24/0x30
>  system_call_exception+0x108/0x1d0
>  system_call_common+0xf0/0x278

Please explain; because afaict this is a use-after-free.

The thing is __mmdrop() is going to actually free the mm, so then what
is finish_cpu()'s mmdrop() going to do?

->active_mm() should have a refcount on the mm.

> Fixes: bf2c59fce407 ("sched/core: Fix illegal RCU from offline CPUs")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  kernel/fork.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 142b23645d82..5334efd2a680 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -694,7 +694,6 @@ void __mmdrop(struct mm_struct *mm)
>  {
>  	BUG_ON(mm == &init_mm);
>  	WARN_ON_ONCE(mm == current->mm);
> -	WARN_ON_ONCE(mm == current->active_mm);
>  	mm_free_pgd(mm);
>  	destroy_context(mm);
>  	mmu_notifier_subscriptions_destroy(mm);
> -- 
> 2.21.0 (Apple Git-122.2)
> 
