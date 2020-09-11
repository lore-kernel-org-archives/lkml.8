Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F475C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8BA221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 11:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RNqqoHer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgIKLmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgIKLlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:41:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B418C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 04:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uGxhjmqGos/FmWn6COOVwZ2sqJ6ts5j539p0PpxlONM=; b=RNqqoHerAdj/UNFERk7iyQDLbJ
        wqCD50BZ13LuMybml6khgghWKGQKM4yQf9pr3CjzJ9pIk8dkNldiHC8Qtgth+8XhwOi9VNzlmspYg
        engVZ59087aaH7FavIOn3V/BRKidOH5YlV1idhs2cv5sexGOsmvCV6QWpNo1VejZRvclFXyIyIWIC
        0jORXE8HEGjJ/XB+SmMAuXhVGCrcXM1MxVVs8f1ENbUts+pzE0aZVJPiP8dy88K2AuqsGjMfVEipV
        JqzP7nMhAk5hi3AIubwhjKm5tG3uz7sHm+xvBJrXrGfRW7B5ZCZYErq1g7t4jMffFhji4RJhMUhTv
        GGjJyNmA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGhQu-0005gA-Gj; Fri, 11 Sep 2020 11:41:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B93D73003D8;
        Fri, 11 Sep 2020 13:41:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 737382B08276B; Fri, 11 Sep 2020 13:41:32 +0200 (CEST)
Date:   Fri, 11 Sep 2020 13:41:32 +0200
From:   peterz@infradead.org
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        mbenes@suse.cz, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH] ftrace: Fix missing synchronize_rcu() removing
 trampoline from kallsyms
Message-ID: <20200911114132.GH1362448@hirez.programming.kicks-ass.net>
References: <20200901091617.31837-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901091617.31837-1-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:16:17PM +0300, Adrian Hunter wrote:
> Add synchronize_rcu() after list_del_rcu() in
> ftrace_remove_trampoline_from_kallsyms() to protect readers of
> ftrace_ops_trampoline_list (in ftrace_get_trampoline_kallsym)
> which is used when kallsyms is read.
> 
> Fixes: fc0ea795f53c8d ("ftrace: Add symbols for ftrace trampolines")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  kernel/trace/ftrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 275441254bb5..4e64367c9774 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2782,6 +2782,7 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
>  {
>  	lockdep_assert_held(&ftrace_lock);
>  	list_del_rcu(&ops->list);
> +	synchronize_rcu();
>  }


Hurmph, we've just done a ton of that:


	ftrace_shutdown()
	  synchronize_rcu_tasks_rude()
	  ftrace_trampoline_free()
	    ftrace_remove_trampoline_from_kallsyms()


So would it not be better to move that call before the existing
synchronize_rcu_tasks stuff rather than adding another synchronize_rcu()
call?
