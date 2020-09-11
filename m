Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F3C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D2122205
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QjWViNbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgIKQOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgIKPdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:33:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE8FC061756
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HJNWUaGrNPQ+bpDjsEfsh83mIX0cdXtkWUDJGZCtiyM=; b=QjWViNbZgjYvRyD+W45yIUjL4H
        qi8wcPKK9iqDySQFazyXEZn7C0JzY1/2Ghxzuaq+7Janpjn2BbhNTJqkHsMrf6qnHmEFoCFBTNpUD
        fGYewTXie6ZXsqhm8e1AmXjCBd33dunikqZqygNGEFIrUHYDJ2eHbdeXp/tn6ihRyYD3y8s/12nUz
        O1trOKWNdsdaD6TPi0hpzYFqqU5KbP7Ps5bg/asv2W6w6bKo+Y6vVxKy893+dLI0nF3rskd6OK3Xg
        ooFkygkuDTrVG6pDC5XemZ1WtwEN6kmaLkEsiHU6hQJGaLmSIdGdrRGGPChZBF4Ins2ems82ytes7
        XUKkJo8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGj4N-0000nY-5r; Fri, 11 Sep 2020 13:26:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BF9B3012DC;
        Fri, 11 Sep 2020 15:26:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2253A2143B27A; Fri, 11 Sep 2020 15:26:24 +0200 (CEST)
Date:   Fri, 11 Sep 2020 15:26:24 +0200
From:   peterz@infradead.org
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        mbenes@suse.cz, linux-kernel@vger.kernel.org,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH] ftrace: Fix missing synchronize_rcu() removing
 trampoline from kallsyms
Message-ID: <20200911132624.GK1362448@hirez.programming.kicks-ass.net>
References: <20200901091617.31837-1-adrian.hunter@intel.com>
 <20200911114132.GH1362448@hirez.programming.kicks-ass.net>
 <ba8eaca9-c207-f1b1-9cf7-e2765533645c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba8eaca9-c207-f1b1-9cf7-e2765533645c@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 03:55:22PM +0300, Adrian Hunter wrote:
> On 11/09/20 2:41 pm, peterz@infradead.org wrote:
> > On Tue, Sep 01, 2020 at 12:16:17PM +0300, Adrian Hunter wrote:
> >> Add synchronize_rcu() after list_del_rcu() in
> >> ftrace_remove_trampoline_from_kallsyms() to protect readers of
> >> ftrace_ops_trampoline_list (in ftrace_get_trampoline_kallsym)
> >> which is used when kallsyms is read.
> >>
> >> Fixes: fc0ea795f53c8d ("ftrace: Add symbols for ftrace trampolines")
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >> ---
> >>  kernel/trace/ftrace.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> >> index 275441254bb5..4e64367c9774 100644
> >> --- a/kernel/trace/ftrace.c
> >> +++ b/kernel/trace/ftrace.c
> >> @@ -2782,6 +2782,7 @@ static void ftrace_remove_trampoline_from_kallsyms(struct ftrace_ops *ops)
> >>  {
> >>  	lockdep_assert_held(&ftrace_lock);
> >>  	list_del_rcu(&ops->list);
> >> +	synchronize_rcu();
> >>  }
> > 
> > 
> > Hurmph, we've just done a ton of that:
> > 
> > 
> > 	ftrace_shutdown()
> > 	  synchronize_rcu_tasks_rude()
> > 	  ftrace_trampoline_free()
> > 	    ftrace_remove_trampoline_from_kallsyms()
> > 
> > 
> > So would it not be better to move that call before the existing
> > synchronize_rcu_tasks stuff rather than adding another synchronize_rcu()
> > call?
> 
> Doesn't that mean removing the symbol while the trampoline is potentially
> still in use?

Hurm.. potentially yes. OK, lets do this first.
